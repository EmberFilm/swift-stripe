//
//  Stripe Billing Subscription Schedule Types List.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 22/09/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Subscription.Schedule.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Filter by cancellation date
        public var canceledAt: Stripe.DateFilter?
        /// Filter by completion date
        public var completedAt: Stripe.DateFilter?
        /// Filter by creation date
        public var created: Stripe.DateFilter?
        /// Filter by customer
        public var customer: Stripe.Customers.Customer.ID?
        /// Pagination cursor
        public var endingBefore: String?
        /// Number of objects to return
        public var limit: Int?
        /// Filter by release date
        public var releasedAt: Stripe.DateFilter?
        /// Filter for not-yet-started schedules
        public var scheduled: Bool?
        /// Pagination cursor
        public var startingAfter: String?

        public init(
            canceledAt: Stripe.DateFilter? = nil,
            completedAt: Stripe.DateFilter? = nil,
            created: Stripe.DateFilter? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            releasedAt: Stripe.DateFilter? = nil,
            scheduled: Bool? = nil,
            startingAfter: String? = nil
        ) {
            self.canceledAt = canceledAt
            self.completedAt = completedAt
            self.created = created
            self.customer = customer
            self.endingBefore = endingBefore
            self.limit = limit
            self.releasedAt = releasedAt
            self.scheduled = scheduled
            self.startingAfter = startingAfter
        }

        private enum CodingKeys: String, CodingKey {
            case canceledAt
            case completedAt
            case created
            case customer
            case endingBefore
            case limit
            case releasedAt
            case scheduled
            case startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.Subscription.Schedule]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}
