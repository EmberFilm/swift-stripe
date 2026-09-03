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

extension FinancialConnections.Account {
    public enum Disconnect {}
    public enum List {}
    public enum ListOwners {}
    public enum Refresh {}
    public enum Retrieve {}
    public enum Subscribe {}
    public enum Unsubscribe {}
}

// POST /v1/financial_connections/accounts/{account}/disconnect
extension FinancialConnections.Account.Disconnect {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = FinancialConnections.Account
}

// GET /v1/financial_connections/accounts
extension FinancialConnections.Account.List {
    public struct Request: Codable, Hashable, Sendable {
        /// If present, only return accounts that belong to the specified account holder.
        public var accountHolder: AccountHolder?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// If present, only return accounts that were collected as part of the given session.
        public var session: String?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            accountHolder: AccountHolder? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            session: String? = nil,
            startingAfter: String? = nil
        ) {
            self.accountHolder = accountHolder
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.session = session
            self.startingAfter = startingAfter
        }

        /// If present, only return accounts that belong to the specified account holder.
        public struct AccountHolder: Codable, Hashable, Sendable {
            /// The ID of the Stripe account whose accounts you will retrieve.
            public var account: String?
            /// The ID of the Stripe customer whose accounts you will retrieve.
            public var customer: String?
            /// The ID of the Account representing a customer whose accounts you will retrieve.
            public var customerAccount: String?

            public init(
                account: String? = nil,
                customer: String? = nil,
                customerAccount: String? = nil
            ) {
                self.account = account
                self.customer = customer
                self.customerAccount = customerAccount
            }
        }
    }

    public typealias Response = Stripe.Page<FinancialConnections.Account>
}

// GET /v1/financial_connections/accounts/{account}/owners
extension FinancialConnections.Account.ListOwners {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// The ID of the ownership object to fetch owners from.
        public var ownership: String
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            ownership: String,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.ownership = ownership
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<FinancialConnections.AccountOwner>
}

// POST /v1/financial_connections/accounts/{account}/refresh
extension FinancialConnections.Account.Refresh {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The list of account features that you would like to refresh.
        public var features: [Features]

        public init(
            expand: [String]? = nil,
            features: [Features]
        ) {
            self.expand = expand
            self.features = features
        }

        public enum Features: String, Codable, Hashable, Sendable {
            case balance
            case ownership
            case transactions
        }
    }

    public typealias Response = FinancialConnections.Account
}

// GET /v1/financial_connections/accounts/{account}
extension FinancialConnections.Account.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = FinancialConnections.Account
}

// POST /v1/financial_connections/accounts/{account}/subscribe
extension FinancialConnections.Account.Subscribe {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The list of account features to which you would like to subscribe.
        public var features: [String]

        public init(
            expand: [String]? = nil,
            features: [String]
        ) {
            self.expand = expand
            self.features = features
        }
    }

    public typealias Response = FinancialConnections.Account
}

// POST /v1/financial_connections/accounts/{account}/unsubscribe
extension FinancialConnections.Account.Unsubscribe {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The list of account features from which you would like to unsubscribe.
        public var features: [String]

        public init(
            expand: [String]? = nil,
            features: [String]
        ) {
            self.expand = expand
            self.features = features
        }
    }

    public typealias Response = FinancialConnections.Account
}
