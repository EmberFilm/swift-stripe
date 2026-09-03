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

extension Stripe.Products.Coupon {
    public enum Create {}
    public enum Delete {}
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/coupons
extension Stripe.Products.Coupon.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// A positive integer representing the amount to subtract from an invoice total (required if `percent_off` is not.
        public var amountOff: Int?
        /// A hash containing directions for what this Coupon will apply discounts to.
        public var appliesTo: AppliesTo?
        /// Three-letter ISO code for the currency of the `amount_off` parameter (required if `amount_off` is passed).
        public var currency: Stripe.Currency?
        /// Coupons defined in each available currency option (only supported if `amount_off` is passed).
        public var currencyOptions: [String: CurrencyOptions]?
        /// Specifies how long the discount will be in effect if used on a subscription.
        public var duration: Duration?
        /// Required only if `duration` is `repeating`, in which case it must be a positive integer that specifies the number of.
        public var durationInMonths: Int?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Unique string of your choice that will be used to identify this coupon when applying it to a customer.
        public var id: String?
        /// A positive integer specifying the number of times the coupon can be redeemed before it's no longer valid.
        public var maxRedemptions: Int?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?
        /// Name of the coupon displayed to customers on, for instance invoices, or receipts.
        public var name: String?
        /// A positive float larger than 0, and smaller or equal to 100, that represents the discount the coupon will apply.
        public var percentOff: Decimal?
        /// Unix timestamp specifying the last time at which the coupon can be redeemed (cannot be set to more than 5 years in.
        public var redeemBy: Date?

        public init(
            amountOff: Int? = nil,
            appliesTo: AppliesTo? = nil,
            currency: Stripe.Currency? = nil,
            currencyOptions: [String: CurrencyOptions]? = nil,
            duration: Duration? = nil,
            durationInMonths: Int? = nil,
            expand: [String]? = nil,
            id: String? = nil,
            maxRedemptions: Int? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil,
            name: String? = nil,
            percentOff: Decimal? = nil,
            redeemBy: Date? = nil
        ) {
            self.amountOff = amountOff
            self.appliesTo = appliesTo
            self.currency = currency
            self.currencyOptions = currencyOptions
            self.duration = duration
            self.durationInMonths = durationInMonths
            self.expand = expand
            self.id = id
            self.maxRedemptions = maxRedemptions
            self.metadata = metadata
            self.name = name
            self.percentOff = percentOff
            self.redeemBy = redeemBy
        }

        public enum Duration: String, Codable, Hashable, Sendable {
            case forever
            case once
            case repeating
        }

        /// A hash containing directions for what this Coupon will apply discounts to.
        public struct AppliesTo: Codable, Hashable, Sendable {
            /// An array of Product IDs that this Coupon will apply to.
            public var products: [String]?

            public init(
                products: [String]? = nil
            ) {
                self.products = products
            }
        }

        public struct CurrencyOptions: Codable, Hashable, Sendable {
            /// A positive integer representing the amount to subtract from an invoice total.
            public var amountOff: Int

            public init(
                amountOff: Int
            ) {
                self.amountOff = amountOff
            }
        }
    }

    public typealias Response = Stripe.Products.Coupon
}

// DELETE /v1/coupons/{coupon}
extension Stripe.Products.Coupon.Delete {
    public typealias Response = DeletedObject<Stripe.Products.Coupon>
}

// GET /v1/coupons
extension Stripe.Products.Coupon.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A filter on the list, based on the object `created` field.
        public var created: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            created: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Stripe.Products.Coupon>
}

// GET /v1/coupons/{coupon}
extension Stripe.Products.Coupon.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Products.Coupon
}

// POST /v1/coupons/{coupon}
extension Stripe.Products.Coupon.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Coupons defined in each available currency option (only supported if the coupon is amount-based).
        public var currencyOptions: [String: CurrencyOptions]?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?
        /// Name of the coupon displayed to customers on, for instance invoices, or receipts.
        public var name: String?

        public init(
            currencyOptions: [String: CurrencyOptions]? = nil,
            expand: [String]? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil,
            name: String? = nil
        ) {
            self.currencyOptions = currencyOptions
            self.expand = expand
            self.metadata = metadata
            self.name = name
        }

        public struct CurrencyOptions: Codable, Hashable, Sendable {
            /// A positive integer representing the amount to subtract from an invoice total.
            public var amountOff: Int

            public init(
                amountOff: Int
            ) {
                self.amountOff = amountOff
            }
        }
    }

    public typealias Response = Stripe.Products.Coupon
}
