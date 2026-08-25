//
//  Stripe Refunds Types Refunds.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Refunds {
    // https://docs.stripe.com/api/refunds/create.md
    public enum Create {}
    // https://docs.stripe.com/api/refunds/update.md
    public enum Update {}
    // https://docs.stripe.com/api/refunds/list.md
    public enum List {}
}

// https://docs.stripe.com/api/refunds/create.md
extension Stripe.Refunds.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// A positive integer in cents representing how much to refund
        public let amount: Int?
        /// ID of the charge to refund
        public let charge: Stripe.Charges.Charge.ID?
        /// Email for refund instructions for payment methods without native refund support
        public let instructionsEmail: String?
        /// Set of key-value pairs for additional information
        public let metadata: [String: String]?
        /// Indicates refund origin for Customer Balance
        public let origin: Origin?
        /// ID of the PaymentIntent to refund
        public let paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID?
        /// Reason for the refund
        public let reason: Stripe.Refunds.Refund.Reason?
        /// Whether to refund the associated application fee
        public let refundApplicationFee: Bool?
        /// Whether to reverse the transfer proportionally to the refund amount
        public let reverseTransfer: Bool?

        private enum CodingKeys: String, CodingKey {
            case amount
            case charge
            case instructionsEmail
            case metadata
            case origin
            case paymentIntent
            case reason
            case refundApplicationFee
            case reverseTransfer
        }

        public enum Origin: String, Codable, Equatable, Sendable {
            case customerBalance = "customer_balance"
        }

        public init(
            amount: Int? = nil,
            charge: Stripe.Charges.Charge.ID? = nil,
            instructionsEmail: String? = nil,
            metadata: [String: String]? = nil,
            origin: Origin? = nil,
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
            reason: Stripe.Refunds.Refund.Reason? = nil,
            refundApplicationFee: Bool? = nil,
            reverseTransfer: Bool? = nil
        ) {
            self.amount = amount
            self.charge = charge
            self.instructionsEmail = instructionsEmail
            self.metadata = metadata
            self.origin = origin
            self.paymentIntent = paymentIntent
            self.reason = reason
            self.refundApplicationFee = refundApplicationFee
            self.reverseTransfer = reverseTransfer
        }
    }
}

// https://docs.stripe.com/api/refunds/update.md
extension Stripe.Refunds.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Set of key-value pairs that you can attach to an object
        public let metadata: [String: String]?

        public init(metadata: [String: String]? = nil) {
            self.metadata = metadata
        }
    }
}

// https://docs.stripe.com/api/refunds/list.md
extension Stripe.Refunds.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return refunds for the charge specified by this charge ID
        public let charge: Stripe.Charges.Charge.ID?
        /// Filter by refund creation date
        public let created: Stripe.DateFilter?
        /// A cursor for use in pagination
        public let endingBefore: String?
        /// A limit on the number of objects to be returned
        public let limit: Int?
        /// Only return refunds for the PaymentIntent specified by this ID
        public let paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID?
        /// A cursor for use in pagination
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case charge
            case created
            case endingBefore
            case limit
            case paymentIntent
            case startingAfter
        }

        public init(
            charge: Stripe.Charges.Charge.ID? = nil,
            created: Stripe.DateFilter? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
            startingAfter: String? = nil
        ) {
            self.charge = charge
            self.created = created
            self.endingBefore = endingBefore
            self.limit = limit
            self.paymentIntent = paymentIntent
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Refunds.Refund]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Stripe.Refunds.Refund]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}
