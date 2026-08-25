//
//  Stripe Billing Invoices Types Billing Invoices.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Invoices {
    // https://docs.stripe.com/api/invoices/create.md
    public enum Create {}

    // https://docs.stripe.com/api/invoices/create_preview.md
    public enum CreatePreview {}

    // https://docs.stripe.com/api/invoices/update.md
    public enum Update {}

    // https://docs.stripe.com/api/invoices/list.md
    public enum List {}

    // https://docs.stripe.com/api/invoices/finalize_invoice.md
    public enum Finalize {}

    // https://docs.stripe.com/api/invoices/pay.md
    public enum Pay {}

    // https://docs.stripe.com/api/invoices/send.md
    public enum Send {}

    // https://docs.stripe.com/api/invoices/void.md
    public enum Void {}
}

// MARK: - Create
extension Stripe.Billing.Invoices.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The ID of the customer to invoice
        public let customer: Stripe.Customers.Customer.ID?
        /// Controls whether Stripe performs automatic collection of the invoice
        public let autoAdvance: Bool?
        /// Collection method: charge_automatically or send_invoice
        public let collectionMethod: Stripe.Billing.Invoice.CollectionMethod?
        /// Three-letter ISO currency code
        public let currency: Stripe.Currency?
        /// An arbitrary string attached to the object
        public let description: String?
        /// Invoice payment due date (timestamp)
        public let dueDate: Date?
        /// Set of key-value pairs for metadata
        public let metadata: [String: String]?
        /// The ID of the subscription to invoice
        public let subscription: Stripe.Billing.Subscription.ID?

        private enum CodingKeys: String, CodingKey {
            case customer
            case autoAdvance
            case collectionMethod
            case currency
            case description
            case dueDate
            case metadata
            case subscription
        }

        public init(
            customer: Stripe.Customers.Customer.ID? = nil,
            autoAdvance: Bool? = nil,
            collectionMethod: Stripe.Billing.Invoice.CollectionMethod? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            dueDate: Date? = nil,
            metadata: [String: String]? = nil,
            subscription: Stripe.Billing.Subscription.ID? = nil
        ) {
            self.customer = customer
            self.autoAdvance = autoAdvance
            self.collectionMethod = collectionMethod
            self.currency = currency
            self.description = description
            self.dueDate = dueDate
            self.metadata = metadata
            self.subscription = subscription
        }
    }
}

// MARK: - CreatePreview
extension Stripe.Billing.Invoices.CreatePreview {
    public struct Request: Codable, Equatable, Sendable {
        /// The ID of the customer to preview invoice for
        public let customer: Stripe.Customers.Customer.ID?
        /// Collection method: charge_automatically or send_invoice
        public let collectionMethod: Stripe.Billing.Invoice.CollectionMethod?
        /// Three-letter ISO currency code
        public let currency: Stripe.Currency?
        /// An arbitrary string attached to the object
        public let description: String?
        /// The ID of the subscription to preview
        public let subscription: Stripe.Billing.Subscription.ID?
        /// Details about the subscription for the preview
        public let subscriptionDetails: SubscriptionDetails?

        private enum CodingKeys: String, CodingKey {
            case customer
            case collectionMethod
            case currency
            case description
            case subscription
            case subscriptionDetails
        }

        public init(
            customer: Stripe.Customers.Customer.ID? = nil,
            collectionMethod: Stripe.Billing.Invoice.CollectionMethod? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            subscription: Stripe.Billing.Subscription.ID? = nil,
            subscriptionDetails: SubscriptionDetails? = nil
        ) {
            self.customer = customer
            self.collectionMethod = collectionMethod
            self.currency = currency
            self.description = description
            self.subscription = subscription
            self.subscriptionDetails = subscriptionDetails
        }

        public struct SubscriptionDetails: Codable, Equatable, Sendable {
            /// Items to include in the subscription preview
            public let items: [Item]?
            /// Behavior for creating prorations
            public let prorationBehavior: Stripe.Billing.Subscription.ProrationBehavior?
            /// Timestamp for proration calculation
            public let prorationDate: Date?

            private enum CodingKeys: String, CodingKey {
                case items
                case prorationBehavior
                case prorationDate
            }

            public init(
                items: [Item]? = nil,
                prorationBehavior: Stripe.Billing.Subscription.ProrationBehavior? = nil,
                prorationDate: Date? = nil
            ) {
                self.items = items
                self.prorationBehavior = prorationBehavior
                self.prorationDate = prorationDate
            }

            /// Item for subscription preview - similar to Update.Item but for preview
            public struct Item: Codable, Equatable, Sendable {
                /// ID of an existing subscription item to update
                public let id: String?
                /// Price for this item
                public let price: Stripe.Products.Price.ID?
                /// Quantity for this item
                public let quantity: Int?
                /// Whether this item should be deleted
                public let deleted: Bool?
                /// Metadata for this item
                public let metadata: [String: String]?
                /// Tax rates to apply to this item
                public let taxRates: [String]?

                private enum CodingKeys: String, CodingKey {
                    case id
                    case price
                    case quantity
                    case deleted
                    case metadata
                    case taxRates
                }

                public init(
                    id: String? = nil,
                    price: Stripe.Products.Price.ID? = nil,
                    quantity: Int? = nil,
                    deleted: Bool? = nil,
                    metadata: [String: String]? = nil,
                    taxRates: [String]? = nil
                ) {
                    self.id = id
                    self.price = price
                    self.quantity = quantity
                    self.deleted = deleted
                    self.metadata = metadata
                    self.taxRates = taxRates
                }
            }
        }
    }
}

// MARK: - Update
extension Stripe.Billing.Invoices.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Controls whether Stripe performs automatic collection of the invoice
        public let autoAdvance: Bool?
        /// Collection method: charge_automatically or send_invoice
        public let collectionMethod: Stripe.Billing.Invoice.CollectionMethod?
        /// An arbitrary string attached to the object
        public let description: String?
        /// Invoice payment due date (timestamp)
        public let dueDate: Date?
        /// Set of key-value pairs for metadata
        public let metadata: [String: String]?

        private enum CodingKeys: String, CodingKey {
            case autoAdvance
            case collectionMethod
            case description
            case dueDate
            case metadata
        }

        public init(
            autoAdvance: Bool? = nil,
            collectionMethod: Stripe.Billing.Invoice.CollectionMethod? = nil,
            description: String? = nil,
            dueDate: Date? = nil,
            metadata: [String: String]? = nil
        ) {
            self.autoAdvance = autoAdvance
            self.collectionMethod = collectionMethod
            self.description = description
            self.dueDate = dueDate
            self.metadata = metadata
        }
    }
}

// MARK: - List
extension Stripe.Billing.Invoices.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Collection method filter
        public let collectionMethod: Stripe.Billing.Invoice.CollectionMethod?
        /// Filter for invoices created in date range
        public let created: Stripe.DateFilter?
        /// Filter by customer ID
        public let customer: Stripe.Customers.Customer.ID?
        /// Filter for invoices due in date range
        public let dueDate: Stripe.DateFilter?
        /// A cursor for pagination
        public let endingBefore: String?
        /// Limit on the number of objects to return
        public let limit: Int?
        /// A cursor for pagination
        public let startingAfter: String?
        /// Filter by invoice status
        public let status: Stripe.Billing.Invoice.Status?
        /// Filter by subscription ID
        public let subscription: Stripe.Billing.Subscription.ID?

        private enum CodingKeys: String, CodingKey {
            case collectionMethod
            case created
            case customer
            case dueDate
            case endingBefore
            case limit
            case startingAfter
            case status
            case subscription
        }

        public init(
            collectionMethod: Stripe.Billing.Invoice.CollectionMethod? = nil,
            created: Stripe.DateFilter? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            dueDate: Stripe.DateFilter? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            status: Stripe.Billing.Invoice.Status? = nil,
            subscription: Stripe.Billing.Subscription.ID? = nil
        ) {
            self.collectionMethod = collectionMethod
            self.created = created
            self.customer = customer
            self.dueDate = dueDate
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
            self.status = status
            self.subscription = subscription
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.Invoice]

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
            data: [Stripe.Billing.Invoice]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}

// MARK: - Finalize
extension Stripe.Billing.Invoices.Finalize {
    public struct Request: Codable, Equatable, Sendable {
        /// Controls whether Stripe performs automatic collection of the invoice
        public let autoAdvance: Bool?

        private enum CodingKeys: String, CodingKey {
            case autoAdvance
        }

        public init(autoAdvance: Bool? = nil) {
            self.autoAdvance = autoAdvance
        }
    }
}

// MARK: - Pay
extension Stripe.Billing.Invoices.Pay {
    public struct Request: Codable, Equatable, Sendable {
        /// ID of the payment method to use for payment
        public let paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID?
        /// ID of the payment source to use for payment
        public let source: String?

        private enum CodingKeys: String, CodingKey {
            case paymentMethod
            case source
        }

        public init(
            paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            source: String? = nil
        ) {
            self.paymentMethod = paymentMethod
            self.source = source
        }
    }
}

// MARK: - Send
extension Stripe.Billing.Invoices.Send {
    public struct Request: Codable, Equatable, Sendable {
        // Send endpoint typically has no required parameters
        public init() {}
    }
}

// MARK: - Void
extension Stripe.Billing.Invoices.Void {
    public struct Request: Codable, Equatable, Sendable {
        // Void endpoint typically has no required parameters
        public init() {}
    }
}
