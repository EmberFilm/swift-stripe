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
    /// An active entitlement describes access to a feature for a customer.
    public struct ActiveEntitlement: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The Feature that the customer is entitled to.
        @Expandable<Stripe.Entitlements.Feature, String> public var feature: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// A unique key you provide as your own system identifier.
        public var lookupKey: String?

        public init(
            id: ID,
            object: String,
            feature: String? = nil,
            livemode: Bool? = nil,
            lookupKey: String? = nil
        ) {
            self.id = id
            self.object = object
            self._feature = Expandable(id: feature)
            self.livemode = livemode
            self.lookupKey = lookupKey
        }
    }
}
