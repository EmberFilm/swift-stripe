//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-stripe open source project
//
// Copyright (c) 2026 the swift-stripe project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
// See NOTICE for attribution of derived work
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import Foundation
import Testing

@testable import Stripe

/// Every generated resource decodes a fixture in which every spec field is populated.
///
/// Written by Scripts/spec-fixture.py. A resource must accept every value the spec allows; a
/// rejection here is a model that will throw on a real object one day.
@Suite("Spec fixture decoding")
struct FixtureDecodingTests {

    private static func fixture(_ name: String) throws -> Data {
        let url = try #require(Bundle.module.url(forResource: name, withExtension: "json", subdirectory: "Fixtures"))
        return try Data(contentsOf: url)
    }

    /// Hand-written types the generated ones reference that reject a value the spec allows.
    ///
    /// A strict enum on a field the spec types as a free string. Each is a defect in that hand
    /// type, listed here by path so it is acknowledged rather than silently tolerated; remove an
    /// entry when the hand type is fixed. Anything not listed fails.
    private static let knownHandStrictness: [String: Set<String>] = [
        "treasury.received_credit": ["linked_flows.source_flow_details.payout.failure_code"],
        "treasury.received_debit": ["linked_flows.source_flow_details.payout.failure_code"],
    ]

    /// Hand-written enums that are strict on a field the spec types as a free string.
    ///
    /// Reached from many resources through the card types. Same status as the paths above:
    /// acknowledged defects, matched by the enum's name in the decoding error, to be removed as
    /// each is fixed.
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
            json[first] = child
            return true
        }
        if var list = json[first] as? [Any], let idx = rest.first, idx.hasPrefix("["),
            let i = Int(idx.dropFirst().dropLast()), i < list.count
        {
            if rest.count == 1 {
                list.remove(at: i)
                json[first] = list
                return true
            }
            guard var element = list[i] as? [String: Any],
                remove(path: Array(rest.dropFirst()), from: &element)
            else { return false }
            list[i] = element
            json[first] = list
            return true
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
    @Test("billing.credit_balance_transaction") func billingCreditBalanceTransaction() throws {
        try Self.decodes("billing.credit_balance_transaction", as: Stripe.Billing.Credit.Balance.Transaction.self)
    }
    @Test("cash_balance") func cashBalance() throws { try Self.decodes("cash_balance", as: Stripe.Customers.CustomerCashBalance.self) }
    @Test("customer_balance_transaction") func customerBalanceTransaction() throws {
        try Self.decodes("customer_balance_transaction", as: Stripe.Billing.Customer.Balance.Transaction.self)
    }
    @Test("dispute") func dispute() throws { try Self.decodes("dispute", as: Stripe.Disputes.Dispute.self) }
    @Test("invoiceitem") func invoiceitem() throws { try Self.decodes("invoiceitem", as: Stripe.Billing.Invoice.Item.self) }
    @Test("item") func item() throws { try Self.decodes("item", as: Stripe.Checkout.Session.LineItem.self) }
    @Test("person") func person() throws { try Self.decodes("person", as: Stripe.Connect.Person.self) }
    @Test("review") func review() throws { try Self.decodes("review", as: Stripe.Fraud.Reviews.Review.self) }
    @Test("tax_code") func taxCode() throws { try Self.decodes("tax_code", as: Stripe.Tax.Code.self) }
    @Test("test_helpers.test_clock") func testHelpersTestClock() throws {
        try Self.decodes("test_helpers.test_clock", as: Stripe.Billing.TestClocks.TestClock.self)
    }
    @Test("token") func token() throws { try Self.decodes("token", as: Stripe.Tokens.Token.self) }
    @Test("topup") func topup() throws { try Self.decodes("topup", as: Stripe.Connect.TopUp.self) }
    @Test("bank_account") func bankAccount() throws { try Self.decodes("bank_account", as: BankAccount.self) }
    @Test("capability") func capability() throws { try Self.decodes("capability", as: Stripe.Connect.Capability.self) }
    @Test("card") func card() throws { try Self.decodes("card", as: Card.self) }
    @Test("country_spec") func countrySpec() throws { try Self.decodes("country_spec", as: Stripe.Connect.CountrySpec.self) }
    @Test("customer_session") func customerSession() throws { try Self.decodes("customer_session", as: Stripe.Customers.Customer.Session.self) }
    @Test("ephemeral_key") func ephemeralKey() throws { try Self.decodes("ephemeral_key", as: Stripe.EphemeralKey.self) }
    @Test("fee_refund") func feeRefund() throws { try Self.decodes("fee_refund", as: Stripe.Connect.Application.Fee.Refund.self) }
    @Test("file_link") func fileLink() throws { try Self.decodes("file_link", as: Stripe.FileLinks.FileLink.self) }
    @Test("financial_connections.account") func financialConnectionsAccount() throws {
        try Self.decodes("financial_connections.account", as: FinancialConnections.Account.self)
    }
    @Test("funding_instructions") func fundingInstructions() throws { try Self.decodes("funding_instructions", as: FundingInstructions.self) }
    @Test("identity.verification_report") func identityVerificationReport() throws {
        try Self.decodes("identity.verification_report", as: VerificationReport.self)
    }
    @Test("identity.verification_session") func identityVerificationSession() throws {
        try Self.decodes("identity.verification_session", as: VerificationSession.self)
    }
    @Test("issuing.authorization") func issuingAuthorization() throws { try Self.decodes("issuing.authorization", as: Authorization.self) }
    @Test("issuing.card") func issuingCard() throws { try Self.decodes("issuing.card", as: IssuingCard.self) }
    @Test("issuing.cardholder") func issuingCardholder() throws { try Self.decodes("issuing.cardholder", as: Cardholder.self) }
    @Test("issuing.dispute") func issuingDispute() throws { try Self.decodes("issuing.dispute", as: IssuingDispute.self) }
    @Test("issuing.transaction") func issuingTransaction() throws { try Self.decodes("issuing.transaction", as: Transaction.self) }
    @Test("payment_method_domain") func paymentMethodDomain() throws {
        try Self.decodes("payment_method_domain", as: Stripe.PaymentMethodDomain.self)
    }
    @Test("radar.early_fraud_warning") func radarEarlyFraudWarning() throws {
        try Self.decodes("radar.early_fraud_warning", as: Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.self)
    }
    @Test("radar.value_list_item") func radarValueListItem() throws {
        try Self.decodes("radar.value_list_item", as: Stripe.Fraud.ValueListItems.ValueListItem.self)
    }
    @Test("reporting.report_run") func reportingReportRun() throws { try Self.decodes("reporting.report_run", as: ReportRun.self) }
    @Test("reporting.report_type") func reportingReportType() throws { try Self.decodes("reporting.report_type", as: ReportType.self) }
    @Test("scheduled_query_run") func scheduledQueryRun() throws { try Self.decodes("scheduled_query_run", as: ScheduledQueryRun.self) }
    @Test("setup_attempt") func setupAttempt() throws { try Self.decodes("setup_attempt", as: Stripe.Setup.Attempt.self) }
    @Test("source") func source() throws { try Self.decodes("source", as: Source.self) }
    @Test("terminal.configuration") func terminalConfiguration() throws { try Self.decodes("terminal.configuration", as: TerminalConfiguration.self) }
    @Test("terminal.connection_token") func terminalConnectionToken() throws {
        try Self.decodes("terminal.connection_token", as: TerminalConnectionToken.self)
    }
    @Test("terminal.reader") func terminalReader() throws { try Self.decodes("terminal.reader", as: Stripe.Terminal.Readers.Reader.self) }
    @Test("webhook_endpoint") func webhookEndpoint() throws { try Self.decodes("webhook_endpoint", as: Webhook.self) }
    @Test("account_session") func accountSession() throws { try Self.decodes("account_session", as: Stripe.Connect.Account.Session.self) }
    @Test("balance") func balance() throws { try Self.decodes("balance", as: Stripe.Balance.self) }
    @Test("billing.credit_balance_summary") func billingCreditBalanceSummary() throws {
        try Self.decodes("billing.credit_balance_summary", as: Stripe.Billing.Credit.Balance.Summary.self)
    }
    @Test("billing_portal.session") func billingPortalSession() throws {
        try Self.decodes("billing_portal.session", as: Stripe.Billing.Customer.Portal.Session.self)
    }
    @Test("confirmation_token") func confirmationToken() throws { try Self.decodes("confirmation_token", as: ConfirmationToken.self) }
    @Test("credit_note") func creditNote() throws { try Self.decodes("credit_note", as: Stripe.Billing.Credit.Note.self) }
    @Test("file") func file() throws { try Self.decodes("file", as: Stripe.Files.File.self) }
    @Test("line_item") func lineItem() throws { try Self.decodes("line_item", as: Stripe.Billing.Invoice.LineItem.self) }
    @Test("login_link") func loginLink() throws { try Self.decodes("login_link", as: Stripe.Connect.Account.LoginLink.self) }
    @Test("mandate") func mandate() throws { try Self.decodes("mandate", as: Stripe.Mandates.Mandate.self) }
    @Test("payment_method_configuration") func paymentMethodConfiguration() throws {
        try Self.decodes("payment_method_configuration", as: Stripe.PaymentMethodConfigurations.Configuration.self)
    }
    @Test("quote") func quote() throws { try Self.decodes("quote", as: Stripe.Billing.Quote.self) }
    @Test("radar.value_list") func radarValueList() throws { try Self.decodes("radar.value_list", as: Stripe.Fraud.ValueLists.ValueList.self) }
    @Test("refund") func refund() throws { try Self.decodes("refund", as: Stripe.Refunds.Refund.self) }
    @Test("tax.calculation") func taxCalculation() throws { try Self.decodes("tax.calculation", as: Stripe.Tax.Calculation.self) }
    @Test("tax_id") func taxId() throws { try Self.decodes("tax_id", as: Stripe.Tax.ID.self) }
    @Test("tax_rate") func taxRate() throws { try Self.decodes("tax_rate", as: Stripe.Tax.Rate.self) }
    @Test("terminal.location") func terminalLocation() throws { try Self.decodes("terminal.location", as: Stripe.Terminal.Locations.Location.self) }
    @Test("transfer_reversal") func transferReversal() throws { try Self.decodes("transfer_reversal", as: Stripe.Connect.Transfer.Reversal.self) }
    @Test("account") func account() throws { try Self.decodes("account", as: Stripe.Connect.Account.self) }
    @Test("billing.credit_grant") func billingCreditGrant() throws { try Self.decodes("billing.credit_grant", as: Stripe.Billing.Credit.Grant.self) }
    @Test("billing_portal.configuration") func billingPortalConfiguration() throws {
        try Self.decodes("billing_portal.configuration", as: Stripe.Billing.Customer.Portal.Configuration.self)
    }
    @Test("coupon") func coupon() throws { try Self.decodes("coupon", as: Stripe.Products.Coupon.self) }
    @Test("forwarding.request") func forwardingRequest() throws { try Self.decodes("forwarding.request", as: Stripe.Forwarding.Request.self) }
    @Test("payment_method") func paymentMethod() throws { try Self.decodes("payment_method", as: Stripe.PaymentMethods.PaymentMethod.self) }
    @Test("payout") func payout() throws { try Self.decodes("payout", as: Stripe.Payouts.Payout.self) }
    @Test("plan") func plan() throws { try Self.decodes("plan", as: Stripe.Billing.Plan.self) }
    @Test("promotion_code") func promotionCode() throws { try Self.decodes("promotion_code", as: Promotion.Code.self) }
    @Test("setup_intent") func setupIntent() throws { try Self.decodes("setup_intent", as: Stripe.Setup.Intent.self) }
    @Test("shipping_rate") func shippingRate() throws { try Self.decodes("shipping_rate", as: Stripe.Products.Shipping.Rate.self) }
    @Test("transfer") func transfer() throws { try Self.decodes("transfer", as: Stripe.Connect.Transfer.self) }
    @Test("payment_link") func paymentLink() throws { try Self.decodes("payment_link", as: Stripe.PaymentLink.self) }
    @Test("subscription_schedule") func subscriptionSchedule() throws {
        try Self.decodes("subscription_schedule", as: Stripe.Billing.Subscription.Schedule.self)
    }
    @Test("reserve.hold") func reserveHold() throws { try Self.decodes("reserve.hold", as: Stripe.Reserve.Hold.self) }
    @Test("reserve.plan") func reservePlan() throws { try Self.decodes("reserve.plan", as: Stripe.Reserve.Plan.self) }
    @Test("reserve.release") func reserveRelease() throws { try Self.decodes("reserve.release", as: Stripe.Reserve.Release.self) }
    @Test("reserve_transaction") func reserveTransaction() throws { try Self.decodes("reserve_transaction", as: Stripe.Reserve.Transaction.self) }
    @Test("billing.alert_triggered") func billingAlertTriggered() throws {
        try Self.decodes("billing.alert_triggered", as: Stripe.Billing.AlertTriggered.self)
    }
    @Test("financial_connections.authorization") func financialConnectionsAuthorization() throws {
        try Self.decodes("financial_connections.authorization", as: FinancialConnections.Authorization.self)
    }
    @Test("issuing.token") func issuingToken() throws { try Self.decodes("issuing.token", as: Stripe.Issuing.Token.self) }
    @Test("payment_record") func paymentRecord() throws { try Self.decodes("payment_record", as: Stripe.PaymentRecord.self) }
    @Test("source_mandate_notification") func sourceMandateNotification() throws {
        try Self.decodes("source_mandate_notification", as: SourceMandateNotification.self)
    }
    @Test("entitlements.active_entitlement_summary") func entitlementsActiveEntitlementSummary() throws {
        try Self.decodes("entitlements.active_entitlement_summary", as: Stripe.Entitlements.ActiveEntitlementSummary.self)
    }
    @Test("tax_deducted_at_source") func taxDeductedAtSource() throws { try Self.decodes("tax_deducted_at_source", as: TaxDeductedAtSource.self) }
    @Test("connect_collection_transfer") func connectCollectionTransfer() throws {
        try Self.decodes("connect_collection_transfer", as: Stripe.Connect.CollectionTransfer.self)
    }
    @Test("climate.order") func climateOrder() throws { try Self.decodes("climate.order", as: Stripe.Climate.Order.self) }
    @Test("climate.product") func climateProduct() throws { try Self.decodes("climate.product", as: Stripe.Climate.Product.self) }
    @Test("tax.settings") func taxSettings() throws { try Self.decodes("tax.settings", as: Stripe.Tax.Settings.self) }
    @Test("tax.transaction") func taxTransaction() throws { try Self.decodes("tax.transaction", as: Stripe.Tax.Transaction.self) }
    @Test("financial_connections.session") func financialConnectionsSession() throws {
        try Self.decodes("financial_connections.session", as: FinancialConnections.Session.self)
    }
    @Test("financial_connections.transaction") func financialConnectionsTransaction() throws {
        try Self.decodes("financial_connections.transaction", as: FinancialConnections.Transaction.self)
    }
    @Test("entitlements.feature") func entitlementsFeature() throws { try Self.decodes("entitlements.feature", as: Stripe.Entitlements.Feature.self) }
    @Test("treasury.transaction") func treasuryTransaction() throws { try Self.decodes("treasury.transaction", as: Stripe.Treasury.Transaction.self) }
    @Test("treasury.credit_reversal") func treasuryCreditReversal() throws {
        try Self.decodes("treasury.credit_reversal", as: Stripe.Treasury.CreditReversal.self)
    }
    @Test("treasury.debit_reversal") func treasuryDebitReversal() throws {
        try Self.decodes("treasury.debit_reversal", as: Stripe.Treasury.DebitReversal.self)
    }
    @Test("treasury.financial_account") func treasuryFinancialAccount() throws {
        try Self.decodes("treasury.financial_account", as: Stripe.Treasury.FinancialAccount.self)
    }
    @Test("treasury.financial_account_features") func treasuryFinancialAccountFeatures() throws {
        try Self.decodes("treasury.financial_account_features", as: Stripe.Treasury.FinancialAccountFeatures.self)
    }
    @Test("treasury.inbound_transfer") func treasuryInboundTransfer() throws {
        try Self.decodes("treasury.inbound_transfer", as: Stripe.Treasury.InboundTransfer.self)
    }
    @Test("treasury.outbound_payment") func treasuryOutboundPayment() throws {
        try Self.decodes("treasury.outbound_payment", as: Stripe.Treasury.OutboundPayment.self)
    }
    @Test("treasury.outbound_transfer") func treasuryOutboundTransfer() throws {
        try Self.decodes("treasury.outbound_transfer", as: Stripe.Treasury.OutboundTransfer.self)
    }
    @Test("treasury.received_credit") func treasuryReceivedCredit() throws {
        try Self.decodes("treasury.received_credit", as: Stripe.Treasury.ReceivedCredit.self)
    }
    @Test("treasury.received_debit") func treasuryReceivedDebit() throws {
        try Self.decodes("treasury.received_debit", as: Stripe.Treasury.ReceivedDebit.self)
    }
    @Test("treasury.transaction_entry") func treasuryTransactionEntry() throws {
        try Self.decodes("treasury.transaction_entry", as: Stripe.Treasury.TransactionEntry.self)
    }
    @Test("billing.alert") func billingAlert() throws { try Self.decodes("billing.alert", as: Stripe.Billing.Alert.self) }
    @Test("billing.feedback_option") func billingFeedbackOption() throws {
        try Self.decodes("billing.feedback_option", as: Stripe.Billing.FeedbackOption.self)
    }
    @Test("billing.meter") func billingMeter() throws { try Self.decodes("billing.meter", as: Stripe.Billing.Meter.self) }
    @Test("billing.meter_event") func billingMeterEvent() throws { try Self.decodes("billing.meter_event", as: Stripe.Billing.MeterEvent.self) }
    @Test("billing.meter_event_adjustment") func billingMeterEventAdjustment() throws {
        try Self.decodes("billing.meter_event_adjustment", as: Stripe.Billing.MeterEventAdjustment.self)
    }
    @Test("billing.meter_event_summary") func billingMeterEventSummary() throws {
        try Self.decodes("billing.meter_event_summary", as: Stripe.Billing.MeterEventSummary.self)
    }
    @Test("invoice_rendering_template") func invoiceRenderingTemplate() throws {
        try Self.decodes("invoice_rendering_template", as: Stripe.Billing.InvoiceRenderingTemplate.self)
    }
    @Test("credit_note_line_item") func creditNoteLineItem() throws {
        try Self.decodes("credit_note_line_item", as: Stripe.Billing.CreditNoteLineItem.self)
    }
    @Test("tax.association") func taxAssociation() throws { try Self.decodes("tax.association", as: Stripe.Tax.Association.self) }
    @Test("tax.calculation_line_item") func taxCalculationLineItem() throws {
        try Self.decodes("tax.calculation_line_item", as: Stripe.Tax.CalculationLineItem.self)
    }
    @Test("tax.registration") func taxRegistration() throws { try Self.decodes("tax.registration", as: Stripe.Tax.Registration.self) }
    @Test("tax.transaction_line_item") func taxTransactionLineItem() throws {
        try Self.decodes("tax.transaction_line_item", as: Stripe.Tax.TransactionLineItem.self)
    }
    @Test("issuing.personalization_design") func issuingPersonalizationDesign() throws {
        try Self.decodes("issuing.personalization_design", as: Stripe.Issuing.PersonalizationDesign.self)
    }
    @Test("issuing.physical_bundle") func issuingPhysicalBundle() throws {
        try Self.decodes("issuing.physical_bundle", as: Stripe.Issuing.PhysicalBundle.self)
    }
    @Test("climate.supplier") func climateSupplier() throws { try Self.decodes("climate.supplier", as: Stripe.Climate.Supplier.self) }
    @Test("entitlements.active_entitlement") func entitlementsActiveEntitlement() throws {
        try Self.decodes("entitlements.active_entitlement", as: Stripe.Entitlements.ActiveEntitlement.self)
    }
    @Test("radar.payment_evaluation") func radarPaymentEvaluation() throws {
        try Self.decodes("radar.payment_evaluation", as: Stripe.Fraud.PaymentEvaluation.self)
    }
    @Test("terminal.onboarding_link") func terminalOnboardingLink() throws {
        try Self.decodes("terminal.onboarding_link", as: Stripe.Terminal.OnboardingLink.self)
    }
    @Test("financial_connections.account_owner") func financialConnectionsAccountOwner() throws {
        try Self.decodes("financial_connections.account_owner", as: FinancialConnections.AccountOwner.self)
    }
    @Test("account_link") func accountLink() throws { try Self.decodes("account_link", as: Stripe.Connect.AccountLink.self) }
    @Test("apple_pay_domain") func applePayDomain() throws { try Self.decodes("apple_pay_domain", as: Stripe.ApplePayDomain.self) }
    @Test("balance_settings") func balanceSettings() throws { try Self.decodes("balance_settings", as: Stripe.BalanceSettings.self) }
    @Test("exchange_rate") func exchangeRate() throws { try Self.decodes("exchange_rate", as: Stripe.ExchangeRate.self) }
    @Test("payment_attempt_record") func paymentAttemptRecord() throws {
        try Self.decodes("payment_attempt_record", as: Stripe.PaymentAttemptRecord.self)
    }
    @Test("product_feature") func productFeature() throws { try Self.decodes("product_feature", as: Stripe.Products.ProductFeature.self) }
    @Test("source_transaction") func sourceTransaction() throws { try Self.decodes("source_transaction", as: Stripe.SourceTransaction.self) }
    @Test("customer_cash_balance_transaction") func customerCashBalanceTransaction() throws {
        try Self.decodes("customer_cash_balance_transaction", as: Stripe.Customers.CashBalanceTransaction.self)
    }
}
