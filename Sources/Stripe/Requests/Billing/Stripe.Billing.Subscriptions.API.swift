//
//  File.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Subscriptions {
    public enum Create {}
    public enum Update {}
    public enum List {}
    public enum Cancel {}
}

extension Stripe.Billing.Subscriptions.Create {
    // https://docs.stripe.com/api/subscriptions/create.md
    public struct Request: Codable, Equatable, Sendable {
        public let customer: Stripe.Customers.Customer.ID
        public let items: [Item]
        public let automaticTax: Stripe.Billing.Subscription.AutomaticTax?
        public let cancelAtPeriodEnd: Bool?
        public let currency: Stripe.Currency?
        public let defaultPaymentMethod: Stripe.PaymentMethods.PaymentMethod.ID?
        public let description: String?
        public let metadata: [String: String]?
        public let paymentBehavior: Stripe.Billing.Subscription.PaymentBehavior?

        private enum CodingKeys: String, CodingKey {
            case customer
            case items
            case automaticTax
            case cancelAtPeriodEnd
            case currency
            case defaultPaymentMethod
            case description
            case metadata
            case paymentBehavior
        }

        public init(
            customer: Stripe.Customers.Customer.ID,
            items: [Item],
            automaticTax: Stripe.Billing.Subscription.AutomaticTax? = nil,
            cancelAtPeriodEnd: Bool? = nil,
            currency: Stripe.Currency? = nil,
            defaultPaymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            paymentBehavior: Stripe.Billing.Subscription.PaymentBehavior? = nil
        ) {
            self.customer = customer
            self.items = items
            self.automaticTax = automaticTax
            self.cancelAtPeriodEnd = cancelAtPeriodEnd
            self.currency = currency
            self.defaultPaymentMethod = defaultPaymentMethod
            self.description = description
            self.metadata = metadata
            self.paymentBehavior = paymentBehavior
        }
    }

    public struct Item: Codable, Equatable, Sendable {
        public let price: Stripe.Products.Price.ID
        public let quantity: Int?

        public init(
            price: Stripe.Products.Price.ID,
            quantity: Int? = nil
        ) {
            self.price = price
            self.quantity = quantity
        }
    }
}

extension Stripe.Billing.Subscriptions.Update {
    // https://docs.stripe.com/api/subscriptions/update.md
    public struct Request: Codable, Equatable, Sendable {
        public let cancelAtPeriodEnd: Bool?
        public let description: String?
        public let items: [Item]?
        public let metadata: [String: String]?
        public let paymentBehavior: Stripe.Billing.Subscription.PaymentBehavior?
        public let prorationBehavior: Stripe.Billing.Subscription.ProrationBehavior?

        private enum CodingKeys: String, CodingKey {
            case cancelAtPeriodEnd
            case description
            case items
            case metadata
            case paymentBehavior
            case prorationBehavior
        }

        public init(
            cancelAtPeriodEnd: Bool? = nil,
            description: String? = nil,
            items: [Item]? = nil,
            metadata: [String: String]? = nil,
            paymentBehavior: Stripe.Billing.Subscription.PaymentBehavior? = nil,
            prorationBehavior: Stripe.Billing.Subscription.ProrationBehavior? = nil
        ) {
            self.cancelAtPeriodEnd = cancelAtPeriodEnd
            self.description = description
            self.items = items
            self.metadata = metadata
            self.paymentBehavior = paymentBehavior
            self.prorationBehavior = prorationBehavior
        }
    }

    public struct Item: Codable, Equatable, Sendable {
        public let id: Stripe.Billing.Subscription.Item.ID?
        public let price: Stripe.Products.Price.ID?
        public let quantity: Int?
        public let deleted: Bool?

        public init(
            id: Stripe.Billing.Subscription.Item.ID? = nil,
            price: Stripe.Products.Price.ID? = nil,
            quantity: Int? = nil,
            deleted: Bool? = nil
        ) {
            self.id = id
            self.price = price
            self.quantity = quantity
            self.deleted = deleted
        }
    }
}

extension Stripe.Billing.Subscriptions.List {
    // https://docs.stripe.com/api/subscriptions/list.md
    public struct Request: Codable, Equatable, Sendable {
        /// Filter subscriptions by their automatic tax settings
        public let automaticTax: Stripe.DateFilter?
        /// The collection method of the subscriptions to retrieve
        public let collectionMethod: Stripe.Billing.Subscription.Collection.Method?
        /// Only return subscriptions that were created during the given date interval
        public let created: Stripe.DateFilter?
        /// Only return subscriptions whose current_period_end falls within the given date interval
        public let currentPeriodEnd: Stripe.DateFilter?
        /// Only return subscriptions whose current_period_start falls within the given date interval
        public let currentPeriodStart: Stripe.DateFilter?
        /// The ID of the customer whose subscriptions will be retrieved
        public let customer: Stripe.Customers.Customer.ID?
        /// A cursor for use in pagination
        public let endingBefore: String?
        /// A limit on the number of objects to be returned (1-100, default 10)
        public let limit: Int?
        /// Filter for subscriptions that contain this recurring price ID
        public let price: Stripe.Products.Price.ID?
        /// A cursor for use in pagination
        public let startingAfter: String?
        /// The status of the subscriptions to retrieve
        public let status: Stripe.Billing.Subscription.Status?
        /// Filter for subscriptions associated with the specified test clock
        public let testClock: String?

        private enum CodingKeys: String, CodingKey {
            case automaticTax
            case collectionMethod
            case created
            case currentPeriodEnd
            case currentPeriodStart
            case customer
            case endingBefore
            case limit
            case price
            case startingAfter
            case status
            case testClock
        }

        public init(
            automaticTax: Stripe.DateFilter? = nil,
            collectionMethod: Stripe.Billing.Subscription.Collection.Method? = nil,
            created: Stripe.DateFilter? = nil,
            currentPeriodEnd: Stripe.DateFilter? = nil,
            currentPeriodStart: Stripe.DateFilter? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            price: Stripe.Products.Price.ID? = nil,
            startingAfter: String? = nil,
            status: Stripe.Billing.Subscription.Status? = nil,
            testClock: String? = nil
        ) {
            self.automaticTax = automaticTax
            self.collectionMethod = collectionMethod
            self.created = created
            self.currentPeriodEnd = currentPeriodEnd
            self.currentPeriodStart = currentPeriodStart
            self.customer = customer
            self.endingBefore = endingBefore
            self.limit = limit
            self.price = price
            self.startingAfter = startingAfter
            self.status = status
            self.testClock = testClock
        }

        /// Filter subscriptions by their automatic tax settings
        public struct AutomaticTaxFilter: Codable, Equatable, Sendable {
            /// Enabled automatic tax calculation
            public let enabled: Bool

            public init(enabled: Bool) {
                self.enabled = enabled
            }
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.Subscription]

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
            data: [Stripe.Billing.Subscription]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}

extension Stripe.Billing.Subscriptions.Cancel {
    // https://docs.stripe.com/api/subscriptions/cancel.md
    public struct Request: Codable, Equatable, Sendable {
        public let invoiceNow: Bool?
        public let prorate: Bool?

        private enum CodingKeys: String, CodingKey {
            case invoiceNow
            case prorate
        }

        public init(
            invoiceNow: Bool? = nil,
            prorate: Bool? = nil
        ) {
            self.invoiceNow = invoiceNow
            self.prorate = prorate
        }
    }
}
