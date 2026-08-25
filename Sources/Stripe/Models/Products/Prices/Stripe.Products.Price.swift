//
//  swift
//
//
//  Created by Andrew Edwards on 7/19/20.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/prices/object.md

/// The [Price Object](https://stripe.com/docs/api/prices/object)
extension Stripe.Products {
    public struct Price: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// Whether the price can be used for new purchases.
        public var active: Bool?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// A brief description of the price, hidden from customers.
        public var nickname: String?
        /// The ID of the product this price is associated with.
        @ExpandableOf<Stripe.Products.Product> public var product: Stripe.Products.Product.ID?
        /// The recurring components of a price such as `interval` and `usage_type`.
        public var recurring: Recurring?
        /// One of `one_time` or `recurring` depending on whether the price is for a one-time purchase or a recurring (subscription) purchase.
        public var type: `Type`?
        /// The unit amount in cents to be charged, represented as a whole integer if possible. Only set if `billing_scheme=per_unit`.
        public var unitAmount: Int?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `unit_amount` or `unit_amount_decimal`) will be charged per unit in quantity (for prices with `usage_type=licensed`), or per unit of total usage (for prices with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.
        public var billingScheme: Billing.Scheme?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Prices defined in each available currency option. Each key must be a three-letter ISO currency code and a supported currency. For example, to get your price in eur, fetch the value of the eur key in `currency_options`. This field is not included by default. To include it in the response, expand the `currency_options` field.
        public var currencyOptions: [Stripe.Currency: Stripe.Products.Price.Currency.Option]?
        /// When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.
        public var customUnitAmount: CustomUnitAmount?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// A lookup key used to retrieve prices dynamically from a static string. This may be up to 200 characters.
        public var lookupKey: String?
        /// Only required if a default tax behavior was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of inclusive, exclusive, or unspecified. Once specified as either inclusive or exclusive, it cannot be changed.
        public var taxBehavior: TaxBehavior?
        /// Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to tiered. See also the documentation for `billing_scheme`. This field is not included by default. To include it in the response, expand the `tiers` field.
        public var tiers: [Tier]?
        /// Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price. In `graduated` tiering, pricing can change as the quantity grows.
        public var tiersMode: TierMode?
        /// Apply a transformation to the reported usage or set quantity before computing the amount billed. Cannot be combined with `tiers`.
        public var transformQuantity: TransformQuantity?
        /// The unit amount in cents to be charged, represented as a decimal string with at most 12 decimal places.
        public var unitAmountDecimal: String?

        private enum CodingKeys: String, CodingKey {
            case id
            case active
            case currency
            case metadata
            case nickname
            case product
            case recurring
            case type
            case unitAmount
            case object
            case billingScheme
            case created
            case currencyOptions
            case customUnitAmount
            case livemode
            case lookupKey
            case taxBehavior
            case tiers
            case tiersMode
            case transformQuantity
            case unitAmountDecimal
        }

        public init(
            id: ID,
            active: Bool? = nil,
            currency: Stripe.Currency? = nil,
            metadata: [String: String]? = nil,
            nickname: String? = nil,
            product: Stripe.Products.Product.ID? = nil,
            recurring: Recurring? = nil,
            type: `Type`? = nil,
            unitAmount: Int? = nil,
            object: String,
            billingScheme: Billing.Scheme? = nil,
            created: Date,
            currencyOptions: [Stripe.Currency: Stripe.Products.Price.Currency.Option]? = nil,
            customUnitAmount: CustomUnitAmount? = nil,
            livemode: Bool? = nil,
            lookupKey: String? = nil,
            taxBehavior: TaxBehavior? = nil,
            tiers: [Tier]? = nil,
            tiersMode: TierMode? = nil,
            transformQuantity: TransformQuantity? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.id = id
            self.active = active
            self.currency = currency
            self.metadata = metadata
            self.nickname = nickname
            self._product = Expandable(id: product)
            self.recurring = recurring
            self.type = type
            self.unitAmount = unitAmount
            self.object = object
            self.billingScheme = billingScheme
            self.created = created
            self.currencyOptions = currencyOptions
            self.customUnitAmount = customUnitAmount
            self.livemode = livemode
            self.lookupKey = lookupKey
            self.taxBehavior = taxBehavior
            self.tiers = tiers
            self.tiersMode = tiersMode
            self.transformQuantity = transformQuantity
            self.unitAmountDecimal = unitAmountDecimal
        }
    }
}

extension Stripe.Products.Price {
    public struct Recurring: Codable, Hashable, Sendable {
        /// Specifies a usage aggregation strategy for prices of `usage_type=metered`. Allowed values are sum for summing up all usage during a period, `last_during_period` for using the last usage record reported within a period, `last_ever` for using the last usage record ever (across period bounds) or `max` which uses the usage record with the maximum reported usage during a period. Defaults to `sum`.
        public var aggregateUsage: Recurring.AggregateUsage?
        /// The frequency at which a subscription is billed. One of `day`, `week`, `month` or `year`.
        public var interval: Stripe.Billing.Plan.Interval?
        /// The number of intervals (specified in the `interval` attribute) between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months.
        public var intervalCount: Int?
        /// Configures how the quantity per period should be determined. Can be either `metered` or `licensed`. `licensed` automatically bills the `quantity` set when adding it to a subscription. `metered` aggregates the total usage based on usage records. Defaults to `licensed`.
        public var usageType: Stripe.Billing.Plan.UsageType?
        /// The meter tracking the usage of a metered price
        public var meter: String?
        /// Default number of trial days when subscribing a customer to this price.
        public var trialPeriodDays: Int?

        private enum CodingKeys: String, CodingKey {
            case aggregateUsage
            case interval
            case intervalCount
            case usageType
            case meter
            case trialPeriodDays
        }

        public init(
            aggregateUsage: Recurring.AggregateUsage? = nil,
            interval: Stripe.Billing.Plan.Interval? = nil,
            intervalCount: Int? = nil,
            usageType: Stripe.Billing.Plan.UsageType? = nil,
            meter: String? = nil,
            trialPeriodDays: Int? = nil
        ) {
            self.aggregateUsage = aggregateUsage
            self.interval = interval
            self.intervalCount = intervalCount
            self.usageType = usageType
            self.meter = meter
            self.trialPeriodDays = trialPeriodDays
        }
    }
}

extension Stripe.Products.Price.Recurring {
    public enum AggregateUsage: String, Codable, Sendable {
        case sum
        case lastDuringPeriod = "last_during_period"
        case lastEver = "last_ever"
        case max
    }
}

extension Stripe.Products.Price {
    public enum `Type`: String, Codable, Sendable {
        case oneTime = "one_time"
        case recurring
    }
}

extension Stripe.Products.Price {
    public enum Billing {}
}

extension Stripe.Products.Price.Billing {
    public enum Scheme: String, Codable, Sendable {
        case perUnit = "per_unit"
        case tiered
    }
}

extension Stripe.Products.Price {
    public typealias Currency = Stripe.Currency
}

extension Stripe.Products.Price.Currency {
    public struct Option: Codable, Hashable, Sendable {
        /// When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.
        public var customUnitAmount: CustomUnitAmount?
        /// Only required if a default tax behavior was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
        public var taxBehavior: Stripe.Products.Price.TaxBehavior?
        /// Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`. This field is not included by default. To include it in the response, expand the `<currency>.tiers` field.
        public var tiers: [Stripe.Products.Price.Tier]?
        /// The unit amount in cents to be charged, represented as a whole integer if possible. Only set if `billing_scheme=per_unit`.
        public var unitAmount: Int?
        /// The unit amount in cents to be charged, represented as a decimal string with at most 12 decimal places. Only set if `billing_scheme=per_unit`.
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
        /// The minimum unit amount the customer can specify for this item. Must be at least the minimum charge amount.
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
    public enum TaxBehavior: String, Codable, Sendable {
        case inclusive
        case exclusive
        case unspecified
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

        private enum CodingKeys: String, CodingKey {
            case flatAmount
            case flatAmountDecimal
            case unitAmount
            case unitAmountDecimal
            case upTo
        }

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
    public struct CustomUnitAmount: Codable, Hashable, Sendable {
        /// The maximum unit amount the customer can specify for this item.
        public var maximum: Int?
        /// The minimum unit amount the customer can specify for this item. Must be at least the minimum charge amount.
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
    public enum TierMode: String, Codable, Sendable {
        case graduated
        case volume
    }
}

extension Stripe.Products.Price {
    public struct TransformQuantity: Codable, Hashable, Sendable {
        /// Divide usage by this number.
        public var divideBy: Int?
        /// After division, either round the result `up` or `down`.
        public var round: TransformQuantityRound?

        private enum CodingKeys: String, CodingKey {
            case divideBy
            case round
        }

        public init(
            divideBy: Int? = nil,
            round: TransformQuantityRound? = nil
        ) {
            self.divideBy = divideBy
            self.round = round
        }
    }
}

extension Stripe.Products.Price {
    public enum TransformQuantityRound: String, Codable, Sendable {
        case up
        case down
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

extension Stripe.Products.Price {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Products.Price]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Products.Price]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
