//
//  Stripe Balance Transactions Types Balance Transactions.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.BalanceTransactions {
    // https://docs.stripe.com/api/balanceTransactions/list.md
    public enum List {}
}

// https://docs.stripe.com/api/balanceTransactions/list.md
extension Stripe.BalanceTransactions.List {
    public struct Request: Codable, Equatable, Sendable {
        /// For automatic Stripe payouts only, only returns transactions that were paid out on the specified payout ID.
        public let payout: Stripe.Payouts.Payout.ID?
        /// Only returns transactions of the given type. One of: adjustment, advance, advance_funding, anticipation_repayment, application_fee, application_fee_refund, charge, connect_collection_transfer, contribution, issuing_authorization_hold, issuing_authorization_release, issuing_dispute, issuing_transaction, payment, payment_failure_refund, payment_refund, payout, payout_cancel, payout_failure, refund, refund_failure, reserve_transaction, reserved_funds, stripe_fee, stripe_fx_fee, tax_fee, topup, topup_reversal, transfer, transfer_cancel, transfer_failure, or transfer_refund.
        public let type: String?
        /// Only returns transactions that were created during the given date interval.
        public let created: Stripe.DateFilter?
        /// Only returns transactions in a certain currency. Three-letter ISO currency code, in lowercase.
        public let currency: Stripe.Currency?
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public let endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public let limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case payout
            case type
            case created
            case currency
            case endingBefore
            case limit
            case startingAfter
        }

        public init(
            payout: Stripe.Payouts.Payout.ID? = nil,
            type: String? = nil,
            created: Stripe.DateFilter? = nil,
            currency: Stripe.Currency? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.payout = payout
            self.type = type
            self.created = created
            self.currency = currency
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Balance.Transaction]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Stripe.Balance.Transaction]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}
