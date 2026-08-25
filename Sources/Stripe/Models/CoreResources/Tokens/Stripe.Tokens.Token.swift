//
//  Token.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/23/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/tokens/object.md

/// The [Token Object](https://stripe.com/docs/api/tokens/object) .
extension Stripe.Tokens {
    public struct Token: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Hash describing the bank account.
        public var bankAccount: BankAccount?
        /// Hash describing the card used to make the charge.
        public var card: Card?
        /// IP address of the client that generated the token.
        public var clientIp: String?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// Type of the token: `account`, `bank_account`, `card`, or `pii`.
        public var type: Stripe.Tokens.Token.`Type`?
        /// Whether this token has already been used (tokens can be used only once).
        public var used: Bool?

        public init(
            id: ID,
            object: String,
            bankAccount: BankAccount? = nil,
            card: Card? = nil,
            clientIp: String? = nil,
            created: Date,
            livemode: Bool? = nil,
            type: Stripe.Tokens.Token.`Type`? = nil,
            used: Bool? = nil
        ) {
            self.id = id
            self.object = object
            self.bankAccount = bankAccount
            self.card = card
            self.clientIp = clientIp
            self.created = created
            self.livemode = livemode
            self.type = type
            self.used = used
        }
    }
}

extension Stripe.Tokens.Token {
    public enum `Type`: String, Codable, Sendable {
        case account
        case person
        case bankAccount = "bank_account"
        case card
        case cvcUpdate = "cvc_update"
        case pii
    }
}
