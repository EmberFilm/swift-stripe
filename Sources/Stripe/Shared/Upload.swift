//
//  Upload.swift
//  Stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe {
    /// The bytes of a file to upload, with the name and MIME type Stripe records for it.
    public struct Upload: Hashable, Sendable {
        public var data: Data
        public var filename: String
        public var contentType: String

        public init(data: Data, filename: String, contentType: String) {
            self.data = data
            self.filename = filename
            self.contentType = contentType
        }
    }
}
