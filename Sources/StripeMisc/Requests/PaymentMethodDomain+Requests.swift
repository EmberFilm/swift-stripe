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

extension Stripe.PaymentMethodDomain {
    public enum Create {}
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
    public enum Validate {}
}

// POST /v1/payment_method_domains
extension Stripe.PaymentMethodDomain.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// The domain name that this payment method domain object represents.
        public var domainName: String
        /// Whether this payment method domain is enabled.
        public var enabled: Bool?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            domainName: String,
            enabled: Bool? = nil,
            expand: [String]? = nil
        ) {
            self.domainName = domainName
            self.enabled = enabled
            self.expand = expand
        }
    }

    public typealias Response = Stripe.PaymentMethodDomain
}

// GET /v1/payment_method_domains
extension Stripe.PaymentMethodDomain.List {
    public struct Request: Codable, Hashable, Sendable {
        /// The domain name that this payment method domain object represents.
        public var domainName: String?
        /// Whether this payment method domain is enabled.
        public var enabled: Bool?
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
            enabled: Bool? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.domainName = domainName
            self.enabled = enabled
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Stripe.PaymentMethodDomain>
}

// GET /v1/payment_method_domains/{payment_method_domain}
extension Stripe.PaymentMethodDomain.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.PaymentMethodDomain
}

// POST /v1/payment_method_domains/{payment_method_domain}
extension Stripe.PaymentMethodDomain.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Whether this payment method domain is enabled.
        public var enabled: Bool?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            enabled: Bool? = nil,
            expand: [String]? = nil
        ) {
            self.enabled = enabled
            self.expand = expand
        }
    }

    public typealias Response = Stripe.PaymentMethodDomain
}

// POST /v1/payment_method_domains/{payment_method_domain}/validate
extension Stripe.PaymentMethodDomain.Validate {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.PaymentMethodDomain
}
