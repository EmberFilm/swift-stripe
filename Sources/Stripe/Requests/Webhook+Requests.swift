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

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Webhook {
    public enum Create {}
    public enum Delete {}
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/webhook_endpoints
extension Webhook.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Events sent to this endpoint will be generated with this Stripe Version instead of your account's default Stripe.
        public var apiVersion: ApiVersion?
        /// Whether this endpoint should receive events from connected accounts (`true`), or from your account (`false`).
        public var connect: Bool?
        /// An optional description of what the webhook is used for.
        public var description: String?
        /// The list of events to enable for this endpoint.
        public var enabledEvents: [EnabledEvents]
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?
        /// The URL of the webhook endpoint.
        public var url: String

        public init(
            apiVersion: ApiVersion? = nil,
            connect: Bool? = nil,
            description: String? = nil,
            enabledEvents: [EnabledEvents],
            expand: [String]? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil,
            url: String
        ) {
            self.apiVersion = apiVersion
            self.connect = connect
            self.description = description
            self.enabledEvents = enabledEvents
            self.expand = expand
            self.metadata = metadata
            self.url = url
        }

        public enum ApiVersion: String, Codable, Hashable, Sendable {
            case value2011_01_01 = "2011-01-01"
            case value2011_06_21 = "2011-06-21"
            case value2011_06_28 = "2011-06-28"
            case value2011_08_01 = "2011-08-01"
            case value2011_09_15 = "2011-09-15"
            case value2011_11_17 = "2011-11-17"
            case value2012_02_23 = "2012-02-23"
            case value2012_03_25 = "2012-03-25"
            case value2012_06_18 = "2012-06-18"
            case value2012_06_28 = "2012-06-28"
            case value2012_07_09 = "2012-07-09"
            case value2012_09_24 = "2012-09-24"
            case value2012_10_26 = "2012-10-26"
            case value2012_11_07 = "2012-11-07"
            case value2013_02_11 = "2013-02-11"
            case value2013_02_13 = "2013-02-13"
            case value2013_07_05 = "2013-07-05"
            case value2013_08_12 = "2013-08-12"
            case value2013_08_13 = "2013-08-13"
            case value2013_10_29 = "2013-10-29"
            case value2013_12_03 = "2013-12-03"
            case value2014_01_31 = "2014-01-31"
            case value2014_03_13 = "2014-03-13"
            case value2014_03_28 = "2014-03-28"
            case value2014_05_19 = "2014-05-19"
            case value2014_06_13 = "2014-06-13"
            case value2014_06_17 = "2014-06-17"
            case value2014_07_22 = "2014-07-22"
            case value2014_07_26 = "2014-07-26"
            case value2014_08_04 = "2014-08-04"
            case value2014_08_20 = "2014-08-20"
            case value2014_09_08 = "2014-09-08"
            case value2014_10_07 = "2014-10-07"
            case value2014_11_05 = "2014-11-05"
            case value2014_11_20 = "2014-11-20"
            case value2014_12_08 = "2014-12-08"
            case value2014_12_17 = "2014-12-17"
            case value2014_12_22 = "2014-12-22"
            case value2015_01_11 = "2015-01-11"
            case value2015_01_26 = "2015-01-26"
            case value2015_02_10 = "2015-02-10"
            case value2015_02_16 = "2015-02-16"
            case value2015_02_18 = "2015-02-18"
            case value2015_03_24 = "2015-03-24"
            case value2015_04_07 = "2015-04-07"
            case value2015_06_15 = "2015-06-15"
            case value2015_07_07 = "2015-07-07"
            case value2015_07_13 = "2015-07-13"
            case value2015_07_28 = "2015-07-28"
            case value2015_08_07 = "2015-08-07"
            case value2015_08_19 = "2015-08-19"
            case value2015_09_03 = "2015-09-03"
            case value2015_09_08 = "2015-09-08"
            case value2015_09_23 = "2015-09-23"
            case value2015_10_01 = "2015-10-01"
            case value2015_10_12 = "2015-10-12"
            case value2015_10_16 = "2015-10-16"
            case value2016_02_03 = "2016-02-03"
            case value2016_02_19 = "2016-02-19"
            case value2016_02_22 = "2016-02-22"
            case value2016_02_23 = "2016-02-23"
            case value2016_02_29 = "2016-02-29"
            case value2016_03_07 = "2016-03-07"
            case value2016_06_15 = "2016-06-15"
            case value2016_07_06 = "2016-07-06"
            case value2016_10_19 = "2016-10-19"
            case value2017_01_27 = "2017-01-27"
            case value2017_02_14 = "2017-02-14"
            case value2017_04_06 = "2017-04-06"
            case value2017_05_25 = "2017-05-25"
            case value2017_06_05 = "2017-06-05"
            case value2017_08_15 = "2017-08-15"
            case value2017_12_14 = "2017-12-14"
            case value2018_01_23 = "2018-01-23"
            case value2018_02_05 = "2018-02-05"
            case value2018_02_06 = "2018-02-06"
            case value2018_02_28 = "2018-02-28"
            case value2018_05_21 = "2018-05-21"
            case value2018_07_27 = "2018-07-27"
            case value2018_08_23 = "2018-08-23"
            case value2018_09_06 = "2018-09-06"
            case value2018_09_24 = "2018-09-24"
            case value2018_10_31 = "2018-10-31"
            case value2018_11_08 = "2018-11-08"
            case value2019_02_11 = "2019-02-11"
            case value2019_02_19 = "2019-02-19"
            case value2019_03_14 = "2019-03-14"
            case value2019_05_16 = "2019-05-16"
            case value2019_08_14 = "2019-08-14"
            case value2019_09_09 = "2019-09-09"
            case value2019_10_08 = "2019-10-08"
            case value2019_10_17 = "2019-10-17"
            case value2019_11_05 = "2019-11-05"
            case value2019_12_03 = "2019-12-03"
            case value2020_03_02 = "2020-03-02"
            case value2020_08_27 = "2020-08-27"
            case value2022_08_01 = "2022-08-01"
            case value2022_11_15 = "2022-11-15"
            case value2023_08_16 = "2023-08-16"
            case value2023_10_16 = "2023-10-16"
            case value2024_04_10 = "2024-04-10"
            case value2024_06_20 = "2024-06-20"
            case value2024_09_30_acacia = "2024-09-30.acacia"
            case value2024_10_28_acacia = "2024-10-28.acacia"
            case value2024_11_20_acacia = "2024-11-20.acacia"
            case value2024_12_18_acacia = "2024-12-18.acacia"
            case value2025_01_27_acacia = "2025-01-27.acacia"
            case value2025_02_24_acacia = "2025-02-24.acacia"
            case value2025_03_01_dashboard = "2025-03-01.dashboard"
            case value2025_03_31_basil = "2025-03-31.basil"
            case value2025_04_30_basil = "2025-04-30.basil"
            case value2025_05_28_basil = "2025-05-28.basil"
            case value2025_06_30_basil = "2025-06-30.basil"
            case value2025_07_30_basil = "2025-07-30.basil"
            case value2025_08_27_basil = "2025-08-27.basil"
            case value2025_09_30_clover = "2025-09-30.clover"
            case value2025_10_29_clover = "2025-10-29.clover"
            case value2025_11_17_clover = "2025-11-17.clover"
            case value2025_12_15_clover = "2025-12-15.clover"
            case value2026_01_28_clover = "2026-01-28.clover"
            case value2026_02_25_clover = "2026-02-25.clover"
            case value2026_03_25_dahlia = "2026-03-25.dahlia"
            case value2026_04_22_dahlia = "2026-04-22.dahlia"
            case value2026_05_27_dahlia = "2026-05-27.dahlia"
            case value2026_06_24_dahlia = "2026-06-24.dahlia"
            case value2026_07_29_dahlia = "2026-07-29.dahlia"
        }

        public enum EnabledEvents: String, Codable, Hashable, Sendable {
            case value_ = "*"
            case accountApplicationAuthorized = "account.application.authorized"
            case accountApplicationDeauthorized = "account.application.deauthorized"
            case accountExternalAccountCreated = "account.external_account.created"
            case accountExternalAccountDeleted = "account.external_account.deleted"
            case accountExternalAccountUpdated = "account.external_account.updated"
            case accountUpdated = "account.updated"
            case applicationFeeCreated = "application_fee.created"
            case applicationFeeRefundUpdated = "application_fee.refund.updated"
            case applicationFeeRefunded = "application_fee.refunded"
            case balanceAvailable = "balance.available"
            case balanceSettingsUpdated = "balance_settings.updated"
            case billingAlertTriggered = "billing.alert.triggered"
            case billingCreditBalanceTransactionCreated = "billing.credit_balance_transaction.created"
            case billingCreditGrantCreated = "billing.credit_grant.created"
            case billingCreditGrantUpdated = "billing.credit_grant.updated"
            case billingMeterCreated = "billing.meter.created"
            case billingMeterDeactivated = "billing.meter.deactivated"
            case billingMeterReactivated = "billing.meter.reactivated"
            case billingMeterUpdated = "billing.meter.updated"
            case billingPortalConfigurationCreated = "billing_portal.configuration.created"
            case billingPortalConfigurationUpdated = "billing_portal.configuration.updated"
            case billingPortalSessionCreated = "billing_portal.session.created"
            case capabilityUpdated = "capability.updated"
            case cashBalanceFundsAvailable = "cash_balance.funds_available"
            case chargeCaptured = "charge.captured"
            case chargeDisputeClosed = "charge.dispute.closed"
            case chargeDisputeCreated = "charge.dispute.created"
            case chargeDisputeFundsReinstated = "charge.dispute.funds_reinstated"
            case chargeDisputeFundsWithdrawn = "charge.dispute.funds_withdrawn"
            case chargeDisputeUpdated = "charge.dispute.updated"
            case chargeExpired = "charge.expired"
            case chargeFailed = "charge.failed"
            case chargePending = "charge.pending"
            case chargeRefundUpdated = "charge.refund.updated"
            case chargeRefunded = "charge.refunded"
            case chargeSucceeded = "charge.succeeded"
            case chargeUpdated = "charge.updated"
            case checkoutSessionAsyncPaymentFailed = "checkout.session.async_payment_failed"
            case checkoutSessionAsyncPaymentSucceeded = "checkout.session.async_payment_succeeded"
            case checkoutSessionCompleted = "checkout.session.completed"
            case checkoutSessionExpired = "checkout.session.expired"
            case climateOrderCanceled = "climate.order.canceled"
            case climateOrderCreated = "climate.order.created"
            case climateOrderDelayed = "climate.order.delayed"
            case climateOrderDelivered = "climate.order.delivered"
            case climateOrderProductSubstituted = "climate.order.product_substituted"
            case climateProductCreated = "climate.product.created"
            case climateProductPricingUpdated = "climate.product.pricing_updated"
            case couponCreated = "coupon.created"
            case couponDeleted = "coupon.deleted"
            case couponUpdated = "coupon.updated"
            case creditNoteCreated = "credit_note.created"
            case creditNoteUpdated = "credit_note.updated"
            case creditNoteVoided = "credit_note.voided"
            case customerCreated = "customer.created"
            case customerDeleted = "customer.deleted"
            case customerDiscountCreated = "customer.discount.created"
            case customerDiscountDeleted = "customer.discount.deleted"
            case customerDiscountUpdated = "customer.discount.updated"
            case customerSourceCreated = "customer.source.created"
            case customerSourceDeleted = "customer.source.deleted"
            case customerSourceExpiring = "customer.source.expiring"
            case customerSourceUpdated = "customer.source.updated"
            case customerSubscriptionCreated = "customer.subscription.created"
            case customerSubscriptionDeleted = "customer.subscription.deleted"
            case customerSubscriptionPaused = "customer.subscription.paused"
            case customerSubscriptionPendingUpdateApplied = "customer.subscription.pending_update_applied"
            case customerSubscriptionPendingUpdateExpired = "customer.subscription.pending_update_expired"
            case customerSubscriptionResumed = "customer.subscription.resumed"
            case customerSubscriptionTrialWillEnd = "customer.subscription.trial_will_end"
            case customerSubscriptionUpdated = "customer.subscription.updated"
            case customerTaxIdCreated = "customer.tax_id.created"
            case customerTaxIdDeleted = "customer.tax_id.deleted"
            case customerTaxIdUpdated = "customer.tax_id.updated"
            case customerUpdated = "customer.updated"
            case customerCashBalanceTransactionCreated = "customer_cash_balance_transaction.created"
            case entitlementsActiveEntitlementSummaryUpdated = "entitlements.active_entitlement_summary.updated"
            case fileCreated = "file.created"
            case financialConnectionsAccountAccountNumbersUpdated = "financial_connections.account.account_numbers_updated"
            case financialConnectionsAccountCreated = "financial_connections.account.created"
            case financialConnectionsAccountDeactivated = "financial_connections.account.deactivated"
            case financialConnectionsAccountDisconnected = "financial_connections.account.disconnected"
            case financialConnectionsAccountExpectedDeactivationDateUpdated = "financial_connections.account.expected_deactivation_date_updated"
            case financialConnectionsAccountReactivated = "financial_connections.account.reactivated"
            case financialConnectionsAccountRefreshedBalance = "financial_connections.account.refreshed_balance"
            case financialConnectionsAccountRefreshedOwnership = "financial_connections.account.refreshed_ownership"
            case financialConnectionsAccountRefreshedTransactions = "financial_connections.account.refreshed_transactions"
            case financialConnectionsAccountSupportedPaymentMethodTypesUpdated =
                "financial_connections.account.supported_payment_method_types_updated"
            case financialConnectionsAccountUpcomingAccountNumberExpiry = "financial_connections.account.upcoming_account_number_expiry"
            case financialConnectionsAccountUpcomingDeactivation = "financial_connections.account.upcoming_deactivation"
            case financialConnectionsAuthorizationExpectedDeactivationDateUpdated =
                "financial_connections.authorization.expected_deactivation_date_updated"
            case financialConnectionsAuthorizationUpcomingDeactivation = "financial_connections.authorization.upcoming_deactivation"
            case identityVerificationSessionCanceled = "identity.verification_session.canceled"
            case identityVerificationSessionCreated = "identity.verification_session.created"
            case identityVerificationSessionProcessing = "identity.verification_session.processing"
            case identityVerificationSessionRedacted = "identity.verification_session.redacted"
            case identityVerificationSessionRequiresInput = "identity.verification_session.requires_input"
            case identityVerificationSessionVerified = "identity.verification_session.verified"
            case invoiceCreated = "invoice.created"
            case invoiceDeleted = "invoice.deleted"
            case invoiceFinalizationFailed = "invoice.finalization_failed"
            case invoiceFinalized = "invoice.finalized"
            case invoiceMarkedUncollectible = "invoice.marked_uncollectible"
            case invoiceOverdue = "invoice.overdue"
            case invoiceOverpaid = "invoice.overpaid"
            case invoicePaid = "invoice.paid"
            case invoicePaymentActionRequired = "invoice.payment_action_required"
            case invoicePaymentAttemptRequired = "invoice.payment_attempt_required"
            case invoicePaymentFailed = "invoice.payment_failed"
            case invoicePaymentSucceeded = "invoice.payment_succeeded"
            case invoiceSent = "invoice.sent"
            case invoiceUpcoming = "invoice.upcoming"
            case invoiceUpdated = "invoice.updated"
            case invoiceVoided = "invoice.voided"
            case invoiceWillBeDue = "invoice.will_be_due"
            case invoicePaymentPaid = "invoice_payment.paid"
            case invoiceitemCreated = "invoiceitem.created"
            case invoiceitemDeleted = "invoiceitem.deleted"
            case issuingAuthorizationCreated = "issuing_authorization.created"
            case issuingAuthorizationRequest = "issuing_authorization.request"
            case issuingAuthorizationUpdated = "issuing_authorization.updated"
            case issuingCardCreated = "issuing_card.created"
            case issuingCardUpdated = "issuing_card.updated"
            case issuingCardholderCreated = "issuing_cardholder.created"
            case issuingCardholderUpdated = "issuing_cardholder.updated"
            case issuingDisputeClosed = "issuing_dispute.closed"
            case issuingDisputeCreated = "issuing_dispute.created"
            case issuingDisputeFundsReinstated = "issuing_dispute.funds_reinstated"
            case issuingDisputeFundsRescinded = "issuing_dispute.funds_rescinded"
            case issuingDisputeSubmitted = "issuing_dispute.submitted"
            case issuingDisputeUpdated = "issuing_dispute.updated"
            case issuingPersonalizationDesignActivated = "issuing_personalization_design.activated"
            case issuingPersonalizationDesignDeactivated = "issuing_personalization_design.deactivated"
            case issuingPersonalizationDesignRejected = "issuing_personalization_design.rejected"
            case issuingPersonalizationDesignUpdated = "issuing_personalization_design.updated"
            case issuingTokenCreated = "issuing_token.created"
            case issuingTokenUpdated = "issuing_token.updated"
            case issuingTransactionCreated = "issuing_transaction.created"
            case issuingTransactionPurchaseDetailsReceiptUpdated = "issuing_transaction.purchase_details_receipt_updated"
            case issuingTransactionUpdated = "issuing_transaction.updated"
            case mandateUpdated = "mandate.updated"
            case paymentIntentAmountCapturableUpdated = "payment_intent.amount_capturable_updated"
            case paymentIntentCanceled = "payment_intent.canceled"
            case paymentIntentCreated = "payment_intent.created"
            case paymentIntentPartiallyFunded = "payment_intent.partially_funded"
            case paymentIntentPaymentFailed = "payment_intent.payment_failed"
            case paymentIntentProcessing = "payment_intent.processing"
            case paymentIntentRequiresAction = "payment_intent.requires_action"
            case paymentIntentSucceeded = "payment_intent.succeeded"
            case paymentLinkCreated = "payment_link.created"
            case paymentLinkUpdated = "payment_link.updated"
            case paymentMethodAttached = "payment_method.attached"
            case paymentMethodAutomaticallyUpdated = "payment_method.automatically_updated"
            case paymentMethodDetached = "payment_method.detached"
            case paymentMethodUpdated = "payment_method.updated"
            case payoutCanceled = "payout.canceled"
            case payoutCreated = "payout.created"
            case payoutFailed = "payout.failed"
            case payoutPaid = "payout.paid"
            case payoutReconciliationCompleted = "payout.reconciliation_completed"
            case payoutUpdated = "payout.updated"
            case personCreated = "person.created"
            case personDeleted = "person.deleted"
            case personUpdated = "person.updated"
            case planCreated = "plan.created"
            case planDeleted = "plan.deleted"
            case planUpdated = "plan.updated"
            case priceCreated = "price.created"
            case priceDeleted = "price.deleted"
            case priceUpdated = "price.updated"
            case productCreated = "product.created"
            case productDeleted = "product.deleted"
            case productUpdated = "product.updated"
            case promotionCodeCreated = "promotion_code.created"
            case promotionCodeUpdated = "promotion_code.updated"
            case quoteAccepted = "quote.accepted"
            case quoteCanceled = "quote.canceled"
            case quoteCreated = "quote.created"
            case quoteFinalized = "quote.finalized"
            case radarEarlyFraudWarningCreated = "radar.early_fraud_warning.created"
            case radarEarlyFraudWarningUpdated = "radar.early_fraud_warning.updated"
            case refundCreated = "refund.created"
            case refundFailed = "refund.failed"
            case refundUpdated = "refund.updated"
            case reportingReportRunFailed = "reporting.report_run.failed"
            case reportingReportRunSucceeded = "reporting.report_run.succeeded"
            case reportingReportTypeUpdated = "reporting.report_type.updated"
            case reserveHoldCreated = "reserve.hold.created"
            case reserveHoldUpdated = "reserve.hold.updated"
            case reservePlanCreated = "reserve.plan.created"
            case reservePlanDisabled = "reserve.plan.disabled"
            case reservePlanExpired = "reserve.plan.expired"
            case reservePlanUpdated = "reserve.plan.updated"
            case reserveReleaseCreated = "reserve.release.created"
            case reviewClosed = "review.closed"
            case reviewOpened = "review.opened"
            case setupIntentCanceled = "setup_intent.canceled"
            case setupIntentCreated = "setup_intent.created"
            case setupIntentRequiresAction = "setup_intent.requires_action"
            case setupIntentSetupFailed = "setup_intent.setup_failed"
            case setupIntentSucceeded = "setup_intent.succeeded"
            case sigmaScheduledQueryRunCreated = "sigma.scheduled_query_run.created"
            case sourceCanceled = "source.canceled"
            case sourceChargeable = "source.chargeable"
            case sourceFailed = "source.failed"
            case sourceMandateNotification = "source.mandate_notification"
            case sourceRefundAttributesRequired = "source.refund_attributes_required"
            case sourceTransactionCreated = "source.transaction.created"
            case sourceTransactionUpdated = "source.transaction.updated"
            case subscriptionScheduleAborted = "subscription_schedule.aborted"
            case subscriptionScheduleCanceled = "subscription_schedule.canceled"
            case subscriptionScheduleCompleted = "subscription_schedule.completed"
            case subscriptionScheduleCreated = "subscription_schedule.created"
            case subscriptionScheduleExpiring = "subscription_schedule.expiring"
            case subscriptionScheduleReleased = "subscription_schedule.released"
            case subscriptionScheduleUpdated = "subscription_schedule.updated"
            case taxSettingsUpdated = "tax.settings.updated"
            case taxRateCreated = "tax_rate.created"
            case taxRateUpdated = "tax_rate.updated"
            case terminalReaderActionFailed = "terminal.reader.action_failed"
            case terminalReaderActionSucceeded = "terminal.reader.action_succeeded"
            case terminalReaderActionUpdated = "terminal.reader.action_updated"
            case testHelpersTestClockAdvancing = "test_helpers.test_clock.advancing"
            case testHelpersTestClockCreated = "test_helpers.test_clock.created"
            case testHelpersTestClockDeleted = "test_helpers.test_clock.deleted"
            case testHelpersTestClockInternalFailure = "test_helpers.test_clock.internal_failure"
            case testHelpersTestClockReady = "test_helpers.test_clock.ready"
            case topupCanceled = "topup.canceled"
            case topupCreated = "topup.created"
            case topupFailed = "topup.failed"
            case topupReversed = "topup.reversed"
            case topupSucceeded = "topup.succeeded"
            case transferCreated = "transfer.created"
            case transferReversed = "transfer.reversed"
            case transferUpdated = "transfer.updated"
            case treasuryCreditReversalCreated = "treasury.credit_reversal.created"
            case treasuryCreditReversalPosted = "treasury.credit_reversal.posted"
            case treasuryDebitReversalCompleted = "treasury.debit_reversal.completed"
            case treasuryDebitReversalCreated = "treasury.debit_reversal.created"
            case treasuryDebitReversalInitialCreditGranted = "treasury.debit_reversal.initial_credit_granted"
            case treasuryFinancialAccountClosed = "treasury.financial_account.closed"
            case treasuryFinancialAccountCreated = "treasury.financial_account.created"
            case treasuryFinancialAccountFeaturesStatusUpdated = "treasury.financial_account.features_status_updated"
            case treasuryInboundTransferCanceled = "treasury.inbound_transfer.canceled"
            case treasuryInboundTransferCreated = "treasury.inbound_transfer.created"
            case treasuryInboundTransferFailed = "treasury.inbound_transfer.failed"
            case treasuryInboundTransferSucceeded = "treasury.inbound_transfer.succeeded"
            case treasuryOutboundPaymentCanceled = "treasury.outbound_payment.canceled"
            case treasuryOutboundPaymentCreated = "treasury.outbound_payment.created"
            case treasuryOutboundPaymentExpectedArrivalDateUpdated = "treasury.outbound_payment.expected_arrival_date_updated"
            case treasuryOutboundPaymentFailed = "treasury.outbound_payment.failed"
            case treasuryOutboundPaymentPosted = "treasury.outbound_payment.posted"
            case treasuryOutboundPaymentReturned = "treasury.outbound_payment.returned"
            case treasuryOutboundPaymentTrackingDetailsUpdated = "treasury.outbound_payment.tracking_details_updated"
            case treasuryOutboundTransferCanceled = "treasury.outbound_transfer.canceled"
            case treasuryOutboundTransferCreated = "treasury.outbound_transfer.created"
            case treasuryOutboundTransferExpectedArrivalDateUpdated = "treasury.outbound_transfer.expected_arrival_date_updated"
            case treasuryOutboundTransferFailed = "treasury.outbound_transfer.failed"
            case treasuryOutboundTransferPosted = "treasury.outbound_transfer.posted"
            case treasuryOutboundTransferReturned = "treasury.outbound_transfer.returned"
            case treasuryOutboundTransferTrackingDetailsUpdated = "treasury.outbound_transfer.tracking_details_updated"
            case treasuryReceivedCreditCreated = "treasury.received_credit.created"
            case treasuryReceivedCreditFailed = "treasury.received_credit.failed"
            case treasuryReceivedCreditSucceeded = "treasury.received_credit.succeeded"
            case treasuryReceivedDebitCreated = "treasury.received_debit.created"
        }
    }

    public typealias Response = Webhook
}

// DELETE /v1/webhook_endpoints/{webhook_endpoint}
extension Webhook.Delete {
    public typealias Response = DeletedObject<Webhook>
}

// GET /v1/webhook_endpoints
extension Webhook.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Webhook>
}

// GET /v1/webhook_endpoints/{webhook_endpoint}
extension Webhook.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Webhook
}

// POST /v1/webhook_endpoints/{webhook_endpoint}
extension Webhook.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// An optional description of what the webhook is used for.
        public var description: String?
        /// Disable the webhook endpoint if set to true.
        public var disabled: Bool?
        /// The list of events to enable for this endpoint.
        public var enabledEvents: [EnabledEvents]?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?
        /// The URL of the webhook endpoint.
        public var url: String?

        public init(
            description: String? = nil,
            disabled: Bool? = nil,
            enabledEvents: [EnabledEvents]? = nil,
            expand: [String]? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil,
            url: String? = nil
        ) {
            self.description = description
            self.disabled = disabled
            self.enabledEvents = enabledEvents
            self.expand = expand
            self.metadata = metadata
            self.url = url
        }

        public enum EnabledEvents: String, Codable, Hashable, Sendable {
            case value_ = "*"
            case accountApplicationAuthorized = "account.application.authorized"
            case accountApplicationDeauthorized = "account.application.deauthorized"
            case accountExternalAccountCreated = "account.external_account.created"
            case accountExternalAccountDeleted = "account.external_account.deleted"
            case accountExternalAccountUpdated = "account.external_account.updated"
            case accountUpdated = "account.updated"
            case applicationFeeCreated = "application_fee.created"
            case applicationFeeRefundUpdated = "application_fee.refund.updated"
            case applicationFeeRefunded = "application_fee.refunded"
            case balanceAvailable = "balance.available"
            case balanceSettingsUpdated = "balance_settings.updated"
            case billingAlertTriggered = "billing.alert.triggered"
            case billingCreditBalanceTransactionCreated = "billing.credit_balance_transaction.created"
            case billingCreditGrantCreated = "billing.credit_grant.created"
            case billingCreditGrantUpdated = "billing.credit_grant.updated"
            case billingMeterCreated = "billing.meter.created"
            case billingMeterDeactivated = "billing.meter.deactivated"
            case billingMeterReactivated = "billing.meter.reactivated"
            case billingMeterUpdated = "billing.meter.updated"
            case billingPortalConfigurationCreated = "billing_portal.configuration.created"
            case billingPortalConfigurationUpdated = "billing_portal.configuration.updated"
            case billingPortalSessionCreated = "billing_portal.session.created"
            case capabilityUpdated = "capability.updated"
            case cashBalanceFundsAvailable = "cash_balance.funds_available"
            case chargeCaptured = "charge.captured"
            case chargeDisputeClosed = "charge.dispute.closed"
            case chargeDisputeCreated = "charge.dispute.created"
            case chargeDisputeFundsReinstated = "charge.dispute.funds_reinstated"
            case chargeDisputeFundsWithdrawn = "charge.dispute.funds_withdrawn"
            case chargeDisputeUpdated = "charge.dispute.updated"
            case chargeExpired = "charge.expired"
            case chargeFailed = "charge.failed"
            case chargePending = "charge.pending"
            case chargeRefundUpdated = "charge.refund.updated"
            case chargeRefunded = "charge.refunded"
            case chargeSucceeded = "charge.succeeded"
            case chargeUpdated = "charge.updated"
            case checkoutSessionAsyncPaymentFailed = "checkout.session.async_payment_failed"
            case checkoutSessionAsyncPaymentSucceeded = "checkout.session.async_payment_succeeded"
            case checkoutSessionCompleted = "checkout.session.completed"
            case checkoutSessionExpired = "checkout.session.expired"
            case climateOrderCanceled = "climate.order.canceled"
            case climateOrderCreated = "climate.order.created"
            case climateOrderDelayed = "climate.order.delayed"
            case climateOrderDelivered = "climate.order.delivered"
            case climateOrderProductSubstituted = "climate.order.product_substituted"
            case climateProductCreated = "climate.product.created"
            case climateProductPricingUpdated = "climate.product.pricing_updated"
            case couponCreated = "coupon.created"
            case couponDeleted = "coupon.deleted"
            case couponUpdated = "coupon.updated"
            case creditNoteCreated = "credit_note.created"
            case creditNoteUpdated = "credit_note.updated"
            case creditNoteVoided = "credit_note.voided"
            case customerCreated = "customer.created"
            case customerDeleted = "customer.deleted"
            case customerDiscountCreated = "customer.discount.created"
            case customerDiscountDeleted = "customer.discount.deleted"
            case customerDiscountUpdated = "customer.discount.updated"
            case customerSourceCreated = "customer.source.created"
            case customerSourceDeleted = "customer.source.deleted"
            case customerSourceExpiring = "customer.source.expiring"
            case customerSourceUpdated = "customer.source.updated"
            case customerSubscriptionCreated = "customer.subscription.created"
            case customerSubscriptionDeleted = "customer.subscription.deleted"
            case customerSubscriptionPaused = "customer.subscription.paused"
            case customerSubscriptionPendingUpdateApplied = "customer.subscription.pending_update_applied"
            case customerSubscriptionPendingUpdateExpired = "customer.subscription.pending_update_expired"
            case customerSubscriptionResumed = "customer.subscription.resumed"
            case customerSubscriptionTrialWillEnd = "customer.subscription.trial_will_end"
            case customerSubscriptionUpdated = "customer.subscription.updated"
            case customerTaxIdCreated = "customer.tax_id.created"
            case customerTaxIdDeleted = "customer.tax_id.deleted"
            case customerTaxIdUpdated = "customer.tax_id.updated"
            case customerUpdated = "customer.updated"
            case customerCashBalanceTransactionCreated = "customer_cash_balance_transaction.created"
            case entitlementsActiveEntitlementSummaryUpdated = "entitlements.active_entitlement_summary.updated"
            case fileCreated = "file.created"
            case financialConnectionsAccountAccountNumbersUpdated = "financial_connections.account.account_numbers_updated"
            case financialConnectionsAccountCreated = "financial_connections.account.created"
            case financialConnectionsAccountDeactivated = "financial_connections.account.deactivated"
            case financialConnectionsAccountDisconnected = "financial_connections.account.disconnected"
            case financialConnectionsAccountExpectedDeactivationDateUpdated = "financial_connections.account.expected_deactivation_date_updated"
            case financialConnectionsAccountReactivated = "financial_connections.account.reactivated"
            case financialConnectionsAccountRefreshedBalance = "financial_connections.account.refreshed_balance"
            case financialConnectionsAccountRefreshedOwnership = "financial_connections.account.refreshed_ownership"
            case financialConnectionsAccountRefreshedTransactions = "financial_connections.account.refreshed_transactions"
            case financialConnectionsAccountSupportedPaymentMethodTypesUpdated =
                "financial_connections.account.supported_payment_method_types_updated"
            case financialConnectionsAccountUpcomingAccountNumberExpiry = "financial_connections.account.upcoming_account_number_expiry"
            case financialConnectionsAccountUpcomingDeactivation = "financial_connections.account.upcoming_deactivation"
            case financialConnectionsAuthorizationExpectedDeactivationDateUpdated =
                "financial_connections.authorization.expected_deactivation_date_updated"
            case financialConnectionsAuthorizationUpcomingDeactivation = "financial_connections.authorization.upcoming_deactivation"
            case identityVerificationSessionCanceled = "identity.verification_session.canceled"
            case identityVerificationSessionCreated = "identity.verification_session.created"
            case identityVerificationSessionProcessing = "identity.verification_session.processing"
            case identityVerificationSessionRedacted = "identity.verification_session.redacted"
            case identityVerificationSessionRequiresInput = "identity.verification_session.requires_input"
            case identityVerificationSessionVerified = "identity.verification_session.verified"
            case invoiceCreated = "invoice.created"
            case invoiceDeleted = "invoice.deleted"
            case invoiceFinalizationFailed = "invoice.finalization_failed"
            case invoiceFinalized = "invoice.finalized"
            case invoiceMarkedUncollectible = "invoice.marked_uncollectible"
            case invoiceOverdue = "invoice.overdue"
            case invoiceOverpaid = "invoice.overpaid"
            case invoicePaid = "invoice.paid"
            case invoicePaymentActionRequired = "invoice.payment_action_required"
            case invoicePaymentAttemptRequired = "invoice.payment_attempt_required"
            case invoicePaymentFailed = "invoice.payment_failed"
            case invoicePaymentSucceeded = "invoice.payment_succeeded"
            case invoiceSent = "invoice.sent"
            case invoiceUpcoming = "invoice.upcoming"
            case invoiceUpdated = "invoice.updated"
            case invoiceVoided = "invoice.voided"
            case invoiceWillBeDue = "invoice.will_be_due"
            case invoicePaymentPaid = "invoice_payment.paid"
            case invoiceitemCreated = "invoiceitem.created"
            case invoiceitemDeleted = "invoiceitem.deleted"
            case issuingAuthorizationCreated = "issuing_authorization.created"
            case issuingAuthorizationRequest = "issuing_authorization.request"
            case issuingAuthorizationUpdated = "issuing_authorization.updated"
            case issuingCardCreated = "issuing_card.created"
            case issuingCardUpdated = "issuing_card.updated"
            case issuingCardholderCreated = "issuing_cardholder.created"
            case issuingCardholderUpdated = "issuing_cardholder.updated"
            case issuingDisputeClosed = "issuing_dispute.closed"
            case issuingDisputeCreated = "issuing_dispute.created"
            case issuingDisputeFundsReinstated = "issuing_dispute.funds_reinstated"
            case issuingDisputeFundsRescinded = "issuing_dispute.funds_rescinded"
            case issuingDisputeSubmitted = "issuing_dispute.submitted"
            case issuingDisputeUpdated = "issuing_dispute.updated"
            case issuingPersonalizationDesignActivated = "issuing_personalization_design.activated"
            case issuingPersonalizationDesignDeactivated = "issuing_personalization_design.deactivated"
            case issuingPersonalizationDesignRejected = "issuing_personalization_design.rejected"
            case issuingPersonalizationDesignUpdated = "issuing_personalization_design.updated"
            case issuingTokenCreated = "issuing_token.created"
            case issuingTokenUpdated = "issuing_token.updated"
            case issuingTransactionCreated = "issuing_transaction.created"
            case issuingTransactionPurchaseDetailsReceiptUpdated = "issuing_transaction.purchase_details_receipt_updated"
            case issuingTransactionUpdated = "issuing_transaction.updated"
            case mandateUpdated = "mandate.updated"
            case paymentIntentAmountCapturableUpdated = "payment_intent.amount_capturable_updated"
            case paymentIntentCanceled = "payment_intent.canceled"
            case paymentIntentCreated = "payment_intent.created"
            case paymentIntentPartiallyFunded = "payment_intent.partially_funded"
            case paymentIntentPaymentFailed = "payment_intent.payment_failed"
            case paymentIntentProcessing = "payment_intent.processing"
            case paymentIntentRequiresAction = "payment_intent.requires_action"
            case paymentIntentSucceeded = "payment_intent.succeeded"
            case paymentLinkCreated = "payment_link.created"
            case paymentLinkUpdated = "payment_link.updated"
            case paymentMethodAttached = "payment_method.attached"
            case paymentMethodAutomaticallyUpdated = "payment_method.automatically_updated"
            case paymentMethodDetached = "payment_method.detached"
            case paymentMethodUpdated = "payment_method.updated"
            case payoutCanceled = "payout.canceled"
            case payoutCreated = "payout.created"
            case payoutFailed = "payout.failed"
            case payoutPaid = "payout.paid"
            case payoutReconciliationCompleted = "payout.reconciliation_completed"
            case payoutUpdated = "payout.updated"
            case personCreated = "person.created"
            case personDeleted = "person.deleted"
            case personUpdated = "person.updated"
            case planCreated = "plan.created"
            case planDeleted = "plan.deleted"
            case planUpdated = "plan.updated"
            case priceCreated = "price.created"
            case priceDeleted = "price.deleted"
            case priceUpdated = "price.updated"
            case productCreated = "product.created"
            case productDeleted = "product.deleted"
            case productUpdated = "product.updated"
            case promotionCodeCreated = "promotion_code.created"
            case promotionCodeUpdated = "promotion_code.updated"
            case quoteAccepted = "quote.accepted"
            case quoteCanceled = "quote.canceled"
            case quoteCreated = "quote.created"
            case quoteFinalized = "quote.finalized"
            case radarEarlyFraudWarningCreated = "radar.early_fraud_warning.created"
            case radarEarlyFraudWarningUpdated = "radar.early_fraud_warning.updated"
            case refundCreated = "refund.created"
            case refundFailed = "refund.failed"
            case refundUpdated = "refund.updated"
            case reportingReportRunFailed = "reporting.report_run.failed"
            case reportingReportRunSucceeded = "reporting.report_run.succeeded"
            case reportingReportTypeUpdated = "reporting.report_type.updated"
            case reserveHoldCreated = "reserve.hold.created"
            case reserveHoldUpdated = "reserve.hold.updated"
            case reservePlanCreated = "reserve.plan.created"
            case reservePlanDisabled = "reserve.plan.disabled"
            case reservePlanExpired = "reserve.plan.expired"
            case reservePlanUpdated = "reserve.plan.updated"
            case reserveReleaseCreated = "reserve.release.created"
            case reviewClosed = "review.closed"
            case reviewOpened = "review.opened"
            case setupIntentCanceled = "setup_intent.canceled"
            case setupIntentCreated = "setup_intent.created"
            case setupIntentRequiresAction = "setup_intent.requires_action"
            case setupIntentSetupFailed = "setup_intent.setup_failed"
            case setupIntentSucceeded = "setup_intent.succeeded"
            case sigmaScheduledQueryRunCreated = "sigma.scheduled_query_run.created"
            case sourceCanceled = "source.canceled"
            case sourceChargeable = "source.chargeable"
            case sourceFailed = "source.failed"
            case sourceMandateNotification = "source.mandate_notification"
            case sourceRefundAttributesRequired = "source.refund_attributes_required"
            case sourceTransactionCreated = "source.transaction.created"
            case sourceTransactionUpdated = "source.transaction.updated"
            case subscriptionScheduleAborted = "subscription_schedule.aborted"
            case subscriptionScheduleCanceled = "subscription_schedule.canceled"
            case subscriptionScheduleCompleted = "subscription_schedule.completed"
            case subscriptionScheduleCreated = "subscription_schedule.created"
            case subscriptionScheduleExpiring = "subscription_schedule.expiring"
            case subscriptionScheduleReleased = "subscription_schedule.released"
            case subscriptionScheduleUpdated = "subscription_schedule.updated"
            case taxSettingsUpdated = "tax.settings.updated"
            case taxRateCreated = "tax_rate.created"
            case taxRateUpdated = "tax_rate.updated"
            case terminalReaderActionFailed = "terminal.reader.action_failed"
            case terminalReaderActionSucceeded = "terminal.reader.action_succeeded"
            case terminalReaderActionUpdated = "terminal.reader.action_updated"
            case testHelpersTestClockAdvancing = "test_helpers.test_clock.advancing"
            case testHelpersTestClockCreated = "test_helpers.test_clock.created"
            case testHelpersTestClockDeleted = "test_helpers.test_clock.deleted"
            case testHelpersTestClockInternalFailure = "test_helpers.test_clock.internal_failure"
            case testHelpersTestClockReady = "test_helpers.test_clock.ready"
            case topupCanceled = "topup.canceled"
            case topupCreated = "topup.created"
            case topupFailed = "topup.failed"
            case topupReversed = "topup.reversed"
            case topupSucceeded = "topup.succeeded"
            case transferCreated = "transfer.created"
            case transferReversed = "transfer.reversed"
            case transferUpdated = "transfer.updated"
            case treasuryCreditReversalCreated = "treasury.credit_reversal.created"
            case treasuryCreditReversalPosted = "treasury.credit_reversal.posted"
            case treasuryDebitReversalCompleted = "treasury.debit_reversal.completed"
            case treasuryDebitReversalCreated = "treasury.debit_reversal.created"
            case treasuryDebitReversalInitialCreditGranted = "treasury.debit_reversal.initial_credit_granted"
            case treasuryFinancialAccountClosed = "treasury.financial_account.closed"
            case treasuryFinancialAccountCreated = "treasury.financial_account.created"
            case treasuryFinancialAccountFeaturesStatusUpdated = "treasury.financial_account.features_status_updated"
            case treasuryInboundTransferCanceled = "treasury.inbound_transfer.canceled"
            case treasuryInboundTransferCreated = "treasury.inbound_transfer.created"
            case treasuryInboundTransferFailed = "treasury.inbound_transfer.failed"
            case treasuryInboundTransferSucceeded = "treasury.inbound_transfer.succeeded"
            case treasuryOutboundPaymentCanceled = "treasury.outbound_payment.canceled"
            case treasuryOutboundPaymentCreated = "treasury.outbound_payment.created"
            case treasuryOutboundPaymentExpectedArrivalDateUpdated = "treasury.outbound_payment.expected_arrival_date_updated"
            case treasuryOutboundPaymentFailed = "treasury.outbound_payment.failed"
            case treasuryOutboundPaymentPosted = "treasury.outbound_payment.posted"
            case treasuryOutboundPaymentReturned = "treasury.outbound_payment.returned"
            case treasuryOutboundPaymentTrackingDetailsUpdated = "treasury.outbound_payment.tracking_details_updated"
            case treasuryOutboundTransferCanceled = "treasury.outbound_transfer.canceled"
            case treasuryOutboundTransferCreated = "treasury.outbound_transfer.created"
            case treasuryOutboundTransferExpectedArrivalDateUpdated = "treasury.outbound_transfer.expected_arrival_date_updated"
            case treasuryOutboundTransferFailed = "treasury.outbound_transfer.failed"
            case treasuryOutboundTransferPosted = "treasury.outbound_transfer.posted"
            case treasuryOutboundTransferReturned = "treasury.outbound_transfer.returned"
            case treasuryOutboundTransferTrackingDetailsUpdated = "treasury.outbound_transfer.tracking_details_updated"
            case treasuryReceivedCreditCreated = "treasury.received_credit.created"
            case treasuryReceivedCreditFailed = "treasury.received_credit.failed"
            case treasuryReceivedCreditSucceeded = "treasury.received_credit.succeeded"
            case treasuryReceivedDebitCreated = "treasury.received_debit.created"
        }
    }

    public typealias Response = Webhook
}
