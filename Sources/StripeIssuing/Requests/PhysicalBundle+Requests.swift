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

extension Stripe.Issuing.PhysicalBundle {
    public enum List {}
    public enum Retrieve {}
}

// GET /v1/issuing/physical_bundles
extension Stripe.Issuing.PhysicalBundle.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return physical bundles with the given status.
        public var status: Status?
        /// Only return physical bundles with the given type.
        public var `type`: Type?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            status: Status? = nil,
            `type`: Type? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
            self.status = status
            self.`type` = `type`
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case active
            case inactive
            case review
        }

        public enum `Type`: String, Codable, Hashable, Sendable {
            case custom
            case standard
        }
    }

    public typealias Response = Stripe.Page<Stripe.Issuing.PhysicalBundle>
}

// GET /v1/issuing/physical_bundles/{physical_bundle}
extension Stripe.Issuing.PhysicalBundle.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Issuing.PhysicalBundle
}
