//
//  Card.Retained.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

// https://docs.stripe.com/api/cards/object.md

public enum CardValidationCheck: String, Codable, Sendable {
    case pass
    case fail
    case unavailable
    case unchecked
}

public enum CardBrand: String, Codable, Sendable {
    case americanExpress = "American Express"
    case dinersClub = "Diners Club"
    case discover = "Discover"
    case eftpos = "Eftpos"
    case australia = "Australia"
    case jcb = "JCB"
    case masterCard = "MasterCard"
    case unionPay = "UnionPay"
    case visa = "Visa"
    case unknown = "Unknown"
}

public enum CardFundingType: String, Codable, Sendable {
    case credit
    case debit
    case prepaid
    case unknown
}

public enum CardTokenizedMethod: String, Codable, Sendable {
    case androidPay = "android_pay"
    case applePay = "apple_pay"
    // REASON: Mirrors Stripe's documented `masterpass` wire value (Mastercard's Masterpass wallet brand).
    // swiftlint:disable:next inclusive_language
    case masterpass
    case visaCheckout = "visa_checkout"
}

public struct CardWallet: Codable, Hashable, Sendable {
    /// If this is an `apple_pay` card wallet, this hash contains details about the wallet.
    public var applePay: CardWalletApplePay?
    /// The type of the card wallet, one of `apple_pay`. An additional hash is included on the Wallet subhash with a name matching this value. It contains additional information specific to the card wallet type.
    public var type: String?

    public init(
        applePay: CardWalletApplePay? = nil,
        type: String? = nil
    ) {
        self.applePay = applePay
        self.type = type
    }
}

public struct CardWalletApplePay: Codable, Hashable, Sendable {
    public var type: String?

    public init(
        type: String? = nil
    ) {
        self.type = type
    }
}

public struct CardList: Codable, Hashable, Sendable {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /// An array of `Card`s associated with the account.
    public var data: [Card]?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?

    init(
        object: String,
        data: [Card]? = nil,
        hasMore: Bool? = nil,
        url: String? = nil
    ) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}

// The Card struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Card` that the generator spells differently.

