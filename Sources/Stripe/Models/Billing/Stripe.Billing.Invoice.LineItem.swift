//
//  InvoiceLineItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/invoices/line_item.md

/// The [Invoice Line Item Object](https://stripe.com/docs/api/invoices/line_item) .
extension Stripe.Billing.Invoice {
    public struct LineItem: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// The amount, in cents.
        public var amount: Int?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public var description: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Note that for line items with `type=subscription` this will reflect the metadata of the subscription that caused the line item to be created.
        public var metadata: [String: String]?
        /// The timespan covered by this invoice item.
        public var period: Period?
        /// The price of the line item.
        public var price: Stripe.Products.Price?
        /// Whether this is a proration.
        public var proration: Bool?
        /// The quantity of the subscription, if the line item is a subscription or a proration.
        public var quantity: Int?
        /// A string identifying the type of the source of this line item, either an `invoiceitem` or a `subscription`.
        public var type: Type?
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// The integer amount in cents representing the amount for this line item, excluding all tax and discounts.
        public var amountExcludingTax: Int?
        /// The amount of discount calculated per discount for this line item.
        public var discountAmounts: [DiscountAmount]?
        /// If true, discounts will apply to this line item. Always false for prorations.
        public var discountable: Bool?
        @ExpandableCollection<Stripe.Products.Discount> public var discounts: [String]?
        /// The ID of the invoice item associated with this line item if any.
        @ExpandableOf<Stripe.Billing.Invoice.Item> public var invoiceItem:
            Stripe.Billing.Invoice.Item.ID?
        /// Whether this is a test line item.
        public var livemode: Bool?
        /// Additional details for proration line items.
        public var prorationDetails: ProrationDetails?
        /// The subscription that the invoice item pertains to, if any.
        @ExpandableOf<Stripe.Billing.Subscription> public var subscription:
            Stripe.Billing.Subscription.ID?
        /// The subscription item that generated this invoice item. Left empty if the line item is not an explicit result of a subscription.
        @ExpandableOf<Stripe.Billing.Subscription.Item> public var subscriptionItem:
            Stripe.Billing.Subscription.Item.ID?
        /// The amount of tax calculated per tax rate for this line item
        public var taxAmounts: [Stripe.Billing.Invoice.TotalTaxAmount]?
        /// The tax rates which apply to the line item.
        public var taxRates: [Stripe.Tax.Rate]?
        /// The amount in cents representing the unit amount for this line item, excluding all tax and discounts.
        public var unitAmountExcludingTax: String?

        public init(
            id: ID,
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            period: Period? = nil,
            price: Stripe.Products.Price? = nil,
            proration: Bool? = nil,
            quantity: Int? = nil,
            type: Type? = nil,
            object: String,
            amountExcludingTax: Int? = nil,
            discountAmounts: [DiscountAmount]? = nil,
            discountable: Bool? = nil,
            discounts: [String]? = nil,
            invoiceItem: Stripe.Billing.Invoice.Item.ID? = nil,
            livemode: Bool? = nil,
            prorationDetails: ProrationDetails? = nil,
            subscription: Stripe.Billing.Subscription.ID? = nil,
            subscriptionItem: Stripe.Billing.Subscription.Item.ID? = nil,
            taxAmounts: [Stripe.Billing.Invoice.TotalTaxAmount]? = nil,
            taxRates: [Stripe.Tax.Rate]? = nil,
            unitAmountExcludingTax: String? = nil
        ) {
            self.id = id
            self.amount = amount
            self.currency = currency
            self.description = description
            self.metadata = metadata
            self.period = period
            self.price = price
            self.proration = proration
            self.quantity = quantity
            self.type = type
            self.object = object
            self.amountExcludingTax = amountExcludingTax
            self.discountAmounts = discountAmounts
            self.discountable = discountable
            self._discounts = ExpandableCollection(ids: discounts)
            self._invoiceItem = Expandable(id: invoiceItem)
            self.livemode = livemode
            self.prorationDetails = prorationDetails
            self._subscription = Expandable(id: subscription)
            self._subscriptionItem = Expandable(id: subscriptionItem)
            self.taxAmounts = taxAmounts
            self.taxRates = taxRates
            self.unitAmountExcludingTax = unitAmountExcludingTax
        }
    }
}

extension Stripe.Billing.Invoice.LineItem {
    public struct Period: Codable, Hashable, Sendable {
        /// Start of the line item's billing period
        public var start: Date?
        /// End of the line item's billing period
        public var end: Date?

        public init(
            start: Date? = nil,
            end: Date? = nil
        ) {
            self.start = start
            self.end = end
        }
    }

    public enum `Type`: String, Codable, Sendable {
        case invoiceitem
        case subscription
    }

    public struct DiscountAmount: Codable, Hashable, Sendable {
        /// The amount, in cents, of the discount.
        public var amount: Int?
        /// The discount that was applied to get this discount amount.
        @ExpandableOf<Stripe.Products.Discount> public var discount: Stripe.Products.Discount.ID?

        public init(
            amount: Int? = nil,
            discount: Stripe.Products.Discount.ID? = nil
        ) {
            self.amount = amount
            self._discount = Expandable(id: discount)
        }
    }

    public struct ProrationDetails: Codable, Hashable, Sendable {
        /// For a credit proration `line_item`, the original debit `lineItems` to which the credit proration applies.
        public var creditedItems: CreditedItem?

        public init(
            creditedItems: CreditedItem? = nil
        ) {
            self.creditedItems = creditedItems
        }
    }
}

extension Stripe.Billing.Invoice.LineItem.ProrationDetails {
    public struct CreditedItem: Codable, Hashable, Sendable {
        /// Invoice containing the credited invoice line items
        public var invoice: Stripe.Billing.Invoice.ID?
        /// Credited invoice line items
        public var invoiceLineItems: [String]?

        public init(
            invoice: Stripe.Billing.Invoice.ID? = nil,
            invoiceLineItems: [String]? = nil
        ) {
            self.invoice = invoice
            self.invoiceLineItems = invoiceLineItems
        }
    }
}

extension Stripe.Billing.Invoice.LineItem {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Billing.Invoice.LineItem]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Billing.Invoice.LineItem]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct SearchResult: Codable, Hashable, Sendable {
        /// A string describing the object type returned.
        public var object: String
        /// A list of invoices, paginated by any request parameters.
        public var data: [Stripe.Billing.Invoice]?
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
            data: [Stripe.Billing.Invoice]? = nil,
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
