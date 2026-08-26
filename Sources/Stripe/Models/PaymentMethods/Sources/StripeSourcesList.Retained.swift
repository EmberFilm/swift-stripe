//
//  Source.swift
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

// https://docs.stripe.com/api/sources/object.md














// The Source struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Source` that the generator spells differently.

// MARK: - Sources
















public struct StripeSourcesList: Codable, Hashable, Sendable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripePaymentSource]?
}

extension StripeSourcesList {
    public var bankAccounts: [BankAccount]? {
        return data?.compactMap { $0.bankAccount }
    }

    public var cards: [Card]? {
        return data?.compactMap { $0.card }
    }

    public var sources: [Source]? {
        return data?.compactMap { $0.source }
    }
}
