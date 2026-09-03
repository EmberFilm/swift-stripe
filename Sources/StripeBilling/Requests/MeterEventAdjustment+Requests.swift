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

extension Stripe.Billing.MeterEventAdjustment {
    public enum Create {}
}

// POST /v1/billing/meter_event_adjustments
extension Stripe.Billing.MeterEventAdjustment.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which event to cancel.
        public var cancel: Cancel?
        /// The name of the meter event.
        public var eventName: String
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Specifies whether to cancel a single event or a range of events for a time period.
        public var `type`: String

        public init(
            cancel: Cancel? = nil,
            eventName: String,
            expand: [String]? = nil,
            `type`: String
        ) {
            self.cancel = cancel
            self.eventName = eventName
            self.expand = expand
            self.`type` = `type`
        }

        /// Specifies which event to cancel.
        public struct Cancel: Codable, Hashable, Sendable {
            /// Unique identifier for the event.
            public var identifier: String?

            public init(
                identifier: String? = nil
            ) {
                self.identifier = identifier
            }
        }
    }

    public typealias Response = Stripe.Billing.MeterEventAdjustment
}
