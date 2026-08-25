//
//  CountrySpec.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/23/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/country_specs/object.md

// The CountrySpec struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.CountrySpec` that the generator spells differently.

extension Stripe.Connect.CountrySpec {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.CountrySpec]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.CountrySpec]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}

