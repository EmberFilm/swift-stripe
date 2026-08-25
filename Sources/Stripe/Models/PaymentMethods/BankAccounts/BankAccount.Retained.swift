//
//  BankAccount.Retained.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/12/17.
//
//

// https://docs.stripe.com/api/bank_accounts/object.md

public enum BankAccountStatus: String, Codable, Sendable {
    case new
    case validated
    case verified
    case verificationFailed = "verification_failed"
    case errored
}

public enum BankAccountHolderType: String, Codable, Sendable {
    case individual
    case company
}

public struct BankAccountList: Codable, Hashable, Sendable {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /// An array of `StripeCard`s associated with the account.
    public var data: [BankAccount]?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?

    public init(
        object: String,
        data: [BankAccount]? = nil,
        hasMore: Bool? = nil,
        url: String? = nil
    ) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}

// The BankAccount struct is generated (Models/Generated). These are the nested types the
// request layer still names under `BankAccount` that the generator spells differently.

