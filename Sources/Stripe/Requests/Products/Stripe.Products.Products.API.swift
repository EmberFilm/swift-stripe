//
//  Products.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Products.Products {
    public enum Create {}
    public enum Update {}
    public enum List {}
    public enum Search {}
    public enum DefaultPrice {}
}

extension Stripe.Products.Products.DefaultPrice {
    /// Data used to generate a new Price object inline when creating a product
    public struct Data: Codable, Equatable, Sendable {
        /// Three-letter ISO currency code, in lowercase
        public let currency: Stripe.Currency
        /// A positive integer in cents (or 0 for a free price) representing how much to charge
        public let unitAmount: Int?
        /// Same as unit_amount, but accepts a decimal value in cents with at most 12 decimal places
        public let unitAmountDecimal: String?
        /// The recurring components of a price such as interval and interval_count
        public let recurring: Recurring?
        /// Specifies whether the price is considered inclusive of taxes or exclusive of taxes
        public let taxBehavior: TaxBehavior?

        private enum CodingKeys: String, CodingKey {
            case currency
            case unitAmount
            case unitAmountDecimal
            case recurring
            case taxBehavior
        }

        public init(
            currency: Stripe.Currency,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil,
            recurring: Recurring? = nil,
            taxBehavior: TaxBehavior? = nil
        ) {
            self.currency = currency
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
            self.recurring = recurring
            self.taxBehavior = taxBehavior
        }

        public struct Recurring: Codable, Equatable, Sendable {
            /// Specifies billing frequency
            public let interval: Stripe.Interval
            /// The number of intervals between subscription billings
            public let intervalCount: Int?

            private enum CodingKeys: String, CodingKey {
                case interval
                case intervalCount
            }

            public init(interval: Stripe.Interval, intervalCount: Int? = nil) {
                self.interval = interval
                self.intervalCount = intervalCount
            }

            // Using shared Stripe.Interval type
            public typealias Interval = Stripe.Interval
        }

        public enum TaxBehavior: String, Codable, Equatable, Sendable {
            case exclusive
            case inclusive
            case unspecified
        }
    }
}

extension Stripe.Products.Products.Create {
    public struct Request: Codable, Equatable, Sendable {
        public let name: String
        public let active: Bool?
        public let description: String?
        public let id: String?
        public let metadata: [String: String]?
        public let defaultPriceData: Stripe.Products.Products.DefaultPrice.Data?
        public let images: [String]?
        public let marketingFeatures: [Marketing.Feature]?
        public let packageDimensions: Stripe.Products.Product.Package.Dimensions?
        public let shippable: Bool?
        public let statementDescriptor: Stripe.StatementDescriptor?
        public let taxCode: String?
        public let unitLabel: String?
        public let url: String?

        private enum CodingKeys: String, CodingKey {
            case name
            case active
            case description
            case id
            case metadata
            case defaultPriceData
            case images
            case marketingFeatures
            case packageDimensions
            case shippable
            case statementDescriptor
            case taxCode
            case unitLabel
            case url
        }

        public init(
            name: String,
            active: Bool? = nil,
            description: String? = nil,
            id: String? = nil,
            metadata: [String: String]? = nil,
            defaultPriceData: Stripe.Products.Products.DefaultPrice.Data? = nil,
            images: [String]? = nil,
            marketingFeatures: [Marketing.Feature]? = nil,
            packageDimensions: Stripe.Products.Product.Package.Dimensions? = nil,
            shippable: Bool? = nil,
            statementDescriptor: Stripe.StatementDescriptor? = nil,
            taxCode: String? = nil,
            unitLabel: String? = nil,
            url: String? = nil
        ) {
            self.name = name
            self.active = active
            self.description = description
            self.id = id
            self.metadata = metadata
            self.defaultPriceData = defaultPriceData
            self.images = images
            self.marketingFeatures = marketingFeatures
            self.packageDimensions = packageDimensions
            self.shippable = shippable
            self.statementDescriptor = statementDescriptor
            self.taxCode = taxCode
            self.unitLabel = unitLabel
            self.url = url
        }
    }
}

extension Stripe.Products.Products.Update {
    public struct Request: Codable, Equatable, Sendable {
        public let active: Bool?
        public let description: String?
        public let metadata: [String: String]?
        public let name: String?
        public let defaultPrice: Stripe.Products.Price.ID?
        public let images: [String]?
        public let marketingFeatures: [Marketing.Feature]?
        public let packageDimensions: Stripe.Products.Product.Package.Dimensions?
        public let shippable: Bool?
        public let statementDescriptor: Stripe.StatementDescriptor?
        public let taxCode: String?
        public let unitLabel: String?
        public let url: String?

        private enum CodingKeys: String, CodingKey {
            case active
            case description
            case metadata
            case name
            case defaultPrice
            case images
            case marketingFeatures
            case packageDimensions
            case shippable
            case statementDescriptor
            case taxCode
            case unitLabel
            case url
        }

        public init(
            active: Bool? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil,
            defaultPrice: Stripe.Products.Price.ID? = nil,
            images: [String]? = nil,
            marketingFeatures: [Marketing.Feature]? = nil,
            packageDimensions: Stripe.Products.Product.Package.Dimensions? = nil,
            shippable: Bool? = nil,
            statementDescriptor: Stripe.StatementDescriptor? = nil,
            taxCode: String? = nil,
            unitLabel: String? = nil,
            url: String? = nil
        ) {
            self.active = active
            self.description = description
            self.metadata = metadata
            self.name = name
            self.defaultPrice = defaultPrice
            self.images = images
            self.marketingFeatures = marketingFeatures
            self.packageDimensions = packageDimensions
            self.shippable = shippable
            self.statementDescriptor = statementDescriptor
            self.taxCode = taxCode
            self.unitLabel = unitLabel
            self.url = url
        }
    }
}

extension Stripe.Products.Products.List {
    public struct Request: Codable, Equatable, Sendable {
        public let active: Bool?
        public let created: Stripe.DateFilter?
        public let endingBefore: String?
        public let ids: [String]?
        public let limit: Int?
        public let shippable: Bool?
        public let startingAfter: String?
        public let type: String?
        public let url: String?

        private enum CodingKeys: String, CodingKey {
            case active
            case created
            case endingBefore
            case ids
            case limit
            case shippable
            case startingAfter
            case type
            case url
        }

        public init(
            active: Bool? = nil,
            created: Stripe.DateFilter? = nil,
            endingBefore: String? = nil,
            ids: [String]? = nil,
            limit: Int? = nil,
            shippable: Bool? = nil,
            startingAfter: String? = nil,
            type: String? = nil,
            url: String? = nil
        ) {
            self.active = active
            self.created = created
            self.endingBefore = endingBefore
            self.ids = ids
            self.limit = limit
            self.shippable = shippable
            self.startingAfter = startingAfter
            self.type = type
            self.url = url
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Products.Product]

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
            data: [Stripe.Products.Product]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}

extension Stripe.Products.Products.Search {
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
        public let data: [Stripe.Products.Product]
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
            data: [Stripe.Products.Product],
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
