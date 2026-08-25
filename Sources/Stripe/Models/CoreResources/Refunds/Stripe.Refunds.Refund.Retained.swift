//
//  Refund.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/refunds/object.md

/// The [Refund Object](https://stripe.com/docs/api/refunds/object) .

// The Refund struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Refunds.Refund` that the generator spells differently.

extension Stripe.Refunds.Refund {
    public enum FailureReason: String, Codable, Sendable {
        case lostOrStolenCard = "lost_or_stolen_card"
        case expiredOrCanceledCard = "expired_or_canceled_card"
        case chargeForPendingRefundDisputed = "charge_for_pending_refund_disputed"
        case insufficientFunds = "insufficient_funds"
        case declined
        case merchantRequest = "merchant_request"
        case unknown
    }

    public enum Status: String, Codable, Sendable {
        case pending
        case succeeded
        case failed
        case canceled
    }

    public struct NextActionDisplayDetails: Codable, Hashable, Sendable {
        /// Contains information about the email sent to the customer.
        public var emailSent: Stripe.Refunds.Refund.NextActionDisplayDetailsEmailSent?
        /// The expiry timestamp.
        public var expiresAt: Date?

        public init(
            emailSent: Stripe.Refunds.Refund.NextActionDisplayDetailsEmailSent? = nil,
            expiresAt: Date? = nil
        ) {
            self.emailSent = emailSent
            self.expiresAt = expiresAt
        }
    }

    public struct NextActionDisplayDetailsEmailSent: Codable, Hashable, Sendable {
        /// The timestamp when the email was sent.
        public var emailSentAt: Date?
        /// The recipient’s email address.
        public var emailSentTo: String?

        public init(
            emailSentAt: Date? = nil,
            emailSentTo: String? = nil
        ) {
            self.emailSentAt = emailSentAt
            self.emailSentTo = emailSentTo
        }
    }

}

extension Stripe.Refunds.Refund {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Refunds.Refund]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Refunds.Refund]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
