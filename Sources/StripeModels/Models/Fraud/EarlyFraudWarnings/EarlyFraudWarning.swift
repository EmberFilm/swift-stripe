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

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Fraud.EarlyFraudWarnings {
    /// An early fraud warning indicates that the card issuer has notified us that a charge may be fraudulent.
    public struct EarlyFraudWarning: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// An EFW is actionable if it has not received a dispute and has not been fully refunded.
        public var actionable: Bool?
        /// ID of the charge this early fraud warning is for, optionally expanded.
        @Expandable<Stripe.Charges.Charge, String> public var charge: String?
        /// Time at which the object was created.
        public var created: Date?
        /// The type of fraud labelled by the issuer.
        public var fraudType: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// ID of the Payment Intent this early fraud warning is for, optionally expanded.
        @Expandable<Stripe.PaymentIntents.PaymentIntent, String> public var paymentIntent: String?

        public init(
            id: ID,
            object: String,
            actionable: Bool? = nil,
            charge: String? = nil,
            created: Date? = nil,
            fraudType: String? = nil,
            livemode: Bool? = nil,
            paymentIntent: String? = nil
        ) {
            self.id = id
            self.object = object
            self.actionable = actionable
            self._charge = Expandable(id: charge)
            self.created = created
            self.fraudType = fraudType
            self.livemode = livemode
            self._paymentIntent = Expandable(id: paymentIntent)
        }
    }
}
