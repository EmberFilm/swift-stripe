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

extension Stripe.Treasury.Transaction {
    public enum List {}
    public enum Retrieve {}
}

// GET /v1/treasury/transactions
extension Stripe.Treasury.Transaction.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return Transactions that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Returns objects associated with this FinancialAccount.
        public var financialAccount: String
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// The results are in reverse chronological order by `created` or `posted_at`.
        public var orderBy: OrderBy?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return Transactions that have the given status: `open`, `posted`, or `void`.
        public var status: Status?
        /// A filter for the `status_transitions.posted_at` timestamp.
        public var statusTransitions: StatusTransitions?

        public init(
            created: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            financialAccount: String,
            limit: Int? = nil,
            orderBy: OrderBy? = nil,
            startingAfter: String? = nil,
            status: Status? = nil,
            statusTransitions: StatusTransitions? = nil
        ) {
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.financialAccount = financialAccount
            self.limit = limit
            self.orderBy = orderBy
            self.startingAfter = startingAfter
            self.status = status
            self.statusTransitions = statusTransitions
        }

        public enum OrderBy: String, Codable, Hashable, Sendable {
            case created
            case postedAt = "posted_at"
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case open
            case posted
            case void
        }

        /// A filter for the `status_transitions.posted_at` timestamp.
        public struct StatusTransitions: Codable, Hashable, Sendable {
            /// Returns Transactions with `posted_at` within the specified range.
            public var postedAt: Stripe.RangeQuery?

            public init(
                postedAt: Stripe.RangeQuery? = nil
            ) {
                self.postedAt = postedAt
            }
        }
    }

    public typealias Response = Stripe.Page<Stripe.Treasury.Transaction>
}

// GET /v1/treasury/transactions/{id}
extension Stripe.Treasury.Transaction.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Treasury.Transaction
}
