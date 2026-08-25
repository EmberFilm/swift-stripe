//
//  Billing.SubscriptionItems.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing {
    public enum SubscriptionItems {}
}

extension Stripe.Billing.SubscriptionItems {
    public struct SubscriptionItem: Codable, Equatable, Sendable, Identifiable {
        public let id: ID

        public typealias ID = String
    }
}
