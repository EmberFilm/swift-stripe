//
//  FileLink.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/14/18.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/file_links/object.md

/// To share the contents of a `File` object with non-Stripe users, you can create a `FileLink`. `FileLink`s contain a URL that can be used to retrieve the contents of the file without authentication.
extension Stripe.FileLinks {
    public struct FileLink: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Whether this link is already expired.
        public var expired: Bool?
        /// Time at which the link expires.
        public var expiresAt: Date?
        /// The file object this link points to.
        @ExpandableOf<Stripe.Files.File> public var file: Stripe.Files.File.ID?
        /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// The publicly accessible URL to download the file.
        public var url: String?

        public init(
            id: ID,
            object: String,
            created: Date,
            expired: Bool? = nil,
            expiresAt: Date? = nil,
            file: Stripe.Files.File.ID? = nil,
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
