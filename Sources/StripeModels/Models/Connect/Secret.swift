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

extension Stripe.Connect {
    /// Secret Store is an API that allows Stripe Apps developers to securely persist secrets for use by UI Extensions and.
    public struct Secret: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Time at which the object was created.
        public var created: Date?
        /// If true, indicates that this secret has been deleted.
        public var deleted: Bool?
        /// The Unix timestamp for the expiry time of the secret, after which the secret deletes.
        public var expiresAt: Date?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// A name for the secret that's unique within the scope.
        public var name: String?
        /// The plaintext secret value to be stored.
        public var payload: String?
        public var scope: Scope?

        public init(
            id: ID,
            object: String,
            created: Date? = nil,
            deleted: Bool? = nil,
            expiresAt: Date? = nil,
            livemode: Bool? = nil,
            name: String? = nil,
            payload: String? = nil,
            scope: Scope? = nil
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.deleted = deleted
            self.expiresAt = expiresAt
            self.livemode = livemode
            self.name = name
            self.payload = payload
            self.scope = scope
        }

        public struct Scope: Codable, Hashable, Sendable {
            /// The secret scope type.
            public var `type`: Type?
            /// The user ID, if type is set to "user".
            public var user: String?

            public init(
                `type`: Type? = nil,
                user: String? = nil
            ) {
                self.`type` = `type`
                self.user = user
            }

            /// The secret scope type.
            public enum `Type`: String, Codable, Hashable, Sendable {
                case account
                case user
            }
        }
    }
}
