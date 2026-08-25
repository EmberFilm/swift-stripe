//
//  Balance.TransactionItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/balanceTransactions/object.md

// The Transaction struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Balance.Transaction` that the generator spells differently.

extension Stripe.Balance.Transaction {
    public enum Fee {}
}

extension Stripe.Balance.Transaction.Fee {
    public struct Details: Codable, Hashable, Sendable {
        /// Amount of the fee, in cents.
        public var amount: Int?
        /// ID of the Connect application that earned the fee.
        public var application: String?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public var description: String?
        /// Type of the fee, one of: `application_fee`, `stripe_fee` or `tax`.
        public var type: Stripe.Balance.Transaction.Fee.Details.`Type`?

        public init(
            amount: Int? = nil,
            application: String? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            type: Stripe.Balance.Transaction.Fee.Details.`Type`? = nil
        ) {
            self.amount = amount
            self.application = application
            self.currency = currency
            self.description = description
            self.type = type
        }
    }
}

extension Stripe.Balance.Transaction.Fee.Details {
    public enum `Type`: String, Codable, Sendable {
        case applicationFee = "application_fee"
        case stripeFee = "stripe_fee"
        case tax
    }
}

extension Stripe.Balance.Transaction {
    public enum Status: String, Codable, Sendable {
        case available
        case pending
    }
}

