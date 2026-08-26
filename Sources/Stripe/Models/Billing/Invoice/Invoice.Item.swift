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
    /// Invoice Items represent the component lines of an invoice.
    public struct Item: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Amount (in the `currency` specified) of the invoice item.
        public var amount: Int?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// The ID of the customer to bill for this invoice item.
        @Expandable<Stripe.Customers.Customer, String> public var customer: String?
        /// The ID of the account to bill for this invoice item.
        public var customerAccount: String?
        /// Time at which the object was created.
        public var date: Date?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// If true, discounts will apply to this invoice item.
        public var discountable: Bool?
        /// The discounts which apply to the invoice item.
        @ExpandableCollection<Stripe.Shared.Discount> public var discounts: [String]?
        /// The ID of the invoice this invoice item belongs to.
        @Expandable<Stripe.Billing.Invoice, String> public var invoice: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The amount after discounts, but before credits and taxes.
        public var netAmount: Int?
        /// The parent that generated this invoice item.
        public var parent: Parent?
        public var period: Stripe.Shared.Period?
        /// The pricing information of the invoice item.
        public var pricing: Stripe.Shared.Pricing?
        /// Whether the invoice item was created automatically as a proration adjustment when the customer switched plans.
        public var proration: Bool?
        public var prorationDetails: ProrationDetails?
        /// Quantity of units for the invoice item in integer format, with any decimal precision truncated.
        public var quantity: Int?
        /// Non-negative decimal with at most 12 decimal places.
        public var quantityDecimal: String?
        /// The tax rates which apply to the invoice item.
        public var taxRates: [Stripe.Tax.Rate]?
        /// ID of the test clock this invoice item belongs to.
        @Expandable<Stripe.Billing.TestClocks.TestClock, String> public var testClock: String?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            date: Date? = nil,
            description: String? = nil,
            discountable: Bool? = nil,
            discounts: [String]? = nil,
            invoice: String? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            netAmount: Int? = nil,
            parent: Parent? = nil,
            period: Stripe.Shared.Period? = nil,
            pricing: Stripe.Shared.Pricing? = nil,
            proration: Bool? = nil,
            prorationDetails: ProrationDetails? = nil,
            quantity: Int? = nil,
            quantityDecimal: String? = nil,
            taxRates: [Stripe.Tax.Rate]? = nil,
            testClock: String? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.currency = currency
            self._customer = Expandable(id: customer)
            self.customerAccount = customerAccount
            self.date = date
            self.description = description
            self.discountable = discountable
            self._discounts = ExpandableCollection(ids: discounts)
            self._invoice = Expandable(id: invoice)
            self.livemode = livemode
            self.metadata = metadata
            self.netAmount = netAmount
            self.parent = parent
            self.period = period
            self.pricing = pricing
            self.proration = proration
            self.prorationDetails = prorationDetails
            self.quantity = quantity
            self.quantityDecimal = quantityDecimal
            self.taxRates = taxRates
            self._testClock = Expandable(id: testClock)
        }

        public struct Parent: Codable, Hashable, Sendable {
            /// Details about the subscription that generated this invoice item.
            public var subscriptionDetails: SubscriptionDetails?
            /// The type of parent that generated this invoice item.
            public var `type`: String?

            public init(
                subscriptionDetails: SubscriptionDetails? = nil,
                `type`: String? = nil
            ) {
                self.subscriptionDetails = subscriptionDetails
                self.`type` = `type`
            }

            public struct SubscriptionDetails: Codable, Hashable, Sendable {
                /// The subscription that generated this invoice item.
                public var subscription: String?
                /// The subscription item that generated this invoice item.
                public var subscriptionItem: String?

                public init(
                    subscription: String? = nil,
                    subscriptionItem: String? = nil
                ) {
                    self.subscription = subscription
                    self.subscriptionItem = subscriptionItem
                }
            }
        }

        public struct ProrationDetails: Codable, Hashable, Sendable {
            /// For a credit proration, links to the debit invoice line items or invoice item that the credit applies to.
            public var creditedItems: CreditedItems?
            /// Discount amounts applied when the proration was created.
            public var discountAmounts: [Stripe.Shared.DiscountsResourceDiscountAmount]?

            public init(
                creditedItems: CreditedItems? = nil,
                discountAmounts: [Stripe.Shared.DiscountsResourceDiscountAmount]? = nil
            ) {
                self.creditedItems = creditedItems
                self.discountAmounts = discountAmounts
            }

            public struct CreditedItems: Codable, Hashable, Sendable {
                /// When `type` is `invoice_item`, the invoice item id for the debited invoice item corresponding to this credit.
                public var invoiceItem: String?
                public var invoiceLineItemDetails: InvoiceLineItemDetails?
                /// Whether the credit references a pending invoice item or one or more invoice line items on an invoice.
                public var `type`: Type?

                public init(
                    invoiceItem: String? = nil,
                    invoiceLineItemDetails: InvoiceLineItemDetails? = nil,
                    `type`: Type? = nil
                ) {
                    self.invoiceItem = invoiceItem
                    self.invoiceLineItemDetails = invoiceLineItemDetails
                    self.`type` = `type`
                }

                /// Whether the credit references a pending invoice item or one or more invoice line items on an invoice.
                public enum `Type`: String, Codable, Hashable, Sendable {
                    case invoiceItem = "invoice_item"
                    case invoiceLineItems = "invoice_line_items"
                }

                public struct InvoiceLineItemDetails: Codable, Hashable, Sendable {
                    /// The invoice id for the debited line item(s).
                    public var invoice: String?
                    /// IDs of the debited invoice line item(s) on the invoice that correspond to the credit proration.
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
