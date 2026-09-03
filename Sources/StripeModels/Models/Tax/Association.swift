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

extension Stripe.Tax {
    /// A Tax Association exposes the Tax Transactions that Stripe attempted to create on your behalf based on the.
    public struct Association: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The Tax Calculation that was included in PaymentIntent.
        public var calculation: String?
        /// The PaymentIntent that this Tax Association is tracking.
        public var paymentIntent: String?
        /// Information about the tax transactions linked to this payment intent.
        public var taxTransactionAttempts: [TaxTransactionAttempts]?

        public init(
            id: ID,
            object: String,
            calculation: String? = nil,
            paymentIntent: String? = nil,
            taxTransactionAttempts: [TaxTransactionAttempts]? = nil
        ) {
            self.id = id
            self.object = object
            self.calculation = calculation
            self.paymentIntent = paymentIntent
            self.taxTransactionAttempts = taxTransactionAttempts
        }

        public struct TaxTransactionAttempts: Codable, Hashable, Sendable {
            public var committed: Committed?
            public var errored: Errored?
            /// The source of the tax transaction attempt.
            public var source: String?
            /// The status of the transaction attempt.
            public var status: String?

            public init(
                committed: Committed? = nil,
                errored: Errored? = nil,
                source: String? = nil,
                status: String? = nil
            ) {
                self.committed = committed
                self.errored = errored
                self.source = source
                self.status = status
            }

            public struct Committed: Codable, Hashable, Sendable {
                /// The Tax Transaction.
                public var transaction: String?

                public init(
                    transaction: String? = nil
                ) {
                    self.transaction = transaction
                }
            }

            public struct Errored: Codable, Hashable, Sendable {
                /// Details on why we couldn't commit the tax transaction.
                public var reason: Reason?

                public init(
                    reason: Reason? = nil
                ) {
                    self.reason = reason
                }

                /// Details on why we couldn't commit the tax transaction.
                public enum Reason: String, Codable, Hashable, Sendable {
                    case anotherPaymentAssociatedWithCalculation = "another_payment_associated_with_calculation"
                    case calculationExpired = "calculation_expired"
                    case currencyMismatch = "currency_mismatch"
                    case originalTransactionVoided = "original_transaction_voided"
                    case uniqueReferenceViolation = "unique_reference_violation"
                }
            }
        }
    }
}
