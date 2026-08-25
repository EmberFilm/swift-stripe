//
//  Tax Code.swift
//
//
//  Created by Andrew Edwards on 12/16/21.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/tax_codes/object.md

extension Stripe.Tax {
    public struct Code: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// A detailed description of which types of products the tax code represents.
        public var description: String
        /// A short name for the tax code.
        public var name: String

        public init(
            id: ID,
            object: String,
            description: String,
            name: String
        ) {
            self.id = id
            self.object = object
            self.description = description
            self.name = name
        }
    }
}

extension Stripe.Tax.Code {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Tax.Code]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Tax.Code]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
