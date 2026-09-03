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
import StripePromotion
import StripeReporting

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.PaymentAttemptRecord {
    public enum List {}
    public enum Retrieve {}
}

// GET /v1/payment_attempt_records
extension Stripe.PaymentAttemptRecord.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// The ID of the Payment Record.
        public var paymentRecord: String
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            expand: [String]? = nil,
            limit: Int? = nil,
            paymentRecord: String,
            startingAfter: String? = nil
        ) {
            self.expand = expand
            self.limit = limit
            self.paymentRecord = paymentRecord
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Stripe.PaymentAttemptRecord>
}

// GET /v1/payment_attempt_records/{id}
extension Stripe.PaymentAttemptRecord.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.PaymentAttemptRecord
}
