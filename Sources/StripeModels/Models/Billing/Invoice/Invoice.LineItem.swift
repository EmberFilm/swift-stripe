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

extension Stripe.Billing.Invoice {
    /// Invoice Line Items represent the individual lines within an invoice and only exist within the context of an invoice.
    public struct LineItem: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The amount, in cents (or local equivalent).
        public var amount: Int?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// The amount of discount calculated per discount for this line item.
        public var discountAmounts: [Stripe.Shared.DiscountsResourceDiscountAmount]?
        /// If true, discounts will apply to this line item.
        public var discountable: Bool?
        /// The discounts applied to the invoice line item.
        @ExpandableCollection<Stripe.Shared.Discount> public var discounts: [String]?
        /// The ID of the invoice that contains this line item.
        public var invoice: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The parent that generated this line item.
        public var parent: Parent?
        public var period: Stripe.Shared.Period?
        /// Contains pretax credit amounts (ex: discount, credit grants, etc) that apply to this line item.
        public var pretaxCreditAmounts: [Stripe.Shared.InvoicesResourcePretaxCreditAmount]?
        /// The pricing information of the line item.
        public var pricing: Stripe.Shared.Pricing?
        /// Quantity of units for the invoice line item in integer format, with any decimal precision truncated.
        public var quantity: Int?
        /// Non-negative decimal with at most 12 decimal places.
        public var quantityDecimal: String?
        @Expandable<Stripe.Billing.Subscription, String> public var subscription: String?
        /// The subtotal of the line item, in cents (or local equivalent), before any discounts or taxes.
        public var subtotal: Int?
        /// The tax information of the line item.
        public var taxes: [Stripe.Shared.BillingBillResourceInvoicingTaxesTax]?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            discountAmounts: [Stripe.Shared.DiscountsResourceDiscountAmount]? = nil,
            discountable: Bool? = nil,
            discounts: [String]? = nil,
            invoice: String? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            parent: Parent? = nil,
            period: Stripe.Shared.Period? = nil,
            pretaxCreditAmounts: [Stripe.Shared.InvoicesResourcePretaxCreditAmount]? = nil,
            pricing: Stripe.Shared.Pricing? = nil,
            quantity: Int? = nil,
            quantityDecimal: String? = nil,
            subscription: String? = nil,
            subtotal: Int? = nil,
            taxes: [Stripe.Shared.BillingBillResourceInvoicingTaxesTax]? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.currency = currency
            self.description = description
            self.discountAmounts = discountAmounts
            self.discountable = discountable
            self._discounts = ExpandableCollection(ids: discounts)
            self.invoice = invoice
            self.livemode = livemode
            self.metadata = metadata
            self.parent = parent
            self.period = period
            self.pretaxCreditAmounts = pretaxCreditAmounts
            self.pricing = pricing
            self.quantity = quantity
            self.quantityDecimal = quantityDecimal
            self._subscription = Expandable(id: subscription)
            self.subtotal = subtotal
            self.taxes = taxes
        }

        public struct Parent: Codable, Hashable, Sendable {
            /// Details about the invoice item that generated this line item.
            public var invoiceItemDetails: InvoiceItemDetails?
            /// Details about the subscription item that generated this line item.
            public var subscriptionItemDetails: SubscriptionItemDetails?
            /// The type of parent that generated this line item.
            public var `type`: Type?

            public init(
                invoiceItemDetails: InvoiceItemDetails? = nil,
                subscriptionItemDetails: SubscriptionItemDetails? = nil,
                `type`: Type? = nil
            ) {
                self.invoiceItemDetails = invoiceItemDetails
                self.subscriptionItemDetails = subscriptionItemDetails
                self.`type` = `type`
            }

            /// The type of parent that generated this line item.
            public enum `Type`: String, Codable, Hashable, Sendable {
                case invoiceItemDetails = "invoice_item_details"
                case subscriptionItemDetails = "subscription_item_details"
            }

            public struct InvoiceItemDetails: Codable, Hashable, Sendable {
                /// The invoice item that generated this line item.
                public var invoiceItem: String?
                /// Whether this is a proration.
                public var proration: Bool?
                /// Additional details for proration line items.
                public var prorationDetails: ProrationDetails?
                /// The subscription that the invoice item belongs to.
                public var subscription: String?

                public init(
                    invoiceItem: String? = nil,
                    proration: Bool? = nil,
                    prorationDetails: ProrationDetails? = nil,
                    subscription: String? = nil
                ) {
                    self.invoiceItem = invoiceItem
                    self.proration = proration
                    self.prorationDetails = prorationDetails
                    self.subscription = subscription
                }

                public struct ProrationDetails: Codable, Hashable, Sendable {
                    /// For a credit proration `line_item`, the original debit line_items to which the credit proration applies.
                    public var creditedItems: CreditedItems?

                    public init(
                        creditedItems: CreditedItems? = nil
                    ) {
                        self.creditedItems = creditedItems
                    }

                    public struct CreditedItems: Codable, Hashable, Sendable {
                        /// Invoice containing the credited invoice line items.
                        public var invoice: String?
                        /// Credited invoice line items.
                        public var invoiceLineItems: [String]?

                        public init(
                            invoice: String? = nil,
                            invoiceLineItems: [String]? = nil
                        ) {
                            self.invoice = invoice
                            self.invoiceLineItems = invoiceLineItems
                        }
                    }
                }
            }

            public struct SubscriptionItemDetails: Codable, Hashable, Sendable {
                /// The invoice item that generated this line item.
                public var invoiceItem: String?
                /// Whether this is a proration.
                public var proration: Bool?
                /// Additional details for proration line items.
                public var prorationDetails: ProrationDetails?
                /// The subscription that the subscription item belongs to.
                public var subscription: String?
                /// The subscription item that generated this line item.
                public var subscriptionItem: String?

                public init(
                    invoiceItem: String? = nil,
                    proration: Bool? = nil,
                    prorationDetails: ProrationDetails? = nil,
                    subscription: String? = nil,
                    subscriptionItem: String? = nil
                ) {
                    self.invoiceItem = invoiceItem
                    self.proration = proration
                    self.prorationDetails = prorationDetails
                    self.subscription = subscription
                    self.subscriptionItem = subscriptionItem
                }

                public struct ProrationDetails: Codable, Hashable, Sendable {
                    /// For a credit proration `line_item`, the original debit line_items to which the credit proration applies.
                    public var creditedItems: CreditedItems?

                    public init(
                        creditedItems: CreditedItems? = nil
                    ) {
                        self.creditedItems = creditedItems
                    }

                    public struct CreditedItems: Codable, Hashable, Sendable {
                        /// Invoice containing the credited invoice line items.
                        public var invoice: String?
                        /// Credited invoice line items.
                        public var invoiceLineItems: [String]?

                        public init(
                            invoice: String? = nil,
                            invoiceLineItems: [String]? = nil
                        ) {
                            self.invoice = invoice
                            self.invoiceLineItems = invoiceLineItems
                        }
                    }
                }
            }
        }
    }
}
