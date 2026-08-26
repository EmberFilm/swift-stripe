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

extension Stripe.Customers.CustomerCashBalance {
    public enum Retrieve {}
    public enum Update {}
}

// GET /v1/customers/{customer}/cash_balance
extension Stripe.Customers.CustomerCashBalance.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Customers.CustomerCashBalance
}

// POST /v1/customers/{customer}/cash_balance
extension Stripe.Customers.CustomerCashBalance.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A hash of settings for this cash balance.
        public var settings: Settings?

        public init(
            expand: [String]? = nil,
            settings: Settings? = nil
        ) {
            self.expand = expand
            self.settings = settings
        }

        /// A hash of settings for this cash balance.
        public struct Settings: Codable, Hashable, Sendable {
            /// Controls how funds transferred by the customer are applied to payment intents and invoices.
            public var reconciliationMode: ReconciliationMode?

            public init(
                reconciliationMode: ReconciliationMode? = nil
            ) {
                self.reconciliationMode = reconciliationMode
            }

            public enum ReconciliationMode: String, Codable, Hashable, Sendable {
                case automatic
                case manual
                case merchantDefault = "merchant_default"
            }
        }
    }

    public typealias Response = Stripe.Customers.CustomerCashBalance
}
