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

extension Stripe.Billing.Credit.Balance {
    /// Indicates the billing credit balance for billing credits granted to a customer.
    public struct Summary: Codable, Hashable, Sendable {
        /// String representing the object's type.
        public let object: String
        /// The billing credit balances.
        public var balances: [Balances]?
        /// The customer the balance is for.
        @Expandable<Stripe.Customers.Customer, String> public var customer: String?
        /// The account the balance is for.
        public var customerAccount: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?

        public init(
            object: String,
            balances: [Balances]? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            livemode: Bool? = nil
        ) {
            self.object = object
            self.balances = balances
            self._customer = Expandable(id: customer)
            self.customerAccount = customerAccount
            self.livemode = livemode
        }

        public struct Balances: Codable, Hashable, Sendable {
            public var availableBalance: Stripe.Shared.BillingCreditGrantsResourceAmount?
            public var ledgerBalance: Stripe.Shared.BillingCreditGrantsResourceAmount?

            public init(
                availableBalance: Stripe.Shared.BillingCreditGrantsResourceAmount? = nil,
                ledgerBalance: Stripe.Shared.BillingCreditGrantsResourceAmount? = nil
            ) {
                self.availableBalance = availableBalance
                self.ledgerBalance = ledgerBalance
            }
        }
    }
}
