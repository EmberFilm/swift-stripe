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
    // https://docs.stripe.com/api/subscriptionSchedules/update.md
    public enum Update {}
}

extension Stripe.Billing.Subscription.Schedule.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Behavior when the subscription schedule ends
        public var endBehavior: Stripe.Billing.Subscription.Schedule.EndBehavior?
        /// Object containing service periods - replaces all existing phases when provided
        public var phases: [Stripe.Billing.Subscription.Schedule.Update.Request.Phase]?
        /// Default settings for subscription schedule
        public var defaultSettings: Stripe.Billing.Subscription.Schedule.DefaultSettings?
        /// Set of key-value pairs
        public var metadata: [String: String]?
        /// Determines how to handle prorations
        public var prorationBehavior: Stripe.Billing.Subscription.Schedule.ProrationBehavior?

        public init(
            endBehavior: Stripe.Billing.Subscription.Schedule.EndBehavior? = nil,
            phases: [Stripe.Billing.Subscription.Schedule.Update.Request.Phase]? = nil,
            defaultSettings: Stripe.Billing.Subscription.Schedule.DefaultSettings? = nil,
            metadata: [String: String]? = nil,
            prorationBehavior: Stripe.Billing.Subscription.Schedule.ProrationBehavior? = nil
        ) {
            self.endBehavior = endBehavior
            self.phases = phases
            self.defaultSettings = defaultSettings
            self.metadata = metadata
            self.prorationBehavior = prorationBehavior
        }

        private enum CodingKeys: String, CodingKey {
            case endBehavior
            case phases
            case defaultSettings
            case metadata
            case prorationBehavior
        }
    }
}

// MARK: - Update Phase Types

extension Stripe.Billing.Subscription.Schedule.Update.Request {
    /// Phase configuration for updating a subscription schedule
    /// Note: start_date must be set on the first phase per Stripe API requirements
    public struct Phase: Codable, Equatable, Sendable {
        /// List of configuration items (required by Stripe API)
        public var items: [Item]
        /// Additional invoice items to add for this phase
        public var addInvoiceItems: [AddInvoiceItem]?
        /// Percentage of invoice transferred to application owner
        public var applicationFeePercent: Double?
        /// Automatic tax settings
        public var automaticTax: AutomaticTax?
        /// Billing cycle anchor configuration
        public var billingCycleAnchor: Stripe.Billing.Subscription.Schedule.BillingCycleAnchor?
        /// Billing thresholds for the phase
        public var billingThresholds: PhaseBillingThresholds?
        /// Collection method for this phase
        public var collectionMethod: Stripe.Billing.Subscription.Schedule.CollectionMethod?
        /// Three-letter ISO currency code
        public var currency: Stripe.Currency?
        /// Default payment method for this phase
        public var defaultPaymentMethod: Stripe.PaymentMethods.PaymentMethod.ID?
        /// Default tax rates to apply
        public var defaultTaxRates: [String]?
        /// Description of the phase
        public var description: String?
        /// Discounts to apply
        public var discounts: [Stripe.Billing.Subscription.Schedule.Discount]?
        /// Phase duration configuration
        public var duration: Duration?
        /// The end of this phase
        public var endDate: Date?
        /// Invoice settings for this phase
        public var invoiceSettings: Stripe.Billing.Subscription.Schedule.InvoiceSettings?
        /// Number of iterations (deprecated)
        public var iterations: Int?
        /// Subscription data to set on the subscription
        public var metadata: [String: String]?
        /// Account receiving charges
        public var onBehalfOf: String?
        /// Controls whether prorations are created
        public var prorationBehavior: Stripe.Billing.Subscription.Schedule.ProrationBehavior?
        /// Start date for this phase - MUST be set for first phase
        public var startDate: Stripe.Billing.Subscription.Schedule.StartDate?
        /// Automatic transfer configuration
        public var transferData: TransferData?
        /// Whether this phase is a trial
        public var trial: Bool?
        /// Trial end timestamp
        public var trialEnd: Date?

        public init(
            items: [Item],
            addInvoiceItems: [AddInvoiceItem]? = nil,
            applicationFeePercent: Double? = nil,
            automaticTax: AutomaticTax? = nil,
            billingCycleAnchor: Stripe.Billing.Subscription.Schedule.BillingCycleAnchor? = nil,
            billingThresholds: PhaseBillingThresholds? = nil,
            collectionMethod: Stripe.Billing.Subscription.Schedule.CollectionMethod? = nil,
            currency: Stripe.Currency? = nil,
            defaultPaymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            defaultTaxRates: [String]? = nil,
            description: String? = nil,
            discounts: [Stripe.Billing.Subscription.Schedule.Discount]? = nil,
            duration: Duration? = nil,
            endDate: Date? = nil,
            invoiceSettings: Stripe.Billing.Subscription.Schedule.InvoiceSettings? = nil,
            iterations: Int? = nil,
            metadata: [String: String]? = nil,
            onBehalfOf: String? = nil,
            prorationBehavior: Stripe.Billing.Subscription.Schedule.ProrationBehavior? = nil,
            startDate: Stripe.Billing.Subscription.Schedule.StartDate? = nil,
            transferData: TransferData? = nil,
            trial: Bool? = nil,
            trialEnd: Date? = nil
        ) {
            self.items = items
            self.addInvoiceItems = addInvoiceItems
            self.applicationFeePercent = applicationFeePercent
            self.automaticTax = automaticTax
            self.billingCycleAnchor = billingCycleAnchor
            self.billingThresholds = billingThresholds
            self.collectionMethod = collectionMethod
            self.currency = currency
            self.defaultPaymentMethod = defaultPaymentMethod
            self.defaultTaxRates = defaultTaxRates
            self.description = description
            self.discounts = discounts
            self.duration = duration
            self.endDate = endDate
            self.invoiceSettings = invoiceSettings
            self.iterations = iterations
            self.metadata = metadata
            self.onBehalfOf = onBehalfOf
            self.prorationBehavior = prorationBehavior
            self.startDate = startDate
            self.transferData = transferData
            self.trial = trial
            self.trialEnd = trialEnd
        }

        private enum CodingKeys: String, CodingKey {
            case items
            case addInvoiceItems
            case applicationFeePercent
            case automaticTax
            case billingCycleAnchor
            case billingThresholds
            case collectionMethod
            case currency
            case defaultPaymentMethod
            case defaultTaxRates
            case description
            case discounts
            case duration
            case endDate
            case invoiceSettings
            case iterations
            case metadata
            case onBehalfOf
            case prorationBehavior
            case startDate
            case transferData
            case trial
            case trialEnd
        }
    }
}

extension Stripe.Billing.Subscription.Schedule.Update.Request.Phase {
    /// Automatic tax configuration for a phase
    public struct AutomaticTax: Codable, Equatable, Sendable {
        /// Whether automatic tax is enabled
        public var enabled: Bool
        /// Liability configuration
        public var liability: Liability?

        public init(enabled: Bool, liability: Liability? = nil) {
            self.enabled = enabled
            self.liability = liability
        }

        public struct Liability: Codable, Equatable, Sendable {
            /// The account that's liable for tax
            public var account: String?
            /// Type of liability
            public var type: String

            public init(account: String? = nil, type: String) {
                self.account = account
                self.type = type
            }
        }
    }

    /// Duration configuration for a phase
    public struct Duration: Codable, Equatable, Sendable {
        /// The unit of time the phase lasts
        public var interval: Interval
        /// Number of intervals
        public var intervalCount: Int

        public enum Interval: String, Codable, Equatable, Sendable {
            case day
            case week
            case month
            case year
        }

        public init(interval: Interval, intervalCount: Int) {
            self.interval = interval
            self.intervalCount = intervalCount
        }

        private enum CodingKeys: String, CodingKey {
            case interval
            case intervalCount
        }
    }

    /// Transfer data configuration for a phase
    public struct TransferData: Codable, Equatable, Sendable {
        /// The account receiving the transfer
        public var destination: String
        /// Percentage of the invoice amount to transfer
        public var amountPercent: Double?

        public init(destination: String, amountPercent: Double? = nil) {
            self.destination = destination
            self.amountPercent = amountPercent
        }

        private enum CodingKeys: String, CodingKey {
            case destination
            case amountPercent
        }
    }

    /// Billing thresholds configuration for a phase
    public struct PhaseBillingThresholds: Codable, Equatable, Sendable {
        /// Amount threshold to advance to next billing period
        public var amountGte: Int?
        /// Whether to reset the billing cycle anchor
        public var resetBillingCycleAnchor: Bool?

        public init(amountGte: Int? = nil, resetBillingCycleAnchor: Bool? = nil) {
            self.amountGte = amountGte
            self.resetBillingCycleAnchor = resetBillingCycleAnchor
        }

        private enum CodingKeys: String, CodingKey {
            case amountGte
            case resetBillingCycleAnchor
        }
    }
}

extension Stripe.Billing.Subscription.Schedule.Update.Request.Phase {
    /// Additional invoice item to add for this phase
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

    /// Price data for additional invoice items
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

    /// Item configuration for phase update
    public struct Item: Codable, Equatable, Sendable {
        /// The price ID
        public var price: Stripe.Products.Price.ID?
        /// Inline price data
        public var priceData: PriceData?
        /// Quantity for this item
        public var quantity: Int?
        /// Tax rates to apply
        public var taxRates: [String]?
        /// Billing thresholds for this item
        public var billingThresholds: Stripe.Billing.Subscription.Schedule.BillingThresholds?

        public init(
            price: Stripe.Products.Price.ID? = nil,
            priceData: PriceData? = nil,
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

extension Stripe.Billing.Subscription.Schedule.Update.Request.Phase.Item {
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
        /// Tax behavior for the price
        public var taxBehavior: String?

        public init(
            currency: Stripe.Currency,
            product: Stripe.Products.Product.ID,
            recurring: Recurring,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil,
            taxBehavior: String? = nil
        ) {
            self.currency = currency
            self.product = product
            self.recurring = recurring
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
            self.taxBehavior = taxBehavior
        }

        private enum CodingKeys: String, CodingKey {
            case currency
            case product
            case recurring
            case unitAmount
            case unitAmountDecimal
            case taxBehavior
        }
    }

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
