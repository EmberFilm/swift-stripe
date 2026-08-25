//
//  FundingInstructions.Retained.swift
//
//
//  Created by Andrew Edwards on 5/16/23.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/issuing/funding_instructions/object.md

public struct FundingInstructionsBankTransfer: Codable, Hashable, Sendable {
    /// The country of the bank account to fund
    public var country: String?
    /// A list of financial addresses that can be used to fund a particular balance
    public var financialAddresses: [FundingInstructionsBankTransferFinancialAddress]?
    /// The `bank_transfer` type
    public var type: FundingInstructionsBankTransferType?
}

public struct FundingInstructionsBankTransferFinancialAddress: Codable, Hashable, Sendable {
    /// An IBAN-based FinancialAddress
    public var iban: FundingInstructionsBankTransferFinancialAddressIban?
    /// An account number and sort code-based FinancialAddress
    public var sortCode: FundingInstructionsBankTransferFinancialAddressSortCode?
    /// The payment networks supported by this FinancialAddress
    public var supportedNetworks: [FundingInstructionsBankTransferFinancialAddressSupportedNetwork]?
    /// The type of financial address
    public var type: FundingInstructionsBankTransferFinancialAddressType?

    public init(
        iban: FundingInstructionsBankTransferFinancialAddressIban? = nil,
        sortCode: FundingInstructionsBankTransferFinancialAddressSortCode? = nil,
        supportedNetworks: [FundingInstructionsBankTransferFinancialAddressSupportedNetwork]? = nil,
        type: FundingInstructionsBankTransferFinancialAddressType? = nil
    ) {
        self.iban = iban
        self.sortCode = sortCode
        self.supportedNetworks = supportedNetworks
        self.type = type
    }
}

public enum FundingInstructionsBankTransferFinancialAddressType: String, Codable, Sendable {
    case iban
    case sortCode = "sort_code"
}

public struct FundingInstructionsBankTransferFinancialAddressIban: Codable, Hashable, Sendable {
    /// The name of the person or business that owns the bank account
    public var accountHolderName: String?
    /// The BIC/SWIFT code of the account.
    public var bic: String?
    /// Two-letter country code (ISO 3166-1 alpha-2).
    public var country: String?
    /// The IBAN of the account.
    public var iban: String?

    public init(
        accountHolderName: String? = nil,
        bic: String? = nil,
        country: String? = nil,
        iban: String? = nil
    ) {
        self.accountHolderName = accountHolderName
        self.bic = bic
        self.country = country
        self.iban = iban
    }
}

public struct FundingInstructionsBankTransferFinancialAddressSortCode: Codable, Hashable, Sendable {
    /// The name of the person or business that owns the bank account
    public var accountHolderName: String?
    /// The account number
    public var accountNumber: String?
    /// The six-digit sort code
    public var sortCode: String?

    public init(
        accountHolderName: String? = nil,
        accountNumber: String? = nil,
        sortCode: String? = nil
    ) {
        self.accountHolderName = accountHolderName
        self.accountNumber = accountNumber
        self.sortCode = sortCode
    }
}

public enum FundingInstructionsBankTransferFinancialAddressSupportedNetwork: String, Codable,
    Sendable
{
    case bacs
    case fps
    case sepa
}

public enum FundingInstructionsBankTransferType: String, Codable, Sendable {
    /// A  bank transfer to an EU bank account
    case euBankTransfer = "eu_bank_transfer"
    /// A bank transfer to a GB bank account
    case gbBankTransfer = "gb_bank_transfer"
}

public enum FundingInstructionsFundingType: String, Codable, Sendable {
    /// Use a `bank_transfer` hash to define the bank transfer type
    case bankTransfer = "bank_transfer"
}

public struct FundingInstructionsList: Codable, Hashable, Sendable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [FundingInstructions]?

    public init(
        object: String,
        hasMore: Bool? = nil,
        url: String? = nil,
        data: [FundingInstructions]? = nil
    ) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}

// The FundingInstructions struct is generated (Models/Generated). These are the nested types the
// request layer still names under `FundingInstructions` that the generator spells differently.

