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

extension Stripe.Billing {
    /// You can now model subscriptions more flexibly using the Prices API.
    public struct Plan: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Whether the plan can be used for new purchases.
        public var active: Bool?
        /// The unit amount in cents (or local equivalent) to be charged, represented as a whole integer if possible.
        public var amount: Int?
        /// The unit amount in cents (or local equivalent) to be charged, represented as a decimal string with at most 12 decimal.
        public var amountDecimal: String?
        /// Describes how to compute the price per period.
        public var billingScheme: BillingScheme?
        /// Time at which the object was created.
        public var created: Date?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// The frequency at which a subscription is billed.
        public var interval: Interval?
        /// The number of intervals (specified in the `interval` attribute) between subscription billings.
        public var intervalCount: Int?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The meter tracking the usage of a metered price.
        public var meter: String?
        /// A brief description of the plan, hidden from customers.
        public var nickname: String?
        /// The product whose pricing this plan determines.
        @Expandable<Stripe.Products.Product, String> public var product: String?
        /// Each element represents a pricing tier.
        public var tiers: [Tiers]?
        /// Defines if the tiering price should be `graduated` or `volume` based.
        public var tiersMode: TiersMode?
        /// Apply a transformation to the reported usage or set quantity before computing the amount billed.
        public var transformUsage: TransformUsage?
        /// Default number of trial days when subscribing a customer to this plan using `trial_from_plan=true`.
        public var trialPeriodDays: Int?
        /// Configures how the quantity per period should be determined.
        public var usageType: UsageType?

        public init(
            id: ID,
            object: String,
            active: Bool? = nil,
            amount: Int? = nil,
            amountDecimal: String? = nil,
            billingScheme: BillingScheme? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            interval: Interval? = nil,
            intervalCount: Int? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            meter: String? = nil,
            nickname: String? = nil,
            product: String? = nil,
            tiers: [Tiers]? = nil,
            tiersMode: TiersMode? = nil,
            transformUsage: TransformUsage? = nil,
            trialPeriodDays: Int? = nil,
            usageType: UsageType? = nil
        ) {
            self.id = id
            self.object = object
            self.active = active
            self.amount = amount
            self.amountDecimal = amountDecimal
            self.billingScheme = billingScheme
            self.created = created
            self.currency = currency
            self.interval = interval
            self.intervalCount = intervalCount
            self.livemode = livemode
            self.metadata = metadata
            self.meter = meter
            self.nickname = nickname
            self._product = Expandable(id: product)
            self.tiers = tiers
            self.tiersMode = tiersMode
            self.transformUsage = transformUsage
            self.trialPeriodDays = trialPeriodDays
            self.usageType = usageType
        }

        /// Describes how to compute the price per period.
        public enum BillingScheme: String, Codable, Hashable, Sendable {
            case perUnit = "per_unit"
            case tiered
        }

        /// The frequency at which a subscription is billed.
        public enum Interval: String, Codable, Hashable, Sendable {
            case day
            case month
            case week
            case year
        }

        /// Defines if the tiering price should be `graduated` or `volume` based.
        public enum TiersMode: String, Codable, Hashable, Sendable {
            case graduated
            case volume
        }

        /// Configures how the quantity per period should be determined.
        public enum UsageType: String, Codable, Hashable, Sendable {
            case licensed
            case metered
        }

        public struct Tiers: Codable, Hashable, Sendable {
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

        public struct TransformUsage: Codable, Hashable, Sendable {
            /// Divide usage by this number.
            public var divideBy: Int?
            /// After division, either round the result `up` or `down`.
            public var round: Round?

            public init(
                divideBy: Int? = nil,
                round: Round? = nil
            ) {
                self.divideBy = divideBy
                self.round = round
            }

            /// After division, either round the result `up` or `down`.
            public enum Round: String, Codable, Hashable, Sendable {
                case down
                case up
            }
        }
    }
}
