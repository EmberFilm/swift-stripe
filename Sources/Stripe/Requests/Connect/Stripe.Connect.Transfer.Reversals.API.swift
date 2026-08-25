//
//  Stripe Connect Transfer Reversals Types.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// Namespace for Transfer Reversals
extension Stripe.Connect.Transfer {
    public enum Reversals {}
}

extension Stripe.Connect.Transfer.Reversals {
    // https://docs.stripe.com/api/transfer_reversals/create.md
    public enum Create {}
}

extension Stripe.Connect.Transfer.Reversals.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// A positive integer in cents representing how much of this transfer to reverse.
        /// By default, the entire transfer is reversed.
        public var amount: Int?

        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public var description: String?

        /// Set of key-value pairs that you can attach to an object.
        /// This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?

        /// Indicates whether the application fee should be refunded when reversing this transfer.
        /// If false, the fee will be pulled from the platform account's balance.
        public var refundApplicationFee: Bool?

        private enum CodingKeys: String, CodingKey {
            case amount
            case description
            case metadata
            case refundApplicationFee
        }

        public init(
            amount: Int? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            refundApplicationFee: Bool? = nil
        ) {
            self.amount = amount
            self.description = description
            self.metadata = metadata
            self.refundApplicationFee = refundApplicationFee
        }
    }
}

extension Stripe.Connect.Transfer.Reversals {
    // https://docs.stripe.com/api/transfer_reversals/update.md
    public enum Update {}
}

extension Stripe.Connect.Transfer.Reversals.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public var description: String?

        /// Set of key-value pairs that you can attach to an object.
        /// This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?

        public init(
            description: String? = nil,
            metadata: [String: String]? = nil
        ) {
            self.description = description
            self.metadata = metadata
        }
    }
}

extension Stripe.Connect.Transfer.Reversals {
    // https://docs.stripe.com/api/transfer_reversals/list.md
    public enum List {}
}

extension Stripe.Connect.Transfer.Reversals.List {
    public struct Request: Codable, Equatable, Sendable {
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        /// For instance, if you make a list request and receive 100 objects, starting with obj_bar,
        /// your subsequent call can include ending_before=obj_bar in order to fetch the previous page of the list.
        public var endingBefore: String?

        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public var limit: Int?

        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        /// For instance, if you make a list request and receive 100 objects, ending with obj_foo,
        /// your subsequent call can include starting_after=obj_foo in order to fetch the next page of the list.
        public var startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case endingBefore
            case limit
            case startingAfter
        }

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Connect.Transfer.Reversal.List
}
