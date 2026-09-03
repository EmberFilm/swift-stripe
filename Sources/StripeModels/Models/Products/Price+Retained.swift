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
//  swift
//
//
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/prices/object.md

/// The [Price Object](https://stripe.com/docs/api/prices/object).

// The Price struct is generated (Models/Generated). These are the nested types the request
// layer still names under `Stripe.Products.Price` that the generator spells differently.

extension Stripe.Products.Price {
    public enum Billing {}
}

extension Stripe.Products.Price {
    public typealias Currency = Stripe.Currency
}

extension Stripe.Products.Price.Currency {
    public struct Option: Codable, Hashable, Sendable {
        /// When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.
        public var customUnitAmount: CustomUnitAmount?
        /// Only required if a default tax behavior was not provided in the Stripe Tax settings.
        ///
        /// Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of
        /// `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or
        /// `exclusive`, it cannot be changed.
        public var taxBehavior: Stripe.Products.Price.TaxBehavior?
        /// Each element represents a pricing tier.
        ///
        /// This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation
        /// for `billing_scheme`. This field is not included by default. To include it in the response,
        /// expand the `<currency>.tiers` field.
        public var tiers: [Stripe.Products.Price.Tier]?
        /// The unit amount in cents to be charged, represented as a whole integer if possible.
        ///
        /// Only set if `billing_scheme=per_unit`.
        public var unitAmount: Int?
        /// The unit amount in cents to be charged, represented as a decimal string with at most 12 decimal places.
        ///
        /// Only set if `billing_scheme=per_unit`.
        public var unitAmountDecimal: String?

        public init(
            customUnitAmount: CustomUnitAmount? = nil,
            taxBehavior: Stripe.Products.Price.TaxBehavior? = nil,
            tiers: [Stripe.Products.Price.Tier]? = nil,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.customUnitAmount = customUnitAmount
            self.taxBehavior = taxBehavior
            self.tiers = tiers
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
        }
    }
}

extension Stripe.Products.Price.Currency.Option {
    public struct CustomUnitAmount: Codable, Hashable, Sendable {
        /// The maximum unit amount the customer can specify for this item.
        public var maximum: Int?
        /// The minimum unit amount the customer can specify for this item.
        ///
        /// Must be at least the minimum charge amount.
        public var minimum: Int?
        /// The starting unit amount which can be updated by the customer.
        public var preset: Int?

        public init(
            maximum: Int? = nil,
            minimum: Int? = nil,
            preset: Int? = nil
        ) {
            self.maximum = maximum
            self.minimum = minimum
            self.preset = preset
        }
    }
}

extension Stripe.Products.Price {
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

extension Stripe.Products.Price {
    public struct SearchResult: Codable, Hashable, Sendable {
        /// A string describing the object type returned.
        public var object: String
        /// A list of prices, paginated by any request parameters.
        public var data: [Stripe.Products.Price]?
        /// Whether or not there are more elements available after this set.
        public var hasMore: Bool?
        /// The URL for accessing this list.
        public var url: String?
        /// The URL for accessing the next page in search results.
        public var nextPage: String?
        /// The total count of entries in the search result, not just the current page.
        public var totalCount: Int?

        public init(
            object: String,
            data: [Stripe.Products.Price]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil,
            nextPage: String? = nil,
            totalCount: Int? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
            self.nextPage = nextPage
            self.totalCount = totalCount
        }
    }
}
