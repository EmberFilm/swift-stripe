//
//  ApplicationFeeRefund.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/17/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/fee_refunds/object.md

extension Stripe.Connect.Application.Fee {
    /// `Application Fee Refund` objects allow you to refund an application fee that has previously been created but not yet refunded. Funds will be refunded to the Stripe account from which the fee was originally collected.
    public struct Refund: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// Amount, in cents.
        public var amount: Int?
        /// Balance transaction that describes the impact on your account balance.
        @ExpandableOf<Stripe.Balance.Transaction> public var balanceTransaction:
            Stripe.Balance.Transaction.ID?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// ID of the application fee that was refunded.
        @ExpandableOf<Stripe.Connect.Application.Fee> public var fee:
            Stripe.Connect.Application.Fee.ID?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            balanceTransaction: Stripe.Balance.Transaction.ID? = nil,
            created: Date,
            currency: Stripe.Currency? = nil,
            fee: Stripe.Connect.Application.Fee.ID? = nil,
            metadata: [String: String]? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self._balanceTransaction = Expandable(id: balanceTransaction)
            self.created = created
            self.currency = currency
            self._fee = Expandable(id: fee)
            self.metadata = metadata
        }
    }
}

extension Stripe.Connect.Application.Fee.Refund {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.Application.Fee.Refund]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.Application.Fee.Refund]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
