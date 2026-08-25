//
//  TransferReversal.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/2/18.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/transfer_reversals/object.md

// The Reversal struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.Transfer.Reversal` that the generator spells differently.

extension Stripe.Connect.Transfer.Reversal {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.Transfer.Reversal]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.Transfer.Reversal]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
