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

extension Stripe.Products {
    /// A product_feature represents an attachment between a feature and a product.
    public struct ProductFeature: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        @Boxed public var entitlementFeature: Stripe.Entitlements.Feature?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?

        public init(
            id: ID,
            object: String,
            entitlementFeature: Stripe.Entitlements.Feature? = nil,
            livemode: Bool? = nil
        ) {
            self.id = id
            self.object = object
            self._entitlementFeature = Boxed(wrappedValue: entitlementFeature)
            self.livemode = livemode
        }
    }
}
