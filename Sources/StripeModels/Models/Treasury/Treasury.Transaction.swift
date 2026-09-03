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
    /// Transactions represent changes to a FinancialAccount's balance.
    public struct Transaction: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Amount (in cents) transferred.
        public var amount: Int?
        public var balanceImpact: Stripe.Shared.BalanceImpact?
        /// Time at which the object was created.
        public var created: Date?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// A list of TransactionEntries that are part of this Transaction.
        public var entries: Entries?
        /// The FinancialAccount associated with this object.
        public var financialAccount: String?
        /// ID of the flow that created the Transaction.
        public var flow: String?
        /// Details of the flow that created the Transaction.
        public var flowDetails: Stripe.Shared.FlowDetails?
        /// Type of the flow that created the Transaction.
        public var flowType: FlowType?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Status of the Transaction.
        public var status: Status?
        public var statusTransitions: StatusTransitions?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            balanceImpact: Stripe.Shared.BalanceImpact? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            entries: Entries? = nil,
            financialAccount: String? = nil,
            flow: String? = nil,
            flowDetails: Stripe.Shared.FlowDetails? = nil,
            flowType: FlowType? = nil,
            livemode: Bool? = nil,
            status: Status? = nil,
            statusTransitions: StatusTransitions? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.balanceImpact = balanceImpact
            self.created = created
            self.currency = currency
            self.description = description
            self.entries = entries
            self.financialAccount = financialAccount
            self.flow = flow
            self.flowDetails = flowDetails
            self.flowType = flowType
            self.livemode = livemode
            self.status = status
            self.statusTransitions = statusTransitions
        }

        /// Type of the flow that created the Transaction.
        public enum FlowType: String, Codable, Hashable, Sendable {
            case creditReversal = "credit_reversal"
            case debitReversal = "debit_reversal"
            case inboundTransfer = "inbound_transfer"
            case issuingAuthorization = "issuing_authorization"
            case other
            case outboundPayment = "outbound_payment"
            case outboundTransfer = "outbound_transfer"
            case receivedCredit = "received_credit"
            case receivedDebit = "received_debit"
        }

        /// Status of the Transaction.
        public enum Status: String, Codable, Hashable, Sendable {
            case open
            case posted
            case void
        }

        /// A list of TransactionEntries that are part of this Transaction.
        public struct Entries: Codable, Hashable, Sendable {
            /// String representing the object's type.
            public let object: String
            /// Details about each object.
            public var data: [Stripe.Treasury.TransactionEntry]?
            /// True if this list has another page of items after this one that can be fetched.
            public var hasMore: Bool?
            /// The URL where this list can be accessed.
            public var url: String?

            public init(
                object: String,
                data: [Stripe.Treasury.TransactionEntry]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil
            ) {
                self.object = object
                self.data = data
                self.hasMore = hasMore
                self.url = url
            }
        }

        public struct StatusTransitions: Codable, Hashable, Sendable {
            /// Timestamp describing when the Transaction changed status to `posted`.
            public var postedAt: Date?
            /// Timestamp describing when the Transaction changed status to `void`.
            public var voidAt: Date?

            public init(
                postedAt: Date? = nil,
                voidAt: Date? = nil
            ) {
                self.postedAt = postedAt
                self.voidAt = voidAt
            }
        }
    }
}
