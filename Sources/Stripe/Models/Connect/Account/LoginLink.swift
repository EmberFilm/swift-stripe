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

extension Stripe.Connect.Account {
    /// Login Links are single-use URLs that takes an Express account to the login page for their Stripe dashboard.
    public struct LoginLink: Codable, Hashable, Sendable {
        /// String representing the object's type.
        public let object: String
        /// Time at which the object was created.
        public var created: Date?
        /// The URL for the login link.
        public var url: String?

        public init(
            object: String,
            created: Date? = nil,
            url: String? = nil
        ) {
            self.object = object
            self.created = created
            self.url = url
        }
    }
}
