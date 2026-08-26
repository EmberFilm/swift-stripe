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

// https://docs.stripe.com/api/invoices/line_item.md

/// The [Invoice Line Item Object](https://stripe.com/docs/api/invoices/line_item) .

// The LineItem struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.Invoice.LineItem` that the generator spells differently.

extension Stripe.Billing.Invoice.LineItem {
    public struct Period: Codable, Hashable, Sendable {
        /// Start of the line item's billing period.
        public var start: Date?
        /// End of the line item's billing period.
        public var end: Date?

        public init(
            start: Date? = nil,
            end: Date? = nil
        ) {
            self.start = start
            self.end = end
        }
    }

    public enum `Type`: String, Codable, Sendable {
        case invoiceitem
        case subscription
    }

    public struct ProrationDetails: Codable, Hashable, Sendable {
        /// For a credit proration `line_item`, the original debit `lineItems` to which the credit proration applies.
        public var creditedItems: CreditedItem?

        public init(
            creditedItems: CreditedItem? = nil
        ) {
            self.creditedItems = creditedItems
        }
    }
}

extension Stripe.Billing.Invoice.LineItem.ProrationDetails {
    public struct CreditedItem: Codable, Hashable, Sendable {
        /// Invoice containing the credited invoice line items.
        public var invoice: Stripe.Billing.Invoice.ID?
        /// Credited invoice line items.
        public var invoiceLineItems: [String]?

        public init(
            invoice: Stripe.Billing.Invoice.ID? = nil,
            invoiceLineItems: [String]? = nil
        ) {
            self.invoice = invoice
            self.invoiceLineItems = invoiceLineItems
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct SearchResult: Codable, Hashable, Sendable {
        /// A string describing the object type returned.
        public var object: String
        /// A list of invoices, paginated by any request parameters.
        public var data: [Stripe.Billing.Invoice]?
        /// Whether or not there are more elements available after this set.
        public var hasMore: Bool?
        /// The URL for accessing this list.
        public var url: String?
        /// The URL for accessing the next page in search results.
        public var nextPage: String?
        /// The total count of entries in the search result, not just the current page.
        public var totalCount: Int?

        public init(
            object: String,
            data: [Stripe.Billing.Invoice]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil,
            nextPage: String? = nil,
            totalCount: Int? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
            self.nextPage = nextPage
            self.totalCount = totalCount
        }
    }
}
