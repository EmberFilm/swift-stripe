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

extension Stripe.Connect.Transfer.Reversal {
    public enum Create {}
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/transfers/{id}/reversals
extension Stripe.Connect.Transfer.Reversal.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// A positive integer in cents (or local equivalent) representing how much of this transfer to reverse.
        public var amount: Int?
        /// An arbitrary string which you can attach to a reversal object.
        public var description: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?
        /// Boolean indicating whether the application fee should be refunded when reversing this transfer.
        public var refundApplicationFee: Bool?

        public init(
            amount: Int? = nil,
            description: String? = nil,
            expand: [String]? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil,
            refundApplicationFee: Bool? = nil
        ) {
            self.amount = amount
            self.description = description
            self.expand = expand
            self.metadata = metadata
            self.refundApplicationFee = refundApplicationFee
        }
    }

    public typealias Response = Stripe.Connect.Transfer.Reversal
}

// GET /v1/transfers/{id}/reversals
extension Stripe.Connect.Transfer.Reversal.List {
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

    public typealias Response = Stripe.Page<Stripe.Connect.Transfer.Reversal>
}

// GET /v1/transfers/{transfer}/reversals/{id}
extension Stripe.Connect.Transfer.Reversal.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Connect.Transfer.Reversal
}

// POST /v1/transfers/{transfer}/reversals/{id}
extension Stripe.Connect.Transfer.Reversal.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?

        public init(
            expand: [String]? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil
        ) {
            self.expand = expand
            self.metadata = metadata
        }
    }

    public typealias Response = Stripe.Connect.Transfer.Reversal
}
