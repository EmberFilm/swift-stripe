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

extension Stripe.Billing {
    /// A billing alert is a resource that notifies you when a certain usage threshold on a meter is crossed.
    public struct Alert: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Defines the type of the alert.
        public var alertType: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Status of the alert.
        public var status: Status?
        /// Title of the alert.
        public var title: String?
        /// Encapsulates configuration of the alert to monitor usage on a specific Billing Meter.
        public var usageThreshold: UsageThreshold?

        public init(
            id: ID,
            object: String,
            alertType: String? = nil,
            livemode: Bool? = nil,
            status: Status? = nil,
            title: String? = nil,
            usageThreshold: UsageThreshold? = nil
        ) {
            self.id = id
            self.object = object
            self.alertType = alertType
            self.livemode = livemode
            self.status = status
            self.title = title
            self.usageThreshold = usageThreshold
        }

        /// Status of the alert.
        public enum Status: String, Codable, Hashable, Sendable {
            case active
            case archived
            case inactive
        }

        /// The usage threshold alert configuration enables setting up alerts for when a certain usage threshold on a specific.
        public struct UsageThreshold: Codable, Hashable, Sendable {
            /// The filters allow limiting the scope of this usage alert.
            public var filters: [Filters]?
            /// The value at which this alert will trigger.
            public var gte: Int?
            /// The Billing Meter ID whose usage is monitored.
            @Expandable<Stripe.Billing.Meter, String> public var meter: String?
            /// Defines how the alert will behave.
            public var recurrence: String?

            public init(
                filters: [Filters]? = nil,
                gte: Int? = nil,
                meter: String? = nil,
                recurrence: String? = nil
            ) {
                self.filters = filters
                self.gte = gte
                self._meter = Expandable(id: meter)
                self.recurrence = recurrence
            }

            public struct Filters: Codable, Hashable, Sendable {
                /// Limit the scope of the alert to this customer ID.
                @Expandable<Stripe.Customers.Customer, String> public var customer: String?
                public var `type`: String?

                public init(
                    customer: String? = nil,
                    `type`: String? = nil
                ) {
                    self._customer = Expandable(id: customer)
                    self.`type` = `type`
                }
            }
        }
    }
}
