//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-stripe open source project
//
// Copyright (c) 2026 the swift-stripe project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
// See NOTICE for attribution of derived work
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import StripeCheckout
import StripeCore
import StripeIssuing
import StripeModels
import StripePromotion
import StripeReporting

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.EphemeralKey {
    public enum Create {}
    public enum Delete {}
}

// POST /v1/ephemeral_keys
extension Stripe.EphemeralKey.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// The ID of the Customer you'd like to modify using the resulting ephemeral key.
        public var customer: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The ID of the Issuing Card you'd like to access using the resulting ephemeral key.
        public var issuingCard: String?
        /// A single-use token, created by Stripe.js, used for creating ephemeral keys for Issuing Cards without exchanging.
        public var nonce: String?
        /// The ID of the Identity VerificationSession you'd like to access using the resulting ephemeral key.
        public var verificationSession: String?

        public init(
            customer: String? = nil,
            expand: [String]? = nil,
            issuingCard: String? = nil,
            nonce: String? = nil,
            verificationSession: String? = nil
        ) {
            self.customer = customer
            self.expand = expand
            self.issuingCard = issuingCard
            self.nonce = nonce
            self.verificationSession = verificationSession
        }
    }

    public typealias Response = Stripe.EphemeralKey
}

// DELETE /v1/ephemeral_keys/{key}
extension Stripe.EphemeralKey.Delete {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.EphemeralKey
}
