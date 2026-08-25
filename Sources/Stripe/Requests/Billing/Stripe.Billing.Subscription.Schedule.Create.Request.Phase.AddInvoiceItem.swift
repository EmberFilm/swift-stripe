//
//  File.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 22/09/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Subscription.Schedule {
    // https://docs.stripe.com/api/subscriptionSchedules/create.md
    public enum Create {}
}

extension Stripe.Billing.Subscription.Schedule.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// Controls how prorations and invoices are calculated
        public var billingMode: BillingMode?
        /// The identifier of the customer to create the subscription schedule for
        public var customer: Stripe.Customers.Customer.ID?
        /// Default settings for subscription schedule
        public var defaultSettings: Stripe.Billing.Subscription.Schedule.DefaultSettings?
        /// Behavior when the subscription schedule ends
        public var endBehavior: Stripe.Billing.Subscription.Schedule.EndBehavior?
        /// Migrate an existing subscription to be managed by a subscription schedule
        public var fromSubscription: Stripe.Billing.Subscription.ID?
        /// Set of key-value pairs
        public var metadata: [String: String]?
        /// Object containing service periods
        public var phases: [Phase]?
        /// When the subscription schedule starts
        public var startDate: Stripe.Billing.Subscription.Schedule.StartDate?

        public init(
            billingMode: BillingMode? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            defaultSettings: Stripe.Billing.Subscription.Schedule.DefaultSettings? = nil,
            endBehavior: Stripe.Billing.Subscription.Schedule.EndBehavior? = nil,
            fromSubscription: Stripe.Billing.Subscription.ID? = nil,
            metadata: [String: String]? = nil,
            phases: [Phase]? = nil,
            startDate: Stripe.Billing.Subscription.Schedule.StartDate? = nil
        ) {
            self.billingMode = billingMode
            self.customer = customer
            self.defaultSettings = defaultSettings
            self.endBehavior = endBehavior
            self.fromSubscription = fromSubscription
            self.metadata = metadata
            self.phases = phases
            self.startDate = startDate
        }

        private enum CodingKeys: String, CodingKey {
            case billingMode
            case customer
            case defaultSettings
            case endBehavior
            case fromSubscription
            case metadata
            case phases
            case startDate
        }
    }
}

extension Stripe.Billing.Subscription.Schedule.Create.Request {
    public struct BillingMode: Codable, Equatable, Sendable {
        public enum ModeType: String, Codable, Equatable, Sendable {
            case classic
            case flexible
        }

        public var type: ModeType

        public init(type: ModeType) {
            self.type = type
        }
    }
}

extension Stripe.Billing.Subscription.Schedule.Create.Request {
    public struct Phase: Codable, Equatable, Sendable {
        /// List of configuration items (required by Stripe API)
        public var items: [Item]
        /// Additional invoice items to add for this phase
        public var addInvoiceItems: [AddInvoiceItem]?
        /// How long the phase lasts
        public var iterations: Int?
        /// The end of this phase
        public var endDate: Date?
        /// Whether this phase is a trial
        public var trial: Bool?
        /// Default tax rates to apply
        public var defaultTaxRates: [String]?
        /// Discounts to apply
        public var discounts: [Stripe.Billing.Subscription.Schedule.Discount]?
        /// Billing cycle anchor configuration
        public var billingCycleAnchor: Stripe.Billing.Subscription.Schedule.BillingCycleAnchor?
        /// Collection method for this phase
        public var collectionMethod: Stripe.Billing.Subscription.Schedule.CollectionMethod?
        /// Invoice settings for this phase
        public var invoiceSettings: Stripe.Billing.Subscription.Schedule.InvoiceSettings?
        /// Subscription data to set on the subscription
        public var metadata: [String: String]?

        public init(
            items: [Item],
            addInvoiceItems: [AddInvoiceItem]? = nil,
            iterations: Int? = nil,
            endDate: Date? = nil,
            trial: Bool? = nil,
            defaultTaxRates: [String]? = nil,
            discounts: [Stripe.Billing.Subscription.Schedule.Discount]? = nil,
            billingCycleAnchor: Stripe.Billing.Subscription.Schedule.BillingCycleAnchor? = nil,
            collectionMethod: Stripe.Billing.Subscription.Schedule.CollectionMethod? = nil,
            invoiceSettings: Stripe.Billing.Subscription.Schedule.InvoiceSettings? = nil,
            metadata: [String: String]? = nil
        ) {
            self.items = items
            self.addInvoiceItems = addInvoiceItems
            self.iterations = iterations
            self.endDate = endDate
            self.trial = trial
            self.defaultTaxRates = defaultTaxRates
            self.discounts = discounts
            self.billingCycleAnchor = billingCycleAnchor
            self.collectionMethod = collectionMethod
            self.invoiceSettings = invoiceSettings
            self.metadata = metadata
        }

        private enum CodingKeys: String, CodingKey {
            case items
            case addInvoiceItems
            case iterations
            case endDate
            case trial
            case defaultTaxRates
            case discounts
            case billingCycleAnchor
            case collectionMethod
            case invoiceSettings
            case metadata
        }
    }
}

extension Stripe.Billing.Subscription.Schedule.Create.Request.Phase {
    public struct AddInvoiceItem: Codable, Equatable, Sendable {
        /// The ID of the price object
        public var price: Stripe.Products.Price.ID?
        /// Data to generate price on the fly
        public var priceData: AddInvoiceItemPriceData?
        /// Quantity for this item
        public var quantity: Int?
        /// Tax rates for this item
        public var taxRates: [String]?

        public init(
            price: Stripe.Products.Price.ID? = nil,
            priceData: AddInvoiceItemPriceData? = nil,
            quantity: Int? = nil,
            taxRates: [String]? = nil
        ) {
            self.price = price
            self.priceData = priceData
            self.quantity = quantity
            self.taxRates = taxRates
        }

        private enum CodingKeys: String, CodingKey {
            case price
            case priceData
            case quantity
            case taxRates
        }
    }

    public struct Item: Codable, Equatable, Sendable {
        /// The price ID
        public var price: Stripe.Products.Price.ID?
        /// Inline price data
        public var priceData: Stripe.Billing.Subscription.Schedule.Create.Request.PriceData?
        /// Quantity for this item
        public var quantity: Int?
        /// Tax rates to apply
        public var taxRates: [String]?
        /// Billing thresholds for this item
        public var billingThresholds: Stripe.Billing.Subscription.Schedule.BillingThresholds?

        public init(
            price: Stripe.Products.Price.ID? = nil,
            priceData: Stripe.Billing.Subscription.Schedule.Create.Request.PriceData? = nil,
            quantity: Int? = nil,
            taxRates: [String]? = nil,
            billingThresholds: Stripe.Billing.Subscription.Schedule.BillingThresholds? = nil
        ) {
            self.price = price
            self.priceData = priceData
            self.quantity = quantity
            self.taxRates = taxRates
            self.billingThresholds = billingThresholds
        }

        private enum CodingKeys: String, CodingKey {
            case price
            case priceData
            case quantity
            case taxRates
            case billingThresholds
        }
    }
}

extension Stripe.Billing.Subscription.Schedule.Create.Request.Phase {
    public struct AddInvoiceItemPriceData: Codable, Equatable, Sendable {
        /// Three-letter ISO currency code
        public var currency: Stripe.Currency
        /// The ID of the product
        public var product: Stripe.Products.Product.ID
        /// Unit amount
        public var unitAmount: Int?
        /// Unit amount as a decimal string
        public var unitAmountDecimal: String?
        /// Tax behavior
        public var taxBehavior: String?

        public init(
            currency: Stripe.Currency,
            product: Stripe.Products.Product.ID,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil,
            taxBehavior: String? = nil
        ) {
            self.currency = currency
            self.product = product
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
            self.taxBehavior = taxBehavior
        }

        private enum CodingKeys: String, CodingKey {
            case currency
            case product
            case unitAmount
            case unitAmountDecimal
            case taxBehavior
        }
    }
}

extension Stripe.Billing.Subscription.Schedule.Create.Request {
    public struct PriceData: Codable, Equatable, Sendable {
        /// Three-letter ISO currency code
        public var currency: Stripe.Currency
        /// The ID of the product
        public var product: Stripe.Products.Product.ID
        /// The recurring components of a price
        public var recurring: Recurring
        /// Unit amount
        public var unitAmount: Int?
        /// Unit amount as a decimal string
        public var unitAmountDecimal: String?

        public init(
            currency: Stripe.Currency,
            product: Stripe.Products.Product.ID,
            recurring: Recurring,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.currency = currency
            self.product = product
            self.recurring = recurring
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
        }

        private enum CodingKeys: String, CodingKey {
            case currency
            case product
            case recurring
            case unitAmount
            case unitAmountDecimal
        }
    }
}

extension Stripe.Billing.Subscription.Schedule.Create.Request {
    public struct Recurring: Codable, Equatable, Sendable {
        /// Billing frequency
        public var interval: String
        /// Number of intervals
        public var intervalCount: Int?

        public init(
            interval: String,
            intervalCount: Int? = nil
        ) {
            self.interval = interval
            self.intervalCount = intervalCount
        }

        private enum CodingKeys: String, CodingKey {
            case interval
            case intervalCount
        }
    }
}
