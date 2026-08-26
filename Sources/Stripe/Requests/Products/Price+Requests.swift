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

extension Stripe.Products.Price {
    public enum Create {}
    public enum List {}
    public enum Retrieve {}
    public enum Search {}
    public enum Update {}
}

// POST /v1/prices
extension Stripe.Products.Price.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Whether the price can be used for new purchases.
        public var active: Bool?
        /// Describes how to compute the price per period.
        public var billingScheme: BillingScheme?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency
        /// Prices defined in each available currency option.
        public var currencyOptions: [String: CurrencyOptions]?
        /// When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment.
        public var customUnitAmount: CustomUnitAmount?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A lookup key used to retrieve prices dynamically from a static string.
        public var lookupKey: String?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// A brief description of the price, hidden from customers.
        public var nickname: String?
        /// The ID of the Product that this Price will belong to.
        public var product: String?
        /// These fields can be used to create a new product that this price will belong to.
        public var productData: ProductData?
        /// The recurring components of a price such as `interval` and `usage_type`.
        public var recurring: Recurring?
        /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
        public var taxBehavior: TaxBehavior?
        /// Each element represents a pricing tier.
        public var tiers: [Tiers]?
        /// Defines if the tiering price should be `graduated` or `volume` based.
        public var tiersMode: TiersMode?
        /// If set to true, will atomically remove the lookup key from the existing price, and assign it to this price.
        public var transferLookupKey: Bool?
        /// Apply a transformation to the reported usage or set quantity before computing the billed price.
        public var transformQuantity: TransformQuantity?
        /// A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
        public var unitAmount: Int?
        /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
        public var unitAmountDecimal: String?

        public init(
            active: Bool? = nil,
            billingScheme: BillingScheme? = nil,
            currency: Stripe.Currency,
            currencyOptions: [String: CurrencyOptions]? = nil,
            customUnitAmount: CustomUnitAmount? = nil,
            expand: [String]? = nil,
            lookupKey: String? = nil,
            metadata: [String: String]? = nil,
            nickname: String? = nil,
            product: String? = nil,
            productData: ProductData? = nil,
            recurring: Recurring? = nil,
            taxBehavior: TaxBehavior? = nil,
            tiers: [Tiers]? = nil,
            tiersMode: TiersMode? = nil,
            transferLookupKey: Bool? = nil,
            transformQuantity: TransformQuantity? = nil,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.active = active
            self.billingScheme = billingScheme
            self.currency = currency
            self.currencyOptions = currencyOptions
            self.customUnitAmount = customUnitAmount
            self.expand = expand
            self.lookupKey = lookupKey
            self.metadata = metadata
            self.nickname = nickname
            self.product = product
            self.productData = productData
            self.recurring = recurring
            self.taxBehavior = taxBehavior
            self.tiers = tiers
            self.tiersMode = tiersMode
            self.transferLookupKey = transferLookupKey
            self.transformQuantity = transformQuantity
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
        }

        public enum BillingScheme: String, Codable, Hashable, Sendable {
            case perUnit = "per_unit"
            case tiered
        }

        public enum TaxBehavior: String, Codable, Hashable, Sendable {
            case exclusive
            case inclusive
            case unspecified
        }

        public enum TiersMode: String, Codable, Hashable, Sendable {
            case graduated
            case volume
        }

        public struct CurrencyOptions: Codable, Hashable, Sendable {
            /// When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment.
            public var customUnitAmount: CustomUnitAmount?
            /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
            public var taxBehavior: TaxBehavior?
            /// Each element represents a pricing tier.
            public var tiers: [Tiers]?
            /// A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
            public var unitAmount: Int?
            /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
            public var unitAmountDecimal: String?

            public init(
                customUnitAmount: CustomUnitAmount? = nil,
                taxBehavior: TaxBehavior? = nil,
                tiers: [Tiers]? = nil,
                unitAmount: Int? = nil,
                unitAmountDecimal: String? = nil
            ) {
                self.customUnitAmount = customUnitAmount
                self.taxBehavior = taxBehavior
                self.tiers = tiers
                self.unitAmount = unitAmount
                self.unitAmountDecimal = unitAmountDecimal
            }

            public enum TaxBehavior: String, Codable, Hashable, Sendable {
                case exclusive
                case inclusive
                case unspecified
            }

            /// When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment.
            public struct CustomUnitAmount: Codable, Hashable, Sendable {
                /// Pass in `true` to enable `custom_unit_amount`, otherwise omit `custom_unit_amount`.
                public var enabled: Bool
                /// The maximum unit amount the customer can specify for this item.
                public var maximum: Int?
                /// The minimum unit amount the customer can specify for this item.
                public var minimum: Int?
                /// The starting unit amount which can be updated by the customer.
                public var preset: Int?

                public init(
                    enabled: Bool,
                    maximum: Int? = nil,
                    minimum: Int? = nil,
                    preset: Int? = nil
                ) {
                    self.enabled = enabled
                    self.maximum = maximum
                    self.minimum = minimum
                    self.preset = preset
                }
            }

            public struct Tiers: Codable, Hashable, Sendable {
                /// The flat billing amount for an entire tier, regardless of the number of units in the tier.
                public var flatAmount: Int?
                /// Same as `flat_amount`, but accepts a decimal value representing an integer in the minor units of the currency.
                public var flatAmountDecimal: String?
                /// The per unit billing amount for each individual unit for which this tier applies.
                public var unitAmount: Int?
                /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
                public var unitAmountDecimal: String?
                /// Specifies the upper bound of this tier.
                public var upTo: UpTo

                public init(
                    flatAmount: Int? = nil,
                    flatAmountDecimal: String? = nil,
                    unitAmount: Int? = nil,
                    unitAmountDecimal: String? = nil,
                    upTo: UpTo
                ) {
                    self.flatAmount = flatAmount
                    self.flatAmountDecimal = flatAmountDecimal
                    self.unitAmount = unitAmount
                    self.unitAmountDecimal = unitAmountDecimal
                    self.upTo = upTo
                }

                /// Specifies the upper bound of this tier.
                public enum UpTo: Codable, Hashable, Sendable {
                    case value(Int)
                    case inf

                    public init(from decoder: any Decoder) throws {
                        let container = try decoder.singleValueContainer()
                        if let value = try? container.decode(Int.self) {
                            self = .value(value)
                            return
                        }
                        switch try container.decode(String.self) {
                        case "inf": self = .inf
                        case let other: throw DecodingError.dataCorruptedError(in: container, debugDescription: "unknown keyword \(other)")
                        }
                    }

                    public func encode(to encoder: any Encoder) throws {
                        var container = encoder.singleValueContainer()
                        switch self {
                        case .value(let value): try container.encode(value)
                        case .inf: try container.encode("inf")
                        }
                    }
                }
            }
        }

        /// When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment.
        public struct CustomUnitAmount: Codable, Hashable, Sendable {
            /// Pass in `true` to enable `custom_unit_amount`, otherwise omit `custom_unit_amount`.
            public var enabled: Bool
            /// The maximum unit amount the customer can specify for this item.
            public var maximum: Int?
            /// The minimum unit amount the customer can specify for this item.
            public var minimum: Int?
            /// The starting unit amount which can be updated by the customer.
            public var preset: Int?

            public init(
                enabled: Bool,
                maximum: Int? = nil,
                minimum: Int? = nil,
                preset: Int? = nil
            ) {
                self.enabled = enabled
                self.maximum = maximum
                self.minimum = minimum
                self.preset = preset
            }
        }

        /// These fields can be used to create a new product that this price will belong to.
        public struct ProductData: Codable, Hashable, Sendable {
            /// Whether the product is currently available for purchase.
            public var active: Bool?
            /// The identifier for the product.
            public var id: String?
            /// Set of key-value pairs that you can attach to an object.
            public var metadata: [String: String]?
            /// The product's name, meant to be displayable to the customer.
            public var name: String
            /// An arbitrary string to be displayed on your customer's credit card or bank statement.
            public var statementDescriptor: String?
            /// A tax code ID.
            public var taxCode: String?
            /// A label that represents units of this product.
            public var unitLabel: String?

            public init(
                active: Bool? = nil,
                id: String? = nil,
                metadata: [String: String]? = nil,
                name: String,
                statementDescriptor: String? = nil,
                taxCode: String? = nil,
                unitLabel: String? = nil
            ) {
                self.active = active
                self.id = id
                self.metadata = metadata
                self.name = name
                self.statementDescriptor = statementDescriptor
                self.taxCode = taxCode
                self.unitLabel = unitLabel
            }
        }

        /// The recurring components of a price such as `interval` and `usage_type`.
        public struct Recurring: Codable, Hashable, Sendable {
            /// Specifies billing frequency.
            public var interval: Interval
            /// The number of intervals between subscription billings.
            public var intervalCount: Int?
            /// The meter tracking the usage of a metered price.
            public var meter: String?
            /// Default number of trial days when subscribing a customer to this price using `trial_from_plan=true`.
            public var trialPeriodDays: Int?
            /// Configures how the quantity per period should be determined.
            public var usageType: UsageType?

            public init(
                interval: Interval,
                intervalCount: Int? = nil,
                meter: String? = nil,
                trialPeriodDays: Int? = nil,
                usageType: UsageType? = nil
            ) {
                self.interval = interval
                self.intervalCount = intervalCount
                self.meter = meter
                self.trialPeriodDays = trialPeriodDays
                self.usageType = usageType
            }

            public enum Interval: String, Codable, Hashable, Sendable {
                case day
                case month
                case week
                case year
            }

            public enum UsageType: String, Codable, Hashable, Sendable {
                case licensed
                case metered
            }
        }

        public struct Tiers: Codable, Hashable, Sendable {
            /// The flat billing amount for an entire tier, regardless of the number of units in the tier.
            public var flatAmount: Int?
            /// Same as `flat_amount`, but accepts a decimal value representing an integer in the minor units of the currency.
            public var flatAmountDecimal: String?
            /// The per unit billing amount for each individual unit for which this tier applies.
            public var unitAmount: Int?
            /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
            public var unitAmountDecimal: String?
            /// Specifies the upper bound of this tier.
            public var upTo: UpTo

            public init(
                flatAmount: Int? = nil,
                flatAmountDecimal: String? = nil,
                unitAmount: Int? = nil,
                unitAmountDecimal: String? = nil,
                upTo: UpTo
            ) {
                self.flatAmount = flatAmount
                self.flatAmountDecimal = flatAmountDecimal
                self.unitAmount = unitAmount
                self.unitAmountDecimal = unitAmountDecimal
                self.upTo = upTo
            }

            /// Specifies the upper bound of this tier.
            public enum UpTo: Codable, Hashable, Sendable {
                case value(Int)
                case inf

                public init(from decoder: any Decoder) throws {
                    let container = try decoder.singleValueContainer()
                    if let value = try? container.decode(Int.self) {
                        self = .value(value)
                        return
                    }
                    switch try container.decode(String.self) {
                    case "inf": self = .inf
                    case let other: throw DecodingError.dataCorruptedError(in: container, debugDescription: "unknown keyword \(other)")
                    }
                }

                public func encode(to encoder: any Encoder) throws {
                    var container = encoder.singleValueContainer()
                    switch self {
                    case .value(let value): try container.encode(value)
                    case .inf: try container.encode("inf")
                    }
                }
            }
        }

        /// Apply a transformation to the reported usage or set quantity before computing the billed price.
        public struct TransformQuantity: Codable, Hashable, Sendable {
            /// Divide usage by this number.
            public var divideBy: Int
            /// After division, either round the result `up` or `down`.
            public var round: Round

            public init(
                divideBy: Int,
                round: Round
            ) {
                self.divideBy = divideBy
                self.round = round
            }

            public enum Round: String, Codable, Hashable, Sendable {
                case down
                case up
            }
        }
    }

    public typealias Response = Stripe.Products.Price
}

// GET /v1/prices
extension Stripe.Products.Price.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return prices that are active or inactive (e.g., pass `false` to list all inactive prices).
        public var active: Bool?
        /// A filter on the list, based on the object `created` field.
        public var created: Stripe.RangeQuery?
        /// Only return prices for the given currency.
        public var currency: Stripe.Currency?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// Only return the price with these lookup_keys, if any exist.
        public var lookupKeys: [String]?
        /// Only return prices for the given product.
        public var product: String?
        /// Only return prices with these recurring fields.
        public var recurring: Recurring?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return prices of type `recurring` or `one_time`.
        public var `type`: Type?

        public init(
            active: Bool? = nil,
            created: Stripe.RangeQuery? = nil,
            currency: Stripe.Currency? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            lookupKeys: [String]? = nil,
            product: String? = nil,
            recurring: Recurring? = nil,
            startingAfter: String? = nil,
            `type`: Type? = nil
        ) {
            self.active = active
            self.created = created
            self.currency = currency
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.lookupKeys = lookupKeys
            self.product = product
            self.recurring = recurring
            self.startingAfter = startingAfter
            self.`type` = `type`
        }

        public enum `Type`: String, Codable, Hashable, Sendable {
            case oneTime = "one_time"
            case recurring
        }

        /// Only return prices with these recurring fields.
        public struct Recurring: Codable, Hashable, Sendable {
            /// Filter by billing frequency.
            public var interval: Interval?
            /// Filter by the price's meter.
            public var meter: String?
            /// Filter by the usage type for this price.
            public var usageType: UsageType?

            public init(
                interval: Interval? = nil,
                meter: String? = nil,
                usageType: UsageType? = nil
            ) {
                self.interval = interval
                self.meter = meter
                self.usageType = usageType
            }

            public enum Interval: String, Codable, Hashable, Sendable {
                case day
                case month
                case week
                case year
            }

            public enum UsageType: String, Codable, Hashable, Sendable {
                case licensed
                case metered
            }
        }
    }

    public typealias Response = Stripe.Page<Stripe.Products.Price>
}

// GET /v1/prices/{price}
extension Stripe.Products.Price.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Products.Price
}

// GET /v1/prices/search
extension Stripe.Products.Price.Search {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for pagination across multiple pages of results.
        public var page: String?
        /// The search query string.
        public var query: String

        public init(
            expand: [String]? = nil,
            limit: Int? = nil,
            page: String? = nil,
            query: String
        ) {
            self.expand = expand
            self.limit = limit
            self.page = page
            self.query = query
        }
    }

    public typealias Response = Stripe.SearchPage<Stripe.Products.Price>
}

// POST /v1/prices/{price}
extension Stripe.Products.Price.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Whether the price can be used for new purchases.
        public var active: Bool?
        /// Prices defined in each available currency option.
        public var currencyOptions: Stripe.Clearable<[String: CurrencyOptions]>?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A lookup key used to retrieve prices dynamically from a static string.
        public var lookupKey: String?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?
        /// A brief description of the price, hidden from customers.
        public var nickname: String?
        /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
        public var taxBehavior: TaxBehavior?
        /// If set to true, will atomically remove the lookup key from the existing price, and assign it to this price.
        public var transferLookupKey: Bool?

        public init(
            active: Bool? = nil,
            currencyOptions: Stripe.Clearable<[String: CurrencyOptions]>? = nil,
            expand: [String]? = nil,
            lookupKey: String? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil,
            nickname: String? = nil,
            taxBehavior: TaxBehavior? = nil,
            transferLookupKey: Bool? = nil
        ) {
            self.active = active
            self.currencyOptions = currencyOptions
            self.expand = expand
            self.lookupKey = lookupKey
            self.metadata = metadata
            self.nickname = nickname
            self.taxBehavior = taxBehavior
            self.transferLookupKey = transferLookupKey
        }

        public enum TaxBehavior: String, Codable, Hashable, Sendable {
            case exclusive
            case inclusive
            case unspecified
        }

        public struct CurrencyOptions: Codable, Hashable, Sendable {
            /// When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment.
            public var customUnitAmount: CustomUnitAmount?
            /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
            public var taxBehavior: TaxBehavior?
            /// Each element represents a pricing tier.
            public var tiers: [Tiers]?
            /// A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
            public var unitAmount: Int?
            /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
            public var unitAmountDecimal: String?

            public init(
                customUnitAmount: CustomUnitAmount? = nil,
                taxBehavior: TaxBehavior? = nil,
                tiers: [Tiers]? = nil,
                unitAmount: Int? = nil,
                unitAmountDecimal: String? = nil
            ) {
                self.customUnitAmount = customUnitAmount
                self.taxBehavior = taxBehavior
                self.tiers = tiers
                self.unitAmount = unitAmount
                self.unitAmountDecimal = unitAmountDecimal
            }

            public enum TaxBehavior: String, Codable, Hashable, Sendable {
                case exclusive
                case inclusive
                case unspecified
            }

            /// When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment.
            public struct CustomUnitAmount: Codable, Hashable, Sendable {
                /// Pass in `true` to enable `custom_unit_amount`, otherwise omit `custom_unit_amount`.
                public var enabled: Bool
                /// The maximum unit amount the customer can specify for this item.
                public var maximum: Int?
                /// The minimum unit amount the customer can specify for this item.
                public var minimum: Int?
                /// The starting unit amount which can be updated by the customer.
                public var preset: Int?

                public init(
                    enabled: Bool,
                    maximum: Int? = nil,
                    minimum: Int? = nil,
                    preset: Int? = nil
                ) {
                    self.enabled = enabled
                    self.maximum = maximum
                    self.minimum = minimum
                    self.preset = preset
                }
            }

            public struct Tiers: Codable, Hashable, Sendable {
                /// The flat billing amount for an entire tier, regardless of the number of units in the tier.
                public var flatAmount: Int?
                /// Same as `flat_amount`, but accepts a decimal value representing an integer in the minor units of the currency.
                public var flatAmountDecimal: String?
                /// The per unit billing amount for each individual unit for which this tier applies.
                public var unitAmount: Int?
                /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
                public var unitAmountDecimal: String?
                /// Specifies the upper bound of this tier.
                public var upTo: UpTo

                public init(
                    flatAmount: Int? = nil,
                    flatAmountDecimal: String? = nil,
                    unitAmount: Int? = nil,
                    unitAmountDecimal: String? = nil,
                    upTo: UpTo
                ) {
                    self.flatAmount = flatAmount
                    self.flatAmountDecimal = flatAmountDecimal
                    self.unitAmount = unitAmount
                    self.unitAmountDecimal = unitAmountDecimal
                    self.upTo = upTo
                }

                /// Specifies the upper bound of this tier.
                public enum UpTo: Codable, Hashable, Sendable {
                    case value(Int)
                    case inf

                    public init(from decoder: any Decoder) throws {
                        let container = try decoder.singleValueContainer()
                        if let value = try? container.decode(Int.self) {
                            self = .value(value)
                            return
                        }
                        switch try container.decode(String.self) {
                        case "inf": self = .inf
                        case let other: throw DecodingError.dataCorruptedError(in: container, debugDescription: "unknown keyword \(other)")
                        }
                    }

                    public func encode(to encoder: any Encoder) throws {
                        var container = encoder.singleValueContainer()
                        switch self {
                        case .value(let value): try container.encode(value)
                        case .inf: try container.encode("inf")
                        }
                    }
                }
            }
        }
    }

    public typealias Response = Stripe.Products.Price
}
