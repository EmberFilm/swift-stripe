//
//  Transfer.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/2/18.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The Transfer struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.Transfer` that the generator spells differently.


// https://docs.stripe.com/api/transfers/object.md

extension Stripe.Connect.Transfer {
    public enum SourceType: String, Codable, Sendable {
        case card
        case fpx
        case bankAccount = "bank_account"
    }
}

