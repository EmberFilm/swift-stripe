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

extension Stripe.Payouts {
    /// A `Payout` object is created when you receive funds from Stripe, or when you initiate a payout to either a bank.
    public struct Payout: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The amount (in cents (or local equivalent)) that transfers to your bank account or debit card.
        public var amount: Int?
        /// The application fee (if any) for the payout.
        @Expandable<Stripe.Connect.Application.Fee, String> public var applicationFee: String?
        /// The amount of the application fee (if any) requested for the payout.
        public var applicationFeeAmount: Int?
        /// Date that you can expect the payout to arrive in the bank.
        public var arrivalDate: Date?
        /// Returns `true` if the payout is created by an automated payout schedule and `false` if it's requested manually.
        public var automatic: Bool?
        /// ID of the balance transaction that describes the impact of this payout on your account balance.
        @Expandable<Stripe.Balance.Transaction, String> public var balanceTransaction: String?
        /// Time at which the object was created.
        public var created: Date?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// ID of the bank account or card the payout is sent to.
        @Expandable<Stripe.ExternalAccount, String> public var destination: String?
        /// If the payout fails or cancels, this is the ID of the balance transaction that reverses the initial balance.
        @Expandable<Stripe.Balance.Transaction, String> public var failureBalanceTransaction: String?
        /// Error code that provides a reason for a payout failure, if available.
        public var failureCode: String?
        /// Message that provides the reason for a payout failure, if available.
        public var failureMessage: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The method used to send this payout, which can be `standard` or `instant`.
        public var method: String?
        /// If the payout reverses another, this is the ID of the original payout.
        @Expandable<Stripe.Payouts.Payout, String> public var originalPayout: String?
        /// ID of the v2 FinancialAccount the funds are sent to.
        public var payoutMethod: String?
        /// If `completed`, you can use the Balance Transactions API to list all balance transactions that are paid out in this.
        public var reconciliationStatus: ReconciliationStatus?
        /// If the payout reverses, this is the ID of the payout that reverses this payout.
        @Expandable<Stripe.Payouts.Payout, String> public var reversedBy: String?
        /// The source balance this payout came from, which can be one of the following: `card`, `fpx`, or `bank_account`.
        public var sourceType: String?
        /// Extra information about a payout that displays on the user's bank statement.
        public var statementDescriptor: String?
        /// Current status of the payout: `paid`, `pending`, `in_transit`, `canceled` or `failed`.
        public var status: String?
        /// A value that generates from the beneficiary's bank that allows users to track payouts with their bank.
        public var traceId: TraceId?
        /// Can be `bank_account` or `card`.
        public var `type`: Type?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            applicationFee: String? = nil,
            applicationFeeAmount: Int? = nil,
            arrivalDate: Date? = nil,
            automatic: Bool? = nil,
            balanceTransaction: String? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            destination: String? = nil,
            failureBalanceTransaction: String? = nil,
            failureCode: String? = nil,
            failureMessage: String? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            method: String? = nil,
            originalPayout: String? = nil,
            payoutMethod: String? = nil,
            reconciliationStatus: ReconciliationStatus? = nil,
            reversedBy: String? = nil,
            sourceType: String? = nil,
            statementDescriptor: String? = nil,
            status: String? = nil,
            traceId: TraceId? = nil,
            `type`: Type? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self._applicationFee = Expandable(id: applicationFee)
            self.applicationFeeAmount = applicationFeeAmount
            self.arrivalDate = arrivalDate
            self.automatic = automatic
            self._balanceTransaction = Expandable(id: balanceTransaction)
            self.created = created
            self.currency = currency
            self.description = description
            self._destination = Expandable(id: destination)
            self._failureBalanceTransaction = Expandable(id: failureBalanceTransaction)
            self.failureCode = failureCode
            self.failureMessage = failureMessage
            self.livemode = livemode
            self.metadata = metadata
            self.method = method
            self._originalPayout = Expandable(id: originalPayout)
            self.payoutMethod = payoutMethod
            self.reconciliationStatus = reconciliationStatus
            self._reversedBy = Expandable(id: reversedBy)
            self.sourceType = sourceType
            self.statementDescriptor = statementDescriptor
            self.status = status
            self.traceId = traceId
            self.`type` = `type`
        }

        /// If `completed`, you can use the Balance Transactions API to list all balance transactions that are paid out in this.
        public enum ReconciliationStatus: String, Codable, Hashable, Sendable {
            case completed
            case inProgress = "in_progress"
            case notApplicable = "not_applicable"
        }

        /// Can be `bank_account` or `card`.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case bankAccount = "bank_account"
            case card
        }

        public struct TraceId: Codable, Hashable, Sendable {
            /// Possible values are `pending`, `supported`, and `unsupported`.
            public var status: String?
            /// The trace ID value if `trace_id.status` is `supported`, otherwise `nil`.
            public var value: String?

            public init(
                status: String? = nil,
                value: String? = nil
            ) {
                self.status = status
                self.value = value
            }
        }
    }
}
