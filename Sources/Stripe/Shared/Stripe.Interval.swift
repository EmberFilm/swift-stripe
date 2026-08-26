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

extension Stripe {
    /// Represents billing frequency intervals used throughout Stripe's API.
    ///
    /// This is the canonical definition for billing intervals, used by:
    /// - Prices (recurring.interval)
    /// - Subscriptions (interval)
    /// - Plans (interval)
    /// - Quotes (recurring.interval)
    /// - And other billing-related resources
    ///
    /// Reference: https://docs.stripe.com/api/prices/create#create_price-recurring-interval
    public enum Interval: String, Codable, Hashable, Sendable, CaseIterable {
        case day
        case week
        case month
        case year
    }
}
