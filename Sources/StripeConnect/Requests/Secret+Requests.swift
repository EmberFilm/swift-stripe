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

import StripeCore
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Connect.Secret {
    public enum Create {}
    public enum DeleteWhere {}
    public enum Find {}
    public enum List {}
}

// POST /v1/apps/secrets
extension Stripe.Connect.Secret.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The Unix timestamp for the expiry time of the secret, after which the secret deletes.
        public var expiresAt: Date?
        /// A name for the secret that's unique within the scope.
        public var name: String
        /// The plaintext secret value to be stored.
        public var payload: String
        /// Specifies the scoping of the secret.
        public var scope: Scope

        public init(
            expand: [String]? = nil,
            expiresAt: Date? = nil,
            name: String,
            payload: String,
            scope: Scope
        ) {
            self.expand = expand
            self.expiresAt = expiresAt
            self.name = name
            self.payload = payload
            self.scope = scope
        }

        /// Specifies the scoping of the secret.
        public struct Scope: Codable, Hashable, Sendable {
            /// The secret scope type.
            public var `type`: Type
            /// The user ID.
            public var user: String?

            public init(
                `type`: Type,
                user: String? = nil
            ) {
                self.`type` = `type`
                self.user = user
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case account
                case user
            }
        }
    }

    public typealias Response = Stripe.Connect.Secret
}

// POST /v1/apps/secrets/delete
extension Stripe.Connect.Secret.DeleteWhere {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A name for the secret that's unique within the scope.
        public var name: String
        /// Specifies the scoping of the secret.
        public var scope: Scope

        public init(
            expand: [String]? = nil,
            name: String,
            scope: Scope
        ) {
            self.expand = expand
            self.name = name
            self.scope = scope
        }

        /// Specifies the scoping of the secret.
        public struct Scope: Codable, Hashable, Sendable {
            /// The secret scope type.
            public var `type`: Type
            /// The user ID.
            public var user: String?

            public init(
                `type`: Type,
                user: String? = nil
            ) {
                self.`type` = `type`
                self.user = user
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case account
                case user
            }
        }
    }

    public typealias Response = Stripe.Connect.Secret
}

// GET /v1/apps/secrets/find
extension Stripe.Connect.Secret.Find {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A name for the secret that's unique within the scope.
        public var name: String
        /// Specifies the scoping of the secret.
        public var scope: Scope

        public init(
            expand: [String]? = nil,
            name: String,
            scope: Scope
        ) {
            self.expand = expand
            self.name = name
            self.scope = scope
        }

        /// Specifies the scoping of the secret.
        public struct Scope: Codable, Hashable, Sendable {
            /// The secret scope type.
            public var `type`: Type
            /// The user ID.
            public var user: String?

            public init(
                `type`: Type,
                user: String? = nil
            ) {
                self.`type` = `type`
                self.user = user
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case account
                case user
            }
        }
    }

    public typealias Response = Stripe.Connect.Secret
}

// GET /v1/apps/secrets
extension Stripe.Connect.Secret.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// Specifies the scoping of the secret.
        public var scope: Scope
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            scope: Scope,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.scope = scope
            self.startingAfter = startingAfter
        }

        /// Specifies the scoping of the secret.
        public struct Scope: Codable, Hashable, Sendable {
            /// The secret scope type.
            public var `type`: Type
            /// The user ID.
            public var user: String?

            public init(
                `type`: Type,
                user: String? = nil
            ) {
                self.`type` = `type`
                self.user = user
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case account
                case user
            }
        }
    }

    public typealias Response = Stripe.Page<Stripe.Connect.Secret>
}
