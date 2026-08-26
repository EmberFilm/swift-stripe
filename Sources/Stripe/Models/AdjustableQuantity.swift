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

// https://docs.stripe.com/api/payment-link/create.md
// https://docs.stripe.com/api/checkout/sessions/create.md
// Shared adjustable quantity configuration used across multiple Stripe resources

extension Stripe {
    public struct AdjustableQuantity: Codable, Equatable, Hashable, Sendable {
        /// Whether the quantity can be adjusted by the customer.
        public let enabled: Bool

        /// The minimum quantity the customer can select.
        public let minimum: Int?

        /// The maximum quantity the customer can select.
        public let maximum: Int?

        public init(
            enabled: Bool,
            minimum: Int? = nil,
            maximum: Int? = nil
        ) {
            self.enabled = enabled
            self.minimum = minimum
            self.maximum = maximum
        }
    }
}
