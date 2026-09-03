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
    /// ReceivedCredits represent funds sent to a FinancialAccount (for example, via ACH or wire).
    public struct ReceivedCredit: Codable, Hashable, Sendable, Identifiable {
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
        /// The FinancialAccount that received the funds.
        public var financialAccount: String?
        /// A hosted transaction receipt URL that is provided when money movement is considered regulated under Stripe's money.
        public var hostedRegulatoryReceiptUrl: String?
        public var initiatingPaymentMethodDetails: Stripe.Shared.InitiatingPaymentMethodDetails?
        public var linkedFlows: LinkedFlows?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// The rails used to send the funds.
        public var network: Network?
        /// Details describing when a ReceivedCredit may be reversed.
        public var reversalDetails: ReversalDetails?
        /// Status of the ReceivedCredit.
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
            case internationalTransaction = "international_transaction"
            case other
        }

        /// The rails used to send the funds.
        public enum Network: String, Codable, Hashable, Sendable {
            case ach
            case card
            case stripe
            case usDomesticWire = "us_domestic_wire"
        }

        /// Status of the ReceivedCredit.
        public enum Status: String, Codable, Hashable, Sendable {
            case failed
            case succeeded
        }

        public struct LinkedFlows: Codable, Hashable, Sendable {
            /// The CreditReversal created as a result of this ReceivedCredit being reversed.
            public var creditReversal: String?
            /// Set if the ReceivedCredit was created due to an Issuing Authorization object.
            public var issuingAuthorization: String?
            /// Set if the ReceivedCredit is also viewable as an Issuing transaction object.
            public var issuingTransaction: String?
            /// ID of the source flow.
            public var sourceFlow: String?
            /// The expandable object of the source flow.
            public var sourceFlowDetails: SourceFlowDetails?
            /// The type of flow that originated the ReceivedCredit (for example, `outbound_payment`).
            public var sourceFlowType: String?

            public init(
                creditReversal: String? = nil,
                issuingAuthorization: String? = nil,
                issuingTransaction: String? = nil,
                sourceFlow: String? = nil,
                sourceFlowDetails: SourceFlowDetails? = nil,
                sourceFlowType: String? = nil
            ) {
                self.creditReversal = creditReversal
                self.issuingAuthorization = issuingAuthorization
                self.issuingTransaction = issuingTransaction
                self.sourceFlow = sourceFlow
                self.sourceFlowDetails = sourceFlowDetails
                self.sourceFlowType = sourceFlowType
            }

            public struct SourceFlowDetails: Codable, Hashable, Sendable {
                /// The type of the source flow that originated the ReceivedCredit.
                public var `type`: Type?
                /// The payload `type` selects.
                public var details: Details

                fileprivate enum CodingKeys: String, CodingKey {
                    case `type`
                    case creditReversal
                    case outboundPayment
                    case outboundTransfer
                    case payout
                }

                public init(
                    `type`: Type? = nil,
                    details: Details
                ) {
                    self.`type` = `type`
                    self.details = details
                }

                public init(from decoder: any Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    self.`type` = try container.decodeIfPresent(Type.self, forKey: .`type`)
                    self.details = try Details(type: try container.decodeIfPresent(String.self, forKey: .type) ?? "", from: container)
                }

                public func encode(to encoder: any Encoder) throws {
                    var container = encoder.container(keyedBy: CodingKeys.self)
                    try container.encodeIfPresent(`type`, forKey: .`type`)
                    try details.encode(into: &container)
                }

                /// The type of the source flow that originated the ReceivedCredit.
                public enum `Type`: String, Codable, Hashable, Sendable {
                    case creditReversal = "credit_reversal"
                    case other
                    case outboundPayment = "outbound_payment"
                    case outboundTransfer = "outbound_transfer"
                    case payout
                }

                /// The payload `type` selects; `unknown` carries a type this package does not model.
                public indirect enum Details: Hashable, Sendable {
                    case creditReversal(Stripe.Treasury.CreditReversal)
                    case outboundPayment(Stripe.Treasury.OutboundPayment)
                    case outboundTransfer(Stripe.Treasury.OutboundTransfer)
                    case payout(Stripe.Payouts.Payout)
                    case other
                    case unknown(type: String)

                    public var creditReversal: Stripe.Treasury.CreditReversal? {
                        if case .creditReversal(let value) = self { return value }
                        return nil
                    }
                    public var outboundPayment: Stripe.Treasury.OutboundPayment? {
                        if case .outboundPayment(let value) = self { return value }
                        return nil
                    }
                    public var outboundTransfer: Stripe.Treasury.OutboundTransfer? {
                        if case .outboundTransfer(let value) = self { return value }
                        return nil
                    }
                    public var payout: Stripe.Payouts.Payout? {
                        if case .payout(let value) = self { return value }
                        return nil
                    }

                    fileprivate init(type: String, from container: KeyedDecodingContainer<CodingKeys>) throws {
                        switch type {
                        case "credit_reversal":
                            if let value = try container.decodeIfPresent(Stripe.Treasury.CreditReversal.self, forKey: .creditReversal) {
                                self = .creditReversal(value)
                            } else {
                                self = .unknown(type: type)
                            }
                        case "outbound_payment":
                            if let value = try container.decodeIfPresent(Stripe.Treasury.OutboundPayment.self, forKey: .outboundPayment) {
                                self = .outboundPayment(value)
                            } else {
                                self = .unknown(type: type)
                            }
                        case "outbound_transfer":
                            if let value = try container.decodeIfPresent(Stripe.Treasury.OutboundTransfer.self, forKey: .outboundTransfer) {
                                self = .outboundTransfer(value)
                            } else {
                                self = .unknown(type: type)
                            }
                        case "payout":
                            if let value = try container.decodeIfPresent(Stripe.Payouts.Payout.self, forKey: .payout) {
                                self = .payout(value)
                            } else {
                                self = .unknown(type: type)
                            }
                        case "other": self = .other
                        default: self = .unknown(type: type)
                        }
                    }

                    fileprivate func encode(into container: inout KeyedEncodingContainer<CodingKeys>) throws {
                        switch self {
                        case .creditReversal(let value): try container.encode(value, forKey: .creditReversal)
                        case .outboundPayment(let value): try container.encode(value, forKey: .outboundPayment)
                        case .outboundTransfer(let value): try container.encode(value, forKey: .outboundTransfer)
                        case .payout(let value): try container.encode(value, forKey: .payout)
                        default: break
                        }
                    }
                }
            }
        }

        public struct ReversalDetails: Codable, Hashable, Sendable {
            /// Time before which a ReceivedCredit can be reversed.
            public var deadline: Date?
            /// Set if a ReceivedCredit cannot be reversed.
            public var restrictedReason: RestrictedReason?

            public init(
                deadline: Date? = nil,
                restrictedReason: RestrictedReason? = nil
            ) {
                self.deadline = deadline
                self.restrictedReason = restrictedReason
            }

            /// Set if a ReceivedCredit cannot be reversed.
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
