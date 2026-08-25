//
//  TopUp.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/24/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/topups/object.md

// The TopUp struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.TopUp` that the generator spells differently.

extension Stripe.Connect.TopUp {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.TopUp]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.TopUp]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
