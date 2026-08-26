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

extension Stripe.Events.Event {
    public enum List {}
    public enum Retrieve {}
}

// GET /v1/events
extension Stripe.Events.Event.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return events that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// Filter events by whether all webhooks were successfully delivered.
        public var deliverySuccess: Bool?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// A string containing a specific event name, or group of events using * as a wildcard.
        public var `type`: String?
        /// An array of up to 20 strings containing specific event names.
        public var types: [String]?

        public init(
            created: Stripe.RangeQuery? = nil,
            deliverySuccess: Bool? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            `type`: String? = nil,
            types: [String]? = nil
        ) {
            self.created = created
            self.deliverySuccess = deliverySuccess
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
            self.`type` = `type`
            self.types = types
        }
    }

    public typealias Response = Stripe.Page<Stripe.Events.Event>
}

// GET /v1/events/{id}
extension Stripe.Events.Event.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Events.Event
}
