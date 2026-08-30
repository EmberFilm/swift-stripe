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

extension FinancialConnections {
    /// A Financial Connections Session is the secure way to programmatically launch the client-side Stripe.js modal that.
    public struct Session: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The account holder for whom accounts are collected in this session.
        public var accountHolder: Stripe.Shared.AccountHolder?
        /// The accounts that were collected as part of this Session.
        public var accounts: Accounts?
        @Boxed public var bankAccountToken: Stripe.Tokens.Token?
        /// A value that will be passed to the client to launch the authentication flow.
        public var clientSecret: String?
        public var filters: Filters?
        public var limits: Limits?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        public var manualEntry: ManualEntry?
        /// Permissions requested for accounts collected during this session.
        public var permissions: [Permissions]?
        /// Data features requested to be retrieved upon account creation.
        public var prefetch: [Prefetch]?
        /// For webview integrations only.
        public var returnUrl: String?

        public init(
            id: ID,
            object: String,
            accountHolder: Stripe.Shared.AccountHolder? = nil,
            accounts: Accounts? = nil,
            bankAccountToken: Stripe.Tokens.Token? = nil,
            clientSecret: String? = nil,
            filters: Filters? = nil,
            limits: Limits? = nil,
            livemode: Bool? = nil,
            manualEntry: ManualEntry? = nil,
            permissions: [Permissions]? = nil,
            prefetch: [Prefetch]? = nil,
            returnUrl: String? = nil
        ) {
            self.id = id
            self.object = object
            self.accountHolder = accountHolder
            self.accounts = accounts
            self._bankAccountToken = Boxed(wrappedValue: bankAccountToken)
            self.clientSecret = clientSecret
            self.filters = filters
            self.limits = limits
            self.livemode = livemode
            self.manualEntry = manualEntry
            self.permissions = permissions
            self.prefetch = prefetch
            self.returnUrl = returnUrl
        }

        public enum Permissions: String, Codable, Hashable, Sendable {
            case balances
            case ownership
            case paymentMethod = "payment_method"
            case transactions
        }

        public enum Prefetch: String, Codable, Hashable, Sendable {
            case balances
            case ownership
            case transactions
        }

        /// The accounts that were collected as part of this Session.
        public struct Accounts: Codable, Hashable, Sendable {
            /// String representing the object's type.
            public let object: String
            /// Details about each object.
            public var data: [FinancialConnections.Account]?
            /// True if this list has another page of items after this one that can be fetched.
            public var hasMore: Bool?
            /// The URL where this list can be accessed.
            public var url: String?

            public init(
                object: String,
                data: [FinancialConnections.Account]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil
            ) {
                self.object = object
                self.data = data
                self.hasMore = hasMore
                self.url = url
            }
        }

        public struct Filters: Codable, Hashable, Sendable {
            /// Restricts the Session to subcategories of accounts that can be linked.
            public var accountSubcategories: [AccountSubcategories]?
            /// List of countries from which to filter accounts.
            public var countries: [String]?
            /// Country from which to filter accounts.
            public var country: String?
            /// Whether the Session should require that linked accounts support payments and retrieve account numbers before.
            public var requirePaymentMethodSupport: RequirePaymentMethodSupport?

            public init(
                accountSubcategories: [AccountSubcategories]? = nil,
                countries: [String]? = nil,
                country: String? = nil,
                requirePaymentMethodSupport: RequirePaymentMethodSupport? = nil
            ) {
                self.accountSubcategories = accountSubcategories
                self.countries = countries
                self.country = country
                self.requirePaymentMethodSupport = requirePaymentMethodSupport
            }

            public enum AccountSubcategories: String, Codable, Hashable, Sendable {
                case checking
                case creditCard = "credit_card"
                case lineOfCredit = "line_of_credit"
                case mortgage
                case savings
            }

            /// Whether the Session should require that linked accounts support payments and retrieve account numbers before.
            public enum RequirePaymentMethodSupport: String, Codable, Hashable, Sendable {
                case all
                case atLeastOne = "at_least_one"
                case none
            }
        }

        public struct Limits: Codable, Hashable, Sendable {
            /// The number of accounts that can be linked in this Session.
            public var accounts: Int?

            public init(
                accounts: Int? = nil
            ) {
                self.accounts = accounts
            }
        }

        public struct ManualEntry: Codable, Hashable, Sendable {
            /// Controls how manual entry of bank account details is presented to the user.
            public var mode: Mode?

            public init(
                mode: Mode? = nil
            ) {
                self.mode = mode
            }

            /// Controls how manual entry of bank account details is presented to the user.
            public enum Mode: String, Codable, Hashable, Sendable {
                case automatic
                case disabled
            }
        }
    }
}
