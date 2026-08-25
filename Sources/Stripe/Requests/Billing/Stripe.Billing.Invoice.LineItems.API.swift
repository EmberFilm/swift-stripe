//
//  Stripe Billing Invoice Line Item Types Billing Invoice Line Item.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Invoice {
    public enum LineItems {}
}

extension Stripe.Billing.Invoice.LineItems {
    // https://docs.stripe.com/api/invoice-line-item/retrieve.md
    public enum List {}
}

extension Stripe.Billing.Invoice.LineItems.List {
    public struct Request: Codable, Equatable, Sendable {
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public var endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public var limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public var startingAfter: String?

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }

        private enum CodingKeys: String, CodingKey {
            case endingBefore
            case limit
            case startingAfter
        }
    }
}

extension Stripe.Billing.Invoice.LineItems {
    // https://docs.stripe.com/api/invoice-line-item/update.md
    public enum Update {}
}

extension Stripe.Billing.Invoice.LineItems.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// The integer amount in cents representing the amount for this line item.
        public var amount: Int?
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public var description: String?
        /// Controls whether discounts apply to this line item. Defaults to false for prorations.
        public var discountable: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The quantity of the subscription, if the line item is a subscription or a proration.
        public var quantity: Int?
        /// The tax amounts which apply to the line item.
        public var taxAmounts: [TaxAmount]?
        /// The tax rates which apply to the line item.
        public var taxRates: [String]?

        public init(
            amount: Int? = nil,
            description: String? = nil,
            discountable: Bool? = nil,
            metadata: [String: String]? = nil,
            quantity: Int? = nil,
            taxAmounts: [TaxAmount]? = nil,
            taxRates: [String]? = nil
        ) {
            self.amount = amount
            self.description = description
            self.discountable = discountable
            self.metadata = metadata
            self.quantity = quantity
            self.taxAmounts = taxAmounts
            self.taxRates = taxRates
        }

        private enum CodingKeys: String, CodingKey {
            case amount
            case description
            case discountable
            case metadata
            case quantity
            case taxAmounts
            case taxRates
        }
    }

    public struct TaxAmount: Codable, Equatable, Sendable {
        /// The amount, in cents, of the tax.
        public var amount: Int
        /// Data to find or create a TaxRate object.
        public var taxRateData: TaxRateData?
        /// The ID of an existing TaxRate.
        public var taxRate: String?
        /// Flag to indicate if the tax amount should be taxable by further taxes.
        public var taxable: Bool?

        public init(
            amount: Int,
            taxRateData: TaxRateData? = nil,
            taxRate: String? = nil,
            taxable: Bool? = nil
        ) {
            self.amount = amount
            self.taxRateData = taxRateData
            self.taxRate = taxRate
            self.taxable = taxable
        }

        private enum CodingKeys: String, CodingKey {
            case amount
            case taxRateData
            case taxRate
            case taxable
        }
    }

    public struct TaxRateData: Codable, Equatable, Sendable {
        /// An arbitrary string attached to the tax rate for your internal use only.
        public var displayName: String
        /// This specifies if the tax rate is inclusive or exclusive.
        public var inclusive: Bool
        /// The high-level tax type, such as vat or sales_tax.
        public var percentage: Double

        public init(
            displayName: String,
            inclusive: Bool,
            percentage: Double
        ) {
            self.displayName = displayName
            self.inclusive = inclusive
            self.percentage = percentage
        }

        private enum CodingKeys: String, CodingKey {
            case displayName
            case inclusive
            case percentage
        }
    }
}

extension Stripe.Billing.Invoice.LineItems {
    // https://docs.stripe.com/api/invoice-line-item/bulk.md
    public enum AddLines {}
}

extension Stripe.Billing.Invoice.LineItems.AddLines {
    public struct Request: Codable, Equatable, Sendable {
        /// The line items to add to the invoice.
        public var lines: [LineItem]
        /// Set of key-value pairs that you can attach to the invoice.
        public var invoiceMetadata: [String: String]?

        public init(
            lines: [LineItem],
            invoiceMetadata: [String: String]? = nil
        ) {
            self.lines = lines
            self.invoiceMetadata = invoiceMetadata
        }

        private enum CodingKeys: String, CodingKey {
            case lines
            case invoiceMetadata
        }
    }

    public struct LineItem: Codable, Equatable, Sendable {
        /// The integer amount in cents representing the amount for this line item.
        public var amount: Int?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// Controls whether discounts apply to this line item.
        public var discountable: Bool?
        /// The ID of the invoice item to add to the invoice.
        public var invoiceItem: String?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The ID of the Price object.
        public var price: Stripe.Products.Price.ID?
        /// Data used to generate a new Price object inline.
        public var priceData: PriceData?
        /// The quantity of the product.
        public var quantity: Int?
        /// The tax amounts which apply to the line item.
        public var taxAmounts: [Stripe.Billing.Invoice.LineItems.Update.TaxAmount]?
        /// The tax rates which apply to the line item.
        public var taxRates: [String]?

        public init(
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            discountable: Bool? = nil,
            invoiceItem: String? = nil,
            metadata: [String: String]? = nil,
            price: Stripe.Products.Price.ID? = nil,
            priceData: PriceData? = nil,
            quantity: Int? = nil,
            taxAmounts: [Stripe.Billing.Invoice.LineItems.Update.TaxAmount]? = nil,
            taxRates: [String]? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.description = description
            self.discountable = discountable
            self.invoiceItem = invoiceItem
            self.metadata = metadata
            self.price = price
            self.priceData = priceData
            self.quantity = quantity
            self.taxAmounts = taxAmounts
            self.taxRates = taxRates
        }

        private enum CodingKeys: String, CodingKey {
            case amount
            case currency
            case description
            case discountable
            case invoiceItem
            case metadata
            case price
            case priceData
            case quantity
            case taxAmounts
            case taxRates
        }
    }

    public struct PriceData: Codable, Equatable, Sendable {
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency
        /// The ID of the product that this price will belong to.
        public var product: Stripe.Products.Product.ID
        /// A positive integer in cents representing how much to charge.
        public var unitAmount: Int?
        /// Same as unit_amount, but accepts a decimal value with at most 12 decimal places.
        public var unitAmountDecimal: String?

        public init(
            currency: Stripe.Currency,
            product: Stripe.Products.Product.ID,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.currency = currency
            self.product = product
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
        }

        private enum CodingKeys: String, CodingKey {
            case currency
            case product
            case unitAmount
            case unitAmountDecimal
        }
    }
}

extension Stripe.Billing.Invoice.LineItems {
    // https://docs.stripe.com/api/invoice-line-item/bulk-update.md
    public enum UpdateLines {}
}

extension Stripe.Billing.Invoice.LineItems.UpdateLines {
    public struct Request: Codable, Equatable, Sendable {
        /// The line items to update on the invoice.
        public var lines: [LineItem]
        /// Set of key-value pairs that you can attach to the invoice.
        public var invoiceMetadata: [String: String]?

        public init(
            lines: [LineItem],
            invoiceMetadata: [String: String]? = nil
        ) {
            self.lines = lines
            self.invoiceMetadata = invoiceMetadata
        }

        private enum CodingKeys: String, CodingKey {
            case lines
            case invoiceMetadata
        }
    }

    public struct LineItem: Codable, Equatable, Sendable, Identifiable {
        public typealias ID = String
        /// The ID of the line item to update.
        public var id: ID
        /// The integer amount in cents representing the amount for this line item.
        public var amount: Int?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// Controls whether discounts apply to this line item.
        public var discountable: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The quantity of the product.
        public var quantity: Int?
        /// The tax amounts which apply to the line item.
        public var taxAmounts: [Stripe.Billing.Invoice.LineItems.Update.TaxAmount]?
        /// The tax rates which apply to the line item.
        public var taxRates: [String]?

        public init(
            id: ID,
            amount: Int? = nil,
            description: String? = nil,
            discountable: Bool? = nil,
            metadata: [String: String]? = nil,
            quantity: Int? = nil,
            taxAmounts: [Stripe.Billing.Invoice.LineItems.Update.TaxAmount]? = nil,
            taxRates: [String]? = nil
        ) {
            self.id = id
            self.amount = amount
            self.description = description
            self.discountable = discountable
            self.metadata = metadata
            self.quantity = quantity
            self.taxAmounts = taxAmounts
            self.taxRates = taxRates
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case amount
            case description
            case discountable
            case metadata
            case quantity
            case taxAmounts
            case taxRates
        }
    }
}

extension Stripe.Billing.Invoice.LineItems {
    // https://docs.stripe.com/api/invoice-line-item/invoices/remove-lines/bulk.md
    public enum RemoveLines {}
}

extension Stripe.Billing.Invoice.LineItems.RemoveLines {
    public struct Request: Codable, Equatable, Sendable {
        /// The line items to remove from the invoice.
        public var lines: [LineItem]
        /// Set of key-value pairs that you can attach to the invoice.
        public var invoiceMetadata: [String: String]?

        public init(
            lines: [LineItem],
            invoiceMetadata: [String: String]? = nil
        ) {
            self.lines = lines
            self.invoiceMetadata = invoiceMetadata
        }

        private enum CodingKeys: String, CodingKey {
            case lines
            case invoiceMetadata
        }
    }

    public struct LineItem: Codable, Equatable, Sendable {
        /// The ID of the line item to remove.
        public var id: Stripe.Billing.Invoice.LineItem.ID

        public init(id: Stripe.Billing.Invoice.LineItem.ID) {
            self.id = id
        }

        private enum CodingKeys: String, CodingKey {
            case id
        }
    }
}
