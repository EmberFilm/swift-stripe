//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-stripe open source project
//
// Copyright (c) 2026 the swift-stripe project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
// See NOTICE for attribution of derived work
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Meter {
    public enum Create {}
    public enum Deactivate {}
    public enum List {}
    public enum Reactivate {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/billing/meters
extension Stripe.Billing.Meter.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Fields that specify how to map a meter event to a customer.
        public var customerMapping: CustomerMapping?
        /// The default settings to aggregate a meter's events with.
        public var defaultAggregation: DefaultAggregation
        /// The meter’s name.
        public var displayName: String
        /// The name of the meter event to record usage for.
        public var eventName: String
        /// The time window which meter events have been pre-aggregated for, if any.
        public var eventTimeWindow: EventTimeWindow?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Fields that specify how to calculate a meter event's value.
        public var valueSettings: ValueSettings?

        public init(
            customerMapping: CustomerMapping? = nil,
            defaultAggregation: DefaultAggregation,
            displayName: String,
            eventName: String,
            eventTimeWindow: EventTimeWindow? = nil,
            expand: [String]? = nil,
            valueSettings: ValueSettings? = nil
        ) {
            self.customerMapping = customerMapping
            self.defaultAggregation = defaultAggregation
            self.displayName = displayName
            self.eventName = eventName
            self.eventTimeWindow = eventTimeWindow
            self.expand = expand
            self.valueSettings = valueSettings
        }

        public enum EventTimeWindow: String, Codable, Hashable, Sendable {
            case day
            case hour
        }

        /// Fields that specify how to map a meter event to a customer.
        public struct CustomerMapping: Codable, Hashable, Sendable {
            /// The key in the meter event payload to use for mapping the event to a customer.
            public var eventPayloadKey: String
            /// The method for mapping a meter event to a customer.
            public var `type`: String

            public init(
                eventPayloadKey: String,
                `type`: String
            ) {
                self.eventPayloadKey = eventPayloadKey
                self.`type` = `type`
            }
        }

        /// The default settings to aggregate a meter's events with.
        public struct DefaultAggregation: Codable, Hashable, Sendable {
            /// Specifies how events are aggregated.
            public var formula: Formula

            public init(
                formula: Formula
            ) {
                self.formula = formula
            }

            public enum Formula: String, Codable, Hashable, Sendable {
                case count
                case last
                case sum
            }
        }

        /// Fields that specify how to calculate a meter event's value.
        public struct ValueSettings: Codable, Hashable, Sendable {
            /// The key in the usage event payload to use as the value for this meter.
            public var eventPayloadKey: String

            public init(
                eventPayloadKey: String
            ) {
                self.eventPayloadKey = eventPayloadKey
            }
        }
    }

    public typealias Response = Stripe.Billing.Meter
}

// POST /v1/billing/meters/{id}/deactivate
extension Stripe.Billing.Meter.Deactivate {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Meter
}

// GET /v1/billing/meters
extension Stripe.Billing.Meter.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Filter results to only include meters with the given status.
        public var status: Status?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            status: Status? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
            self.status = status
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case active
            case inactive
        }
    }

    public typealias Response = Stripe.Page<Stripe.Billing.Meter>
}

// POST /v1/billing/meters/{id}/reactivate
extension Stripe.Billing.Meter.Reactivate {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Meter
}

// GET /v1/billing/meters/{id}
extension Stripe.Billing.Meter.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Meter
}

// POST /v1/billing/meters/{id}
extension Stripe.Billing.Meter.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// The meter’s name.
        public var displayName: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            displayName: String? = nil,
            expand: [String]? = nil
        ) {
            self.displayName = displayName
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Meter
}
