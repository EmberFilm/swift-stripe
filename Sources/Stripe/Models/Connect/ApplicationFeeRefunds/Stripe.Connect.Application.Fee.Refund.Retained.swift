//
//  ApplicationFeeRefund.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/17/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/fee_refunds/object.md

// The Refund struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.Application.Fee.Refund` that the generator spells differently.

extension Stripe.Connect.Application.Fee.Refund {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.Application.Fee.Refund]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.Application.Fee.Refund]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
