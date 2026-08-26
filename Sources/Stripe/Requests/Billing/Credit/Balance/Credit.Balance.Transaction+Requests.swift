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

extension Stripe.Billing.Credit.Balance.Transaction {
    public enum List {}
    public enum Retrieve {}
}

// GET /v1/billing/credit_balance_transactions
extension Stripe.Billing.Credit.Balance.Transaction.List {
    public struct Request: Codable, Hashable, Sendable {
        /// The credit grant for which to fetch credit balance transactions.
        public var creditGrant: String?
        /// The customer whose credit balance transactions you're retrieving.
        public var customer: String?
        /// The account representing the customer whose credit balance transactions you're retrieving.
        public var customerAccount: String?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            creditGrant: String? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.creditGrant = creditGrant
            self.customer = customer
            self.customerAccount = customerAccount
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Stripe.Billing.Credit.Balance.Transaction>
}

// GET /v1/billing/credit_balance_transactions/{id}
extension Stripe.Billing.Credit.Balance.Transaction.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Credit.Balance.Transaction
}
