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
    /// Meter events represent actions that customers take in your system.
    public struct MeterEvent: Codable, Hashable, Sendable {
        /// String representing the object's type.
        public let object: String
        /// Time at which the object was created.
        public var created: Date?
        /// The name of the meter event.
        public var eventName: String?
        /// A unique identifier for the event.
        public var identifier: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// The payload of the event.
        public var payload: [String: String]?
        /// The timestamp passed in when creating the event.
        public var timestamp: Date?

        public init(
            object: String,
            created: Date? = nil,
            eventName: String? = nil,
            identifier: String? = nil,
            livemode: Bool? = nil,
            payload: [String: String]? = nil,
            timestamp: Date? = nil
        ) {
            self.object = object
            self.created = created
            self.eventName = eventName
            self.identifier = identifier
            self.livemode = livemode
            self.payload = payload
            self.timestamp = timestamp
        }
    }
}
