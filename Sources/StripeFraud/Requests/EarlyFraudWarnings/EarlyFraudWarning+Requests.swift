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

import StripeCore
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning {
    public enum List {}
    public enum Retrieve {}
}

// GET /v1/radar/early_fraud_warnings
extension Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return early fraud warnings for the charge specified by this charge ID.
        public var charge: String?
        /// Only return early fraud warnings that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// Only return early fraud warnings for charges that were created by the PaymentIntent specified by this PaymentIntent.
        public var paymentIntent: String?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            charge: String? = nil,
            created: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            paymentIntent: String? = nil,
            startingAfter: String? = nil
        ) {
            self.charge = charge
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.paymentIntent = paymentIntent
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning>
}

// GET /v1/radar/early_fraud_warnings/{early_fraud_warning}
extension Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning
}
