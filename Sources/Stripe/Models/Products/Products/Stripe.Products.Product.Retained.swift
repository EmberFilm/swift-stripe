//
//  Product.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/products/object.md

/// The [Product Object](https://stripe.com/docs/api/products/object) .

// The Product struct is generated (Models/Generated). These are the nested types the request
// layer still names under `Stripe.Products.Product` that the generator spells differently.


public enum Marketing {}

extension Marketing {
    public struct Feature: Codable, Hashable, Sendable {
        public var name: String?

        public init(
            name: String? = nil
        ) {
            self.name = name
        }
    }
}



extension Stripe.Products.Product.Search {
    public struct Result: Codable, Hashable, Sendable {
        /// A string describing the object type returned.
        public var object: String
        /// A list of products, paginated by any request parameters.
        public var data: [Stripe.Products.Product]?
        /// Whether or not there are more elements available after this set.
        public var hasMore: Bool?
        /// The URL for accessing this list.
        public var url: String?
        /// The URL for accessing the next page in search results.
        public var nextPage: String?
        /// The total count of entries in the search result, not just the current page.
        public var totalCount: Int?

        public init(
            object: String,
            data: [Stripe.Products.Product]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil,
            nextPage: String? = nil,
            totalCount: Int? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
            self.nextPage = nextPage
            self.totalCount = totalCount
        }
    }
}

