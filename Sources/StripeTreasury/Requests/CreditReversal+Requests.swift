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

extension Stripe.Treasury.CreditReversal {
    public enum Create {}
    public enum List {}
    public enum Retrieve {}
}

// POST /v1/treasury/credit_reversals
extension Stripe.Treasury.CreditReversal.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The ReceivedCredit to reverse.
        public var receivedCredit: String

        public init(
            expand: [String]? = nil,
            metadata: [String: String]? = nil,
            receivedCredit: String
        ) {
            self.expand = expand
            self.metadata = metadata
            self.receivedCredit = receivedCredit
        }
    }

    public typealias Response = Stripe.Treasury.CreditReversal
}

// GET /v1/treasury/credit_reversals
extension Stripe.Treasury.CreditReversal.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Returns objects associated with this FinancialAccount.
        public var financialAccount: String
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// Only return CreditReversals for the ReceivedCredit ID.
        public var receivedCredit: String?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return CreditReversals for a given status.
        public var status: Status?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            financialAccount: String,
            limit: Int? = nil,
            receivedCredit: String? = nil,
            startingAfter: String? = nil,
            status: Status? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.financialAccount = financialAccount
            self.limit = limit
            self.receivedCredit = receivedCredit
            self.startingAfter = startingAfter
            self.status = status
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case canceled
            case posted
            case processing
        }
    }

    public typealias Response = Stripe.Page<Stripe.Treasury.CreditReversal>
}

// GET /v1/treasury/credit_reversals/{credit_reversal}
extension Stripe.Treasury.CreditReversal.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Treasury.CreditReversal
}
