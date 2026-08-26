//
//  CreditNote.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/13/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/creditNotes/object.md

/// The [Credit Note Object](https://stripe.com/docs/api/creditNotes/object) .

// The Note struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.Credit.Note` that the generator spells differently.

extension Stripe.Billing.Credit.Note {
    public enum Shipping {}
}

extension Stripe.Billing.Credit.Note.Shipping {
    public struct Cost: Codable, Hashable, Sendable {
        /// Total shipping cost before any taxes are applied.
        public var amountSubtotal: Int?
        /// Total tax amount applied due to shipping costs. If no tax was applied, defaults to 0.
        public var amountTax: Int?
        /// Total shipping cost after taxes are applied.
        public var amountTotal: Int?
        /// The ID of the Shipping.Rate for this invoice.
        @Expandable<Stripe.Products.Shipping.Rate, String> public var shippingRate: String?
        /// The taxes applied to the shipping rate. This field is not included by default. To include it in the response, [expand](https://stripe.com/docs/api/expanding_objects) the `taxes` field.
        public var taxes: [Cost.Tax]?

        public init(
            amountSubtotal: Int? = nil,
            amountTax: Int? = nil,
            amountTotal: Int? = nil,
            shippingRate: String? = nil,
            taxes: [Cost.Tax]? = nil
        ) {
            self.amountSubtotal = amountSubtotal
            self.amountTax = amountTax
            self.amountTotal = amountTotal
            self._shippingRate = Expandable(id: shippingRate)
            self.taxes = taxes
        }
    }
}

extension Stripe.Billing.Credit.Note.Shipping.Cost {
    public struct Tax: Codable, Hashable, Sendable {
        /// Amount of tax applied for this rate.
        public var amount: Int?
        /// The tax rate applied.
        public var rate: Stripe.Tax.Rate?

        public init(
            amount: Int? = nil,
            rate: Stripe.Tax.Rate? = nil
        ) {
            self.amount = amount
            self.rate = rate
        }
    }
}

extension Stripe.Billing.Credit.Note {
    public enum Tax {}
}

extension Stripe.Billing.Credit.Note.Tax {
    public struct Amount: Codable, Hashable, Sendable {
        /// The amount, in cents, of the tax.
        public var amount: Int?
        /// Whether this tax amount is inclusive or exclusive.
        public var inclusive: Bool?
        /// The tax rate that was applied to get this tax amount.
        @ExpandableOf<Stripe.Tax.Rate> public var taxRate: Stripe.Tax.Rate.ID?

        public init(
            amount: Int? = nil,
            inclusive: Bool? = nil,
            taxRate: Stripe.Tax.Rate.ID? = nil
        ) {
            self.amount = amount
            self.inclusive = inclusive
            self._taxRate = Expandable(id: taxRate)
        }
    }
}

