//
//  Billing Credit Balance Transaction.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/billing/credit-balance-transaction/object.md

/// The [Credit Balance Transaction Object](https://stripe.com/docs/api/billing/credit-balance-transaction/object) .

// The Transaction struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.Credit.Balance.Transaction` that the generator spells differently.

extension Stripe.Billing.Credit.Balance.Transaction {
    public struct Amount: Codable, Hashable, Sendable {
        /// Monetary amount details
        public var monetary: Monetary?
        /// The type of amount
        public var type: String?

        public init(
            monetary: Monetary? = nil,
            type: String? = nil
        ) {
            self.monetary = monetary
            self.type = type
        }

    }

    public struct Monetary: Codable, Hashable, Sendable {
        /// Three-letter ISO currency code, in lowercase
        public var currency: Stripe.Currency?
        /// The amount in the smallest currency unit (e.g., cents for USD)
        public var value: Int?

        public init(
            currency: Stripe.Currency? = nil,
            value: Int? = nil
        ) {
            self.currency = currency
            self.value = value
        }

    }

    public struct CreditsApplied: Codable, Hashable, Sendable {
        /// The ID of the invoice the credits were applied to
        public var invoice: Stripe.Billing.Invoice.ID?
        /// The ID of the invoice line item the credits were applied to
        public var invoiceLineItem: String?

        public init(
            invoice: Stripe.Billing.Invoice.ID? = nil,
            invoiceLineItem: String? = nil
        ) {
            self.invoice = invoice
            self.invoiceLineItem = invoiceLineItem
        }

    }
}

