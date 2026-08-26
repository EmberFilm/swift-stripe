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

// https://docs.stripe.com/api/invoices/object.md

/// The [Invoice Object](https://stripe.com/docs/api/invoices/object) .

// The Invoice struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.Invoice` that the generator spells differently.

extension Stripe.Billing.Subscription {
    public struct Details: Codable, Hashable, Sendable {
        /// Set of key-value pairs that you can attach to an object.
        ///
        /// This can be useful for storing additional information about the object in a structured
        /// format.
        public var metadata: [String: String]?

        public init(
            metadata: [String: String]? = nil
        ) {
            self.metadata = metadata
        }
    }
}

extension Stripe.Billing.Invoice {
    public enum Reason: String, Codable, Sendable {
        case subscriptionCycle = "subscription_cycle"
        case subscriptionCreate = "subscription_create"
        case subscriptionUpdate = "subscription_update"
        case subscription
        case manual
        case upcoming
        case subscriptionThreshold = "subscription_threshold"
    }
}

extension Stripe.Billing.Invoice {
    public struct CustomField: Codable, Hashable, Sendable {
        /// The name of the custom field.
        public var name: String?
        /// The value of the custom field.
        public var value: String?

        public init(
            name: String? = nil,
            value: String? = nil
        ) {
            self.name = name
            self.value = value
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct RenderingOptions: Codable, Hashable, Sendable {
        /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
        public var amountTaxDisplay: String?

        public init(
            amountTaxDisplay: String? = nil
        ) {
            self.amountTaxDisplay = amountTaxDisplay
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct TotalTaxAmount: Codable, Hashable, Sendable {
        /// The amount, in cents, of the tax.
        public var amount: Int?
        /// Whether this tax amount is inclusive or exclusive.
        public var inclusive: Bool?
        /// The tax rate that was applied to get this tax amount.
        @ExpandableOf<Stripe.Tax.Rate> public var taxRate
        /// The reasoning behind this tax, for example, if the product is tax exempt.
        ///
        /// The possible values for this field may be extended as new tax rules are supported.
        public var taxabilityReason: Stripe.Billing.Invoice.TotalTaxAmount.TaxabilityReason?
        /// The amount on which tax is calculated, in cents.
        public var taxableAmount: Int?

        public init(
            amount: Int? = nil,
            inclusive: Bool? = nil,
            taxRate: Stripe.Tax.Rate.ID? = nil,
            taxabilityReason: Stripe.Billing.Invoice.TotalTaxAmount.TaxabilityReason? = nil,
            taxableAmount: Int? = nil
        ) {
            self.amount = amount
            self.inclusive = inclusive
            self._taxRate = Expandable(id: taxRate)
            self.taxabilityReason = taxabilityReason
            self.taxableAmount = taxableAmount
        }
    }
}

extension Stripe.Billing.Invoice.TotalTaxAmount {
    public enum TaxabilityReason: String, Codable, Sendable {
        /// Taxed at the standard rate.
        case standardRated = "standard_rated"
        /// Taxed at a reduced rate.
        case reducedRated = "reduced_rated"
        /// The transaction is taxed at a special rate of 0% or the transaction is exempt (but these exempt transactions still let you deduct the “input VAT” paid on your business purchases).
        case zeroRated = "zero_rated"
        /// No tax is applied as it is the responsibility of the buyer to account for tax in this case.
        case reverseCharge = "reverse_charge"
        /// No tax is applied as the customer is exempt from tax.
        case customerExempt = "customer_exempt"
        /// The product or service is nontaxable or exempt from tax.
        case productExempt = "product_exempt"
        /// The product or service is not taxed due to a sales tax holiday.
        case productExemptHoliday = "product_exempt_holiday"
        /// A portion of the price is taxed at the standard rate.
        case portionStandardRated = "portion_standard_rated"
        /// A portion of the price is taxed at a reduced rate.
        case portionReducedRated = "portion_reduced_rated"
        /// A portion of the price is exempt from tax.
        case portionProductExempt = "portion_product_exempt"
        /// A reduced amount of the price is subject to tax.
        case taxableBasisReduced = "taxable_basis_reduced"
        /// No tax is collected either because you are not registered to collect tax in this jurisdiction, or because the non-taxable product tax code (txcd_00000000) was used.
        case notCollecting = "not_collecting"
        /// No tax is imposed on this transaction.
        case notSubjectToTax = "not_subject_to_tax"
        /// No tax is applied as Stripe Tax does not support this jurisdiction or territory.
        case notSupported = "not_supported"
        /// The shipping cost tax rate is calculated as a weighted average of the other line items’ rates, weighted by their amounts.
        case proportionallyRated = "proportionally_rated"
    }
}

extension Stripe.Billing.Invoice {
    public struct TransferData: Codable, Hashable, Sendable {
        /// The amount in cents that will be transferred to the destination account when the invoice is paid.
        ///
        /// By default, the entire amount is transferred to the destination.
        public var amount: Int?
        /// The account where funds from the payment will be transferred to upon payment success.
        @ExpandableOf<Stripe.Connect.Account> public var destination

        public init(
            amount: Int? = nil,
            destination: Stripe.Connect.Account.ID? = nil
        ) {
            self.amount = amount
            self._destination = Expandable(id: destination)
        }
    }
}

// MARK: - Parent
extension Stripe.Billing.Invoice {

    /// Details about the subscription that created an invoice.
    public struct SubscriptionDetails: Codable, Hashable, Sendable {
        /// The subscription that generated this invoice.
        @ExpandableOf<Stripe.Billing.Subscription> public var subscription: Stripe.Billing.Subscription.ID?
        /// An immutable snapshot of the subscription's metadata as of invoice finalization.
        ///
        /// Populated only for invoices created on or after 2023-06-29.
        public var metadata: [String: String]?
        /// Only set on upcoming invoices that preview prorations: the time used to calculate them.
        public var subscriptionProrationDate: Date?

        public init(
            subscription: Stripe.Billing.Subscription.ID? = nil,
            metadata: [String: String]? = nil,
            subscriptionProrationDate: Date? = nil
        ) {
            self._subscription = Expandable(id: subscription)
            self.metadata = metadata
            self.subscriptionProrationDate = subscriptionProrationDate
        }
    }

    /// Details about the quote that created an invoice.
    public struct QuoteDetails: Codable, Hashable, Sendable {
        /// The quote that generated this invoice.
        public var quote: Stripe.Billing.Quote.ID?

        public init(quote: Stripe.Billing.Quote.ID? = nil) {
            self.quote = quote
        }
    }
}

// MARK: - Fields added through API version 2026-07-29.dahlia
