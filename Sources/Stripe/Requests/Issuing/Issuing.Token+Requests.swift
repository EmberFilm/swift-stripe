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

extension Stripe.Issuing.Token {
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
}

// GET /v1/issuing/tokens
extension Stripe.Issuing.Token.List {
    public struct Request: Codable, Hashable, Sendable {
        /// The Issuing card identifier to list tokens for.
        public var card: String
        /// Only return Issuing tokens that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Select Issuing tokens with the given status.
        public var status: Status?

        public init(
            card: String,
            created: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            status: Status? = nil
        ) {
            self.card = card
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
            self.status = status
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case active
            case deleted
            case requested
            case suspended
        }
    }

    public typealias Response = Stripe.Page<Stripe.Issuing.Token>
}

// GET /v1/issuing/tokens/{token}
extension Stripe.Issuing.Token.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Issuing.Token
}

// POST /v1/issuing/tokens/{token}
extension Stripe.Issuing.Token.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Specifies which status the token should be updated to.
        public var status: Status

        public init(
            expand: [String]? = nil,
            status: Status
        ) {
            self.expand = expand
            self.status = status
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case active
            case deleted
            case suspended
        }
    }

    public typealias Response = Stripe.Issuing.Token
}
