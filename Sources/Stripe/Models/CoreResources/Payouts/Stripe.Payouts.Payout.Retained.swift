//
//  Payout.swift
//  Async
//
//  Created by Andrew Edwards on 8/20/18.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The Payout struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Payouts.Payout` that the generator spells differently.


// https://docs.stripe.com/api/payouts/object.md


extension Stripe.Payouts.Payout {
    public enum FailureCode: String, Codable, Sendable {
        /// The bank account has been closed.
        case accountClosed = "account_closed"
        /// The bank account has been frozen.
        case accountFrozen = "account_frozen"
        /// The bank account has restrictions on either the type, or the number, of payouts allowed. This normally indicates that the bank account is a savings or other non-checking account.
        case bankAccountRestricted = "bank_account_restricted"
        /// The destination bank account is no longer valid because its branch has changed ownership.
        case bankOwnershipChanged = "bank_ownership_changed"
        /// The bank could not process this payout.
        case couldNotProcess = "could_not_process"
        /// Debit transactions are not approved on the bank account. (Stripe requires bank accounts to be set up for both credit and debit payouts.)
        case debitNotAuthorized = "debit_not_authorized"
        /// The bank has declined this transfer. Please contact the bank before retrying.
        case declined
        /// Your Stripe account has insufficient funds to cover the payout.
        case insufficientFunds = "insufficient_funds"
        /// The routing number seems correct, but the account number is invalid.
        case invalidAccountNumber = "invalid_account_number"
        /// Your bank notified us that the bank account holder name on file is incorrect.
        case incorrectAccountHolderName = "incorrect_account_holder_name"
        /// Your bank notified us that the bank account holder address on file is incorrect.
        case incorrectAccountHolderAddress = "incorrect_account_holder_address"
        /// Your bank notified us that the bank account holder tax ID on file is incorrect.
        case incorrectAccountHolderTaxId = "incorrect_account_holder_tax_id"
        /// The bank was unable to process this payout because of its currency. This is probably because the bank account cannot accept payments in that currency.
        case invalidCurrency = "invalid_currency"
        /// The bank account details on file are probably incorrect. No bank account could be located with those details.
        case noAccount = "no_account"
        /// The bank no longer supports payouts to this card.
        case unsupportedCard = "unsupported_card"
    }
}

extension Stripe.Payouts.Payout {
    public enum Method: String, Codable, Sendable {
        case standard
        case instant
    }
}


extension Stripe.Payouts.Payout {
    public enum SourceType: String, Codable, Sendable {
        case card
        case fpx
        case bankAccount = "bank_account"
    }
}

extension Stripe.Payouts.Payout {
    public enum Status: String, Codable, Sendable {
        case paid
        case pending
        case inTransit = "in_transit"
        case canceled
        case failed
    }
}

