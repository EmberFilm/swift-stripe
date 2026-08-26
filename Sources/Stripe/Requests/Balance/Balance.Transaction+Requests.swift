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

extension Stripe.Balance.Transaction {
    public enum List {}
    public enum Retrieve {}
}

// GET /v1/balance_transactions
extension Stripe.Balance.Transaction.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return transactions that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// Only return transactions in a certain currency.
        public var currency: Stripe.Currency?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// For automatic Stripe payouts only, only returns transactions that were paid out on the specified payout ID.
        public var payout: String?
        /// Only returns transactions associated with the given object.
        public var source: String?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only returns transactions of the given type.
        public var `type`: String?

        public init(
            created: Stripe.RangeQuery? = nil,
            currency: Stripe.Currency? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            payout: String? = nil,
            source: String? = nil,
            startingAfter: String? = nil,
            `type`: String? = nil
        ) {
            self.created = created
            self.currency = currency
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.payout = payout
            self.source = source
            self.startingAfter = startingAfter
            self.`type` = `type`
        }
    }

    public typealias Response = Stripe.Page<Stripe.Balance.Transaction>
}

// GET /v1/balance_transactions/{id}
extension Stripe.Balance.Transaction.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Balance.Transaction
}
