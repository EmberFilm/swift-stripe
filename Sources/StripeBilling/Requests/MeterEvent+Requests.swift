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

import StripeCheckout
import StripeCore
import StripeIssuing
import StripeModels
import StripeProducts

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.MeterEvent {
    public enum Create {}
}

// POST /v1/billing/meter_events
extension Stripe.Billing.MeterEvent.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// The name of the meter event.
        public var eventName: String
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A unique identifier for the event.
        public var identifier: String?
        /// The payload of the event.
        public var payload: [String: String]
        /// The time of the event.
        public var timestamp: Date?

        public init(
            eventName: String,
            expand: [String]? = nil,
            identifier: String? = nil,
            payload: [String: String],
            timestamp: Date? = nil
        ) {
            self.eventName = eventName
            self.expand = expand
            self.identifier = identifier
            self.payload = payload
            self.timestamp = timestamp
        }
    }

    public typealias Response = Stripe.Billing.MeterEvent
}
