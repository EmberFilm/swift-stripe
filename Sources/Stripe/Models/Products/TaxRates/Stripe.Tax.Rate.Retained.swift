//
//  Tax.Rate.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/12/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/tax_rates/object.md

// The Rate struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Tax.Rate` that the generator spells differently.

extension Stripe.Tax.Rate {
}

public struct TaxRateList: Codable, Hashable, Sendable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Stripe.Tax.Rate]?

    public init(
        object: String,
        hasMore: Bool? = nil,
        url: String? = nil,
        data: [Stripe.Tax.Rate]? = nil
    ) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
