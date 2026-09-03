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
    /// ReceivedDebits represent funds pulled from a FinancialAccount.
    public struct ReceivedDebit: Codable, Hashable, Sendable, Identifiable {
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
        /// An arbitrary string attached to the object.
        public var description: String?
        /// Reason for the failure.
        public var failureCode: FailureCode?
        /// The FinancialAccount that funds were pulled from.
        public var financialAccount: String?
        /// A hosted transaction receipt URL that is provided when money movement is considered regulated under Stripe's money.
        public var hostedRegulatoryReceiptUrl: String?
        public var initiatingPaymentMethodDetails: Stripe.Shared.InitiatingPaymentMethodDetails?
        public var linkedFlows: LinkedFlows?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// The network used for the ReceivedDebit.
        public var network: Network?
        /// Details describing when a ReceivedDebit might be reversed.
        public var reversalDetails: ReversalDetails?
        /// Status of the ReceivedDebit.
        public var status: Status?
        /// The Transaction associated with this object.
        @Expandable<Stripe.Treasury.Transaction, String> public var transaction: String?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            failureCode: FailureCode? = nil,
            financialAccount: String? = nil,
            hostedRegulatoryReceiptUrl: String? = nil,
            initiatingPaymentMethodDetails: Stripe.Shared.InitiatingPaymentMethodDetails? = nil,
            linkedFlows: LinkedFlows? = nil,
            livemode: Bool? = nil,
            network: Network? = nil,
            reversalDetails: ReversalDetails? = nil,
            status: Status? = nil,
            transaction: String? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.created = created
            self.currency = currency
            self.description = description
            self.failureCode = failureCode
            self.financialAccount = financialAccount
            self.hostedRegulatoryReceiptUrl = hostedRegulatoryReceiptUrl
            self.initiatingPaymentMethodDetails = initiatingPaymentMethodDetails
            self.linkedFlows = linkedFlows
            self.livemode = livemode
            self.network = network
            self.reversalDetails = reversalDetails
            self.status = status
            self._transaction = Expandable(id: transaction)
        }

        /// Reason for the failure.
        public enum FailureCode: String, Codable, Hashable, Sendable {
            case accountClosed = "account_closed"
            case accountFrozen = "account_frozen"
            case insufficientFunds = "insufficient_funds"
            case internationalTransaction = "international_transaction"
            case other
        }

        /// The network used for the ReceivedDebit.
        public enum Network: String, Codable, Hashable, Sendable {
            case ach
            case card
            case stripe
        }

        /// Status of the ReceivedDebit.
        public enum Status: String, Codable, Hashable, Sendable {
            case failed
            case succeeded
        }

        public struct LinkedFlows: Codable, Hashable, Sendable {
            /// The DebitReversal created as a result of this ReceivedDebit being reversed.
            public var debitReversal: String?
            /// Set if the ReceivedDebit is associated with an InboundTransfer's return of funds.
            public var inboundTransfer: String?
            /// Set if the ReceivedDebit was created due to an Issuing Authorization object.
            public var issuingAuthorization: String?
            /// Set if the ReceivedDebit is also viewable as an Issuing Dispute object.
            public var issuingTransaction: String?
            /// Set if the ReceivedDebit was created due to a Payout object.
            public var payout: String?
            /// Set if the ReceivedDebit was created due to a Topup object.
            public var topup: String?

            public init(
                debitReversal: String? = nil,
                inboundTransfer: String? = nil,
                issuingAuthorization: String? = nil,
                issuingTransaction: String? = nil,
                payout: String? = nil,
                topup: String? = nil
            ) {
                self.debitReversal = debitReversal
                self.inboundTransfer = inboundTransfer
                self.issuingAuthorization = issuingAuthorization
                self.issuingTransaction = issuingTransaction
                self.payout = payout
                self.topup = topup
            }
        }

        public struct ReversalDetails: Codable, Hashable, Sendable {
            /// Time before which a ReceivedDebit can be reversed.
            public var deadline: Date?
            /// Set if a ReceivedDebit can't be reversed.
            public var restrictedReason: RestrictedReason?

            public init(
                deadline: Date? = nil,
                restrictedReason: RestrictedReason? = nil
            ) {
                self.deadline = deadline
                self.restrictedReason = restrictedReason
            }

            /// Set if a ReceivedDebit can't be reversed.
            public enum RestrictedReason: String, Codable, Hashable, Sendable {
                case alreadyReversed = "already_reversed"
                case deadlinePassed = "deadline_passed"
                case networkRestricted = "network_restricted"
                case other
                case sourceFlowRestricted = "source_flow_restricted"
            }
        }
    }
}
