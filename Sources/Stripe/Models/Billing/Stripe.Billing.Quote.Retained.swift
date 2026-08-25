//
//  Quote.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/25/21.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/quotes/object.md

/// A Quote is a way to model prices that you'd like to provide to a customer. Once accepted, it will automatically create an invoice, subscription or subscription schedule.

// The Quote struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.Quote` that the generator spells differently.

extension Stripe.Billing.Quote {
    public struct StatusTransition: Codable, Hashable, Sendable {
        /// The time that the quote was accepted. Measured in seconds since Unix epoch.
        public var acceptedAt: Date?
        /// The time that the quote was canceled. Measured in seconds since Unix epoch.
        public var canceledAt: Date?
        /// The time that the quote was finalized. Measured in seconds since Unix epoch.
        public var finalizedAt: Date?

        public init(
            acceptedAt: Date? = nil,
            canceledAt: Date? = nil,
            finalizedAt: Date? = nil
        ) {
            self.acceptedAt = acceptedAt
            self.canceledAt = canceledAt
            self.finalizedAt = finalizedAt
        }
    }
}

extension Stripe.Billing.Quote {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Billing.Quote.LineItem]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Billing.Quote.LineItem]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
