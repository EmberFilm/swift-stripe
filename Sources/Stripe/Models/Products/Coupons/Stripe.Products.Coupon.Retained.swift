//
//  Coupon.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The Coupon struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Products.Coupon` that the generator spells differently.




extension Stripe.Products.Coupon {
    public enum Currency {}
}

extension Stripe.Products.Coupon.Currency {
    public struct Options: Codable, Hashable, Sendable {
        /// Amount (in the currency specified) that will be taken off the subtotal of any invoices for this customer.
        public var amountOff: Int?

        public init(
            amountOff: Int? = nil
        ) {
            self.amountOff = amountOff
        }
    }
}


extension Stripe.Products.Coupon {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Products.Coupon]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Products.Coupon]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
