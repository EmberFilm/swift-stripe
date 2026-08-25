//
//  Capabilities.swift
//
//
//  Created by Andrew Edwards on 11/29/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/capabilities/object.md

// The Capability struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.Capability` that the generator spells differently.

extension Stripe.Connect.Capability {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.Capability]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.Capability]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
