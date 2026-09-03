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

import StripeCore
import StripeIssuing
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Treasury.InboundTransfer {
    public enum Cancel {}
    public enum Create {}
    public enum Fail {}
    public enum List {}
    public enum Retrieve {}
    public enum ReturnInboundTransfer {}
    public enum Succeed {}
}

// POST /v1/treasury/inbound_transfers/{inbound_transfer}/cancel
extension Stripe.Treasury.InboundTransfer.Cancel {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Treasury.InboundTransfer
}

// POST /v1/treasury/inbound_transfers
extension Stripe.Treasury.InboundTransfer.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Amount (in cents) to be transferred.
        public var amount: Int
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency
        /// An arbitrary string attached to the object.
        public var description: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The FinancialAccount to send funds to.
        public var financialAccount: String
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The origin payment method to be debited for the InboundTransfer.
        public var originPaymentMethod: String
        /// The complete description that appears on your customers' statements.
        public var statementDescriptor: String?

        public init(
            amount: Int,
            currency: Stripe.Currency,
            description: String? = nil,
            expand: [String]? = nil,
            financialAccount: String,
            metadata: [String: String]? = nil,
            originPaymentMethod: String,
            statementDescriptor: String? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.description = description
            self.expand = expand
            self.financialAccount = financialAccount
            self.metadata = metadata
            self.originPaymentMethod = originPaymentMethod
            self.statementDescriptor = statementDescriptor
        }
    }

    public typealias Response = Stripe.Treasury.InboundTransfer
}

// POST /v1/test_helpers/treasury/inbound_transfers/{id}/fail
extension Stripe.Treasury.InboundTransfer.Fail {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Details about a failed InboundTransfer.
        public var failureDetails: FailureDetails?

        public init(
            expand: [String]? = nil,
            failureDetails: FailureDetails? = nil
        ) {
            self.expand = expand
            self.failureDetails = failureDetails
        }

        /// Details about a failed InboundTransfer.
        public struct FailureDetails: Codable, Hashable, Sendable {
            /// Reason for the failure.
            public var code: Code?

            public init(
                code: Code? = nil
            ) {
                self.code = code
            }

            public enum Code: String, Codable, Hashable, Sendable {
                case accountClosed = "account_closed"
                case accountFrozen = "account_frozen"
                case bankAccountRestricted = "bank_account_restricted"
                case bankOwnershipChanged = "bank_ownership_changed"
                case debitNotAuthorized = "debit_not_authorized"
                case incorrectAccountHolderAddress = "incorrect_account_holder_address"
                case incorrectAccountHolderName = "incorrect_account_holder_name"
                case incorrectAccountHolderTaxId = "incorrect_account_holder_tax_id"
                case insufficientFunds = "insufficient_funds"
                case invalidAccountNumber = "invalid_account_number"
                case invalidCurrency = "invalid_currency"
                case noAccount = "no_account"
                case other
            }
        }
    }

    public typealias Response = Stripe.Treasury.InboundTransfer
}

// GET /v1/treasury/inbound_transfers
extension Stripe.Treasury.InboundTransfer.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Returns objects associated with this FinancialAccount.
        public var financialAccount: String
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return InboundTransfers that have the given status: `processing`, `succeeded`, `failed` or `canceled`.
        public var status: Status?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            financialAccount: String,
            limit: Int? = nil,
            startingAfter: String? = nil,
            status: Status? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.financialAccount = financialAccount
            self.limit = limit
            self.startingAfter = startingAfter
            self.status = status
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case canceled
            case failed
            case processing
            case succeeded
        }
    }

    public typealias Response = Stripe.Page<Stripe.Treasury.InboundTransfer>
}

// GET /v1/treasury/inbound_transfers/{id}
extension Stripe.Treasury.InboundTransfer.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Treasury.InboundTransfer
}

// POST /v1/test_helpers/treasury/inbound_transfers/{id}/return
extension Stripe.Treasury.InboundTransfer.ReturnInboundTransfer {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Treasury.InboundTransfer
}

// POST /v1/test_helpers/treasury/inbound_transfers/{id}/succeed
extension Stripe.Treasury.InboundTransfer.Succeed {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Treasury.InboundTransfer
}
