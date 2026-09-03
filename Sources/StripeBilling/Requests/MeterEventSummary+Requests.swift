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

extension Stripe.Billing.MeterEventSummary {
    public enum List {}
}

// GET /v1/billing/meters/{id}/event_summaries
extension Stripe.Billing.MeterEventSummary.List {
    public struct Request: Codable, Hashable, Sendable {
        /// The customer for which to fetch event summaries.
        public var customer: String
        /// The timestamp from when to stop aggregating meter events (exclusive).
        public var endTime: Date
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// The timestamp from when to start aggregating meter events (inclusive).
        public var startTime: Date
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Specifies what granularity to use when generating event summaries.
        public var valueGroupingWindow: ValueGroupingWindow?

        public init(
            customer: String,
            endTime: Date,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startTime: Date,
            startingAfter: String? = nil,
            valueGroupingWindow: ValueGroupingWindow? = nil
        ) {
            self.customer = customer
            self.endTime = endTime
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startTime = startTime
            self.startingAfter = startingAfter
            self.valueGroupingWindow = valueGroupingWindow
        }

        public enum ValueGroupingWindow: String, Codable, Hashable, Sendable {
            case day
            case hour
        }
    }

    public typealias Response = Stripe.Page<Stripe.Billing.MeterEventSummary>
}
