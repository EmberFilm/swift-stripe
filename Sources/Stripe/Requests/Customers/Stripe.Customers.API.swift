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

extension Stripe.Customers {
    public enum Create {}
    public enum Update {}
    public enum List {}
    public enum Search {}
}

extension Stripe.Customers.Create {
    public struct Request: Codable, Equatable, Sendable {
        public let address: Address?
        public let description: String?
        public let email: String?
        public let metadata: [String: String]?
        public let name: String?
        public let phone: String?
        public let shipping: ShippingLabel?
        public let balance: Int?
        public let coupon: String?
        public let invoicePrefix: String?
        public let nextInvoiceSequence: Int?
        public let preferredLocales: [String]?
        public let promotionCode: Promotion.Code.ID?
        public let source: String?
        public let taxExempt: Stripe.Customers.CustomerTaxExempt?
        public let taxIdData: [Stripe.Tax.ID]?
        public let testClock: String?

        private enum CodingKeys: String, CodingKey {
            case address
            case description
            case email
            case metadata
            case name
            case phone
            case shipping
            case balance
            case coupon
            case invoicePrefix
            case nextInvoiceSequence
            case preferredLocales
            case promotionCode
            case source
            case taxExempt
            case taxIdData
            case testClock
        }

        public init(
            address: Address? = nil,
            description: String? = nil,
            email: String? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil,
            phone: String? = nil,
            shipping: ShippingLabel? = nil,
            balance: Int? = nil,
            coupon: String? = nil,
            invoicePrefix: String? = nil,
            nextInvoiceSequence: Int? = nil,
            preferredLocales: [String]? = nil,
            promotionCode: Promotion.Code.ID? = nil,
            source: String? = nil,
            taxExempt: Stripe.Customers.CustomerTaxExempt? = nil,
            taxIdData: [Stripe.Tax.ID]? = nil,
            testClock: String? = nil
        ) {
            self.address = address
            self.description = description
            self.email = email
            self.metadata = metadata
            self.name = name
            self.phone = phone
            self.shipping = shipping
            self.balance = balance
            self.coupon = coupon
            self.invoicePrefix = invoicePrefix
            self.nextInvoiceSequence = nextInvoiceSequence
            self.preferredLocales = preferredLocales
            self.promotionCode = promotionCode
            self.source = source
            self.taxExempt = taxExempt
            self.taxIdData = taxIdData
            self.testClock = testClock
        }
    }
}

extension Stripe.Customers.Update {
    public struct Request: Codable, Equatable, Sendable {
        public let address: Address?
        public let description: String?
        public let email: String?
        public let metadata: [String: String]?
        public let name: String?
        public let phone: String?
        public let shipping: ShippingLabel?
        public let balance: Int?
        public let coupon: String?
        public let invoicePrefix: String?
        public let nextInvoiceSequence: Int?
        public let preferredLocales: [String]?
        public let promotionCode: Promotion.Code.ID?
        public let source: String?
        public let taxExempt: Stripe.Customers.CustomerTaxExempt?

        private enum CodingKeys: String, CodingKey {
            case address
            case description
            case email
            case metadata
            case name
            case phone
            case shipping
            case balance
            case coupon
            case invoicePrefix
            case nextInvoiceSequence
            case preferredLocales
            case promotionCode
            case source
            case taxExempt
        }

        public init(
            address: Address? = nil,
            description: String? = nil,
            email: String? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil,
            phone: String? = nil,
            shipping: ShippingLabel? = nil,
            balance: Int? = nil,
            coupon: String? = nil,
            invoicePrefix: String? = nil,
            nextInvoiceSequence: Int? = nil,
            preferredLocales: [String]? = nil,
            promotionCode: Promotion.Code.ID? = nil,
            source: String? = nil,
            taxExempt: Stripe.Customers.CustomerTaxExempt? = nil
        ) {
            self.address = address
            self.description = description
            self.email = email
            self.metadata = metadata
            self.name = name
            self.phone = phone
            self.shipping = shipping
            self.balance = balance
            self.coupon = coupon
            self.invoicePrefix = invoicePrefix
            self.nextInvoiceSequence = nextInvoiceSequence
            self.preferredLocales = preferredLocales
            self.promotionCode = promotionCode
            self.source = source
            self.taxExempt = taxExempt
        }
    }
}

extension Stripe.Customers.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return customers that were created during the given date interval
        public let created: Stripe.DateFilter?
        /// Filter customers by email address
        public let email: String?
        /// A cursor for use in pagination
        public let endingBefore: String?
        /// A limit on the number of objects to be returned (1-100, default 10)
        public let limit: Int?
        /// A cursor for use in pagination
        public let startingAfter: String?
        /// Filter for customers associated with the specified test clock
        public let testClock: String?

        private enum CodingKeys: String, CodingKey {
            case created
            case email
            case endingBefore
            case limit
            case startingAfter
            case testClock
        }

        public init(
            created: Stripe.DateFilter? = nil,
            email: String? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            testClock: String? = nil
        ) {
            self.created = created
            self.email = email
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
            self.testClock = testClock
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Customers.Customer]

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
            data: [Stripe.Customers.Customer]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}

extension Stripe.Customers.Search {
    public struct Request: Codable, Equatable, Sendable {
        public let query: String
        public let limit: Int?
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
        public let data: [Stripe.Customers.Customer]
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
            data: [Stripe.Customers.Customer],
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
