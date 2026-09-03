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

extension Stripe.Treasury {
    /// You can reverse some ReceivedDebits depending on their network and source flow.
    public struct DebitReversal: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Amount (in cents) transferred.
        public var amount: Int?
        /// Time at which the object was created.
        public var created: Date?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// The FinancialAccount to reverse funds from.
        public var financialAccount: String?
        /// A hosted transaction receipt URL that is provided when money movement is considered regulated under Stripe's money.
        public var hostedRegulatoryReceiptUrl: String?
        /// Other flows linked to a DebitReversal.
        public var linkedFlows: LinkedFlows?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The rails used to reverse the funds.
        public var network: Network?
        /// The ReceivedDebit being reversed.
        public var receivedDebit: String?
        /// Status of the DebitReversal.
        public var status: Status?
        public var statusTransitions: StatusTransitions?
        /// The Transaction associated with this object.
        @Expandable<Stripe.Treasury.Transaction, String> public var transaction: String?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            financialAccount: String? = nil,
            hostedRegulatoryReceiptUrl: String? = nil,
            linkedFlows: LinkedFlows? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            network: Network? = nil,
            receivedDebit: String? = nil,
            status: Status? = nil,
            statusTransitions: StatusTransitions? = nil,
            transaction: String? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.created = created
            self.currency = currency
            self.financialAccount = financialAccount
            self.hostedRegulatoryReceiptUrl = hostedRegulatoryReceiptUrl
            self.linkedFlows = linkedFlows
            self.livemode = livemode
            self.metadata = metadata
            self.network = network
            self.receivedDebit = receivedDebit
            self.status = status
            self.statusTransitions = statusTransitions
            self._transaction = Expandable(id: transaction)
        }

        /// The rails used to reverse the funds.
        public enum Network: String, Codable, Hashable, Sendable {
            case ach
            case card
        }

        /// Status of the DebitReversal.
        public enum Status: String, Codable, Hashable, Sendable {
            case failed
            case processing
            case succeeded
        }

        public struct LinkedFlows: Codable, Hashable, Sendable {
            /// Set if there is an Issuing dispute associated with the DebitReversal.
            public var issuingDispute: String?

            public init(
                issuingDispute: String? = nil
            ) {
                self.issuingDispute = issuingDispute
            }
        }

        public struct StatusTransitions: Codable, Hashable, Sendable {
            /// Timestamp describing when the DebitReversal changed status to `completed`.
            public var completedAt: Date?

            public init(
                completedAt: Date? = nil
            ) {
                self.completedAt = completedAt
            }
        }
    }
}
