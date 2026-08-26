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

extension Stripe.Connect.Application.Fee {
    /// `Application Fee Refund` objects allow you to refund an application fee that has previously been created but not yet.
    public struct Refund: Codable, Hashable, Sendable, Identifiable {
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
        /// ID of the application fee that was refunded.
        @Expandable<Stripe.Connect.Application.Fee, String> public var fee: String?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            balanceTransaction: String? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            fee: String? = nil,
            metadata: [String: String]? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self._balanceTransaction = Expandable(id: balanceTransaction)
            self.created = created
            self.currency = currency
            self._fee = Expandable(id: fee)
            self.metadata = metadata
        }
    }
}
