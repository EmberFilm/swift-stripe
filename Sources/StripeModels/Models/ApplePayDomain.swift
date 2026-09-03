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
    public struct ApplePayDomain: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Time at which the object was created.
        public var created: Date?
        public var domainName: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?

        public init(
            id: ID,
            object: String,
            created: Date? = nil,
            domainName: String? = nil,
            livemode: Bool? = nil
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.domainName = domainName
            self.livemode = livemode
        }
    }
}
