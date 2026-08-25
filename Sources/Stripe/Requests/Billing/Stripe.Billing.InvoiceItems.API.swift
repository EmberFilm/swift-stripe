//
//  Stripe Billing Invoice Items Types Billing Invoice Items.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.InvoiceItems {
    // https://docs.stripe.com/api/invoiceitems/create.md
    public enum Create {}

    // https://docs.stripe.com/api/invoiceitems/update.md
    public enum Update {}

    // https://docs.stripe.com/api/invoiceitems/list.md
    public enum List {}
}

// MARK: - Create
extension Stripe.Billing.InvoiceItems.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The ID of the customer to be billed
        public let customer: Stripe.Customers.Customer.ID
        /// The amount of the item, in cents
        public let amount: Int?
        /// Three-letter ISO currency code
        public let currency: Stripe.Currency?
        /// An arbitrary string attached to the object
        public let description: String?
        /// Controls discount applicability
        public let discountable: Bool?
        /// List of discounts to apply
        public let discounts: [Discount]?
        /// The ID of an existing invoice to add this item to
        public let invoice: Stripe.Billing.Invoice.ID?
        /// Set of key-value pairs for metadata
        public let metadata: [String: String]?
        /// The time period for this item
        public let period: Period?
        /// Data used to generate a new Price object inline
        public let priceData: PriceData?
        /// Pricing information for the invoice item
        public let pricing: Pricing?
        /// Non-negative integer quantity of units for the invoice item
        public let quantity: Int?
        /// The ID of the subscription this item belongs to
        public let subscription: Stripe.Billing.Subscription.ID?
        /// Specifies tax behavior
        public let taxBehavior: String?
        /// The tax code ID for the item
        public let taxCode: String?
        /// Tax rates which apply to the invoice item
        public let taxRates: [String]?
        /// Same as amount, but represents a decimal value
        public let unitAmountDecimal: String?

        private enum CodingKeys: String, CodingKey {
            case customer
            case amount
            case currency
            case description
            case discountable
            case discounts
            case invoice
            case metadata
            case period
            case priceData
            case pricing
            case quantity
            case subscription
            case taxBehavior
            case taxCode
            case taxRates
            case unitAmountDecimal
        }

        public init(
            customer: Stripe.Customers.Customer.ID,
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            discountable: Bool? = nil,
            discounts: [Discount]? = nil,
            invoice: Stripe.Billing.Invoice.ID? = nil,
            metadata: [String: String]? = nil,
            period: Period? = nil,
            priceData: PriceData? = nil,
            pricing: Pricing? = nil,
            quantity: Int? = nil,
            subscription: Stripe.Billing.Subscription.ID? = nil,
            taxBehavior: String? = nil,
            taxCode: String? = nil,
            taxRates: [String]? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.customer = customer
            self.amount = amount
            self.currency = currency
            self.description = description
            self.discountable = discountable
            self.discounts = discounts
            self.invoice = invoice
            self.metadata = metadata
            self.period = period
            self.priceData = priceData
            self.pricing = pricing
            self.quantity = quantity
            self.subscription = subscription
            self.taxBehavior = taxBehavior
            self.taxCode = taxCode
            self.taxRates = taxRates
            self.unitAmountDecimal = unitAmountDecimal
        }
    }

    public struct Discount: Codable, Equatable, Sendable {
        /// ID of the coupon to create a new discount for
        public let coupon: String?
        /// ID of an existing discount
        public let discount: String?
        /// ID of the promotion code
        public let promotionCode: Promotion.Code.ID?

        private enum CodingKeys: String, CodingKey {
            case coupon
            case discount
            case promotionCode
        }

        public init(
            coupon: String? = nil,
            discount: String? = nil,
            promotionCode: Promotion.Code.ID? = nil
        ) {
            self.coupon = coupon
            self.discount = discount
            self.promotionCode = promotionCode
        }
    }

    public struct Period: Codable, Equatable, Sendable {
        /// The end of the time period
        public let end: Date
        /// The start of the time period
        public let start: Date

        public init(end: Date, start: Date) {
            self.end = end
            self.start = start
        }
    }

    public struct PriceData: Codable, Equatable, Sendable {
        /// Three-letter ISO currency code
        public let currency: Stripe.Currency
        /// The ID of the product that this price will belong to
        public let product: Stripe.Products.Product.ID
        /// Specifies whether the price is considered inclusive of taxes
        public let taxBehavior: String?
        /// A positive integer in cents
        public let unitAmount: Int?
        /// Same as unit_amount, but represented as a decimal string
        public let unitAmountDecimal: String?

        private enum CodingKeys: String, CodingKey {
            case currency
            case product
            case taxBehavior
            case unitAmount
            case unitAmountDecimal
        }

        public init(
            currency: Stripe.Currency,
            product: Stripe.Products.Product.ID,
            taxBehavior: String? = nil,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.currency = currency
            self.product = product
            self.taxBehavior = taxBehavior
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
        }
    }

    public struct Pricing: Codable, Equatable, Sendable {
        /// The ID of the price object
        public let price: Stripe.Products.Price.ID?

        public init(price: Stripe.Products.Price.ID? = nil) {
            self.price = price
        }
    }
}

// MARK: - Update
extension Stripe.Billing.InvoiceItems.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// The amount of the item, in cents
        public let amount: Int?
        /// An arbitrary string attached to the object
        public let description: String?
        /// Controls discount applicability
        public let discountable: Bool?
        /// List of discounts to apply
        public let discounts: [Stripe.Billing.InvoiceItems.Create.Discount]?
        /// Set of key-value pairs for metadata
        public let metadata: [String: String]?
        /// The time period for this item
        public let period: Stripe.Billing.InvoiceItems.Create.Period?
        /// Data used to generate a new Price object inline
        public let priceData: Stripe.Billing.InvoiceItems.Create.PriceData?
        /// Pricing information for the invoice item
        public let pricing: Stripe.Billing.InvoiceItems.Create.Pricing?
        /// Non-negative integer quantity of units for the invoice item
        public let quantity: Int?
        /// Specifies tax behavior
        public let taxBehavior: String?
        /// The tax code ID for the item
        public let taxCode: String?
        /// Tax rates which apply to the invoice item
        public let taxRates: [String]?
        /// Same as amount, but represents a decimal value
        public let unitAmountDecimal: String?

        private enum CodingKeys: String, CodingKey {
            case amount
            case description
            case discountable
            case discounts
            case metadata
            case period
            case priceData
            case pricing
            case quantity
            case taxBehavior
            case taxCode
            case taxRates
            case unitAmountDecimal
        }

        public init(
            amount: Int? = nil,
            description: String? = nil,
            discountable: Bool? = nil,
            discounts: [Stripe.Billing.InvoiceItems.Create.Discount]? = nil,
            metadata: [String: String]? = nil,
            period: Stripe.Billing.InvoiceItems.Create.Period? = nil,
            priceData: Stripe.Billing.InvoiceItems.Create.PriceData? = nil,
            pricing: Stripe.Billing.InvoiceItems.Create.Pricing? = nil,
            quantity: Int? = nil,
            taxBehavior: String? = nil,
            taxCode: String? = nil,
            taxRates: [String]? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.amount = amount
            self.description = description
            self.discountable = discountable
            self.discounts = discounts
            self.metadata = metadata
            self.period = period
            self.priceData = priceData
            self.pricing = pricing
            self.quantity = quantity
            self.taxBehavior = taxBehavior
            self.taxCode = taxCode
            self.taxRates = taxRates
            self.unitAmountDecimal = unitAmountDecimal
        }
    }
}

// MARK: - List
extension Stripe.Billing.InvoiceItems.List {
    public struct Request: Codable, Equatable, Sendable {
        /// A filter on the list based on the object created field
        public let created: Stripe.DateFilter?
        /// The identifier of the customer to list invoice items for
        public let customer: Stripe.Customers.Customer.ID?
        /// A cursor to use in pagination
        public let endingBefore: String?
        /// The identifier of an invoice to retrieve invoice items for
        public let invoice: Stripe.Billing.Invoice.ID?
        /// A limit on the number of objects to return
        public let limit: Int?
        /// Only return pending invoice items
        public let pending: String?
        /// A cursor to use in pagination
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case created
            case customer
            case endingBefore
            case invoice
            case limit
            case pending
            case startingAfter
        }

        public init(
            created: Stripe.DateFilter? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            endingBefore: String? = nil,
            invoice: Stripe.Billing.Invoice.ID? = nil,
            limit: Int? = nil,
            pending: String? = nil,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.customer = customer
            self.endingBefore = endingBefore
            self.invoice = invoice
            self.limit = limit
            self.pending = pending
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.Invoice.Item]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Stripe.Billing.Invoice.Item]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}
