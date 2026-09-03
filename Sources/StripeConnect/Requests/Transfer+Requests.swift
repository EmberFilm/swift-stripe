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
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Connect.Transfer {
    public enum Create {}
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/transfers
extension Stripe.Connect.Transfer.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// A positive integer in cents (or local equivalent) representing how much to transfer.
        public var amount: Int?
        /// Three-letter ISO code for currency in lowercase.
        public var currency: Stripe.Currency
        /// An arbitrary string attached to the object.
        public var description: String?
        /// The ID of a connected Stripe account.
        public var destination: String
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// You can use this parameter to transfer funds from a charge before they are added to your available balance.
        public var sourceTransaction: String?
        /// The source balance to use for this transfer.
        public var sourceType: SourceType?
        /// A string that identifies this transaction as part of a group.
        public var transferGroup: String?

        public init(
            amount: Int? = nil,
            currency: Stripe.Currency,
            description: String? = nil,
            destination: String,
            expand: [String]? = nil,
            metadata: [String: String]? = nil,
            sourceTransaction: String? = nil,
            sourceType: SourceType? = nil,
            transferGroup: String? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.description = description
            self.destination = destination
            self.expand = expand
            self.metadata = metadata
            self.sourceTransaction = sourceTransaction
            self.sourceType = sourceType
            self.transferGroup = transferGroup
        }

        public enum SourceType: String, Codable, Hashable, Sendable {
            case bankAccount = "bank_account"
            case card
            case fpx
        }
    }

    public typealias Response = Stripe.Connect.Transfer
}

// GET /v1/transfers
extension Stripe.Connect.Transfer.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return transfers that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// Only return transfers for the destination specified by this account ID.
        public var destination: String?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return transfers with the specified transfer group.
        public var transferGroup: String?

        public init(
            created: Stripe.RangeQuery? = nil,
            destination: String? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            transferGroup: String? = nil
        ) {
            self.created = created
            self.destination = destination
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
            self.transferGroup = transferGroup
        }
    }

    public typealias Response = Stripe.Page<Stripe.Connect.Transfer>
}

// GET /v1/transfers/{transfer}
extension Stripe.Connect.Transfer.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Connect.Transfer
}

// POST /v1/transfers/{transfer}
extension Stripe.Connect.Transfer.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// An arbitrary string attached to the object.
        public var description: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?

        public init(
            description: String? = nil,
            expand: [String]? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil
        ) {
            self.description = description
            self.expand = expand
            self.metadata = metadata
        }
    }

    public typealias Response = Stripe.Connect.Transfer
}
