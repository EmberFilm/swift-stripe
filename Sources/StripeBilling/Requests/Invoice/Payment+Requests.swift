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

import StripeCheckout
import StripeCore
import StripeIssuing
import StripeModels
import StripeProducts

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Invoice.Payment {
    public enum List {}
    public enum Retrieve {}
}

// GET /v1/invoice_payments
extension Stripe.Billing.Invoice.Payment.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return invoice payments that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The identifier of the invoice whose payments to return.
        public var invoice: String?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// The payment details of the invoice payments to return.
        public var payment: Payment?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// The status of the invoice payments to return.
        public var status: Status?

        public init(
            created: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            invoice: String? = nil,
            limit: Int? = nil,
            payment: Payment? = nil,
            startingAfter: String? = nil,
            status: Status? = nil
        ) {
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.invoice = invoice
            self.limit = limit
            self.payment = payment
            self.startingAfter = startingAfter
            self.status = status
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case canceled
            case open
            case paid
        }

        /// The payment details of the invoice payments to return.
        public struct Payment: Codable, Hashable, Sendable {
            /// Only return invoice payments associated by this payment intent ID.
            public var paymentIntent: String?
            /// Only return invoice payments associated by this payment record ID.
            public var paymentRecord: String?
            /// Only return invoice payments associated by this payment type.
            public var `type`: Type

            public init(
                paymentIntent: String? = nil,
                paymentRecord: String? = nil,
                `type`: Type
            ) {
                self.paymentIntent = paymentIntent
                self.paymentRecord = paymentRecord
                self.`type` = `type`
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case paymentIntent = "payment_intent"
                case paymentRecord = "payment_record"
            }
        }
    }

    public typealias Response = Stripe.Page<Stripe.Billing.Invoice.Payment>
}

// GET /v1/invoice_payments/{invoice_payment}
extension Stripe.Billing.Invoice.Payment.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Invoice.Payment
}
