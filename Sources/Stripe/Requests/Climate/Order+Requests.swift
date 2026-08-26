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

extension Stripe.Climate.Order {
    public enum Cancel {}
    public enum Create {}
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/climate/orders/{order}/cancel
extension Stripe.Climate.Order.Cancel {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Climate.Order
}

// POST /v1/climate/orders
extension Stripe.Climate.Order.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Requested amount of carbon removal units.
        public var amount: Int?
        /// Publicly sharable reference for the end beneficiary of carbon removal.
        public var beneficiary: Beneficiary?
        /// Request currency for the order as a three-letter ISO currency code, in lowercase.
        public var currency: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// Requested number of tons for the order.
        public var metricTons: String?
        /// Unique identifier of the Climate product.
        public var product: String

        public init(
            amount: Int? = nil,
            beneficiary: Beneficiary? = nil,
            currency: String? = nil,
            expand: [String]? = nil,
            metadata: [String: String]? = nil,
            metricTons: String? = nil,
            product: String
        ) {
            self.amount = amount
            self.beneficiary = beneficiary
            self.currency = currency
            self.expand = expand
            self.metadata = metadata
            self.metricTons = metricTons
            self.product = product
        }

        /// Publicly sharable reference for the end beneficiary of carbon removal.
        public struct Beneficiary: Codable, Hashable, Sendable {
            /// Publicly displayable name for the end beneficiary of carbon removal.
            public var publicName: String

            public init(
                publicName: String
            ) {
                self.publicName = publicName
            }
        }
    }

    public typealias Response = Stripe.Climate.Order
}

// GET /v1/climate/orders
extension Stripe.Climate.Order.List {
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

    public typealias Response = Stripe.Page<Stripe.Climate.Order>
}

// GET /v1/climate/orders/{order}
extension Stripe.Climate.Order.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Climate.Order
}

// POST /v1/climate/orders/{order}
extension Stripe.Climate.Order.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Publicly sharable reference for the end beneficiary of carbon removal.
        public var beneficiary: Stripe.Clearable<Beneficiary>?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?

        public init(
            beneficiary: Stripe.Clearable<Beneficiary>? = nil,
            expand: [String]? = nil,
            metadata: [String: String]? = nil
        ) {
            self.beneficiary = beneficiary
            self.expand = expand
            self.metadata = metadata
        }

        public struct Beneficiary: Codable, Hashable, Sendable {
            /// Publicly displayable name for the end beneficiary of carbon removal.
            public var publicName: String

            public init(
                publicName: String
            ) {
                self.publicName = publicName
            }
        }
    }

    public typealias Response = Stripe.Climate.Order
}
