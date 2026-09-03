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

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/disputes/object.md

/// The [Dispute Object](https://stripe.com/docs/api/disputes/object).

// The Dispute struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Disputes.Dispute` that the generator spells differently.

extension Stripe.Disputes.Dispute {

    public enum Reason: String, Codable, Sendable {
        case bankCannotProcess = "bank_cannot_process"
        case checkReturned = "check_returned"
        case creditNotProcessed = "credit_not_processed"
        case customerInitiated = "customer_initiated"
        case debitNotAuthorized = "debit_not_authorized"
        case duplicate
        case fraudulent
        case general
        case incorrectAccountDetails = "incorrect_account_details"
        case insufficientFunds = "insufficient_funds"
        case productNotReceived = "product_not_received"
        case productUnacceptable = "product_unacceptable"
        case subscriptionCanceled = "subscription_canceled"
        case unrecognized
    }
}
