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

//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The Plan struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.Plan` that the generator spells differently.

// https://docs.stripe.com/api/plans/object.md

extension Stripe.Billing.Plan {
    public struct Tier: Codable, Hashable, Sendable {
        /// Price for the entire tier.
        public var flatAmount: Int?
        /// Same as `flat_amount`, but contains a decimal value with at most 12 decimal places.
        public var flatAmountDecimal: String?
        /// Per unit price for units relevant to the tier.
        public var unitAmount: Int?
        /// Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.
        public var unitAmountDecimal: String?
        /// Up to and including to this quantity will be contained in the tier.
        public var upTo: Int?

        public init(
            flatAmount: Int? = nil,
            flatAmountDecimal: String? = nil,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil,
            upTo: Int? = nil
        ) {
            self.flatAmount = flatAmount
            self.flatAmountDecimal = flatAmountDecimal
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
            self.upTo = upTo
        }
    }
}
