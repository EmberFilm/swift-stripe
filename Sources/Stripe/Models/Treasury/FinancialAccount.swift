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
    /// Stripe Treasury for Platforms provides users with a container for money called a FinancialAccount that is separate.
    public struct FinancialAccount: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The array of paths to active Features in the Features hash.
        public var activeFeatures: [ActiveFeatures]?
        public var balance: Balance?
        /// Two-letter country code (ISO 3166-1 alpha-2).
        public var country: String?
        /// Time at which the object was created.
        public var created: Date?
        @Boxed public var features: Stripe.Treasury.FinancialAccountFeatures?
        /// The set of credentials that resolve to a FinancialAccount.
        public var financialAddresses: [FinancialAddresses]?
        public var isDefault: Bool?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The nickname for the FinancialAccount.
        public var nickname: String?
        /// The array of paths to pending Features in the Features hash.
        public var pendingFeatures: [PendingFeatures]?
        /// The set of functionalities that the platform can restrict on the FinancialAccount.
        public var platformRestrictions: PlatformRestrictions?
        /// The array of paths to restricted Features in the Features hash.
        public var restrictedFeatures: [RestrictedFeatures]?
        /// Status of this FinancialAccount.
        public var status: Status?
        public var statusDetails: StatusDetails?
        /// The currencies the FinancialAccount can hold a balance in.
        public var supportedCurrencies: [String]?

        public init(
            id: ID,
            object: String,
            activeFeatures: [ActiveFeatures]? = nil,
            balance: Balance? = nil,
            country: String? = nil,
            created: Date? = nil,
            features: Stripe.Treasury.FinancialAccountFeatures? = nil,
            financialAddresses: [FinancialAddresses]? = nil,
            isDefault: Bool? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            nickname: String? = nil,
            pendingFeatures: [PendingFeatures]? = nil,
            platformRestrictions: PlatformRestrictions? = nil,
            restrictedFeatures: [RestrictedFeatures]? = nil,
            status: Status? = nil,
            statusDetails: StatusDetails? = nil,
            supportedCurrencies: [String]? = nil
        ) {
            self.id = id
            self.object = object
            self.activeFeatures = activeFeatures
            self.balance = balance
            self.country = country
            self.created = created
            self._features = Boxed(wrappedValue: features)
            self.financialAddresses = financialAddresses
            self.isDefault = isDefault
            self.livemode = livemode
            self.metadata = metadata
            self.nickname = nickname
            self.pendingFeatures = pendingFeatures
            self.platformRestrictions = platformRestrictions
            self.restrictedFeatures = restrictedFeatures
            self.status = status
            self.statusDetails = statusDetails
            self.supportedCurrencies = supportedCurrencies
        }

        public enum ActiveFeatures: String, Codable, Hashable, Sendable {
            case cardIssuing = "card_issuing"
            case depositInsurance = "deposit_insurance"
            case financialAddressesAba = "financial_addresses.aba"
            case financialAddressesAbaForwarding = "financial_addresses.aba.forwarding"
            case inboundTransfersAch = "inbound_transfers.ach"
            case intraStripeFlows = "intra_stripe_flows"
            case outboundPaymentsAch = "outbound_payments.ach"
            case outboundPaymentsUsDomesticWire = "outbound_payments.us_domestic_wire"
            case outboundTransfersAch = "outbound_transfers.ach"
            case outboundTransfersUsDomesticWire = "outbound_transfers.us_domestic_wire"
            case remoteDepositCapture = "remote_deposit_capture"
        }

        public enum PendingFeatures: String, Codable, Hashable, Sendable {
            case cardIssuing = "card_issuing"
            case depositInsurance = "deposit_insurance"
            case financialAddressesAba = "financial_addresses.aba"
            case financialAddressesAbaForwarding = "financial_addresses.aba.forwarding"
            case inboundTransfersAch = "inbound_transfers.ach"
            case intraStripeFlows = "intra_stripe_flows"
            case outboundPaymentsAch = "outbound_payments.ach"
            case outboundPaymentsUsDomesticWire = "outbound_payments.us_domestic_wire"
            case outboundTransfersAch = "outbound_transfers.ach"
            case outboundTransfersUsDomesticWire = "outbound_transfers.us_domestic_wire"
            case remoteDepositCapture = "remote_deposit_capture"
        }

        public enum RestrictedFeatures: String, Codable, Hashable, Sendable {
            case cardIssuing = "card_issuing"
            case depositInsurance = "deposit_insurance"
            case financialAddressesAba = "financial_addresses.aba"
            case financialAddressesAbaForwarding = "financial_addresses.aba.forwarding"
            case inboundTransfersAch = "inbound_transfers.ach"
            case intraStripeFlows = "intra_stripe_flows"
            case outboundPaymentsAch = "outbound_payments.ach"
            case outboundPaymentsUsDomesticWire = "outbound_payments.us_domestic_wire"
            case outboundTransfersAch = "outbound_transfers.ach"
            case outboundTransfersUsDomesticWire = "outbound_transfers.us_domestic_wire"
            case remoteDepositCapture = "remote_deposit_capture"
        }

        /// Status of this FinancialAccount.
        public enum Status: String, Codable, Hashable, Sendable {
            case closed
            case open
        }

        /// Balance information for the FinancialAccount.
        public struct Balance: Codable, Hashable, Sendable {
            /// Funds the user can spend right now.
            public var cash: [String: Int]?
            /// Funds not spendable yet, but will become available at a later time.
            public var inboundPending: [String: Int]?
            /// Funds in the account, but not spendable because they are being held for pending outbound flows.
            public var outboundPending: [String: Int]?

            public init(
                cash: [String: Int]? = nil,
                inboundPending: [String: Int]? = nil,
                outboundPending: [String: Int]? = nil
            ) {
                self.cash = cash
                self.inboundPending = inboundPending
                self.outboundPending = outboundPending
            }
        }

        /// FinancialAddresses contain identifying information that resolves to a FinancialAccount.
        public struct FinancialAddresses: Codable, Hashable, Sendable {
            public var aba: Aba?
            /// The list of networks that the address supports.
            public var supportedNetworks: [SupportedNetworks]?
            /// The type of financial address.
            public var `type`: String?

            public init(
                aba: Aba? = nil,
                supportedNetworks: [SupportedNetworks]? = nil,
                `type`: String? = nil
            ) {
                self.aba = aba
                self.supportedNetworks = supportedNetworks
                self.`type` = `type`
            }

            public enum SupportedNetworks: String, Codable, Hashable, Sendable {
                case ach
                case usDomesticWire = "us_domestic_wire"
            }

            /// ABA Records contain U.S.
            public struct Aba: Codable, Hashable, Sendable {
                /// The name of the person or business that owns the bank account.
                public var accountHolderName: String?
                /// The account number.
                public var accountNumber: String?
                /// The last four characters of the account number.
                public var accountNumberLast4: String?
                /// Name of the bank.
                public var bankName: String?
                /// Routing number for the account.
                public var routingNumber: String?

                public init(
                    accountHolderName: String? = nil,
                    accountNumber: String? = nil,
                    accountNumberLast4: String? = nil,
                    bankName: String? = nil,
                    routingNumber: String? = nil
                ) {
                    self.accountHolderName = accountHolderName
                    self.accountNumber = accountNumber
                    self.accountNumberLast4 = accountNumberLast4
                    self.bankName = bankName
                    self.routingNumber = routingNumber
                }
            }
        }

        /// Restrictions that a Connect Platform has placed on this FinancialAccount.
        public struct PlatformRestrictions: Codable, Hashable, Sendable {
            /// Restricts all inbound money movement.
            public var inboundFlows: InboundFlows?
            /// Restricts all outbound money movement.
            public var outboundFlows: OutboundFlows?

            public init(
                inboundFlows: InboundFlows? = nil,
                outboundFlows: OutboundFlows? = nil
            ) {
                self.inboundFlows = inboundFlows
                self.outboundFlows = outboundFlows
            }

            /// Restricts all inbound money movement.
            public enum InboundFlows: String, Codable, Hashable, Sendable {
                case restricted
                case unrestricted
            }

            /// Restricts all outbound money movement.
            public enum OutboundFlows: String, Codable, Hashable, Sendable {
                case restricted
                case unrestricted
            }
        }

        public struct StatusDetails: Codable, Hashable, Sendable {
            /// Details related to the closure of this FinancialAccount.
            public var closed: Closed?

            public init(
                closed: Closed? = nil
            ) {
                self.closed = closed
            }

            public struct Closed: Codable, Hashable, Sendable {
                /// The array that contains reasons for a FinancialAccount closure.
                public var reasons: [Reasons]?

                public init(
                    reasons: [Reasons]? = nil
                ) {
                    self.reasons = reasons
                }

                public enum Reasons: String, Codable, Hashable, Sendable {
                    case accountRejected = "account_rejected"
                    case closedByPlatform = "closed_by_platform"
                    case other
                }
            }
        }
    }
}
