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

extension Stripe.Treasury.ReceivedCredit {
    public enum Create {}
    public enum List {}
    public enum Retrieve {}
}

// POST /v1/test_helpers/treasury/received_credits
extension Stripe.Treasury.ReceivedCredit.Create {
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
        /// Initiating payment method details for the object.
        public var initiatingPaymentMethodDetails: InitiatingPaymentMethodDetails?
        /// Specifies the network rails to be used.
        public var network: Network

        public init(
            amount: Int,
            currency: Stripe.Currency,
            description: String? = nil,
            expand: [String]? = nil,
            financialAccount: String,
            initiatingPaymentMethodDetails: InitiatingPaymentMethodDetails? = nil,
            network: Network
        ) {
            self.amount = amount
            self.currency = currency
            self.description = description
            self.expand = expand
            self.financialAccount = financialAccount
            self.initiatingPaymentMethodDetails = initiatingPaymentMethodDetails
            self.network = network
        }

        public enum Network: String, Codable, Hashable, Sendable {
            case ach
            case usDomesticWire = "us_domestic_wire"
        }

        /// Initiating payment method details for the object.
        public struct InitiatingPaymentMethodDetails: Codable, Hashable, Sendable {
            /// The source type.
            public var `type`: String
            /// Optional fields for `us_bank_account`.
            public var usBankAccount: UsBankAccount?

            public init(
                `type`: String,
                usBankAccount: UsBankAccount? = nil
            ) {
                self.`type` = `type`
                self.usBankAccount = usBankAccount
            }

            /// Optional fields for `us_bank_account`.
            public struct UsBankAccount: Codable, Hashable, Sendable {
                /// The bank account holder's name.
                public var accountHolderName: String?
                /// The bank account number.
                public var accountNumber: String?
                /// The bank account's routing number.
                public var routingNumber: String?

                public init(
                    accountHolderName: String? = nil,
                    accountNumber: String? = nil,
                    routingNumber: String? = nil
                ) {
                    self.accountHolderName = accountHolderName
                    self.accountNumber = accountNumber
                    self.routingNumber = routingNumber
                }
            }
        }
    }

    public typealias Response = Stripe.Treasury.ReceivedCredit
}

// GET /v1/treasury/received_credits
extension Stripe.Treasury.ReceivedCredit.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The FinancialAccount that received the funds.
        public var financialAccount: String
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// Only return ReceivedCredits described by the flow.
        public var linkedFlows: LinkedFlows?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return ReceivedCredits that have the given status: `succeeded` or `failed`.
        public var status: Status?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            financialAccount: String,
            limit: Int? = nil,
            linkedFlows: LinkedFlows? = nil,
            startingAfter: String? = nil,
            status: Status? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.financialAccount = financialAccount
            self.limit = limit
            self.linkedFlows = linkedFlows
            self.startingAfter = startingAfter
            self.status = status
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case failed
            case succeeded
        }

        /// Only return ReceivedCredits described by the flow.
        public struct LinkedFlows: Codable, Hashable, Sendable {
            /// The source flow type.
            public var sourceFlowType: SourceFlowType

            public init(
                sourceFlowType: SourceFlowType
            ) {
                self.sourceFlowType = sourceFlowType
            }

            public enum SourceFlowType: String, Codable, Hashable, Sendable {
                case creditReversal = "credit_reversal"
                case other
                case outboundPayment = "outbound_payment"
                case outboundTransfer = "outbound_transfer"
                case payout
            }
        }
    }

    public typealias Response = Stripe.Page<Stripe.Treasury.ReceivedCredit>
}

// GET /v1/treasury/received_credits/{id}
extension Stripe.Treasury.ReceivedCredit.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Treasury.ReceivedCredit
}
