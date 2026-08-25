//
//  Stripe Billing Meters Types Billing Meters.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Meters {
    // Placeholder for the Meter model - should be replaced with actual model from Stripe Types Models
    public struct Meter: Codable, Equatable, Sendable, Identifiable {
        public typealias ID = String

        public let id: ID
        public let object: String
        public let created: Date
        public let displayName: String
        public let eventName: String
        public let eventTimeWindow: EventTimeWindow?
        public let status: Status
        public let updated: Date

        public init(
            id: ID,
            object: String,
            created: Date,
            displayName: String,
            eventName: String,
            eventTimeWindow: EventTimeWindow?,
            status: Status,
            updated: Date
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.displayName = displayName
            self.eventName = eventName
            self.eventTimeWindow = eventTimeWindow
            self.status = status
            self.updated = updated
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case created
            case displayName
            case eventName
            case eventTimeWindow
            case status
            case updated
        }
    }

    public enum Status: String, Codable, Equatable, Sendable {
        case active
        case inactive
    }

    public enum EventTimeWindow: String, Codable, Equatable, Sendable {
        case hour
        case day
    }

    public struct DefaultAggregation: Codable, Equatable, Sendable {
        public var formula: Formula

        public init(formula: Formula) {
            self.formula = formula
        }
    }

    public enum Formula: String, Codable, Equatable, Sendable {
        case count
        case sum
    }

    public struct ValueSettings: Codable, Equatable, Sendable {
        public var eventPayloadKey: String

        public init(eventPayloadKey: String) {
            self.eventPayloadKey = eventPayloadKey
        }

        private enum CodingKeys: String, CodingKey {
            case eventPayloadKey
        }
    }

    public struct CustomerMapping: Codable, Equatable, Sendable {
        public var eventPayloadKey: String
        public var type: CustomerMappingType

        public init(eventPayloadKey: String, type: CustomerMappingType) {
            self.eventPayloadKey = eventPayloadKey
            self.type = type
        }

        private enum CodingKeys: String, CodingKey {
            case eventPayloadKey
            case type
        }
    }

    public enum CustomerMappingType: String, Codable, Equatable, Sendable {
        case byId = "by_id"
    }
}

extension Stripe.Billing.Meters {
    // https://docs.stripe.com/api/billing/meter/create.md
    public enum Create {}
}

extension Stripe.Billing.Meters.Create {
    public struct Request: Codable, Equatable, Sendable {
        public var displayName: String
        public var eventName: String
        public var defaultAggregation: Stripe.Billing.Meters.DefaultAggregation?
        public var eventTimeWindow: Stripe.Billing.Meters.EventTimeWindow?
        public var valueSettings: Stripe.Billing.Meters.ValueSettings?
        public var customerMapping: Stripe.Billing.Meters.CustomerMapping?

        public init(
            displayName: String,
            eventName: String,
            defaultAggregation: Stripe.Billing.Meters.DefaultAggregation? = nil,
            eventTimeWindow: Stripe.Billing.Meters.EventTimeWindow? = nil,
            valueSettings: Stripe.Billing.Meters.ValueSettings? = nil,
            customerMapping: Stripe.Billing.Meters.CustomerMapping? = nil
        ) {
            self.displayName = displayName
            self.eventName = eventName
            self.defaultAggregation = defaultAggregation
            self.eventTimeWindow = eventTimeWindow
            self.valueSettings = valueSettings
            self.customerMapping = customerMapping
        }

        private enum CodingKeys: String, CodingKey {
            case displayName
            case eventName
            case defaultAggregation
            case eventTimeWindow
            case valueSettings
            case customerMapping
        }
    }
}

extension Stripe.Billing.Meters {
    // https://docs.stripe.com/api/billing/meter/update.md
    public enum Update {}
}

extension Stripe.Billing.Meters.Update {
    public struct Request: Codable, Equatable, Sendable {
        public var displayName: String?

        public init(displayName: String? = nil) {
            self.displayName = displayName
        }

        private enum CodingKeys: String, CodingKey {
            case displayName
        }
    }
}

extension Stripe.Billing.Meters {
    // https://docs.stripe.com/api/billing/meter/list.md
    public enum List {}
}

extension Stripe.Billing.Meters.List {
    public struct Request: Codable, Equatable, Sendable {
        public var endingBefore: String?
        public var limit: Int?
        public var startingAfter: String?
        public var status: Stripe.Billing.Meters.Status?

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            status: Stripe.Billing.Meters.Status? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
            self.status = status
        }

        private enum CodingKeys: String, CodingKey {
            case endingBefore
            case limit
            case startingAfter
            case status
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.Meters.Meter]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}

extension Stripe.Billing.Meters {
    // https://docs.stripe.com/api/billing/meter/deactivate.md
    public enum Deactivate {}
}

extension Stripe.Billing.Meters.Deactivate {
    public struct Request: Codable, Equatable, Sendable {
        public init() {}
    }
}

extension Stripe.Billing.Meters {
    // https://docs.stripe.com/api/billing/meter/reactivate.md
    public enum Reactivate {}
}

extension Stripe.Billing.Meters.Reactivate {
    public struct Request: Codable, Equatable, Sendable {
        public init() {}
    }
}
