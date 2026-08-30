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
    /// A resource for the feedback options model (for custom cancellation reasons).
    public struct FeedbackOption: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// An arbitrary string attached to the object.
        public var description: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// The feedback option's status.
        public var status: Status?
        public var statusTransitions: StatusTransitions?

        public init(
            id: ID,
            object: String,
            description: String? = nil,
            livemode: Bool? = nil,
            status: Status? = nil,
            statusTransitions: StatusTransitions? = nil
        ) {
            self.id = id
            self.object = object
            self.description = description
            self.livemode = livemode
            self.status = status
            self.statusTransitions = statusTransitions
        }

        /// The feedback option's status.
        public enum Status: String, Codable, Hashable, Sendable {
            case active
            case inactive
        }

        public struct StatusTransitions: Codable, Hashable, Sendable {
            /// The time the feedback option was deactivated, if any.
            public var deactivatedAt: Date?

            public init(
                deactivatedAt: Date? = nil
            ) {
                self.deactivatedAt = deactivatedAt
            }
        }
    }
}
