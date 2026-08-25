//
//  Stripe Billing Subscription Items Types Billing Subscription Items.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.SubscriptionItems {
    // https://docs.stripe.com/api/subscriptionItems/create.md
    public enum Create {}
}

extension Stripe.Billing.SubscriptionItems.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The identifier of the subscription to add items to
        public var subscription: Stripe.Billing.Subscription.ID
        /// The ID of the price object
        public var price: Stripe.Products.Price.ID?
        /// Data used to generate a new price object inline
        public var priceData: PriceData?
        /// Quantity for this item
        public var quantity: Int?
        /// A list of Tax Rate IDs to apply to this subscription item
        public var taxRates: [String]?
        /// Set of key-value pairs that you can attach to an object
        public var metadata: [String: String]?
        /// The billing thresholds of the item
        public var billingThresholds: BillingThresholds?

        public init(
            subscription: Stripe.Billing.Subscription.ID,
            price: Stripe.Products.Price.ID? = nil,
            priceData: PriceData? = nil,
            quantity: Int? = nil,
            taxRates: [String]? = nil,
            metadata: [String: String]? = nil,
            billingThresholds: BillingThresholds? = nil
        ) {
            self.subscription = subscription
            self.price = price
            self.priceData = priceData
            self.quantity = quantity
            self.taxRates = taxRates
            self.metadata = metadata
            self.billingThresholds = billingThresholds
        }

        private enum CodingKeys: String, CodingKey {
            case subscription
            case price
            case priceData
            case quantity
            case taxRates
            case metadata
            case billingThresholds
        }
    }

    public struct PriceData: Codable, Equatable, Sendable {
        /// Three-letter ISO currency code
        public var currency: Stripe.Currency
        /// The ID of the product that this price will belong to
        public var product: Stripe.Products.Product.ID
        /// The recurring components of a price
        public var recurring: Recurring
        /// A positive integer in cents representing how much to charge
        public var unitAmount: Int?
        /// Same as unit_amount, but accepts a decimal value with at most 12 decimal places
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

    public struct Recurring: Codable, Equatable, Sendable {
        /// Billing frequency
        public var interval: String
        /// The number of intervals between subscription billings
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

    public struct BillingThresholds: Codable, Equatable, Sendable {
        /// Usage threshold that triggers the subscription to advance to a new billing period
        public var usageGte: Int?

        public init(usageGte: Int? = nil) {
            self.usageGte = usageGte
        }

        private enum CodingKeys: String, CodingKey {
            case usageGte
        }
    }
}

extension Stripe.Billing.SubscriptionItems {
    // https://docs.stripe.com/api/subscriptionItems/update.md
    public enum Update {}
}

extension Stripe.Billing.SubscriptionItems.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// The ID of the price object
        public var price: Stripe.Products.Price.ID?
        /// Data used to generate a new price object inline
        public var priceData: Stripe.Billing.SubscriptionItems.Create.PriceData?
        /// Quantity for this item
        public var quantity: Int?
        /// A list of Tax Rate IDs to apply to this subscription item
        public var taxRates: [String]?
        /// Set of key-value pairs that you can attach to an object
        public var metadata: [String: String]?
        /// The billing thresholds of the item
        public var billingThresholds: Stripe.Billing.SubscriptionItems.Create.BillingThresholds?
        /// Delete all keys from the existing metadata
        public var clearMetadata: Bool?

        public init(
            price: Stripe.Products.Price.ID? = nil,
            priceData: Stripe.Billing.SubscriptionItems.Create.PriceData? = nil,
            quantity: Int? = nil,
            taxRates: [String]? = nil,
            metadata: [String: String]? = nil,
            billingThresholds: Stripe.Billing.SubscriptionItems.Create.BillingThresholds? = nil,
            clearMetadata: Bool? = nil
        ) {
            self.price = price
            self.priceData = priceData
            self.quantity = quantity
            self.taxRates = taxRates
            self.metadata = metadata
            self.billingThresholds = billingThresholds
            self.clearMetadata = clearMetadata
        }

        private enum CodingKeys: String, CodingKey {
            case price
            case priceData
            case quantity
            case taxRates
            case metadata
            case billingThresholds
            case clearMetadata
        }
    }
}

extension Stripe.Billing.SubscriptionItems {
    // https://docs.stripe.com/api/subscriptionItems/list.md
    public enum List {}
}

extension Stripe.Billing.SubscriptionItems.List {
    public struct Request: Codable, Equatable, Sendable {
        /// The ID of the subscription whose items will be retrieved
        public var subscription: Stripe.Billing.Subscription.ID
        /// A cursor for use in pagination
        public var endingBefore: String?
        /// A limit on the number of objects to be returned
        public var limit: Int?
        /// A cursor for use in pagination
        public var startingAfter: String?

        public init(
            subscription: Stripe.Billing.Subscription.ID,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.subscription = subscription
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }

        private enum CodingKeys: String, CodingKey {
            case subscription
            case endingBefore
            case limit
            case startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.Subscription.Item]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}
