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

// The Code struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Tax.Code` that the generator spells differently.

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
