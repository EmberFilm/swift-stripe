//
//  Balance.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

// https://docs.stripe.com/api/balance/object.md

// The Balance struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Balance` that the generator spells differently.

extension Stripe.Balance {
    public struct Amount: Codable, Hashable, Sendable {
        /// Balance amount.
        public var amount: Int?
        /// Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies) .
        public var currency: Stripe.Currency?
        /// Breakdown of balance by source types.
        public var sourceTypes: Stripe.Balance.Amount.Source.`Type`?

        public init(
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            sourceTypes: Stripe.Balance.Amount.Source.`Type`? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.sourceTypes = sourceTypes
        }
    }
}

extension Stripe.Balance.Amount {
    public enum Source {}
}

extension Stripe.Balance.Amount.Source {
    public struct `Type`: Codable, Hashable, Sendable {
        /// Amount for bank account.
        public var bankAccount: Int?
        /// Amount for card.
        public var card: Int?
        /// Amount for FPX.
        public var fpx: Int?

        public init(
            bankAccount: Int? = nil,
            card: Int? = nil,
            fpx: Int? = nil
        ) {
            self.bankAccount = bankAccount
            self.card = card
            self.fpx = fpx
        }
    }
}
