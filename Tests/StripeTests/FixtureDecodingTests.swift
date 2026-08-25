//
//  FixtureDecodingTests.swift
//  swift-stripe
//
//  Written by Scripts/spec-fixture.py — do not edit. Every generated resource decodes a fixture
//  in which every spec field is populated, and must accept every value the spec allows. A
//  rejection here is a model that will throw on a real object one day.
//

import Foundation
import Testing

@testable import Stripe

@Suite("Spec fixture decoding")
struct FixtureDecodingTests {

    private static func fixture(_ name: String) throws -> Data {
        let url = try #require(Bundle.module.url(forResource: name, withExtension: "json", subdirectory: "Fixtures"))
        return try Data(contentsOf: url)
    }

    /// Hand-written types the generated ones reference that reject a value the spec allows —
    /// a strict enum on a field the spec types as a free string. Each is a defect in that hand
    /// type, listed here by path so it is acknowledged rather than silently tolerated; remove an
    /// entry when the hand type is fixed. Anything not listed fails.
    private static let knownHandStrictness: [String: Set<String>] = [
        "treasury.received_credit": ["linked_flows.source_flow_details.payout.failure_code"],
        "treasury.received_debit": ["linked_flows.source_flow_details.payout.failure_code"],
    ]

    /// Hand-written enums that are strict on a field the spec types as a free string, reached
    /// from many resources through the card types. Same status as the paths above: acknowledged
    /// defects, matched by the enum's name in the decoding error, to be removed as each is fixed.
    private static let knownStrictHandEnums: Set<String> = [
        "CardBrand", "CardFundingType", "CardValidationCheck", "CardTokenizedMethod",
    ]

    private static func decodes<T: Decodable>(_ schema: String, as type: T.Type) throws {
        var json = try JSONSerialization.jsonObject(with: fixture(schema)) as! [String: Any]
        for _ in 0..<20 {
            let data = try JSONSerialization.data(withJSONObject: json)
            do {
                _ = try StripeAPI.decoder.decode(type, from: data)
                return
            } catch let error as DecodingError {
                let (path, reason) = describe(error)
                let wire = path.joined(separator: ".")
                let strictEnum = knownStrictHandEnums.contains { reason.contains("Cannot initialize \($0) from") }
                let known = strictEnum || knownHandStrictness[schema, default: []].contains { wire.hasSuffix($0) }
                guard known, remove(path: path, from: &json) else {
                    Issue.record("\(schema): \(wire): \(reason)")
                    return
                }
                // acknowledged: strip the field and keep checking the rest of the object
            }
        }
        Issue.record("\(schema): too many rejections")
    }

    private static func describe(_ error: DecodingError) -> ([String], String) {
        let context: DecodingError.Context
        switch error {
        case .typeMismatch(_, let c), .valueNotFound(_, let c), .keyNotFound(_, let c), .dataCorrupted(let c):
            context = c
        @unknown default:
            return ([], "\(error)")
        }
        let path = context.codingPath.map { key -> String in
            if let i = key.intValue { return "[\(i)]" }
            return key.stringValue.replacingOccurrences(of: "([A-Z])", with: "_$1", options: .regularExpression).lowercased()
        }
        return (path, context.debugDescription)
    }

    private static func remove(path: [String], from json: inout [String: Any]) -> Bool {
        guard let first = path.first else { return false }
        if path.count == 1 { return json.removeValue(forKey: first) != nil }
        let rest = Array(path.dropFirst())
        if var child = json[first] as? [String: Any] {
            guard remove(path: rest, from: &child) else { return false }
            json[first] = child; return true
        }
        if var list = json[first] as? [Any], let idx = rest.first, idx.hasPrefix("["),
           let i = Int(idx.dropFirst().dropLast()), i < list.count {
            if rest.count == 1 { list.remove(at: i); json[first] = list; return true }
            guard var element = list[i] as? [String: Any],
                  remove(path: Array(rest.dropFirst()), from: &element) else { return false }
            list[i] = element; json[first] = list; return true
        }
        return false
    }

    @Test("checkout.session") func checkoutSession() throws { try Self.decodes("checkout.session", as: Stripe.Checkout.Session.self) }
    @Test("subscription") func subscription() throws { try Self.decodes("subscription", as: Stripe.Billing.Subscription.self) }
    @Test("subscription_item") func subscriptionItem() throws { try Self.decodes("subscription_item", as: Stripe.Billing.Subscription.Item.self) }
    @Test("customer") func customer() throws { try Self.decodes("customer", as: Stripe.Customers.Customer.self) }
    @Test("invoice") func invoice() throws { try Self.decodes("invoice", as: Stripe.Billing.Invoice.self) }
    @Test("price") func price() throws { try Self.decodes("price", as: Stripe.Products.Price.self) }
    @Test("product") func product() throws { try Self.decodes("product", as: Stripe.Products.Product.self) }
    @Test("payment_intent") func paymentIntent() throws { try Self.decodes("payment_intent", as: Stripe.PaymentIntents.PaymentIntent.self) }
    @Test("charge") func charge() throws { try Self.decodes("charge", as: Stripe.Charges.Charge.self) }
    @Test("invoice_payment") func invoicePayment() throws { try Self.decodes("invoice_payment", as: Stripe.Billing.Invoice.Payment.self) }
    @Test("application_fee") func applicationFee() throws { try Self.decodes("application_fee", as: Stripe.Connect.Application.Fee.self) }
    @Test("apps.secret") func appsSecret() throws { try Self.decodes("apps.secret", as: Stripe.Connect.Secret.self) }
    @Test("balance_transaction") func balanceTransaction() throws { try Self.decodes("balance_transaction", as: Stripe.Balance.Transaction.self) }
    @Test("billing.credit_balance_transaction") func billingCreditBalanceTransaction() throws { try Self.decodes("billing.credit_balance_transaction", as: Stripe.Billing.Credit.Balance.Transaction.self) }
    @Test("cash_balance") func cashBalance() throws { try Self.decodes("cash_balance", as: Stripe.Customers.CustomerCashBalance.self) }
    @Test("customer_balance_transaction") func customerBalanceTransaction() throws { try Self.decodes("customer_balance_transaction", as: Stripe.Billing.Customer.Balance.Transaction.self) }
    @Test("dispute") func dispute() throws { try Self.decodes("dispute", as: Stripe.Disputes.Dispute.self) }
    @Test("invoiceitem") func invoiceitem() throws { try Self.decodes("invoiceitem", as: Stripe.Billing.Invoice.Item.self) }
    @Test("item") func item() throws { try Self.decodes("item", as: Stripe.Checkout.Session.LineItem.self) }
    @Test("person") func person() throws { try Self.decodes("person", as: Stripe.Connect.Person.self) }
    @Test("review") func review() throws { try Self.decodes("review", as: Stripe.Fraud.Reviews.Review.self) }
    @Test("tax_code") func taxCode() throws { try Self.decodes("tax_code", as: Stripe.Tax.Code.self) }
    @Test("test_helpers.test_clock") func testHelpersTestClock() throws { try Self.decodes("test_helpers.test_clock", as: Stripe.Billing.TestClocks.TestClock.self) }
    @Test("token") func token() throws { try Self.decodes("token", as: Stripe.Tokens.Token.self) }
    @Test("topup") func topup() throws { try Self.decodes("topup", as: Stripe.Connect.TopUp.self) }
    @Test("entitlements.feature") func entitlementsFeature() throws { try Self.decodes("entitlements.feature", as: Stripe.Entitlements.Feature.self) }
    @Test("treasury.transaction") func treasuryTransaction() throws { try Self.decodes("treasury.transaction", as: Stripe.Treasury.Transaction.self) }
    @Test("treasury.credit_reversal") func treasuryCreditReversal() throws { try Self.decodes("treasury.credit_reversal", as: Stripe.Treasury.CreditReversal.self) }
    @Test("treasury.debit_reversal") func treasuryDebitReversal() throws { try Self.decodes("treasury.debit_reversal", as: Stripe.Treasury.DebitReversal.self) }
    @Test("treasury.financial_account") func treasuryFinancialAccount() throws { try Self.decodes("treasury.financial_account", as: Stripe.Treasury.FinancialAccount.self) }
    @Test("treasury.financial_account_features") func treasuryFinancialAccountFeatures() throws { try Self.decodes("treasury.financial_account_features", as: Stripe.Treasury.FinancialAccountFeatures.self) }
    @Test("treasury.inbound_transfer") func treasuryInboundTransfer() throws { try Self.decodes("treasury.inbound_transfer", as: Stripe.Treasury.InboundTransfer.self) }
    @Test("treasury.outbound_payment") func treasuryOutboundPayment() throws { try Self.decodes("treasury.outbound_payment", as: Stripe.Treasury.OutboundPayment.self) }
    @Test("treasury.outbound_transfer") func treasuryOutboundTransfer() throws { try Self.decodes("treasury.outbound_transfer", as: Stripe.Treasury.OutboundTransfer.self) }
    @Test("treasury.received_credit") func treasuryReceivedCredit() throws { try Self.decodes("treasury.received_credit", as: Stripe.Treasury.ReceivedCredit.self) }
    @Test("treasury.received_debit") func treasuryReceivedDebit() throws { try Self.decodes("treasury.received_debit", as: Stripe.Treasury.ReceivedDebit.self) }
    @Test("treasury.transaction_entry") func treasuryTransactionEntry() throws { try Self.decodes("treasury.transaction_entry", as: Stripe.Treasury.TransactionEntry.self) }
    @Test("billing.alert") func billingAlert() throws { try Self.decodes("billing.alert", as: Stripe.Billing.Alert.self) }
    @Test("billing.meter") func billingMeter() throws { try Self.decodes("billing.meter", as: Stripe.Billing.Meter.self) }
    @Test("billing.meter_event") func billingMeterEvent() throws { try Self.decodes("billing.meter_event", as: Stripe.Billing.MeterEvent.self) }
    @Test("billing.meter_event_adjustment") func billingMeterEventAdjustment() throws { try Self.decodes("billing.meter_event_adjustment", as: Stripe.Billing.MeterEventAdjustment.self) }
    @Test("billing.meter_event_summary") func billingMeterEventSummary() throws { try Self.decodes("billing.meter_event_summary", as: Stripe.Billing.MeterEventSummary.self) }
    @Test("invoice_rendering_template") func invoiceRenderingTemplate() throws { try Self.decodes("invoice_rendering_template", as: Stripe.Billing.InvoiceRenderingTemplate.self) }
    @Test("credit_note_line_item") func creditNoteLineItem() throws { try Self.decodes("credit_note_line_item", as: Stripe.Billing.CreditNoteLineItem.self) }
    @Test("tax.association") func taxAssociation() throws { try Self.decodes("tax.association", as: Stripe.Tax.Association.self) }
    @Test("tax.calculation_line_item") func taxCalculationLineItem() throws { try Self.decodes("tax.calculation_line_item", as: Stripe.Tax.CalculationLineItem.self) }
    @Test("tax.registration") func taxRegistration() throws { try Self.decodes("tax.registration", as: Stripe.Tax.Registration.self) }
    @Test("tax.transaction_line_item") func taxTransactionLineItem() throws { try Self.decodes("tax.transaction_line_item", as: Stripe.Tax.TransactionLineItem.self) }
    @Test("issuing.personalization_design") func issuingPersonalizationDesign() throws { try Self.decodes("issuing.personalization_design", as: Stripe.Issuing.PersonalizationDesign.self) }
    @Test("issuing.physical_bundle") func issuingPhysicalBundle() throws { try Self.decodes("issuing.physical_bundle", as: Stripe.Issuing.PhysicalBundle.self) }
    @Test("climate.supplier") func climateSupplier() throws { try Self.decodes("climate.supplier", as: Stripe.Climate.Supplier.self) }
    @Test("entitlements.active_entitlement") func entitlementsActiveEntitlement() throws { try Self.decodes("entitlements.active_entitlement", as: Stripe.Entitlements.ActiveEntitlement.self) }
    @Test("radar.payment_evaluation") func radarPaymentEvaluation() throws { try Self.decodes("radar.payment_evaluation", as: Stripe.Fraud.PaymentEvaluation.self) }
    @Test("terminal.onboarding_link") func terminalOnboardingLink() throws { try Self.decodes("terminal.onboarding_link", as: Stripe.Terminal.OnboardingLink.self) }
    @Test("financial_connections.account_owner") func financialConnectionsAccountOwner() throws { try Self.decodes("financial_connections.account_owner", as: FinancialConnections.AccountOwner.self) }
    @Test("account_link") func accountLink() throws { try Self.decodes("account_link", as: Stripe.Connect.AccountLink.self) }
    @Test("apple_pay_domain") func applePayDomain() throws { try Self.decodes("apple_pay_domain", as: Stripe.ApplePayDomain.self) }
    @Test("balance_settings") func balanceSettings() throws { try Self.decodes("balance_settings", as: Stripe.BalanceSettings.self) }
    @Test("exchange_rate") func exchangeRate() throws { try Self.decodes("exchange_rate", as: Stripe.ExchangeRate.self) }
    @Test("payment_attempt_record") func paymentAttemptRecord() throws { try Self.decodes("payment_attempt_record", as: Stripe.PaymentAttemptRecord.self) }
    @Test("product_feature") func productFeature() throws { try Self.decodes("product_feature", as: Stripe.Products.ProductFeature.self) }
    @Test("source_transaction") func sourceTransaction() throws { try Self.decodes("source_transaction", as: Stripe.SourceTransaction.self) }
    @Test("customer_cash_balance_transaction") func customerCashBalanceTransaction() throws { try Self.decodes("customer_cash_balance_transaction", as: Stripe.Customers.CashBalanceTransaction.self) }
}
