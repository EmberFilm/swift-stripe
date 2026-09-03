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

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Each customer has a `balance` that is automatically applied to future invoices and payments using the.
public struct FundingInstructions: Codable, Hashable, Sendable {
    /// String representing the object's type.
    public let object: String
    public var bankTransfer: BankTransfer?
    /// Three-letter ISO currency code, in lowercase.
    public var currency: String?
    /// The `funding_type` of the returned instructions.
    public var fundingType: String?
    /// If the object exists in live mode, the value is `true`.
    public var livemode: Bool?

    public init(
        object: String,
        bankTransfer: BankTransfer? = nil,
        currency: String? = nil,
        fundingType: String? = nil,
        livemode: Bool? = nil
    ) {
        self.object = object
        self.bankTransfer = bankTransfer
        self.currency = currency
        self.fundingType = fundingType
        self.livemode = livemode
    }

    public struct BankTransfer: Codable, Hashable, Sendable {
        /// The country of the bank account to fund.
        public var country: String?
        /// A list of financial addresses that can be used to fund a particular balance.
        public var financialAddresses: [Stripe.Shared.FinancialAddresses]?
        /// The bank_transfer type.
        public var `type`: Type?

        public init(
            country: String? = nil,
            financialAddresses: [Stripe.Shared.FinancialAddresses]? = nil,
            `type`: Type? = nil
        ) {
            self.country = country
            self.financialAddresses = financialAddresses
            self.`type` = `type`
        }

        /// The bank_transfer type.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case euBankTransfer = "eu_bank_transfer"
            case jpBankTransfer = "jp_bank_transfer"
        }
    }
}
