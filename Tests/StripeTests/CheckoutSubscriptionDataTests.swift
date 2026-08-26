//
//  CheckoutSubscriptionDataTests.swift
//  swift-stripe
//
//  `subscription_data` is the only way to reach the Subscription a checkout
//  session creates, so its wire shape is asserted directly.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import Testing

@testable import Stripe

@Suite("Checkout subscription data")
struct CheckoutSubscriptionDataTests {

    private static func pairs(
        _ subscriptionData: Stripe.Checkout.Session.Create.Request.SubscriptionData?
    ) throws -> [String: String] {
        let request = Stripe.Checkout.Session.Create.Request(
            customer: "cus_1",
            lineItems: [.init(price: "price_1", quantity: 1)],
            mode: .subscription,
            subscriptionData: subscriptionData,
            successUrl: "https://example.com/ok"
        )
        return Dictionary(uniqueKeysWithValues: try StripeFormEncoder().pairs(of: request))
    }

    @Test("metadata and the trial nest under subscription_data")
    func trialAndMetadata() throws {
        let pairs = try Self.pairs(.init(metadata: ["user_id": "u_1"], trialPeriodDays: 14))

        #expect(pairs["subscription_data[metadata][user_id]"] == "u_1")
        #expect(pairs["subscription_data[trial_period_days]"] == "14")
        // The rest of the session is unaffected.
        #expect(pairs["mode"] == "subscription")
        #expect(pairs["line_items[0][price]"] == "price_1")
    }

    @Test("every modelled field reaches its Stripe wire name")
    func fullShape() throws {
        let pairs = try Self.pairs(
            .init(
                billingCycleAnchor: Date(timeIntervalSince1970: 1_614_556_800),
                defaultTaxRates: ["txr_1", "txr_2"],
                description: "Pro plan",
                metadata: ["order_id": "o_1"],
                onBehalfOf: "acct_1",
                prorationBehavior: .createProrations,
                transferData: .init(amountPercent: 80, destination: "acct_2"),
                trialEnd: Date(timeIntervalSince1970: 1_617_235_200),
                trialSettings: .init(endBehavior: .init(missingPaymentMethod: .cancel))
            )
        )

        #expect(pairs["subscription_data[billing_cycle_anchor]"] == "1614556800")
        #expect(pairs["subscription_data[default_tax_rates][0]"] == "txr_1")
        #expect(pairs["subscription_data[default_tax_rates][1]"] == "txr_2")
        #expect(pairs["subscription_data[description]"] == "Pro plan")
        #expect(pairs["subscription_data[metadata][order_id]"] == "o_1")
        #expect(pairs["subscription_data[on_behalf_of]"] == "acct_1")
        #expect(pairs["subscription_data[proration_behavior]"] == "create_prorations")
        #expect(pairs["subscription_data[transfer_data][destination]"] == "acct_2")
        #expect(pairs["subscription_data[transfer_data][amount_percent]"] == "80")
        #expect(pairs["subscription_data[trial_end]"] == "1617235200")
        #expect(
            pairs["subscription_data[trial_settings][end_behavior][missing_payment_method]"]
                == "cancel"
        )
    }

    @Test("a fractional percentage keeps its decimals on the wire")
    func fractionalPercentages() throws {
        // Stripe documents both of these as "a non-negative decimal between 0 and 100, with at
        // most two decimal places" — an integer type would silently truncate them.
        let pairs = try Self.pairs(
            .init(
                applicationFeePercent: 2.75,
                transferData: .init(amountPercent: 87.5, destination: "acct_1")
            )
        )
        #expect(pairs["subscription_data[application_fee_percent]"] == "2.75")
        #expect(pairs["subscription_data[transfer_data][amount_percent]"] == "87.5")
    }

    @Test("a whole percentage does not gain a decimal point")
    func wholePercentages() throws {
        let pairs = try Self.pairs(
            .init(transferData: .init(amountPercent: 80, destination: "acct_1"))
        )
        #expect(pairs["subscription_data[transfer_data][amount_percent]"] == "80")
    }

    @Test("a session without subscription data sends none of it")
    func omitted() throws {
        let pairs = try Self.pairs(nil)
        #expect(pairs.keys.contains { $0.hasPrefix("subscription_data") } == false)
    }
}
