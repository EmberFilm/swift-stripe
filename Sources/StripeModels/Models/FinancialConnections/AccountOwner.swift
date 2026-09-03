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

extension FinancialConnections {
    /// Describes an owner of an account.
    public struct AccountOwner: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The email address of the owner.
        public var email: String?
        /// The full name of the owner.
        public var name: String?
        /// The ownership object that this owner belongs to.
        public var ownership: String?
        /// The raw phone number of the owner.
        public var phone: String?
        /// The raw physical address of the owner.
        public var rawAddress: String?
        /// The timestamp of the refresh that updated this owner.
        public var refreshedAt: Date?

        public init(
            id: ID,
            object: String,
            email: String? = nil,
            name: String? = nil,
            ownership: String? = nil,
            phone: String? = nil,
            rawAddress: String? = nil,
            refreshedAt: Date? = nil
        ) {
            self.id = id
            self.object = object
            self.email = email
            self.name = name
            self.ownership = ownership
            self.phone = phone
            self.rawAddress = rawAddress
            self.refreshedAt = refreshedAt
        }
    }
}
