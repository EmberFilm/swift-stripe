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

extension Stripe.FileLinks {
    /// To share the contents of a `File` object with non-Stripe users, you can create a `FileLink`.
    public struct FileLink: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Time at which the object was created.
        public var created: Date?
        /// Returns if the link is already expired.
        public var expired: Bool?
        /// Time that the link expires.
        public var expiresAt: Date?
        /// The file object this link points to.
        @Expandable<Stripe.Files.File, String> public var file: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The publicly accessible URL to download the file.
        public var url: String?

        public init(
            id: ID,
            object: String,
            created: Date? = nil,
            expired: Bool? = nil,
            expiresAt: Date? = nil,
            file: String? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            url: String? = nil
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.expired = expired
            self.expiresAt = expiresAt
            self._file = Expandable(id: file)
            self.livemode = livemode
            self.metadata = metadata
            self.url = url
        }
    }
}
