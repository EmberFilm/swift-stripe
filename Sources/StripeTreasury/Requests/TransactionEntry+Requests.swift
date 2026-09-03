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

import StripeCore
import StripeIssuing
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Treasury.TransactionEntry {
    public enum List {}
    public enum Retrieve {}
}

// GET /v1/treasury/transaction_entries
extension Stripe.Treasury.TransactionEntry.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return TransactionEntries that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        public var effectiveAt: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Returns objects associated with this FinancialAccount.
        public var financialAccount: String
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// The results are in reverse chronological order by `created` or `effective_at`.
        public var orderBy: OrderBy?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return TransactionEntries associated with this Transaction.
        public var transaction: String?

        public init(
            created: Stripe.RangeQuery? = nil,
            effectiveAt: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            financialAccount: String,
            limit: Int? = nil,
            orderBy: OrderBy? = nil,
            startingAfter: String? = nil,
            transaction: String? = nil
        ) {
            self.created = created
            self.effectiveAt = effectiveAt
            self.endingBefore = endingBefore
            self.expand = expand
            self.financialAccount = financialAccount
            self.limit = limit
            self.orderBy = orderBy
            self.startingAfter = startingAfter
            self.transaction = transaction
        }

        public enum OrderBy: String, Codable, Hashable, Sendable {
            case created
            case effectiveAt = "effective_at"
        }
    }

    public typealias Response = Stripe.Page<Stripe.Treasury.TransactionEntry>
}

// GET /v1/treasury/transaction_entries/{id}
extension Stripe.Treasury.TransactionEntry.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Treasury.TransactionEntry
}
