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
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Connect.Account.Session {
    public enum Create {}
}

// POST /v1/account_sessions
extension Stripe.Connect.Account.Session.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// The identifier of the account to create an Account Session for.
        public var account: String
        /// Each key of the dictionary represents an embedded component, and each embedded component maps to its configuration.
        public var components: Components
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            account: String,
            components: Components,
            expand: [String]? = nil
        ) {
            self.account = account
            self.components = components
            self.expand = expand
        }

        /// Each key of the dictionary represents an embedded component, and each embedded component maps to its configuration.
        public struct Components: Codable, Hashable, Sendable {
            /// Configuration for the account management embedded component.
            public var accountManagement: AccountManagement?
            /// Configuration for the account onboarding embedded component.
            public var accountOnboarding: AccountOnboarding?
            /// Configuration for the balance report embedded component.
            public var balanceReport: BalanceReport?
            /// Configuration for the balances embedded component.
            public var balances: Balances?
            /// Configuration for the disputes list embedded component.
            public var disputesList: DisputesList?
            /// Configuration for the documents embedded component.
            public var documents: Documents?
            /// Configuration for the financial account embedded component.
            public var financialAccount: FinancialAccount?
            /// Configuration for the financial account transactions embedded component.
            public var financialAccountTransactions: FinancialAccountTransactions?
            /// Configuration for the instant payouts promotion embedded component.
            public var instantPayoutsPromotion: InstantPayoutsPromotion?
            /// Configuration for the issuing card embedded component.
            public var issuingCard: IssuingCard?
            /// Configuration for the issuing cards list embedded component.
            public var issuingCardsList: IssuingCardsList?
            /// Configuration for the notification banner embedded component.
            public var notificationBanner: NotificationBanner?
            /// Configuration for the payment details embedded component.
            public var paymentDetails: PaymentDetails?
            /// Configuration for the payment disputes embedded component.
            public var paymentDisputes: PaymentDisputes?
            /// Configuration for the payment method settings embedded component.
            public var paymentMethodSettings: PaymentMethodSettings?
            /// Configuration for the payments embedded component.
            public var payments: Payments?
            /// Configuration for the payout details embedded component.
            public var payoutDetails: PayoutDetails?
            /// Configuration for the payout reconciliation report embedded component.
            public var payoutReconciliationReport: PayoutReconciliationReport?
            /// Configuration for the payouts embedded component.
            public var payouts: Payouts?
            /// Configuration for the payouts list embedded component.
            public var payoutsList: PayoutsList?
            /// Configuration for the tax registrations embedded component.
            public var taxRegistrations: TaxRegistrations?
            /// Configuration for the tax settings embedded component.
            public var taxSettings: TaxSettings?

            public init(
                accountManagement: AccountManagement? = nil,
                accountOnboarding: AccountOnboarding? = nil,
                balanceReport: BalanceReport? = nil,
                balances: Balances? = nil,
                disputesList: DisputesList? = nil,
                documents: Documents? = nil,
                financialAccount: FinancialAccount? = nil,
                financialAccountTransactions: FinancialAccountTransactions? = nil,
                instantPayoutsPromotion: InstantPayoutsPromotion? = nil,
                issuingCard: IssuingCard? = nil,
                issuingCardsList: IssuingCardsList? = nil,
                notificationBanner: NotificationBanner? = nil,
                paymentDetails: PaymentDetails? = nil,
                paymentDisputes: PaymentDisputes? = nil,
                paymentMethodSettings: PaymentMethodSettings? = nil,
                payments: Payments? = nil,
                payoutDetails: PayoutDetails? = nil,
                payoutReconciliationReport: PayoutReconciliationReport? = nil,
                payouts: Payouts? = nil,
                payoutsList: PayoutsList? = nil,
                taxRegistrations: TaxRegistrations? = nil,
                taxSettings: TaxSettings? = nil
            ) {
                self.accountManagement = accountManagement
                self.accountOnboarding = accountOnboarding
                self.balanceReport = balanceReport
                self.balances = balances
                self.disputesList = disputesList
                self.documents = documents
                self.financialAccount = financialAccount
                self.financialAccountTransactions = financialAccountTransactions
                self.instantPayoutsPromotion = instantPayoutsPromotion
                self.issuingCard = issuingCard
                self.issuingCardsList = issuingCardsList
                self.notificationBanner = notificationBanner
                self.paymentDetails = paymentDetails
                self.paymentDisputes = paymentDisputes
                self.paymentMethodSettings = paymentMethodSettings
                self.payments = payments
                self.payoutDetails = payoutDetails
                self.payoutReconciliationReport = payoutReconciliationReport
                self.payouts = payouts
                self.payoutsList = payoutsList
                self.taxRegistrations = taxRegistrations
                self.taxSettings = taxSettings
            }

            /// Configuration for the account management embedded component.
            public struct AccountManagement: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether Stripe user authentication is disabled.
                    public var disableStripeUserAuthentication: Bool?
                    /// Whether external account collection is enabled.
                    public var externalAccountCollection: Bool?

                    public init(
                        disableStripeUserAuthentication: Bool? = nil,
                        externalAccountCollection: Bool? = nil
                    ) {
                        self.disableStripeUserAuthentication = disableStripeUserAuthentication
                        self.externalAccountCollection = externalAccountCollection
                    }
                }
            }

            /// Configuration for the account onboarding embedded component.
            public struct AccountOnboarding: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether Stripe user authentication is disabled.
                    public var disableStripeUserAuthentication: Bool?
                    /// Whether external account collection is enabled.
                    public var externalAccountCollection: Bool?

                    public init(
                        disableStripeUserAuthentication: Bool? = nil,
                        externalAccountCollection: Bool? = nil
                    ) {
                        self.disableStripeUserAuthentication = disableStripeUserAuthentication
                        self.externalAccountCollection = externalAccountCollection
                    }
                }
            }

            /// Configuration for the balance report embedded component.
            public struct BalanceReport: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// An empty list, because this embedded component has no features.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// An empty list, because this embedded component has no features.
                public struct Features: Codable, Hashable, Sendable {
                    public init() {}
                }
            }

            /// Configuration for the balances embedded component.
            public struct Balances: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether Stripe user authentication is disabled.
                    public var disableStripeUserAuthentication: Bool?
                    /// Whether to allow payout schedule to be changed.
                    public var editPayoutSchedule: Bool?
                    /// Whether external account collection is enabled.
                    public var externalAccountCollection: Bool?
                    /// Whether instant payouts are enabled for this component.
                    public var instantPayouts: Bool?
                    /// Whether to allow creation of standard payouts.
                    public var standardPayouts: Bool?

                    public init(
                        disableStripeUserAuthentication: Bool? = nil,
                        editPayoutSchedule: Bool? = nil,
                        externalAccountCollection: Bool? = nil,
                        instantPayouts: Bool? = nil,
                        standardPayouts: Bool? = nil
                    ) {
                        self.disableStripeUserAuthentication = disableStripeUserAuthentication
                        self.editPayoutSchedule = editPayoutSchedule
                        self.externalAccountCollection = externalAccountCollection
                        self.instantPayouts = instantPayouts
                        self.standardPayouts = standardPayouts
                    }
                }
            }

            /// Configuration for the disputes list embedded component.
            public struct DisputesList: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether to allow capturing and cancelling payment intents.
                    public var capturePayments: Bool?
                    /// Whether connected accounts can manage destination charges that are created on behalf of them.
                    public var destinationOnBehalfOfChargeManagement: Bool?
                    /// Whether responding to disputes is enabled, including submitting evidence and accepting disputes.
                    public var disputeManagement: Bool?
                    /// Whether sending refunds is enabled.
                    public var refundManagement: Bool?
                    /// Whether to allow connected accounts to submit disputes using Smart Disputes.
                    public var smartDisputesManagement: Bool?

                    public init(
                        capturePayments: Bool? = nil,
                        destinationOnBehalfOfChargeManagement: Bool? = nil,
                        disputeManagement: Bool? = nil,
                        refundManagement: Bool? = nil,
                        smartDisputesManagement: Bool? = nil
                    ) {
                        self.capturePayments = capturePayments
                        self.destinationOnBehalfOfChargeManagement = destinationOnBehalfOfChargeManagement
                        self.disputeManagement = disputeManagement
                        self.refundManagement = refundManagement
                        self.smartDisputesManagement = smartDisputesManagement
                    }
                }
            }

            /// Configuration for the documents embedded component.
            public struct Documents: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// An empty list, because this embedded component has no features.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// An empty list, because this embedded component has no features.
                public struct Features: Codable, Hashable, Sendable {
                    public init() {}
                }
            }

            /// Configuration for the financial account embedded component.
            public struct FinancialAccount: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether Stripe user authentication is disabled.
                    public var disableStripeUserAuthentication: Bool?
                    /// Whether external account collection is enabled.
                    public var externalAccountCollection: Bool?
                    /// Whether to allow sending money.
                    public var sendMoney: Bool?
                    /// Whether to allow transferring balance.
                    public var transferBalance: Bool?

                    public init(
                        disableStripeUserAuthentication: Bool? = nil,
                        externalAccountCollection: Bool? = nil,
                        sendMoney: Bool? = nil,
                        transferBalance: Bool? = nil
                    ) {
                        self.disableStripeUserAuthentication = disableStripeUserAuthentication
                        self.externalAccountCollection = externalAccountCollection
                        self.sendMoney = sendMoney
                        self.transferBalance = transferBalance
                    }
                }
            }

            /// Configuration for the financial account transactions embedded component.
            public struct FinancialAccountTransactions: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether to allow card spend dispute management features.
                    public var cardSpendDisputeManagement: Bool?

                    public init(
                        cardSpendDisputeManagement: Bool? = nil
                    ) {
                        self.cardSpendDisputeManagement = cardSpendDisputeManagement
                    }
                }
            }

            /// Configuration for the instant payouts promotion embedded component.
            public struct InstantPayoutsPromotion: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether Stripe user authentication is disabled.
                    public var disableStripeUserAuthentication: Bool?
                    /// Whether external account collection is enabled.
                    public var externalAccountCollection: Bool?
                    /// Whether instant payouts are enabled for this component.
                    public var instantPayouts: Bool?

                    public init(
                        disableStripeUserAuthentication: Bool? = nil,
                        externalAccountCollection: Bool? = nil,
                        instantPayouts: Bool? = nil
                    ) {
                        self.disableStripeUserAuthentication = disableStripeUserAuthentication
                        self.externalAccountCollection = externalAccountCollection
                        self.instantPayouts = instantPayouts
                    }
                }
            }

            /// Configuration for the issuing card embedded component.
            public struct IssuingCard: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether to allow card management features.
                    public var cardManagement: Bool?
                    /// Whether to allow card spend dispute management features.
                    public var cardSpendDisputeManagement: Bool?
                    /// Whether to allow cardholder management features.
                    public var cardholderManagement: Bool?
                    /// Whether to allow spend control management features.
                    public var spendControlManagement: Bool?

                    public init(
                        cardManagement: Bool? = nil,
                        cardSpendDisputeManagement: Bool? = nil,
                        cardholderManagement: Bool? = nil,
                        spendControlManagement: Bool? = nil
                    ) {
                        self.cardManagement = cardManagement
                        self.cardSpendDisputeManagement = cardSpendDisputeManagement
                        self.cardholderManagement = cardholderManagement
                        self.spendControlManagement = spendControlManagement
                    }
                }
            }

            /// Configuration for the issuing cards list embedded component.
            public struct IssuingCardsList: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether to allow card management features.
                    public var cardManagement: Bool?
                    /// Whether to allow card spend dispute management features.
                    public var cardSpendDisputeManagement: Bool?
                    /// Whether to allow cardholder management features.
                    public var cardholderManagement: Bool?
                    /// Whether Stripe user authentication is disabled.
                    public var disableStripeUserAuthentication: Bool?
                    /// Whether to allow spend control management features.
                    public var spendControlManagement: Bool?

                    public init(
                        cardManagement: Bool? = nil,
                        cardSpendDisputeManagement: Bool? = nil,
                        cardholderManagement: Bool? = nil,
                        disableStripeUserAuthentication: Bool? = nil,
                        spendControlManagement: Bool? = nil
                    ) {
                        self.cardManagement = cardManagement
                        self.cardSpendDisputeManagement = cardSpendDisputeManagement
                        self.cardholderManagement = cardholderManagement
                        self.disableStripeUserAuthentication = disableStripeUserAuthentication
                        self.spendControlManagement = spendControlManagement
                    }
                }
            }

            /// Configuration for the notification banner embedded component.
            public struct NotificationBanner: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether Stripe user authentication is disabled.
                    public var disableStripeUserAuthentication: Bool?
                    /// Whether external account collection is enabled.
                    public var externalAccountCollection: Bool?

                    public init(
                        disableStripeUserAuthentication: Bool? = nil,
                        externalAccountCollection: Bool? = nil
                    ) {
                        self.disableStripeUserAuthentication = disableStripeUserAuthentication
                        self.externalAccountCollection = externalAccountCollection
                    }
                }
            }

            /// Configuration for the payment details embedded component.
            public struct PaymentDetails: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether to allow capturing and cancelling payment intents.
                    public var capturePayments: Bool?
                    /// Whether connected accounts can manage destination charges that are created on behalf of them.
                    public var destinationOnBehalfOfChargeManagement: Bool?
                    /// Whether responding to disputes is enabled, including submitting evidence and accepting disputes.
                    public var disputeManagement: Bool?
                    /// Whether sending refunds is enabled.
                    public var refundManagement: Bool?
                    /// Whether to allow connected accounts to submit disputes using Smart Disputes.
                    public var smartDisputesManagement: Bool?

                    public init(
                        capturePayments: Bool? = nil,
                        destinationOnBehalfOfChargeManagement: Bool? = nil,
                        disputeManagement: Bool? = nil,
                        refundManagement: Bool? = nil,
                        smartDisputesManagement: Bool? = nil
                    ) {
                        self.capturePayments = capturePayments
                        self.destinationOnBehalfOfChargeManagement = destinationOnBehalfOfChargeManagement
                        self.disputeManagement = disputeManagement
                        self.refundManagement = refundManagement
                        self.smartDisputesManagement = smartDisputesManagement
                    }
                }
            }

            /// Configuration for the payment disputes embedded component.
            public struct PaymentDisputes: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether connected accounts can manage destination charges that are created on behalf of them.
                    public var destinationOnBehalfOfChargeManagement: Bool?
                    /// Whether responding to disputes is enabled, including submitting evidence and accepting disputes.
                    public var disputeManagement: Bool?
                    /// Whether sending refunds is enabled.
                    public var refundManagement: Bool?
                    /// Whether to allow connected accounts to submit disputes using Smart Disputes.
                    public var smartDisputesManagement: Bool?

                    public init(
                        destinationOnBehalfOfChargeManagement: Bool? = nil,
                        disputeManagement: Bool? = nil,
                        refundManagement: Bool? = nil,
                        smartDisputesManagement: Bool? = nil
                    ) {
                        self.destinationOnBehalfOfChargeManagement = destinationOnBehalfOfChargeManagement
                        self.disputeManagement = disputeManagement
                        self.refundManagement = refundManagement
                        self.smartDisputesManagement = smartDisputesManagement
                    }
                }
            }

            /// Configuration for the payment method settings embedded component.
            public struct PaymentMethodSettings: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether Stripe user authentication is disabled.
                    public var disableStripeUserAuthentication: Bool?

                    public init(
                        disableStripeUserAuthentication: Bool? = nil
                    ) {
                        self.disableStripeUserAuthentication = disableStripeUserAuthentication
                    }
                }
            }

            /// Configuration for the payments embedded component.
            public struct Payments: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether to allow capturing and cancelling payment intents.
                    public var capturePayments: Bool?
                    /// Whether connected accounts can manage destination charges that are created on behalf of them.
                    public var destinationOnBehalfOfChargeManagement: Bool?
                    /// Whether responding to disputes is enabled, including submitting evidence and accepting disputes.
                    public var disputeManagement: Bool?
                    /// Whether sending refunds is enabled.
                    public var refundManagement: Bool?
                    /// Whether to allow connected accounts to submit disputes using Smart Disputes.
                    public var smartDisputesManagement: Bool?

                    public init(
                        capturePayments: Bool? = nil,
                        destinationOnBehalfOfChargeManagement: Bool? = nil,
                        disputeManagement: Bool? = nil,
                        refundManagement: Bool? = nil,
                        smartDisputesManagement: Bool? = nil
                    ) {
                        self.capturePayments = capturePayments
                        self.destinationOnBehalfOfChargeManagement = destinationOnBehalfOfChargeManagement
                        self.disputeManagement = disputeManagement
                        self.refundManagement = refundManagement
                        self.smartDisputesManagement = smartDisputesManagement
                    }
                }
            }

            /// Configuration for the payout details embedded component.
            public struct PayoutDetails: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// An empty list, because this embedded component has no features.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// An empty list, because this embedded component has no features.
                public struct Features: Codable, Hashable, Sendable {
                    public init() {}
                }
            }

            /// Configuration for the payout reconciliation report embedded component.
            public struct PayoutReconciliationReport: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// An empty list, because this embedded component has no features.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// An empty list, because this embedded component has no features.
                public struct Features: Codable, Hashable, Sendable {
                    public init() {}
                }
            }

            /// Configuration for the payouts embedded component.
            public struct Payouts: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// The list of features enabled in the embedded component.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// The list of features enabled in the embedded component.
                public struct Features: Codable, Hashable, Sendable {
                    /// Whether Stripe user authentication is disabled.
                    public var disableStripeUserAuthentication: Bool?
                    /// Whether to allow payout schedule to be changed.
                    public var editPayoutSchedule: Bool?
                    /// Whether external account collection is enabled.
                    public var externalAccountCollection: Bool?
                    /// Whether instant payouts are enabled for this component.
                    public var instantPayouts: Bool?
                    /// Whether to allow creation of standard payouts.
                    public var standardPayouts: Bool?

                    public init(
                        disableStripeUserAuthentication: Bool? = nil,
                        editPayoutSchedule: Bool? = nil,
                        externalAccountCollection: Bool? = nil,
                        instantPayouts: Bool? = nil,
                        standardPayouts: Bool? = nil
                    ) {
                        self.disableStripeUserAuthentication = disableStripeUserAuthentication
                        self.editPayoutSchedule = editPayoutSchedule
                        self.externalAccountCollection = externalAccountCollection
                        self.instantPayouts = instantPayouts
                        self.standardPayouts = standardPayouts
                    }
                }
            }

            /// Configuration for the payouts list embedded component.
            public struct PayoutsList: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// An empty list, because this embedded component has no features.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// An empty list, because this embedded component has no features.
                public struct Features: Codable, Hashable, Sendable {
                    public init() {}
                }
            }

            /// Configuration for the tax registrations embedded component.
            public struct TaxRegistrations: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// An empty list, because this embedded component has no features.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// An empty list, because this embedded component has no features.
                public struct Features: Codable, Hashable, Sendable {
                    public init() {}
                }
            }

            /// Configuration for the tax settings embedded component.
            public struct TaxSettings: Codable, Hashable, Sendable {
                /// Whether the embedded component is enabled.
                public var enabled: Bool
                /// An empty list, because this embedded component has no features.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// An empty list, because this embedded component has no features.
                public struct Features: Codable, Hashable, Sendable {
                    public init() {}
                }
            }
        }
    }

    public typealias Response = Stripe.Connect.Account.Session
}
