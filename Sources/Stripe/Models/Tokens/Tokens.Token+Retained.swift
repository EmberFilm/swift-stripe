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

// The Token struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Tokens.Token` that the generator spells differently.

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
