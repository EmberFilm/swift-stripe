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
//  CreditNote.LineItem.swift
//
//
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/creditNotes/line_item.md

extension Stripe.Billing.Credit.Note {
    /// The [Credit Note Line Item](https://stripe.com/docs/api/creditNotes/line_item).
    public struct LineItem: Codable, Hashable, Sendable {
        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object's type.
        ///
        /// Objects of the same type share the same value.
        public var object: String
        /// The integer amount in `cents` representing the total amount being credited for this line item, excluding (exclusive) tax and discounts.
        public var amount: Int?
        /// The integer amount in cents representing the amount being credited for this line item, excluding all tax and discounts.
        public var amountExcludingTax: Int?
        /// Description of the item being credited.
        public var description: String?
        /// The amount of discount calculated per discount for this line item.
        public var discountAmounts: [LineItem.Discount.Amount]?
        /// ID of the invoice line item being credited.
        public var invoiceLineItem: String?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// The number of units of product being credited.
        public var quantity: Int?
        /// The amount of tax calculated per tax rate for this line item.
        public var taxAmounts: [LineItem.Tax.Amount]?
        /// The tax rates which apply to the line item.
        public var taxRates: [Stripe.Tax.Rate]?
        /// The type of the credit note line item, one of `invoice_line_item` or `custom_line_item`.
        ///
        /// When the type is `invoice_line_item` there is an additional `invoice_line_item` property on
        /// the resource the value of which is the id of the credited line item on the invoice.
        public var type: LineItem.`Type`?
        /// The cost of each unit of product being credited.
        public var unitAmount: Int?
        /// Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.
        public var unitAmountDecimal: String?
        /// The amount in cents representing the unit amount being credited for this line item, excluding all tax and discounts.
        public var unitAmountExcludingTax: String?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            amountExcludingTax: Int? = nil,
            description: String? = nil,
            discountAmounts: [LineItem.Discount.Amount]? = nil,
            invoiceLineItem: String? = nil,
            livemode: Bool? = nil,
            quantity: Int? = nil,
            taxAmounts: [LineItem.Tax.Amount]? = nil,
            taxRates: [Stripe.Tax.Rate]? = nil,
            type: LineItem.`Type`? = nil,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil,
            unitAmountExcludingTax: String? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.amountExcludingTax = amountExcludingTax
            self.description = description
            self.discountAmounts = discountAmounts
            self.invoiceLineItem = invoiceLineItem
            self.livemode = livemode
            self.quantity = quantity
            self.taxAmounts = taxAmounts
            self.taxRates = taxRates
            self.type = type
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
            self.unitAmountExcludingTax = unitAmountExcludingTax
        }
    }
}

extension Stripe.Billing.Credit.Note.LineItem {
    public enum Discount {}
}

extension Stripe.Billing.Credit.Note.LineItem.Discount {
    public struct Amount: Codable, Hashable, Sendable {
        /// The amount, in cents, of the discount.
        public var amount: Int?
        /// The discount that was applied to get this discount amount.
        @ExpandableOf<Stripe.Products.Discount> public var discount: Stripe.Products.Discount.ID?

        public init(amount: Int? = nil, discount: Stripe.Products.Discount.ID? = nil) {
            self.amount = amount
            self._discount = Expandable(id: discount)
        }
    }
}

extension Stripe.Billing.Credit.Note.LineItem {
    public enum Tax {}
}

extension Stripe.Billing.Credit.Note.LineItem.Tax {
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

extension Stripe.Billing.Credit.Note.LineItem {
    public enum `Type`: String, Codable, Sendable {
        case invoiceLineItem = "invoice_line_item"
        case customLineItem = "custom_line_item"
    }
}

extension Stripe.Billing.Credit.Note.LineItem {
    public struct List: Codable, Hashable, Sendable {
        /// String representing the object's type.
        ///
        /// Objects of the same type share the same value. Always has the value list.
        public var object: String?
        /// Details about each object.
        public var data: [Stripe.Billing.Credit.Note.LineItem]?
        /// True if this list has another page of items after this one that can be fetched.
        public var hasMore: Bool?
        /// The URL where this list can be accessed.
        public var url: String?

        public init(
            object: String? = nil,
            data: [Stripe.Billing.Credit.Note.LineItem]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
        }
    }
}
