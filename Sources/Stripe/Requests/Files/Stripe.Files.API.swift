//
//  Stripe Files Types Files.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Files {
    // https://docs.stripe.com/api/files/create.md
    public enum Create {}
    // https://docs.stripe.com/api/files/list.md
    public enum List {}
}

// https://docs.stripe.com/api/files/create.md
extension Stripe.Files.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The file to upload (multipart/form-data)
        public let file: Data
        /// The purpose of the uploaded file
        public let purpose: Stripe.Files.File.Purpose
        /// Specifies which fields in the response should be expanded
        public let expand: [String]?
        /// Optional parameters for the file link that's created
        public let fileLinkData: FileLinkData?

        private enum CodingKeys: String, CodingKey {
            case file
            case purpose
            case expand
            case fileLinkData
        }

        public init(
            file: Data,
            purpose: Stripe.Files.File.Purpose,
            expand: [String]? = nil,
            fileLinkData: FileLinkData? = nil
        ) {
            self.file = file
            self.purpose = purpose
            self.expand = expand
            self.fileLinkData = fileLinkData
        }
    }
}

extension Stripe.Files.Create.Request {
    public struct FileLinkData: Codable, Equatable, Sendable {
        /// Set to true to create a file link for the newly created file
        public let create: Bool
        /// The time after which the link expires
        public let expiresAt: Date?
        /// Set of key-value pairs that you can attach to an object
        public let metadata: [String: String]?

        private enum CodingKeys: String, CodingKey {
            case create
            case expiresAt
            case metadata
        }

        public init(
            create: Bool,
            expiresAt: Date? = nil,
            metadata: [String: String]? = nil
        ) {
            self.create = create
            self.expiresAt = expiresAt
            self.metadata = metadata
        }
    }
}

// https://docs.stripe.com/api/files/list.md
extension Stripe.Files.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return files created during the given date interval
        public let created: Stripe.DateFilter?
        /// A cursor for use in pagination
        public let endingBefore: String?
        /// A limit on the number of objects to be returned
        public let limit: Int?
        /// The file purpose to filter queries by
        public let purpose: Stripe.Files.File.Purpose?
        /// A cursor for use in pagination
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case created
            case endingBefore
            case limit
            case purpose
            case startingAfter
        }

        public init(
            created: Stripe.DateFilter? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            purpose: Stripe.Files.File.Purpose? = nil,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.endingBefore = endingBefore
            self.limit = limit
            self.purpose = purpose
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Files.File]

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
            data: [Stripe.Files.File]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}
