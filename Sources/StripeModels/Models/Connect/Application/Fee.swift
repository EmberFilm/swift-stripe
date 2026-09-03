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

extension Stripe.Connect.Application {
    public struct Fee: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// ID of the Stripe account this fee was taken from.
        @Expandable<Stripe.Connect.Account, String> public var account: String?
        /// Amount earned, in cents (or local equivalent).
        public var amount: Int?
        /// Amount in cents (or local equivalent) refunded (can be less than the amount attribute on the fee if a partial refund.
        public var amountRefunded: Int?
        /// ID of the Connect application that earned the fee.
        @Expandable<Stripe.Shared.Application, String> public var application: String?
        /// Balance transaction that describes the impact of this collected application fee on your account balance (not.
        @Expandable<Stripe.Balance.Transaction, String> public var balanceTransaction: String?
        /// ID of the charge that the application fee was taken from.
        @Expandable<Stripe.Charges.Charge, String> public var charge: String?
        /// Time at which the object was created.
        public var created: Date?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// Polymorphic source of the application fee.
        public var feeSource: FeeSource?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// ID of the corresponding charge on the platform account, if this fee was the result of a charge using the.
        @Expandable<Stripe.Charges.Charge, String> public var originatingTransaction: String?
        /// Whether the fee has been fully refunded.
        public var refunded: Bool?
        /// A list of refunds that have been applied to the fee.
        public var refunds: Refunds?

        public init(
            id: ID,
            object: String,
            account: String? = nil,
            amount: Int? = nil,
            amountRefunded: Int? = nil,
            application: String? = nil,
            balanceTransaction: String? = nil,
            charge: String? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            feeSource: FeeSource? = nil,
            livemode: Bool? = nil,
            originatingTransaction: String? = nil,
            refunded: Bool? = nil,
            refunds: Refunds? = nil
        ) {
            self.id = id
            self.object = object
            self._account = Expandable(id: account)
            self.amount = amount
            self.amountRefunded = amountRefunded
            self._application = Expandable(id: application)
            self._balanceTransaction = Expandable(id: balanceTransaction)
            self._charge = Expandable(id: charge)
            self.created = created
            self.currency = currency
            self.feeSource = feeSource
            self.livemode = livemode
            self._originatingTransaction = Expandable(id: originatingTransaction)
            self.refunded = refunded
            self.refunds = refunds
        }

        public struct FeeSource: Codable, Hashable, Sendable {
            /// Charge ID that created this application fee.
            public var charge: String?
            /// Payout ID that created this application fee.
            public var payout: String?
            /// Type of object that created the application fee.
            public var `type`: Type?

            public init(
                charge: String? = nil,
                payout: String? = nil,
                `type`: Type? = nil
            ) {
                self.charge = charge
                self.payout = payout
                self.`type` = `type`
            }

            /// Type of object that created the application fee.
            public enum `Type`: String, Codable, Hashable, Sendable {
                case charge
                case payout
            }
        }

        /// A list of refunds that have been applied to the fee.
        public struct Refunds: Codable, Hashable, Sendable {
            /// String representing the object's type.
            public let object: String
            /// Details about each object.
            public var data: [Stripe.Connect.Application.Fee.Refund]?
            /// True if this list has another page of items after this one that can be fetched.
            public var hasMore: Bool?
            /// The URL where this list can be accessed.
            public var url: String?

            public init(
                object: String,
                data: [Stripe.Connect.Application.Fee.Refund]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil
            ) {
                self.object = object
                self.data = data
                self.hasMore = hasMore
                self.url = url
            }
        }
    }
}
