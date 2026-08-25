//
//  Stripe Billing Meter Events Types Billing Meter Events.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.MeterEvents {
    // Placeholder for the MeterEvent model - should be replaced with actual model from Stripe Types Models
    public struct MeterEvent: Codable, Equatable, Sendable {
        public let object: String
        public let created: Date
        public let eventName: String
        public let livemode: Bool
        public let identifier: String
        public let timestamp: Date
        public let payload: [String: String]?

        private enum CodingKeys: String, CodingKey {
            case object
            case created
            case eventName
            case livemode
            case identifier
            case timestamp
            case payload
        }
    }
}

extension Stripe.Billing.MeterEvents {
    // https://docs.stripe.com/api/billing/meter-event/create.md
    public enum Create {}
}

extension Stripe.Billing.MeterEvents.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The name of the meter event
        public var eventName: String
        /// A unique identifier for the event
        public var identifier: String?
        /// The time of the event
        public var timestamp: Date
        /// The payload of the event
        public var payload: [String: String]

        public init(
            eventName: String,
            identifier: String? = nil,
            timestamp: Date,
            payload: [String: String]
        ) {
            self.eventName = eventName
            self.identifier = identifier
            self.timestamp = timestamp
            self.payload = payload
        }

        private enum CodingKeys: String, CodingKey {
            case eventName
            case identifier
            case timestamp
            case payload
        }
    }
}
