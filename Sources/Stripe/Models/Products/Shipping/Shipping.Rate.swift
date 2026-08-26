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

extension Stripe.Products.Shipping {
    /// Shipping rates describe the price of shipping presented to your customers and applied to a purchase.
    public struct Rate: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Whether the shipping rate can be used for new purchases.
        public var active: Bool?
        /// Time at which the object was created.
        public var created: Date?
        /// The estimated range for how long shipping will take, meant to be displayable to the customer.
        public var deliveryEstimate: DeliveryEstimate?
        /// The name of the shipping rate, meant to be displayable to the customer.
        public var displayName: String?
        public var fixedAmount: FixedAmount?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes.
        public var taxBehavior: TaxBehavior?
        /// A tax code ID.
        @Expandable<Stripe.Tax.Code, String> public var taxCode: String?
        /// The type of calculation to use on the shipping rate.
        public var `type`: String?

        public init(
            id: ID,
            object: String,
            active: Bool? = nil,
            created: Date? = nil,
            deliveryEstimate: DeliveryEstimate? = nil,
            displayName: String? = nil,
            fixedAmount: FixedAmount? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            taxBehavior: TaxBehavior? = nil,
            taxCode: String? = nil,
            `type`: String? = nil
        ) {
            self.id = id
            self.object = object
            self.active = active
            self.created = created
            self.deliveryEstimate = deliveryEstimate
            self.displayName = displayName
            self.fixedAmount = fixedAmount
            self.livemode = livemode
            self.metadata = metadata
            self.taxBehavior = taxBehavior
            self._taxCode = Expandable(id: taxCode)
            self.`type` = `type`
        }

        /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes.
        public enum TaxBehavior: String, Codable, Hashable, Sendable {
            case exclusive
            case inclusive
            case unspecified
        }

        public struct DeliveryEstimate: Codable, Hashable, Sendable {
            /// The upper bound of the estimated range.
            public var maximum: Maximum?
            /// The lower bound of the estimated range.
            public var minimum: Minimum?

            public init(
                maximum: Maximum? = nil,
                minimum: Minimum? = nil
            ) {
                self.maximum = maximum
                self.minimum = minimum
            }

            public struct Maximum: Codable, Hashable, Sendable {
                /// A unit of time.
                public var unit: Unit?
                /// Must be greater than 0.
                public var value: Int?

                public init(
                    unit: Unit? = nil,
                    value: Int? = nil
                ) {
                    self.unit = unit
                    self.value = value
                }

                /// A unit of time.
                public enum Unit: String, Codable, Hashable, Sendable {
                    case businessDay = "business_day"
                    case day
                    case hour
                    case month
                    case week
                }
            }

            public struct Minimum: Codable, Hashable, Sendable {
                /// A unit of time.
                public var unit: Unit?
                /// Must be greater than 0.
                public var value: Int?

                public init(
                    unit: Unit? = nil,
                    value: Int? = nil
                ) {
                    self.unit = unit
                    self.value = value
                }

                /// A unit of time.
                public enum Unit: String, Codable, Hashable, Sendable {
                    case businessDay = "business_day"
                    case day
                    case hour
                    case month
                    case week
                }
            }
        }

        public struct FixedAmount: Codable, Hashable, Sendable {
            /// A non-negative integer in cents representing how much to charge.
            public var amount: Int?
            /// Three-letter ISO currency code, in lowercase.
            public var currency: Stripe.Currency?
            /// Shipping rates defined in each available currency option.
            public var currencyOptions: [String: CurrencyOptions]?

            public init(
                amount: Int? = nil,
                currency: Stripe.Currency? = nil,
                currencyOptions: [String: CurrencyOptions]? = nil
            ) {
                self.amount = amount
                self.currency = currency
                self.currencyOptions = currencyOptions
            }

            public struct CurrencyOptions: Codable, Hashable, Sendable {
                /// A non-negative integer in cents representing how much to charge.
                public var amount: Int?
                /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes.
                public var taxBehavior: TaxBehavior?

                public init(
                    amount: Int? = nil,
                    taxBehavior: TaxBehavior? = nil
                ) {
                    self.amount = amount
                    self.taxBehavior = taxBehavior
                }

                /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes.
                public enum TaxBehavior: String, Codable, Hashable, Sendable {
                    case exclusive
                    case inclusive
                    case unspecified
                }
            }
        }
    }
}
