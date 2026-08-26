//
//  QuoteLineItem.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/25/21.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/quotes/line_item.md

extension Stripe.Billing.Quote {
    public struct LineItem: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// Total discount amount applied. If no discounts were applied, defaults to 0.
        public var amountDiscount: Int?
        /// Total before any discounts or taxes are applied.
        public var amountSubtotal: Int?
        /// Total tax amount applied. If no tax was applied, defaults to 0.
        public var amountTax: Int?
        /// Total after discounts and taxes.
        public var amountTotal: Int?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// An arbitrary string attached to the object. Often useful for displaying to users. Defaults to product name.
        public var description: String?
        /// This field is not included by default. To include it in the response, expand the `discounts` field.
        public var discounts: [Discount]?
        /// The price used to generate the line item.
        public var price: Stripe.Products.Price?
        /// The quantity of products being purchased.
        public var quantity: Int?
        /// The taxes applied to the line item.
        ///
        /// This field is not included by default. To include it in the response, expand the `taxes` field.
        public var taxes: [Tax]?

        public init(
            id: ID,
            object: String,
            amountDiscount: Int? = nil,
            amountSubtotal: Int? = nil,
            amountTax: Int? = nil,
            amountTotal: Int? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            discounts: [Discount]? = nil,
            price: Stripe.Products.Price? = nil,
            quantity: Int? = nil,
            taxes: [Tax]? = nil
        ) {
            self.id = id
            self.object = object
            self.amountDiscount = amountDiscount
            self.amountSubtotal = amountSubtotal
            self.amountTax = amountTax
            self.amountTotal = amountTotal
            self.currency = currency
            self.description = description
            self.discounts = discounts
            self.price = price
            self.quantity = quantity
            self.taxes = taxes
        }
    }
}

extension Stripe.Billing.Quote.LineItem {
    public struct Discount: Codable, Hashable, Sendable {
        /// The amount discounted.
        public var amount: Int?
        /// The discount applied.
        public var discount: Stripe.Products.Discount?

        public init(
            amount: Int? = nil,
            discount: Stripe.Products.Discount? = nil
        ) {
            self.amount = amount
            self.discount = discount
        }
    }
}

extension Stripe.Billing.Quote.LineItem {
    public struct Tax: Codable, Hashable, Sendable {
        /// Amount of tax applied for this rate.
        public var amount: Int?
        /// The tax rate applied.
        public var rate: Stripe.Tax.Rate?
        /// The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
        public var taxabilityReason: TaxabilityReason?

        public init(
            amount: Int? = nil,
            rate: Stripe.Tax.Rate? = nil,
            taxabilityReason: TaxabilityReason? = nil
        ) {
            self.amount = amount
            self.rate = rate
            self.taxabilityReason = taxabilityReason
        }
    }
}

extension Stripe.Billing.Quote.LineItem.Tax {
    public enum TaxabilityReason: String, Codable, Sendable {
        case vatExempt = "vat_exempt"
        case jurisdictionUnsupported = "jurisdiction_unsupported"
        case excludedTerritory = "excluded_territory"
        case standardRated = "standard_rated"
        case reducedRated = "reduced_rated"
        case zeroRated = "zero_rated"
        case reverseCharge = "reverse_charge"
        case customerExempt = "customer_exempt"
        case productExempt = "product_exempt"
        case productExemptHoliday = "product_exempt_holiday"
        case portionStandardRated = "portion_standard_rated"
        case portionReducedRated = "portion_reduced_rated"
        case portionProductExempt = "portion_product_exempt"
        case taxableBasisReduced = "taxable_basis_reduced"
        case notCollecting = "not_collecting"
        case notSubjectToTax = "not_subject_to_tax"
        case notSupported = "not_supported"
        case proportionallyRated = "proportionally_rated"
    }
}

extension Stripe.Billing.Quote.LineItem {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Billing.Quote.LineItem]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Billing.Quote.LineItem]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
