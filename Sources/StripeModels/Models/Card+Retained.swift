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
    /// The type of the card wallet, one of `apple_pay`.
    ///
    /// An additional hash is included on the Wallet subhash with a name matching this value. It
    /// contains additional information specific to the card wallet type.
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
