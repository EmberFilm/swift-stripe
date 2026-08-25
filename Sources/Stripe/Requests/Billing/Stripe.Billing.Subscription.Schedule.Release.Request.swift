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
    // https://docs.stripe.com/api/subscriptionSchedules/release.md
    public enum Release {}
}

extension Stripe.Billing.Subscription.Schedule.Release {
    public struct Request: Codable, Equatable, Sendable {
        /// Keep any cancellation on the subscription
        public var preserveCancelDate: Bool?

        public init(preserveCancelDate: Bool? = nil) {
            self.preserveCancelDate = preserveCancelDate
        }

        private enum CodingKeys: String, CodingKey {
            case preserveCancelDate
        }
    }
}
