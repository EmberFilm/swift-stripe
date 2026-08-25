//
//  Secret.swift
//
//
//  Created by Andrew Edwards on 5/18/23.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/secrets/object.md

// The Secret struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.Secret` that the generator spells differently.

extension Stripe.Connect.Secret {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.Secret]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.Secret]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
