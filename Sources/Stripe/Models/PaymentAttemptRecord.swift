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

extension Stripe {
    /// A Payment Attempt Record represents an individual attempt at making a payment, on or off Stripe.
    public struct PaymentAttemptRecord: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        public var amount: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount?
        public var amountAuthorized: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount?
        public var amountCanceled: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount?
        public var amountFailed: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount?
        public var amountGuaranteed: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount?
        public var amountRefunded: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount?
        public var amountRequested: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount?
        /// ID of the Connect application that created the PaymentAttemptRecord.
        public var application: String?
        /// Time at which the object was created.
        public var created: Date?
        /// Customer information for this payment.
        public var customerDetails: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceCustomerDetails?
        /// Indicates whether the customer was present in your checkout flow during this payment.
        public var customerPresence: CustomerPresence?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// Information about the Payment Method debited for this payment.
        public var paymentMethodDetails: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodDetails?
        /// ID of the Payment Record this Payment Attempt Record belongs to.
        public var paymentRecord: String?
        public var processorDetails: Stripe.Shared.ProcessorDetails?
        /// Indicates who reported the payment.
        public var reportedBy: ReportedBy?
        /// Shipping information for this payment.
        public var shippingDetails: Stripe.Shared.ShippingDetails?

        public init(
            id: ID,
            object: String,
            amount: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount? = nil,
            amountAuthorized: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount? = nil,
            amountCanceled: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount? = nil,
            amountFailed: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount? = nil,
            amountGuaranteed: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount? = nil,
            amountRefunded: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount? = nil,
            amountRequested: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAmount? = nil,
            application: String? = nil,
            created: Date? = nil,
            customerDetails: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceCustomerDetails? = nil,
            customerPresence: CustomerPresence? = nil,
            description: String? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            paymentMethodDetails: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodDetails? = nil,
            paymentRecord: String? = nil,
            processorDetails: Stripe.Shared.ProcessorDetails? = nil,
            reportedBy: ReportedBy? = nil,
            shippingDetails: Stripe.Shared.ShippingDetails? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.amountAuthorized = amountAuthorized
            self.amountCanceled = amountCanceled
            self.amountFailed = amountFailed
            self.amountGuaranteed = amountGuaranteed
            self.amountRefunded = amountRefunded
            self.amountRequested = amountRequested
            self.application = application
            self.created = created
            self.customerDetails = customerDetails
            self.customerPresence = customerPresence
            self.description = description
            self.livemode = livemode
            self.metadata = metadata
            self.paymentMethodDetails = paymentMethodDetails
            self.paymentRecord = paymentRecord
            self.processorDetails = processorDetails
            self.reportedBy = reportedBy
            self.shippingDetails = shippingDetails
        }

        /// Indicates whether the customer was present in your checkout flow during this payment.
        public enum CustomerPresence: String, Codable, Hashable, Sendable {
            case offSession = "off_session"
            case onSession = "on_session"
        }

        /// Indicates who reported the payment.
        public enum ReportedBy: String, Codable, Hashable, Sendable {
            case `self`
            case stripe
        }
    }
}
