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

// https://docs.stripe.com/api/billing/credit-balance-summary/object.md

/// The [Credit Balance Summary Object](https://stripe.com/docs/api/billing/credit-balance-summary/object) .

// The Summary struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.Credit.Balance.Summary` that the generator spells differently.

extension Stripe.Billing.Credit.Balance.Summary {
    public struct Balance: Codable, Hashable, Sendable {
        /// The available balance that can be applied to new charges.
        public var availableBalance: BalanceAmount?
        /// The ledger balance, which includes pending transactions.
        public var ledgerBalance: BalanceAmount?

        public init(
            availableBalance: BalanceAmount? = nil,
            ledgerBalance: BalanceAmount? = nil
        ) {
            self.availableBalance = availableBalance
            self.ledgerBalance = ledgerBalance
        }

    }

    public struct BalanceAmount: Codable, Hashable, Sendable {
        /// Monetary amount details.
        public var monetary: Monetary?
        /// The type of amount.
        public var type: String?

        public init(
            monetary: Monetary? = nil,
            type: String? = nil
        ) {
            self.monetary = monetary
            self.type = type
        }

    }

    public struct Monetary: Codable, Hashable, Sendable {
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// The amount in the smallest currency unit (e.g., cents for USD).
        public var value: Int?

        public init(
            currency: Stripe.Currency? = nil,
            value: Int? = nil
        ) {
            self.currency = currency
            self.value = value
        }

    }
}

extension Stripe.Billing.Credit.Balance.Summary {
    public struct Filter: Codable, Hashable, Sendable {
        /// The type of filter.
        public var type: FilterType
        /// Applicability scope filter.
        public var applicabilityScope: ApplicabilityScope?
        /// Credit grant filter.
        public var creditGrant: String?

        public init(
            type: FilterType,
            applicabilityScope: ApplicabilityScope? = nil,
            creditGrant: String? = nil
        ) {
            self.type = type
            self.applicabilityScope = applicabilityScope
            self.creditGrant = creditGrant
        }

    }

    public enum FilterType: String, Codable, Sendable {
        case applicabilityScope = "applicability_scope"
        case creditGrant = "credit_grant"
    }

    public struct ApplicabilityScope: Codable, Hashable, Sendable {
        /// Price type filter.
        public var priceType: PriceType?
        /// List of price IDs to filter by.
        public var prices: [String]?

        public init(
            priceType: PriceType? = nil,
            prices: [String]? = nil
        ) {
            self.priceType = priceType
            self.prices = prices
        }

    }

    public enum PriceType: String, Codable, Sendable {
        case metered
    }
}
