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

extension Stripe.Billing.Invoice.Item {
    public enum Create {}
    public enum Delete {}
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/invoiceitems
extension Stripe.Billing.Invoice.Item.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// The integer amount in cents (or local equivalent) of the charge to be applied to the upcoming invoice.
        public var amount: Int?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// The ID of the customer to bill for this invoice item.
        public var customer: String?
        /// The ID of the account representing the customer to bill for this invoice item.
        public var customerAccount: String?
        /// An arbitrary string which you can attach to the invoice item.
        public var description: String?
        /// Controls whether discounts apply to this invoice item.
        public var discountable: Bool?
        /// The coupons and promotion codes to redeem into discounts for the invoice item or invoice line item.
        public var discounts: Stripe.Clearable<[Discounts]>?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The ID of an existing invoice to add this invoice item to.
        public var invoice: String?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?
        /// The period associated with this invoice item.
        public var period: Period?
        /// Data used to generate a new Price object inline.
        public var priceData: PriceData?
        /// The pricing information for the invoice item.
        public var pricing: Pricing?
        /// Non-negative integer.
        public var quantity: Int?
        /// Non-negative decimal with at most 12 decimal places.
        public var quantityDecimal: String?
        /// The ID of a subscription to add this invoice item to.
        public var subscription: String?
        /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
        public var taxBehavior: TaxBehavior?
        /// A tax code ID.
        public var taxCode: String?
        /// The tax rates which apply to the invoice item.
        public var taxRates: [String]?
        /// The decimal unit amount in cents (or local equivalent) of the charge to be applied to the upcoming invoice.
        public var unitAmountDecimal: String?

        public init(
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            description: String? = nil,
            discountable: Bool? = nil,
            discounts: Stripe.Clearable<[Discounts]>? = nil,
            expand: [String]? = nil,
            invoice: String? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil,
            period: Period? = nil,
            priceData: PriceData? = nil,
            pricing: Pricing? = nil,
            quantity: Int? = nil,
            quantityDecimal: String? = nil,
            subscription: String? = nil,
            taxBehavior: TaxBehavior? = nil,
            taxCode: String? = nil,
            taxRates: [String]? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.customer = customer
            self.customerAccount = customerAccount
            self.description = description
            self.discountable = discountable
            self.discounts = discounts
            self.expand = expand
            self.invoice = invoice
            self.metadata = metadata
            self.period = period
            self.priceData = priceData
            self.pricing = pricing
            self.quantity = quantity
            self.quantityDecimal = quantityDecimal
            self.subscription = subscription
            self.taxBehavior = taxBehavior
            self.taxCode = taxCode
            self.taxRates = taxRates
            self.unitAmountDecimal = unitAmountDecimal
        }

        public enum TaxBehavior: String, Codable, Hashable, Sendable {
            case exclusive
            case inclusive
            case unspecified
        }

        public struct Discounts: Codable, Hashable, Sendable {
            /// ID of the coupon to create a new discount for.
            public var coupon: String?
            /// ID of an existing discount on the object (or one of its ancestors) to reuse.
            public var discount: String?
            /// ID of the promotion code to create a new discount for.
            public var promotionCode: String?

            public init(
                coupon: String? = nil,
                discount: String? = nil,
                promotionCode: String? = nil
            ) {
                self.coupon = coupon
                self.discount = discount
                self.promotionCode = promotionCode
            }
        }

        /// The period associated with this invoice item.
        public struct Period: Codable, Hashable, Sendable {
            /// The end of the period, which must be greater than or equal to the start.
            public var end: Date
            /// The start of the period.
            public var start: Date

            public init(
                end: Date,
                start: Date
            ) {
                self.end = end
                self.start = start
            }
        }

        /// Data used to generate a new Price object inline.
        public struct PriceData: Codable, Hashable, Sendable {
            /// Three-letter ISO currency code, in lowercase.
            public var currency: Stripe.Currency
            /// The ID of the Product that this Price will belong to.
            public var product: String
            /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
            public var taxBehavior: TaxBehavior?
            /// A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
            public var unitAmount: Int?
            /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
            public var unitAmountDecimal: String?

            public init(
                currency: Stripe.Currency,
                product: String,
                taxBehavior: TaxBehavior? = nil,
                unitAmount: Int? = nil,
                unitAmountDecimal: String? = nil
            ) {
                self.currency = currency
                self.product = product
                self.taxBehavior = taxBehavior
                self.unitAmount = unitAmount
                self.unitAmountDecimal = unitAmountDecimal
            }

            public enum TaxBehavior: String, Codable, Hashable, Sendable {
                case exclusive
                case inclusive
                case unspecified
            }
        }

        /// The pricing information for the invoice item.
        public struct Pricing: Codable, Hashable, Sendable {
            /// The ID of the price object.
            public var price: String?

            public init(
                price: String? = nil
            ) {
                self.price = price
            }
        }
    }

    public typealias Response = Stripe.Billing.Invoice.Item
}

// DELETE /v1/invoiceitems/{invoiceitem}
extension Stripe.Billing.Invoice.Item.Delete {
    public typealias Response = DeletedObject<Stripe.Billing.Invoice.Item>
}

// GET /v1/invoiceitems
extension Stripe.Billing.Invoice.Item.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return invoice items that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// The identifier of the customer whose invoice items to return.
        public var customer: String?
        /// The identifier of the account representing the customer whose invoice items to return.
        public var customerAccount: String?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Only return invoice items belonging to this invoice.
        public var invoice: String?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// Set to `true` to only show pending invoice items, which are not yet attached to any invoices.
        public var pending: Bool?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            created: Stripe.RangeQuery? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            invoice: String? = nil,
            limit: Int? = nil,
            pending: Bool? = nil,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.customer = customer
            self.customerAccount = customerAccount
            self.endingBefore = endingBefore
            self.expand = expand
            self.invoice = invoice
            self.limit = limit
            self.pending = pending
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Stripe.Billing.Invoice.Item>
}

// GET /v1/invoiceitems/{invoiceitem}
extension Stripe.Billing.Invoice.Item.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Invoice.Item
}

// POST /v1/invoiceitems/{invoiceitem}
extension Stripe.Billing.Invoice.Item.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// The integer amount in cents (or local equivalent) of the charge to be applied to the upcoming invoice.
        public var amount: Int?
        /// An arbitrary string which you can attach to the invoice item.
        public var description: String?
        /// Controls whether discounts apply to this invoice item.
        public var discountable: Bool?
        /// The coupons, promotion codes & existing discounts which apply to the invoice item or invoice line item.
        public var discounts: Stripe.Clearable<[Discounts]>?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?
        /// The period associated with this invoice item.
        public var period: Period?
        /// Data used to generate a new Price object inline.
        public var priceData: PriceData?
        /// The pricing information for the invoice item.
        public var pricing: Pricing?
        /// Non-negative integer.
        public var quantity: Int?
        /// Non-negative decimal with at most 12 decimal places.
        public var quantityDecimal: String?
        /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
        public var taxBehavior: TaxBehavior?
        /// A tax code ID.
        public var taxCode: String?
        /// The tax rates which apply to the invoice item.
        public var taxRates: Stripe.Clearable<[String]>?
        /// The decimal unit amount in cents (or local equivalent) of the charge to be applied to the upcoming invoice.
        public var unitAmountDecimal: String?

        public init(
            amount: Int? = nil,
            description: String? = nil,
            discountable: Bool? = nil,
            discounts: Stripe.Clearable<[Discounts]>? = nil,
            expand: [String]? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil,
            period: Period? = nil,
            priceData: PriceData? = nil,
            pricing: Pricing? = nil,
            quantity: Int? = nil,
            quantityDecimal: String? = nil,
            taxBehavior: TaxBehavior? = nil,
            taxCode: String? = nil,
            taxRates: Stripe.Clearable<[String]>? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.amount = amount
            self.description = description
            self.discountable = discountable
            self.discounts = discounts
            self.expand = expand
            self.metadata = metadata
            self.period = period
            self.priceData = priceData
            self.pricing = pricing
            self.quantity = quantity
            self.quantityDecimal = quantityDecimal
            self.taxBehavior = taxBehavior
            self.taxCode = taxCode
            self.taxRates = taxRates
            self.unitAmountDecimal = unitAmountDecimal
        }

        public enum TaxBehavior: String, Codable, Hashable, Sendable {
            case exclusive
            case inclusive
            case unspecified
        }

        public struct Discounts: Codable, Hashable, Sendable {
            /// ID of the coupon to create a new discount for.
            public var coupon: String?
            /// ID of an existing discount on the object (or one of its ancestors) to reuse.
            public var discount: String?
            /// ID of the promotion code to create a new discount for.
            public var promotionCode: String?

            public init(
                coupon: String? = nil,
                discount: String? = nil,
                promotionCode: String? = nil
            ) {
                self.coupon = coupon
                self.discount = discount
                self.promotionCode = promotionCode
            }
        }

        /// The period associated with this invoice item.
        public struct Period: Codable, Hashable, Sendable {
            /// The end of the period, which must be greater than or equal to the start.
            public var end: Date
            /// The start of the period.
            public var start: Date

            public init(
                end: Date,
                start: Date
            ) {
                self.end = end
                self.start = start
            }
        }

        /// Data used to generate a new Price object inline.
        public struct PriceData: Codable, Hashable, Sendable {
            /// Three-letter ISO currency code, in lowercase.
            public var currency: Stripe.Currency
            /// The ID of the Product that this Price will belong to.
            public var product: String
            /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
            public var taxBehavior: TaxBehavior?
            /// A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
            public var unitAmount: Int?
            /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
            public var unitAmountDecimal: String?

            public init(
                currency: Stripe.Currency,
                product: String,
                taxBehavior: TaxBehavior? = nil,
                unitAmount: Int? = nil,
                unitAmountDecimal: String? = nil
            ) {
                self.currency = currency
                self.product = product
                self.taxBehavior = taxBehavior
                self.unitAmount = unitAmount
                self.unitAmountDecimal = unitAmountDecimal
            }

            public enum TaxBehavior: String, Codable, Hashable, Sendable {
                case exclusive
                case inclusive
                case unspecified
            }
        }

        /// The pricing information for the invoice item.
        public struct Pricing: Codable, Hashable, Sendable {
            /// The ID of the price object.
            public var price: String?

            public init(
                price: String? = nil
            ) {
                self.price = price
            }
        }
    }

    public typealias Response = Stripe.Billing.Invoice.Item
}
