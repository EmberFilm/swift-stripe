//
//  AddedFieldDecodingTests.swift
//  swift-stripe
//
//  Every field closed out of the model-drift report, decoded from the wire.
//
//  Declaring a property is not enough: where a type has an explicit `CodingKeys`, a property
//  missing from it compiles, reports no drift, and still decodes to nil forever. These assert
//  the value actually arrives.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import Testing

@testable import Stripe

@Suite("Added field decoding")
struct AddedFieldDecodingTests {

    private static func decode<T: Decodable>(_ type: T.Type, _ json: String) throws -> T {
        try StripeAPI.decoder.decode(type, from: Data(json.utf8))
    }

    @Test("subscription gains its 2026 fields")
    func subscription() throws {
        let sub = try Self.decode(Stripe.Billing.Subscription.self, #"""
        {"id":"sub_1","object":"subscription","created":1,"customer_account":"acct_1",
         "managed_payments":{"enabled":true},
         "presentment_details":{"presentment_currency":"eur"},
         "billing_schedules":[{"key":"bs_1","applies_to":[{"type":"price","price":"price_1"}],
                               "bill_until":{"computed_timestamp":1700000000,
                                             "duration":{"interval":"month","interval_count":3}}}]}
        """#)

        #expect(sub.customerAccount == "acct_1")
        #expect(sub.managedPayments?.enabled == true)
        #expect(sub.presentmentDetails?.presentmentCurrency == "eur")
        let schedule = try #require(sub.billingSchedules?.first)
        #expect(schedule.key == "bs_1")
        #expect(schedule.appliesTo?.first?.price == "price_1")
        #expect(schedule.appliesTo?.first?.type == .price)
        #expect(schedule.billUntil?.duration?.interval == .month)
        #expect(schedule.billUntil?.duration?.intervalCount == 3)
        #expect(schedule.billUntil?.computedTimestamp == Date(timeIntervalSince1970: 1_700_000_000))
    }

    @Test("subscription item reports how far it has billed")
    func subscriptionItem() throws {
        let item = try Self.decode(Stripe.Billing.Subscription.Item.self, #"""
        {"id":"si_1","object":"subscription_item","created":1,"billed_until":1700000000}
        """#)
        #expect(item.billedUntil == Date(timeIntervalSince1970: 1_700_000_000))
    }

    @Test("customer gains names, account and tax")
    func customer() throws {
        let customer = try Self.decode(Stripe.Customers.Customer.self, #"""
        {"id":"cus_1","object":"customer","created":1,"business_name":"Ada Ltd",
         "individual_name":"Ada Lovelace","customer_account":"acct_1",
         "tax":{"automatic_tax":"supported","ip_address":"1.2.3.4","provider":"stripe"}}
        """#)

        #expect(customer.businessName == "Ada Ltd")
        #expect(customer.individualName == "Ada Lovelace")
        #expect(customer.customerAccount == "acct_1")
        #expect(customer.tax?.automaticTax == .supported)
        #expect(customer.tax?.ipAddress == "1.2.3.4")
        #expect(customer.tax?.provider == .stripe)
    }

    @Test("charge gains authorization code, level 3 and presentment")
    func charge() throws {
        let charge = try Self.decode(Stripe.Charges.Charge.self, #"""
        {"id":"ch_1","object":"charge","created":1,"authorization_code":"A1B2C3",
         "presentment_details":{"presentment_amount":1200,"presentment_currency":"gbp"},
         "level3":{"merchant_reference":"m_1","shipping_amount":500,
                   "line_items":[{"product_code":"p_1","quantity":2,"unit_cost":250}]}}
        """#)

        #expect(charge.authorizationCode == "A1B2C3")
        #expect(charge.presentmentDetails?.presentmentAmount == 1200)
        #expect(charge.presentmentDetails?.presentmentCurrency == "gbp")
        #expect(charge.level3?.merchantReference == "m_1")
        #expect(charge.level3?.shippingAmount == 500)
        #expect(charge.level3?.lineItems?.first?.unitCost == 250)
    }

    @Test("payment intent gains its 2026 fields")
    func paymentIntent() throws {
        let intent = try Self.decode(Stripe.PaymentIntents.PaymentIntent.self, #"""
        {"id":"pi_1","object":"payment_intent","created":1,"amount":1000,"currency":"usd",
         "customer_account":"acct_1",
         "allowed_payment_method_types":["card"],
         "excluded_payment_method_types":["link"],
         "hooks":{"inputs":{"tax":{"calculation":"taxcalc_1"}}},
         "managed_payments":{"enabled":false},
         "payment_details":{"customer_reference":"cr_1","order_reference":"or_1"},
         "payment_method_configuration_details":{"id":"pmc_1","parent":"pmc_0"},
         "presentment_details":{"presentment_amount":900,"presentment_currency":"eur"}}
        """#)

        #expect(intent.customerAccount == "acct_1")
        #expect(intent.allowedPaymentMethodTypes == ["card"])
        #expect(intent.excludedPaymentMethodTypes == ["link"])
        #expect(intent.hooks?.inputs?.tax?.calculation == "taxcalc_1")
        #expect(intent.managedPayments?.enabled == false)
        #expect(intent.paymentDetails?.customerReference == "cr_1")
        #expect(intent.paymentDetails?.orderReference == "or_1")
        #expect(intent.paymentMethodConfigurationDetails?.id == "pmc_1")
        #expect(intent.paymentMethodConfigurationDetails?.parent == "pmc_0")
        #expect(intent.presentmentDetails?.presentmentAmount == 900)
    }

    @Test("event carries its fetch context")
    func event() throws {
        let event = try Self.decode(Stripe.Events.Event.self, #"""
        {"id":"evt_1","object":"event","created":1,"type":"charge.succeeded","context":"acct_1"}
        """#)
        #expect(event.context == "acct_1")
    }
}
