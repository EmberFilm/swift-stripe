//
//  Stripe Payouts Types Payouts.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Payouts {
    // https://docs.stripe.com/api/payouts/create.md
    public enum Create {}
    // https://docs.stripe.com/api/payouts/update.md
    public enum Update {}
    // https://docs.stripe.com/api/payouts/list.md
    public enum List {}
    // https://docs.stripe.com/api/payouts/reverse.md
    public enum Reverse {}
}

// https://docs.stripe.com/api/payouts/create.md
extension Stripe.Payouts.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// A positive integer in cents representing how much to payout
        public let amount: Int
        /// Three-letter ISO currency code, in lowercase
        public let currency: Stripe.Currency
        /// An arbitrary string attached to the object
        public let description: String?
        /// ID of bank account or card to send payout
        public let destination: String?
        /// Set of key-value pairs for additional information
        public let metadata: [String: String]?
        /// Payout sending method: standard or instant
        public let method: Stripe.Payouts.Payout.Method?
        /// Balance type to draw payout from
        public let sourceType: Stripe.Payouts.Payout.SourceType?
        /// Displays on recipient's bank/card statement
        public let statementDescriptor: String?

        private enum CodingKeys: String, CodingKey {
            case amount
            case currency
            case description
            case destination
            case metadata
            case method
            case sourceType
            case statementDescriptor
        }

        public init(
            amount: Int,
            currency: Stripe.Currency,
            description: String? = nil,
            destination: String? = nil,
            metadata: [String: String]? = nil,
            method: Stripe.Payouts.Payout.Method? = nil,
            sourceType: Stripe.Payouts.Payout.SourceType? = nil,
            statementDescriptor: String? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.description = description
            self.destination = destination
            self.metadata = metadata
            self.method = method
            self.sourceType = sourceType
            self.statementDescriptor = statementDescriptor
        }
    }
}

// https://docs.stripe.com/api/payouts/update.md
extension Stripe.Payouts.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Set of key-value pairs that you can attach to an object
        public let metadata: [String: String]?

        public init(metadata: [String: String]? = nil) {
            self.metadata = metadata
        }
    }
}

// https://docs.stripe.com/api/payouts/list.md
extension Stripe.Payouts.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Filter by expected payout arrival date
        public let arrivalDate: Stripe.DateFilter?
        /// Filter by payout creation date
        public let created: Stripe.DateFilter?
        /// Filter by external account ID
        public let destination: String?
        /// A cursor for use in pagination
        public let endingBefore: String?
        /// A limit on the number of objects to be returned
        public let limit: Int?
        /// A cursor for use in pagination
        public let startingAfter: String?
        /// Filter by payout status
        public let status: Stripe.Payouts.Payout.Status?

        private enum CodingKeys: String, CodingKey {
            case arrivalDate
            case created
            case destination
            case endingBefore
            case limit
            case startingAfter
            case status
        }

        public init(
            arrivalDate: Stripe.DateFilter? = nil,
            created: Stripe.DateFilter? = nil,
            destination: String? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            status: Stripe.Payouts.Payout.Status? = nil
        ) {
            self.arrivalDate = arrivalDate
            self.created = created
            self.destination = destination
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
            self.status = status
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Payouts.Payout]

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
            data: [Stripe.Payouts.Payout]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}

// https://docs.stripe.com/api/payouts/reverse.md
extension Stripe.Payouts.Reverse {
    public struct Request: Codable, Equatable, Sendable {
        /// Set of key-value pairs that you can attach to an object
        public let metadata: [String: String]?

        public init(metadata: [String: String]? = nil) {
            self.metadata = metadata
        }
    }
}
