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

extension Stripe.Billing.Credit.Balance {
    /// A credit balance transaction is a resource representing a transaction (either a credit or a debit) against an.
    public struct Transaction: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Time at which the object was created.
        public var created: Date?
        /// Credit details for this credit balance transaction.
        public var credit: Credit?
        /// The credit grant associated with this credit balance transaction.
        @Expandable<Stripe.Billing.Credit.Grant, String> public var creditGrant: String?
        /// Debit details for this credit balance transaction.
        public var debit: Debit?
        /// The effective time of this credit balance transaction.
        public var effectiveAt: Date?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// ID of the test clock this credit balance transaction belongs to.
        @Expandable<Stripe.Billing.TestClocks.TestClock, String> public var testClock: String?
        /// The type of credit balance transaction (credit or debit).
        public var `type`: Type?

        public init(
            id: ID,
            object: String,
            created: Date? = nil,
            credit: Credit? = nil,
            creditGrant: String? = nil,
            debit: Debit? = nil,
            effectiveAt: Date? = nil,
            livemode: Bool? = nil,
            testClock: String? = nil,
            `type`: Type? = nil
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.credit = credit
            self._creditGrant = Expandable(id: creditGrant)
            self.debit = debit
            self.effectiveAt = effectiveAt
            self.livemode = livemode
            self._testClock = Expandable(id: testClock)
            self.`type` = `type`
        }

        /// The type of credit balance transaction (credit or debit).
        public enum `Type`: String, Codable, Hashable, Sendable {
            case credit
            case debit
        }

        public struct Credit: Codable, Hashable, Sendable {
            public var amount: Stripe.Shared.BillingCreditGrantsResourceAmount?
            /// Details of the invoice to which the reinstated credits were originally applied.
            public var creditsApplicationInvoiceVoided: CreditsApplicationInvoiceVoided?
            /// The type of credit transaction.
            public var `type`: Type?

            public init(
                amount: Stripe.Shared.BillingCreditGrantsResourceAmount? = nil,
                creditsApplicationInvoiceVoided: CreditsApplicationInvoiceVoided? = nil,
                `type`: Type? = nil
            ) {
                self.amount = amount
                self.creditsApplicationInvoiceVoided = creditsApplicationInvoiceVoided
                self.`type` = `type`
            }

            /// The type of credit transaction.
            public enum `Type`: String, Codable, Hashable, Sendable {
                case creditsApplicationInvoiceVoided = "credits_application_invoice_voided"
                case creditsGranted = "credits_granted"
            }

            public struct CreditsApplicationInvoiceVoided: Codable, Hashable, Sendable {
                /// The invoice to which the reinstated billing credits were originally applied.
                @Expandable<Stripe.Billing.Invoice, String> public var invoice: String?
                /// The invoice line item to which the reinstated billing credits were originally applied.
                public var invoiceLineItem: String?

                public init(
                    invoice: String? = nil,
                    invoiceLineItem: String? = nil
                ) {
                    self._invoice = Expandable(id: invoice)
                    self.invoiceLineItem = invoiceLineItem
                }
            }
        }

        public struct Debit: Codable, Hashable, Sendable {
            public var amount: Stripe.Shared.BillingCreditGrantsResourceAmount?
            /// Details of how the billing credits were applied to an invoice.
            public var creditsApplied: CreditsApplied?
            /// The type of debit transaction.
            public var `type`: Type?

            public init(
                amount: Stripe.Shared.BillingCreditGrantsResourceAmount? = nil,
                creditsApplied: CreditsApplied? = nil,
                `type`: Type? = nil
            ) {
                self.amount = amount
                self.creditsApplied = creditsApplied
                self.`type` = `type`
            }

            /// The type of debit transaction.
            public enum `Type`: String, Codable, Hashable, Sendable {
                case creditsApplied = "credits_applied"
                case creditsExpired = "credits_expired"
                case creditsVoided = "credits_voided"
            }

            public struct CreditsApplied: Codable, Hashable, Sendable {
                /// The invoice to which the billing credits were applied.
                @Expandable<Stripe.Billing.Invoice, String> public var invoice: String?
                /// The invoice line item to which the billing credits were applied.
                public var invoiceLineItem: String?

                public init(
                    invoice: String? = nil,
                    invoiceLineItem: String? = nil
                ) {
                    self._invoice = Expandable(id: invoice)
                    self.invoiceLineItem = invoiceLineItem
                }
            }
        }
    }
}
