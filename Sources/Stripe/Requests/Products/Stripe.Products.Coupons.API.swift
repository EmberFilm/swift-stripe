//
//  File.swift
//  swift-stripe
//
//  Created by Coen ten Thije Boonkkamp on 07/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// Main request/response types
extension Stripe.Products.Coupons {
    public enum Create {}
    public enum Update {}
    public enum List {}
}

extension Stripe.Products.Coupons.Create {
    public struct Request: Codable, Equatable, Sendable {
        public let amountOff: Int?
        public let currency: Stripe.Currency?
        public let duration: Stripe.Products.Coupon.Duration
        public let durationInMonths: Int?
        public let metadata: [String: String]?
        public let name: String?
        public let percentOff: Double?
        public let appliesTo: Stripe.Products.Coupon.AppliesTo?
        public let currencyOptions: [Stripe.Currency: Stripe.Products.Coupon.Currency.Options]?
        public let id: String?
        public let maxRedemptions: Int?
        public let redeemBy: Date?

        private enum CodingKeys: String, CodingKey {
            case amountOff
            case currency
            case duration
            case durationInMonths
            case metadata
            case name
            case percentOff
            case appliesTo
            case currencyOptions
            case id
            case maxRedemptions
            case redeemBy
        }

        public init(
            amountOff: Int? = nil,
            currency: Stripe.Currency? = nil,
            duration: Stripe.Products.Coupon.Duration,
            durationInMonths: Int? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil,
            percentOff: Double? = nil,
            appliesTo: Stripe.Products.Coupon.AppliesTo? = nil,
            currencyOptions: [Stripe.Currency: Stripe.Products.Coupon.Currency.Options]? = nil,
            id: String? = nil,
            maxRedemptions: Int? = nil,
            redeemBy: Date? = nil
        ) {
            self.amountOff = amountOff
            self.currency = currency
            self.duration = duration
            self.durationInMonths = durationInMonths
            self.metadata = metadata
            self.name = name
            self.percentOff = percentOff
            self.appliesTo = appliesTo
            self.currencyOptions = currencyOptions
            self.id = id
            self.maxRedemptions = maxRedemptions
            self.redeemBy = redeemBy
        }
    }
}

extension Stripe.Products.Coupons.Update {
    public struct Request: Codable, Equatable, Sendable {
        public let metadata: [String: String]?
        public let name: String?
        public let currencyOptions: [Stripe.Currency: Stripe.Products.Coupon.Currency.Options]?

        private enum CodingKeys: String, CodingKey {
            case metadata
            case name
            case currencyOptions
        }

        public init(
            metadata: [String: String]? = nil,
            name: String? = nil,
            currencyOptions: [Stripe.Currency: Stripe.Products.Coupon.Currency.Options]? = nil
        ) {
            self.metadata = metadata
            self.name = name
            self.currencyOptions = currencyOptions
        }
    }
}

extension Stripe.Products.Coupons.List {
    public struct Request: Codable, Equatable, Sendable {
        public let created: Stripe.DateFilter?
        public let endingBefore: String?
        public let limit: Int?
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case created
            case endingBefore
            case limit
            case startingAfter
        }

        public init(
            created: Stripe.DateFilter? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Equatable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Products.Coupon]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}
