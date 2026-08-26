//
//  Transaction.Retained.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/issuing/transactions/object.md



public enum TransactionType: String, Codable, Sendable {
    /// Funds were captured by the acquirer. `amount` will be negative as funds are moving out of your balance. Not all captures will be linked to an authorization, as acquirers can force capture in some cases.
    case capture
    /// An acquirer initiated a refund. This transaction might not be linked to an original capture, for example credits are original transactions. `amount` will be positive for refunds and negative for refund reversals.
    case refund
}






