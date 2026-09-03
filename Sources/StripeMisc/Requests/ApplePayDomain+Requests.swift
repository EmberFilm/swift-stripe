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

import StripeCheckout
import StripeCore
import StripeIssuing
import StripeModels
import StripePromotion
import StripeReporting

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.ApplePayDomain {
    public enum Create {}
    public enum Delete {}
    public enum List {}
    public enum Retrieve {}
}

// POST /v1/apple_pay/domains
extension Stripe.ApplePayDomain.Create {
    public struct Request: Codable, Hashable, Sendable {
        public var domainName: String
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            domainName: String,
            expand: [String]? = nil
        ) {
            self.domainName = domainName
            self.expand = expand
        }
    }

    public typealias Response = Stripe.ApplePayDomain
}

// DELETE /v1/apple_pay/domains/{domain}
extension Stripe.ApplePayDomain.Delete {
    public typealias Response = DeletedObject<Stripe.ApplePayDomain>
}

// GET /v1/apple_pay/domains
extension Stripe.ApplePayDomain.List {
    public struct Request: Codable, Hashable, Sendable {
        public var domainName: String?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            domainName: String? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.domainName = domainName
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Stripe.ApplePayDomain>
}

// GET /v1/apple_pay/domains/{domain}
extension Stripe.ApplePayDomain.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.ApplePayDomain
}
