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
    /// A billing meter event adjustment is a resource that allows you to cancel a meter event.
    public struct MeterEventAdjustment: Codable, Hashable, Sendable {
        /// String representing the object's type.
        public let object: String
        /// Specifies which event to cancel.
        public var cancel: Cancel?
        /// The name of the meter event.
        public var eventName: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// The meter event adjustment's status.
        public var status: Status?
        /// Specifies whether to cancel a single event or a range of events for a time period.
        public var `type`: String?

        public init(
            object: String,
            cancel: Cancel? = nil,
            eventName: String? = nil,
            livemode: Bool? = nil,
            status: Status? = nil,
            `type`: String? = nil
        ) {
            self.object = object
            self.cancel = cancel
            self.eventName = eventName
            self.livemode = livemode
            self.status = status
            self.`type` = `type`
        }

        /// The meter event adjustment's status.
        public enum Status: String, Codable, Hashable, Sendable {
            case complete
            case pending
        }

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
}
