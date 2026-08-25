//
//  Tax.ID.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/11/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The ID struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Tax.ID` that the generator spells differently.


// https://docs.stripe.com/api/taxIds/object.md

// Tax namespace is already defined in Stripe Namespaces.swift



extension Stripe.Tax.ID {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var url: String?
        public var hasMore: Bool?
        public var data: [Stripe.Tax.ID]?

        public init(
            object: String,
            url: String? = nil,
            hasMore: Bool? = nil,
            data: [Stripe.Tax.ID]? = nil
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}
