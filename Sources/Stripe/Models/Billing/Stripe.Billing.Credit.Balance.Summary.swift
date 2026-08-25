//
//  Billing Credit Balance Summary.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/billing/credit-balance-summary/object.md

/// The [Credit Balance Summary Object](https://stripe.com/docs/api/billing/credit-balance-summary/object) .
extension Stripe.Billing.Credit.Balance {
    public struct Summary: Codable, Hashable, Sendable {
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// The credit balance summary information
        public var balances: [Balance]?
        /// The ID of the customer for whom the credit balance summary is retrieved
        public var customer: Stripe.Customers.Customer.ID?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?

        public init(
            object: String,
            balances: [Balance]? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            livemode: Bool? = nil
        ) {
            self.object = object
            self.balances = balances
            self.customer = customer
            self.livemode = livemode
        }

        private enum CodingKeys: String, CodingKey {
            case object
            case balances
            case customer
            case livemode
        }
    }
}

extension Stripe.Billing.Credit.Balance.Summary {
    public struct Balance: Codable, Hashable, Sendable {
        /// The available balance that can be applied to new charges
        public var availableBalance: BalanceAmount?
        /// The ledger balance, which includes pending transactions
        public var ledgerBalance: BalanceAmount?

        public init(
            availableBalance: BalanceAmount? = nil,
            ledgerBalance: BalanceAmount? = nil
        ) {
            self.availableBalance = availableBalance
            self.ledgerBalance = ledgerBalance
        }

        private enum CodingKeys: String, CodingKey {
            case availableBalance
            case ledgerBalance
        }
    }

    public struct BalanceAmount: Codable, Hashable, Sendable {
        /// Monetary amount details
        public var monetary: Monetary?
        /// The type of amount
        public var type: String?

        public init(
            monetary: Monetary? = nil,
            type: String? = nil
        ) {
            self.monetary = monetary
            self.type = type
        }

        private enum CodingKeys: String, CodingKey {
            case monetary
            case type
        }
    }

    public struct Monetary: Codable, Hashable, Sendable {
        /// Three-letter ISO currency code, in lowercase
        public var currency: Stripe.Currency?
        /// The amount in the smallest currency unit (e.g., cents for USD)
        public var value: Int?

        public init(
            currency: Stripe.Currency? = nil,
            value: Int? = nil
        ) {
            self.currency = currency
            self.value = value
        }

        private enum CodingKeys: String, CodingKey {
            case currency
            case value
        }
    }
}

extension Stripe.Billing.Credit.Balance.Summary {
    public struct Filter: Codable, Hashable, Sendable {
        /// The type of filter
        public var type: FilterType
        /// Applicability scope filter
        public var applicabilityScope: ApplicabilityScope?
        /// Credit grant filter
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

        private enum CodingKeys: String, CodingKey {
            case type
            case applicabilityScope
            case creditGrant
        }
    }

    public enum FilterType: String, Codable, Sendable {
        case applicabilityScope = "applicability_scope"
        case creditGrant = "credit_grant"
    }

    public struct ApplicabilityScope: Codable, Hashable, Sendable {
        /// Price type filter
        public var priceType: PriceType?
        /// List of price IDs to filter by
        public var prices: [String]?

        public init(
            priceType: PriceType? = nil,
            prices: [String]? = nil
        ) {
            self.priceType = priceType
            self.prices = prices
        }

        private enum CodingKeys: String, CodingKey {
            case priceType
            case prices
        }
    }

    public enum PriceType: String, Codable, Sendable {
        case metered
    }
}
