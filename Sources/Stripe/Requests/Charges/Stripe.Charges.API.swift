//
//  Stripe Charges Types Charges.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Charges {
    // https://docs.stripe.com/api/charges/create.md
    public enum Create {}
    // https://docs.stripe.com/api/charges/update.md
    public enum Update {}
    // https://docs.stripe.com/api/charges/list.md
    public enum List {}
    // https://docs.stripe.com/api/charges/capture.md
    public enum Capture {}
    // https://docs.stripe.com/api/charges/search.md
    public enum Search {}
}

// https://docs.stripe.com/api/charges/create.md
extension Stripe.Charges.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// Amount intended to be collected by this payment (required)
        public let amount: Int
        /// Three-letter ISO currency code, in lowercase (required)
        public let currency: Stripe.Currency
        /// A payment source to be charged (optional)
        public let source: String?
        /// The ID of an existing customer that will be charged (optional)
        public let customer: Stripe.Customers.Customer.ID?
        /// An arbitrary string attached to the object (optional)
        public let description: String?
        /// Set of key-value pairs that you can attach to an object (optional)
        public let metadata: [String: String]?
        /// Whether to immediately capture the charge (optional, defaults to true)
        public let capture: Bool?
        /// The email address to which this charge's receipt will be sent (optional)
        public let receiptEmail: String?
        /// Shipping information for the charge (optional)
        public let shipping: Shipping?
        /// A fee in cents that will be applied to the charge (optional)
        public let applicationFeeAmount: Int?
        /// Text to appear on the customer's credit card statement (optional)
        public let statementDescriptor: String?
        /// Text to provide additional information about the charge (optional)
        public let statementDescriptorSuffix: String?
        /// The parameters used to automatically create a Transfer (optional)
        public let transferData: TransferData?
        /// A string that identifies this transaction as part of a group (optional)
        public let transferGroup: String?
        /// The Stripe account ID for which these funds are intended (optional)
        public let onBehalfOf: String?

        private enum CodingKeys: String, CodingKey {
            case amount
            case currency
            case source
            case customer
            case description
            case metadata
            case capture
            case receiptEmail
            case shipping
            case applicationFeeAmount
            case statementDescriptor
            case statementDescriptorSuffix
            case transferData
            case transferGroup
            case onBehalfOf
        }

        public init(
            amount: Int,
            currency: Stripe.Currency,
            source: String? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            capture: Bool? = nil,
            receiptEmail: String? = nil,
            shipping: Shipping? = nil,
            applicationFeeAmount: Int? = nil,
            statementDescriptor: String? = nil,
            statementDescriptorSuffix: String? = nil,
            transferData: TransferData? = nil,
            transferGroup: String? = nil,
            onBehalfOf: String? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.source = source
            self.customer = customer
            self.description = description
            self.metadata = metadata
            self.capture = capture
            self.receiptEmail = receiptEmail
            self.shipping = shipping
            self.applicationFeeAmount = applicationFeeAmount
            self.statementDescriptor = statementDescriptor
            self.statementDescriptorSuffix = statementDescriptorSuffix
            self.transferData = transferData
            self.transferGroup = transferGroup
            self.onBehalfOf = onBehalfOf
        }

        public struct Shipping: Codable, Equatable, Sendable {
            public let address: Address
            public let carrier: String?
            public let name: String
            public let phone: String?
            public let trackingNumber: String?

            private enum CodingKeys: String, CodingKey {
                case address
                case carrier
                case name
                case phone
                case trackingNumber
            }

            public init(
                address: Address,
                carrier: String? = nil,
                name: String,
                phone: String? = nil,
                trackingNumber: String? = nil
            ) {
                self.address = address
                self.carrier = carrier
                self.name = name
                self.phone = phone
                self.trackingNumber = trackingNumber
            }
        }

        public struct TransferData: Codable, Equatable, Sendable {
            public let amount: Int?
            public let destination: String

            public init(amount: Int? = nil, destination: String) {
                self.amount = amount
                self.destination = destination
            }
        }
    }
}

// https://docs.stripe.com/api/charges/update.md
extension Stripe.Charges.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// The ID of an existing customer that will be associated with this request
        public let customer: Stripe.Customers.Customer.ID?
        /// An arbitrary string attached to the object
        public let description: String?
        /// Set of key-value pairs that you can attach to an object
        public let metadata: [String: String]?
        /// The email address to which this charge's receipt will be sent
        public let receiptEmail: String?
        /// Shipping information for the charge
        public let shipping: Stripe.Charges.Create.Request.Shipping?
        /// This is a legacy field that will be removed in the future
        public let fraudDetails: FraudDetails?
        /// A string that identifies this transaction as part of a group
        public let transferGroup: String?

        private enum CodingKeys: String, CodingKey {
            case customer
            case description
            case metadata
            case receiptEmail
            case shipping
            case fraudDetails
            case transferGroup
        }

        public init(
            customer: Stripe.Customers.Customer.ID? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            receiptEmail: String? = nil,
            shipping: Stripe.Charges.Create.Request.Shipping? = nil,
            fraudDetails: FraudDetails? = nil,
            transferGroup: String? = nil
        ) {
            self.customer = customer
            self.description = description
            self.metadata = metadata
            self.receiptEmail = receiptEmail
            self.shipping = shipping
            self.fraudDetails = fraudDetails
            self.transferGroup = transferGroup
        }

        public struct FraudDetails: Codable, Equatable, Sendable {
            public let userReport: String?

            private enum CodingKeys: String, CodingKey {
                case userReport
            }

            public init(userReport: String? = nil) {
                self.userReport = userReport
            }
        }
    }
}

// https://docs.stripe.com/api/charges/list.md
extension Stripe.Charges.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return charges that were created during the given date interval
        public let created: Stripe.DateFilter?
        /// Only return charges for the customer specified by this customer ID
        public let customer: Stripe.Customers.Customer.ID?
        /// Only return charges that were created by the PaymentIntent specified by this ID
        public let paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID?
        /// Only return charges with the given transfer group
        public let transferGroup: String?
        /// A cursor for use in pagination
        public let endingBefore: String?
        /// A limit on the number of objects to be returned
        public let limit: Int?
        /// A cursor for use in pagination
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case created
            case customer
            case paymentIntent
            case transferGroup
            case endingBefore
            case limit
            case startingAfter
        }

        public init(
            created: Stripe.DateFilter? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
            transferGroup: String? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.customer = customer
            self.paymentIntent = paymentIntent
            self.transferGroup = transferGroup
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Charges.Charge]

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
            data: [Stripe.Charges.Charge]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}

// https://docs.stripe.com/api/charges/capture.md
extension Stripe.Charges.Capture {
    public struct Request: Codable, Equatable, Sendable {
        /// The amount to capture, which must be less than or equal to the original amount
        public let amount: Int?
        /// An application fee to add on to this charge
        public let applicationFeeAmount: Int?
        /// The email address to send this charge's receipt to
        public let receiptEmail: String?
        /// Text to appear on the customer's credit card statement
        public let statementDescriptor: String?
        /// Text to provide additional information about the charge
        public let statementDescriptorSuffix: String?
        /// The parameters used to automatically create a transfer
        public let transferData: TransferData?
        /// A string that identifies this transaction as part of a group
        public let transferGroup: String?

        private enum CodingKeys: String, CodingKey {
            case amount
            case applicationFeeAmount
            case receiptEmail
            case statementDescriptor
            case statementDescriptorSuffix
            case transferData
            case transferGroup
        }

        public init(
            amount: Int? = nil,
            applicationFeeAmount: Int? = nil,
            receiptEmail: String? = nil,
            statementDescriptor: String? = nil,
            statementDescriptorSuffix: String? = nil,
            transferData: TransferData? = nil,
            transferGroup: String? = nil
        ) {
            self.amount = amount
            self.applicationFeeAmount = applicationFeeAmount
            self.receiptEmail = receiptEmail
            self.statementDescriptor = statementDescriptor
            self.statementDescriptorSuffix = statementDescriptorSuffix
            self.transferData = transferData
            self.transferGroup = transferGroup
        }

        public struct TransferData: Codable, Equatable, Sendable {
            public let amount: Int?

            public init(amount: Int? = nil) {
                self.amount = amount
            }
        }
    }
}

// https://docs.stripe.com/api/charges/search.md
extension Stripe.Charges.Search {
    public struct Request: Codable, Equatable, Sendable {
        /// The search query string
        public let query: String
        /// A limit on the number of objects to be returned
        public let limit: Int?
        /// A cursor for pagination across multiple pages of results
        public let page: String?

        public init(
            query: String,
            limit: Int? = nil,
            page: String? = nil
        ) {
            self.query = query
            self.limit = limit
            self.page = page
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Charges.Charge]
        public let nextPage: String?
        public let totalCount: Int?

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
            case nextPage
            case totalCount
        }

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Stripe.Charges.Charge],
            nextPage: String? = nil,
            totalCount: Int? = nil
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
            self.nextPage = nextPage
            self.totalCount = totalCount
        }
    }
}
