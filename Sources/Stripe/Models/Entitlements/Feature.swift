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

extension Stripe.Entitlements {
    /// A feature represents a monetizable ability or functionality in your system.
    public struct Feature: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Inactive features cannot be attached to new products and will not be returned from the features list endpoint.
        public var active: Bool?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// A unique key you provide as your own system identifier.
        public var lookupKey: String?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The feature's name, for your own purpose, not meant to be displayable to the customer.
        public var name: String?

        public init(
            id: ID,
            object: String,
            active: Bool? = nil,
            livemode: Bool? = nil,
            lookupKey: String? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil
        ) {
            self.id = id
            self.object = object
            self.active = active
            self.livemode = livemode
            self.lookupKey = lookupKey
            self.metadata = metadata
            self.name = name
        }
    }
}
