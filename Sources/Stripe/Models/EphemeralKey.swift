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

extension Stripe {
    /// Ephemeral keys give the SDKs (like Stripe's mobile SDKs and Issuing Elements) temporary, scoped access to a specific.
    public struct EphemeralKey: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Time at which the object was created.
        public var created: Date?
        /// Time at which the key will expire.
        public var expires: Date?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// The key's secret.
        public var secret: String?

        public init(
            id: ID,
            object: String,
            created: Date? = nil,
            expires: Date? = nil,
            livemode: Bool? = nil,
            secret: String? = nil
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.expires = expires
            self.livemode = livemode
            self.secret = secret
        }
    }
}
