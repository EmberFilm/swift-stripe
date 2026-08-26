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
    /// Account Links are the means by which a Connect platform grants a connected account permission to access Stripe-hosted.
    public struct AccountLink: Codable, Hashable, Sendable {
        /// String representing the object's type.
        public let object: String
        /// Time at which the object was created.
        public var created: Date?
        /// The timestamp at which this account link will expire.
        public var expiresAt: Date?
        /// The URL for the account link.
        public var url: String?

        public init(
            object: String,
            created: Date? = nil,
            expiresAt: Date? = nil,
            url: String? = nil
        ) {
            self.object = object
            self.created = created
            self.expiresAt = expiresAt
            self.url = url
        }
    }
}
