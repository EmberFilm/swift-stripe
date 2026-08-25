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
extension Stripe.Billing.Credit.Balance {
    public struct Transaction: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String

        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// The credit portion of the transaction. Can be null.
        public var credit: Credit?
        /// The ID of the credit grant associated with this transaction.
        public var creditGrant: String?
        /// The debit portion of the transaction. Can be null.
        public var debit: Debit?
        /// The time when the credit balance transaction's effect becomes realized and impacts the credit balance.
        public var effectiveAt: Date?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// The ID of the test clock used to create this credit balance transaction.
        public var testClock: String?
        /// The type of transaction, either `credit` or `debit`.
        public var type: TransactionType?

        public init(
            id: ID,
            object: String,
            created: Date,
            credit: Credit? = nil,
            creditGrant: String? = nil,
            debit: Debit? = nil,
            effectiveAt: Date? = nil,
            livemode: Bool? = nil,
            testClock: String? = nil,
            type: TransactionType? = nil
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.credit = credit
            self.creditGrant = creditGrant
            self.debit = debit
            self.effectiveAt = effectiveAt
            self.livemode = livemode
            self.testClock = testClock
            self.type = type
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case created
            case credit
            case creditGrant
            case debit
            case effectiveAt
            case livemode
            case testClock
            case type
        }
    }

    public enum TransactionType: String, Codable, Sendable {
        case credit
        case debit
    }
}

extension Stripe.Billing.Credit.Balance.Transaction {
    public struct Credit: Codable, Hashable, Sendable {
        /// Amount details for the credit
        public var amount: Amount?

        public init(amount: Amount? = nil) {
            self.amount = amount
        }

        private enum CodingKeys: String, CodingKey {
            case amount
        }
    }

    public struct Debit: Codable, Hashable, Sendable {
        /// Amount details for the debit
        public var amount: Amount?
        /// Details about the credits applied
        public var creditsApplied: CreditsApplied?
        /// The type of debit
        public var type: DebitType?

        public init(
            amount: Amount? = nil,
            creditsApplied: CreditsApplied? = nil,
            type: DebitType? = nil
        ) {
            self.amount = amount
            self.creditsApplied = creditsApplied
            self.type = type
        }

        private enum CodingKeys: String, CodingKey {
            case amount
            case creditsApplied
            case type
        }
    }

    public enum DebitType: String, Codable, Sendable {
        case creditsApplied = "credits_applied"
    }
}

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

        private enum CodingKeys: String, CodingKey {
            case monetary
            case type
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

        private enum CodingKeys: String, CodingKey {
            case currency
            case value
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

        private enum CodingKeys: String, CodingKey {
            case invoice
            case invoiceLineItem
        }
    }
}

extension Stripe.Billing.Credit.Balance.Transaction {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var data: [Stripe.Billing.Credit.Balance.Transaction]?
        public var hasMore: Bool?
        public var url: String?

        public init(
            object: String,
            data: [Stripe.Billing.Credit.Balance.Transaction]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
        }

        private enum CodingKeys: String, CodingKey {
            case object
            case data
            case hasMore
            case url
        }
    }
}
