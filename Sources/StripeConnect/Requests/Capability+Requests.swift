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

extension Stripe.Connect.Capability {
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
}

// GET /v1/accounts/{account}/capabilities
extension Stripe.Connect.Capability.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Page<Stripe.Connect.Capability>
}

// GET /v1/accounts/{account}/capabilities/{capability}
extension Stripe.Connect.Capability.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Connect.Capability
}

// POST /v1/accounts/{account}/capabilities/{capability}
extension Stripe.Connect.Capability.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// To request a new capability for an account, pass true.
        public var requested: Bool?

        public init(
            expand: [String]? = nil,
            requested: Bool? = nil
        ) {
            self.expand = expand
            self.requested = requested
        }
    }

    public typealias Response = Stripe.Connect.Capability
}
