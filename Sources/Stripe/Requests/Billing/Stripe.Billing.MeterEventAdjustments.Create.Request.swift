//
//  Stripe Billing Meter Event Adjustment Types Billing Meter Event Adjustment.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.MeterEventAdjustments {
    // Placeholder for the MeterEventAdjustment model
    public struct MeterEventAdjustment: Codable, Equatable, Sendable {
        public let object: String
        public let livemode: Bool
        public let status: String
        public let eventName: String
        public let type: String
        public let cancel: Cancel?

        public struct Cancel: Codable, Equatable, Sendable {
            public let identifier: String?
        }

        private enum CodingKeys: String, CodingKey {
            case object
            case livemode
            case status
            case eventName
            case type
            case cancel
        }
    }
}

extension Stripe.Billing.MeterEventAdjustments {
    // https://docs.stripe.com/api/billing/meter-event-adjustment/create.md
    public enum Create {}
}

extension Stripe.Billing.MeterEventAdjustments.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The name of the meter event
        public var eventName: String
        /// Specifies whether to cancel a single event or a range of events
        public var type: AdjustmentType
        /// Details for canceling events
        public var cancel: Cancel?

        public enum AdjustmentType: String, Codable, Equatable, Sendable {
            case cancel
        }

        public struct Cancel: Codable, Equatable, Sendable {
            /// Unique identifier for the event (can only cancel events within 24 hours)
            public var identifier: String?

            public init(identifier: String? = nil) {
                self.identifier = identifier
            }
        }

        public init(
            eventName: String,
            type: AdjustmentType = .cancel,
            cancel: Cancel? = nil
        ) {
            self.eventName = eventName
            self.type = type
            self.cancel = cancel
        }

        private enum CodingKeys: String, CodingKey {
            case eventName
            case type
            case cancel
        }
    }
}
