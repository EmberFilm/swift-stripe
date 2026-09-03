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

extension Stripe {
    /// Options for customizing account balances and payout settings for a Stripe platform’s connected accounts.
    public struct BalanceSettings: Codable, Hashable, Sendable {
        /// String representing the object's type.
        public let object: String
        public var payments: Payments?

        public init(
            object: String,
            payments: Payments? = nil
        ) {
            self.object = object
            self.payments = payments
        }

        public struct Payments: Codable, Hashable, Sendable {
            /// A Boolean indicating if Stripe should try to reclaim negative balances from an attached bank account.
            public var debitNegativeBalances: Bool?
            /// Settings specific to the account's payouts.
            public var payouts: Payouts?
            public var settlementTiming: SettlementTiming?

            public init(
                debitNegativeBalances: Bool? = nil,
                payouts: Payouts? = nil,
                settlementTiming: SettlementTiming? = nil
            ) {
                self.debitNegativeBalances = debitNegativeBalances
                self.payouts = payouts
                self.settlementTiming = settlementTiming
            }

            public struct Payouts: Codable, Hashable, Sendable {
                /// Configures per-currency rules for automatically transferring funds from the payments balance to a FinancialAccount.
                public var automaticTransferRulesByCurrency: [String: [AutomaticTransferRulesByCurrency]]?
                /// The minimum balance amount to retain per currency after automatic payouts.
                public var minimumBalanceByCurrency: [String: Int]?
                /// Details on when funds from charges are available, and when they are paid out to an external account.
                public var schedule: Schedule?
                /// The text that appears on the bank account statement for payouts.
                public var statementDescriptor: String?
                /// Whether the funds in this account can be paid out.
                public var status: Status?

                public init(
                    automaticTransferRulesByCurrency: [String: [AutomaticTransferRulesByCurrency]]? = nil,
                    minimumBalanceByCurrency: [String: Int]? = nil,
                    schedule: Schedule? = nil,
                    statementDescriptor: String? = nil,
                    status: Status? = nil
                ) {
                    self.automaticTransferRulesByCurrency = automaticTransferRulesByCurrency
                    self.minimumBalanceByCurrency = minimumBalanceByCurrency
                    self.schedule = schedule
                    self.statementDescriptor = statementDescriptor
                    self.status = status
                }

                /// Whether the funds in this account can be paid out.
                public enum Status: String, Codable, Hashable, Sendable {
                    case disabled
                    case enabled
                }

                public struct AutomaticTransferRulesByCurrency: Codable, Hashable, Sendable {
                    /// The ID of the FinancialAccount that funds will be transferred to during automatic transfers.
                    public var payoutMethod: String?
                    /// The maximum amount in minor units to transfer to the FinancialAccount.
                    public var transferUpToAmount: Int?
                    /// The type of automatic transfer rule.
                    public var `type`: Type?

                    public init(
                        payoutMethod: String? = nil,
                        transferUpToAmount: Int? = nil,
                        `type`: Type? = nil
                    ) {
                        self.payoutMethod = payoutMethod
                        self.transferUpToAmount = transferUpToAmount
                        self.`type` = `type`
                    }

                    /// The type of automatic transfer rule.
                    public enum `Type`: String, Codable, Hashable, Sendable {
                        case transferAll = "transfer_all"
                        case transferUpToAmount = "transfer_up_to_amount"
                    }
                }

                public struct Schedule: Codable, Hashable, Sendable {
                    /// How frequently funds will be paid out.
                    public var interval: Interval?
                    /// The day of the month funds will be paid out.
                    public var monthlyPayoutDays: [Int]?
                    /// The days of the week when available funds are paid out, specified as an array, for example, [`monday`, `tuesday`].
                    public var weeklyPayoutDays: [WeeklyPayoutDays]?

                    public init(
                        interval: Interval? = nil,
                        monthlyPayoutDays: [Int]? = nil,
                        weeklyPayoutDays: [WeeklyPayoutDays]? = nil
                    ) {
                        self.interval = interval
                        self.monthlyPayoutDays = monthlyPayoutDays
                        self.weeklyPayoutDays = weeklyPayoutDays
                    }

                    /// How frequently funds will be paid out.
                    public enum Interval: String, Codable, Hashable, Sendable {
                        case daily
                        case manual
                        case monthly
                        case weekly
                    }

                    public enum WeeklyPayoutDays: String, Codable, Hashable, Sendable {
                        case friday
                        case monday
                        case thursday
                        case tuesday
                        case wednesday
                    }
                }
            }

            public struct SettlementTiming: Codable, Hashable, Sendable {
                /// The number of days charge funds are held before becoming available.
                public var delayDays: Int?
                /// The number of days charge funds are held before becoming available.
                public var delayDaysOverride: Int?
                /// Customized start of day configuration for automatic payouts to group and send payments in local timezones with a.
                public var startOfDay: StartOfDay?

                public init(
                    delayDays: Int? = nil,
                    delayDaysOverride: Int? = nil,
                    startOfDay: StartOfDay? = nil
                ) {
                    self.delayDays = delayDays
                    self.delayDaysOverride = delayDaysOverride
                    self.startOfDay = startOfDay
                }

                public struct StartOfDay: Codable, Hashable, Sendable {
                    /// Hour at which the customized start of day begins according to the given timezone.
                    public var hour: Int?
                    /// Minutes at which the customized start of day begins according to the given timezone.
                    public var minutes: Int?
                    /// Timezone for the customized start of day.
                    public var timezone: String?

                    public init(
                        hour: Int? = nil,
                        minutes: Int? = nil,
                        timezone: String? = nil
                    ) {
                        self.hour = hour
                        self.minutes = minutes
                        self.timezone = timezone
                    }
                }
            }
        }
    }
}
