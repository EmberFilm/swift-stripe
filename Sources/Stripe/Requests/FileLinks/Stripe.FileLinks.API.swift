//
//  Stripe File Links Types File Links.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.FileLinks {
    // https://docs.stripe.com/api/file_links/create.md
    public enum Create {}
    // https://docs.stripe.com/api/file_links/update.md
    public enum Update {}
    // https://docs.stripe.com/api/file_links/list.md
    public enum List {}
}

// https://docs.stripe.com/api/file_links/create.md
extension Stripe.FileLinks.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The ID of the file to create a link for
        public let file: String
        /// The time after which the link expires
        public let expiresAt: Date?
        /// Set of key-value pairs that you can attach to an object
        public let metadata: [String: String]?

        private enum CodingKeys: String, CodingKey {
            case file
            case expiresAt
            case metadata
        }

        public init(
            file: String,
            expiresAt: Date? = nil,
            metadata: [String: String]? = nil
        ) {
            self.file = file
            self.expiresAt = expiresAt
            self.metadata = metadata
        }
    }
}

// https://docs.stripe.com/api/file_links/update.md
extension Stripe.FileLinks.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// The time after which the link expires
        public let expiresAt: Date?
        /// Set of key-value pairs that you can attach to an object
        public let metadata: [String: String]?

        private enum CodingKeys: String, CodingKey {
            case expiresAt
            case metadata
        }

        public init(
            expiresAt: Date? = nil,
            metadata: [String: String]? = nil
        ) {
            self.expiresAt = expiresAt
            self.metadata = metadata
        }
    }
}

// https://docs.stripe.com/api/file_links/list.md
extension Stripe.FileLinks.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return links created during the given date interval
        public let created: Stripe.DateFilter?
        /// A cursor for use in pagination
        public let endingBefore: String?
        /// Filter links by expired status
        public let expired: Bool?
        /// Only return links for the specified file
        public let file: String?
        /// A limit on the number of objects to be returned
        public let limit: Int?
        /// A cursor for use in pagination
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case created
            case endingBefore
            case expired
            case file
            case limit
            case startingAfter
        }

        public init(
            created: Stripe.DateFilter? = nil,
            endingBefore: String? = nil,
            expired: Bool? = nil,
            file: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.endingBefore = endingBefore
            self.expired = expired
            self.file = file
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.FileLinks.FileLink]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Stripe.FileLinks.FileLink]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}
