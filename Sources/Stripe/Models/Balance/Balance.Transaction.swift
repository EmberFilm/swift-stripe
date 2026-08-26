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

extension Stripe.Balance {
    /// Balance transactions represent funds moving through your Stripe account.
    public struct Transaction: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Gross amount of this transaction (in cents (or local equivalent)).
        public var amount: Int?
        /// The date that the transaction's net funds become available in the Stripe balance.
        public var availableOn: Date?
        /// The balance that this transaction impacts.
        public var balanceType: BalanceType?
        /// Time at which the object was created.
        public var created: Date?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// If applicable, this transaction uses an exchange rate.
        public var exchangeRate: Double?
        /// Fees (in cents (or local equivalent)) paid for this transaction.
        public var fee: Int?
        /// Detailed breakdown of fees (in cents (or local equivalent)) paid for this transaction.
        public var feeDetails: [FeeDetails]?
        /// Net impact to a Stripe balance (in cents (or local equivalent)).
        public var net: Int?
        /// Learn more about how reporting categories can help you understand balance transactions from an accounting perspective.
        public var reportingCategory: String?
        /// This transaction relates to the Stripe object.
        @Expandable<Stripe.BalanceTransactionSource, String> public var source: String?
        /// The transaction's net funds status in the Stripe balance, which are either `available` or `pending`.
        public var status: String?
        /// Transaction type: `tax_fund`, `adjustment`, `advance`, `advance_funding`, `anticipation_repayment`.
        public var `type`: Type?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            availableOn: Date? = nil,
            balanceType: BalanceType? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            exchangeRate: Double? = nil,
            fee: Int? = nil,
            feeDetails: [FeeDetails]? = nil,
            net: Int? = nil,
            reportingCategory: String? = nil,
            source: String? = nil,
            status: String? = nil,
            `type`: Type? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.availableOn = availableOn
            self.balanceType = balanceType
            self.created = created
            self.currency = currency
            self.description = description
            self.exchangeRate = exchangeRate
            self.fee = fee
            self.feeDetails = feeDetails
            self.net = net
            self.reportingCategory = reportingCategory
            self._source = Expandable(id: source)
            self.status = status
            self.`type` = `type`
        }

        /// The balance that this transaction impacts.
        public enum BalanceType: String, Codable, Hashable, Sendable {
            case issuing
            case payments
            case refundAndDisputePrefunding = "refund_and_dispute_prefunding"
            case riskReserved = "risk_reserved"
        }

        /// Transaction type: `tax_fund`, `adjustment`, `advance`, `advance_funding`, `anticipation_repayment`.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case adjustment
            case advance
            case advanceFunding = "advance_funding"
            case anticipationRepayment = "anticipation_repayment"
            case applicationFee = "application_fee"
            case applicationFeeRefund = "application_fee_refund"
            case charge
            case climateOrderPurchase = "climate_order_purchase"
            case climateOrderRefund = "climate_order_refund"
            case connectCollectionTransfer = "connect_collection_transfer"
            case contribution
            case feeCreditFunding = "fee_credit_funding"
            case inboundTransfer = "inbound_transfer"
            case inboundTransferReversal = "inbound_transfer_reversal"
            case issuingAuthorizationHold = "issuing_authorization_hold"
            case issuingAuthorizationRelease = "issuing_authorization_release"
            case issuingDispute = "issuing_dispute"
            case issuingTransaction = "issuing_transaction"
            case obligationOutbound = "obligation_outbound"
            case obligationReversalInbound = "obligation_reversal_inbound"
            case payment
            case paymentFailureRefund = "payment_failure_refund"
            case paymentNetworkReserveHold = "payment_network_reserve_hold"
            case paymentNetworkReserveRelease = "payment_network_reserve_release"
            case paymentRefund = "payment_refund"
            case paymentReversal = "payment_reversal"
            case paymentUnreconciled = "payment_unreconciled"
            case payout
            case payoutCancel = "payout_cancel"
            case payoutFailure = "payout_failure"
            case payoutMinimumBalanceHold = "payout_minimum_balance_hold"
            case payoutMinimumBalanceRelease = "payout_minimum_balance_release"
            case refund
            case refundFailure = "refund_failure"
            case reserveHold = "reserve_hold"
            case reserveRelease = "reserve_release"
            case reserveTransaction = "reserve_transaction"
            case reservedFunds = "reserved_funds"
            case stripeBalancePaymentDebit = "stripe_balance_payment_debit"
            case stripeBalancePaymentDebitReversal = "stripe_balance_payment_debit_reversal"
            case stripeFee = "stripe_fee"
            case stripeFxFee = "stripe_fx_fee"
            case taxFee = "tax_fee"
            case taxFund = "tax_fund"
            case topup
            case topupReversal = "topup_reversal"
            case transfer
            case transferCancel = "transfer_cancel"
            case transferFailure = "transfer_failure"
            case transferRefund = "transfer_refund"
        }

        public struct FeeDetails: Codable, Hashable, Sendable {
            /// Amount of the fee, in cents.
            public var amount: Int?
            /// ID of the Connect application that earned the fee.
            public var application: String?
            /// Three-letter ISO currency code, in lowercase.
            public var currency: Stripe.Currency?
            /// An arbitrary string attached to the object.
            public var description: String?
            /// Type of the fee, one of: `application_fee`, `payment_method_passthrough_fee`, `stripe_fee`, `tax`, or `withheld_tax`.
            public var `type`: String?

            public init(
                amount: Int? = nil,
                application: String? = nil,
                currency: Stripe.Currency? = nil,
                description: String? = nil,
                `type`: String? = nil
            ) {
                self.amount = amount
                self.application = application
                self.currency = currency
                self.description = description
                self.`type` = `type`
            }
        }
    }
}
