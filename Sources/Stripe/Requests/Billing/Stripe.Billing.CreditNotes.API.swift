//
//  Stripe Billing Credit Notes Types Billing Credit Notes.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.CreditNotes {
    // https://docs.stripe.com/api/creditNotes/create.md
    public enum Create {}
}

extension Stripe.Billing.CreditNotes.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// ID of the invoice
        public var invoice: Stripe.Billing.Invoice.ID
        /// The integer amount in cents representing the total amount of the credit note
        public var amount: Int?
        /// The integer amount in cents representing the amount to credit the customer's balance
        public var creditAmount: Int?
        /// Line items to credit
        public var lines: [LineItem]?
        /// The credit note's memo appears on the credit note PDF
        public var memo: String?
        /// Reason for issuing this credit note
        public var reason: Stripe.Billing.Credit.Note.Reason?
        /// ID of an existing refund to link this credit note to
        public var refund: String?
        /// Amount to refund. If set, a refund will be created for the charge associated with the invoice
        public var refundAmount: Int?
        /// The amount to increment the customer's credit balance
        public var outOfBandAmount: Int?
        /// Set of key-value pairs that you can attach to an object
        public var metadata: [String: String]?

        public init(
            invoice: Stripe.Billing.Invoice.ID,
            amount: Int? = nil,
            creditAmount: Int? = nil,
            lines: [LineItem]? = nil,
            memo: String? = nil,
            reason: Stripe.Billing.Credit.Note.Reason? = nil,
            refund: String? = nil,
            refundAmount: Int? = nil,
            outOfBandAmount: Int? = nil,
            metadata: [String: String]? = nil
        ) {
            self.invoice = invoice
            self.amount = amount
            self.creditAmount = creditAmount
            self.lines = lines
            self.memo = memo
            self.reason = reason
            self.refund = refund
            self.refundAmount = refundAmount
            self.outOfBandAmount = outOfBandAmount
            self.metadata = metadata
        }

        private enum CodingKeys: String, CodingKey {
            case invoice
            case amount
            case creditAmount
            case lines
            case memo
            case reason
            case refund
            case refundAmount
            case outOfBandAmount
            case metadata
        }
    }

    public struct LineItem: Codable, Equatable, Sendable {
        /// Type of the credit note line item
        public var type: LineItemType
        /// The integer amount in cents representing the amount being credited for this line item
        public var amount: Int?
        /// An arbitrary string attached to the object
        public var description: String?
        /// The ID of the invoice line item to credit
        public var invoiceLineItem: String?
        /// The integer amount in cents representing the amount being credited for this line item
        public var quantity: Int?
        /// The tax rates which apply to the line item
        public var taxRates: [String]?
        /// The integer unit amount in cents of the credit note line item
        public var unitAmount: Int?
        /// Same as unit_amount, but accepts a decimal value with at most 12 decimal places
        public var unitAmountDecimal: String?

        public init(
            type: LineItemType,
            amount: Int? = nil,
            description: String? = nil,
            invoiceLineItem: String? = nil,
            quantity: Int? = nil,
            taxRates: [String]? = nil,
            unitAmount: Int? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.type = type
            self.amount = amount
            self.description = description
            self.invoiceLineItem = invoiceLineItem
            self.quantity = quantity
            self.taxRates = taxRates
            self.unitAmount = unitAmount
            self.unitAmountDecimal = unitAmountDecimal
        }

        private enum CodingKeys: String, CodingKey {
            case type
            case amount
            case description
            case invoiceLineItem
            case quantity
            case taxRates
            case unitAmount
            case unitAmountDecimal
        }
    }

    public enum LineItemType: String, Codable, Equatable, Sendable {
        case customLineItem = "custom_line_item"
        case invoiceLineItem = "invoice_line_item"
    }
}

extension Stripe.Billing.CreditNotes {
    // https://docs.stripe.com/api/creditNotes/update.md
    public enum Update {}
}

extension Stripe.Billing.CreditNotes.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Credit note memo
        public var memo: String?
        /// Set of key-value pairs that you can attach to an object
        public var metadata: [String: String]?

        public init(
            memo: String? = nil,
            metadata: [String: String]? = nil
        ) {
            self.memo = memo
            self.metadata = metadata
        }

        private enum CodingKeys: String, CodingKey {
            case memo
            case metadata
        }
    }
}

extension Stripe.Billing.CreditNotes {
    // https://docs.stripe.com/api/creditNotes/list.md
    public enum List {}
}

extension Stripe.Billing.CreditNotes.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return credit notes for the customer specified by this customer ID
        public var customer: Stripe.Customers.Customer.ID?
        /// Only return credit notes for the invoice specified by this invoice ID
        public var invoice: Stripe.Billing.Invoice.ID?
        /// A limit on the number of objects to be returned
        public var limit: Int?
        /// A cursor for use in pagination
        public var startingAfter: String?
        /// A cursor for use in pagination
        public var endingBefore: String?

        public init(
            customer: Stripe.Customers.Customer.ID? = nil,
            invoice: Stripe.Billing.Invoice.ID? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            endingBefore: String? = nil
        ) {
            self.customer = customer
            self.invoice = invoice
            self.limit = limit
            self.startingAfter = startingAfter
            self.endingBefore = endingBefore
        }

        private enum CodingKeys: String, CodingKey {
            case customer
            case invoice
            case limit
            case startingAfter
            case endingBefore
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.Credit.Note]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}

extension Stripe.Billing.CreditNotes {
    // https://docs.stripe.com/api/creditNotes/preview.md
    public enum Preview {}
}

extension Stripe.Billing.CreditNotes.Preview {
    public struct Request: Codable, Equatable, Sendable {
        /// ID of the invoice
        public var invoice: Stripe.Billing.Invoice.ID
        /// The integer amount in cents representing the total amount of the credit note
        public var amount: Int?
        /// The integer amount in cents representing the amount to credit the customer's balance
        public var creditAmount: Int?
        /// The credit note's memo appears on the credit note PDF
        public var memo: String?
        /// Reason for issuing this credit note
        public var reason: String?  // Simplified for GET query

        public init(
            invoice: Stripe.Billing.Invoice.ID,
            amount: Int? = nil,
            creditAmount: Int? = nil,
            memo: String? = nil,
            reason: String? = nil
        ) {
            self.invoice = invoice
            self.amount = amount
            self.creditAmount = creditAmount
            self.memo = memo
            self.reason = reason
        }

        private enum CodingKeys: String, CodingKey {
            case invoice
            case amount
            case creditAmount
            case memo
            case reason
        }
    }
}

extension Stripe.Billing.CreditNotes {
    // https://docs.stripe.com/api/creditNotes/void.md
    public enum Void {}
}

extension Stripe.Billing.CreditNotes.Void {
    public struct Request: Codable, Equatable, Sendable {
        public init() {}
    }
}

extension Stripe.Billing.CreditNotes {
    // https://docs.stripe.com/api/creditNotes/lines.md
    public enum Lines {}
}

extension Stripe.Billing.CreditNotes.Lines {
    public struct Request: Codable, Equatable, Sendable {
        /// A limit on the number of objects to be returned
        public var limit: Int?
        /// A cursor for use in pagination
        public var startingAfter: String?
        /// A cursor for use in pagination
        public var endingBefore: String?

        public init(
            limit: Int? = nil,
            startingAfter: String? = nil,
            endingBefore: String? = nil
        ) {
            self.limit = limit
            self.startingAfter = startingAfter
            self.endingBefore = endingBefore
        }

        private enum CodingKeys: String, CodingKey {
            case limit
            case startingAfter
            case endingBefore
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.Credit.Note.LineItem]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}

extension Stripe.Billing.CreditNotes {
    // https://docs.stripe.com/api/creditNotes/preview_lines.md
    public enum PreviewLines {}
}

extension Stripe.Billing.CreditNotes.PreviewLines {
    public struct Request: Codable, Equatable, Sendable {
        /// ID of the invoice
        public var invoice: Stripe.Billing.Invoice.ID
        /// The integer amount in cents representing the total amount of the credit note
        public var amount: Int?
        /// The integer amount in cents representing the amount to credit the customer's balance
        public var creditAmount: Int?
        /// A limit on the number of objects to be returned
        public var limit: Int?
        /// A cursor for use in pagination
        public var startingAfter: String?
        /// A cursor for use in pagination
        public var endingBefore: String?

        public init(
            invoice: Stripe.Billing.Invoice.ID,
            amount: Int? = nil,
            creditAmount: Int? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            endingBefore: String? = nil
        ) {
            self.invoice = invoice
            self.amount = amount
            self.creditAmount = creditAmount
            self.limit = limit
            self.startingAfter = startingAfter
            self.endingBefore = endingBefore
        }

        private enum CodingKeys: String, CodingKey {
            case invoice
            case amount
            case creditAmount
            case limit
            case startingAfter
            case endingBefore
        }
    }

    public typealias Response = Stripe.Billing.CreditNotes.Lines.Response
}
