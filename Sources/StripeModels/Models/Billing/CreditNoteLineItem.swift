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
    /// The credit note line item object.
    public struct CreditNoteLineItem: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The integer amount in cents (or local equivalent) representing the gross amount being credited for this line item.
        public var amount: Int?
        /// Description of the item being credited.
        public var description: String?
        /// The integer amount in cents (or local equivalent) representing the discount being credited for this line item.
        public var discountAmount: Int?
        /// The amount of discount calculated per discount for this line item.
        public var discountAmounts: [Stripe.Shared.DiscountsResourceDiscountAmount]?
        /// ID of the invoice line item being credited.
        public var invoiceLineItem: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The pretax credit amounts (ex: discount, credit grants, etc) for this line item.
        public var pretaxCreditAmounts: [Stripe.Shared.PretaxCreditAmounts]?
        /// The number of units of product being credited.
        public var quantity: Int?
        /// The tax rates which apply to the line item.
        public var taxRates: [Stripe.Tax.Rate]?
        /// The tax information of the line item.
        public var taxes: [Stripe.Shared.BillingBillResourceInvoicingTaxesTax]?
        /// The type of the credit note line item, one of `invoice_line_item` or `custom_line_item`.
        public var `type`: Type?
        /// The cost of each unit of product being credited.
        public var unitAmount: Int?
        /// Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.
        public var unitAmountDecimal: String?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            description: String? = nil,
            discountAmount: Int? = nil,
            discountAmounts: [Stripe.Shared.DiscountsResourceDiscountAmount]? = nil,
            invoiceLineItem: String? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            pretaxCreditAmounts: [Stripe.Shared.PretaxCreditAmounts]? = nil,
            quantity: Int? = nil,
            taxRates: [Stripe.Tax.Rate]? = nil,
            taxes: [Stripe.Shared.BillingBillResourceInvoicingTaxesTax]? = nil,
            `type`: Type? = nil,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.description = description
            self.discountAmount = discountAmount
            self.discountAmounts = discountAmounts
            self.invoiceLineItem = invoiceLineItem
            self.livemode = livemode
            self.metadata = metadata
            self.pretaxCreditAmounts = pretaxCreditAmounts
            self.quantity = quantity
            self.taxRates = taxRates
            self.taxes = taxes
            self.`type` = `type`
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
        }

        /// The type of the credit note line item, one of `invoice_line_item` or `custom_line_item`.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case customLineItem = "custom_line_item"
            case invoiceLineItem = "invoice_line_item"
        }
    }
}
