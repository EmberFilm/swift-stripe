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

extension Stripe.Connect.Transfer {
    /// Stripe Connect platforms can reverse transfers made to a connected account, either entirely or partially, and can.
    public struct Reversal: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Amount, in cents (or local equivalent).
        public var amount: Int?
        /// Balance transaction that describes the impact on your account balance.
        @Expandable<Stripe.Balance.Transaction, String> public var balanceTransaction: String?
        /// Time at which the object was created.
        public var created: Date?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// Linked payment refund for the transfer reversal.
        @Expandable<Stripe.Refunds.Refund, String> public var destinationPaymentRefund: String?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// ID of the refund responsible for the transfer reversal.
        @Expandable<Stripe.Refunds.Refund, String> public var sourceRefund: String?
        /// ID of the transfer that was reversed.
        @Expandable<Stripe.Connect.Transfer, String> public var transfer: String?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            balanceTransaction: String? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            destinationPaymentRefund: String? = nil,
            metadata: [String: String]? = nil,
            sourceRefund: String? = nil,
            transfer: String? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self._balanceTransaction = Expandable(id: balanceTransaction)
            self.created = created
            self.currency = currency
            self._destinationPaymentRefund = Expandable(id: destinationPaymentRefund)
            self.metadata = metadata
            self._sourceRefund = Expandable(id: sourceRefund)
            self._transfer = Expandable(id: transfer)
        }
    }
}
