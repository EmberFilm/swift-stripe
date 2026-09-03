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
import StripeIssuing
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Tax.Association {
    public enum Find {}
}

// GET /v1/tax/associations/find
extension Stripe.Tax.Association.Find {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Valid PaymentIntent id.
        public var paymentIntent: String

        public init(
            expand: [String]? = nil,
            paymentIntent: String
        ) {
            self.expand = expand
            self.paymentIntent = paymentIntent
        }
    }

    public typealias Response = Stripe.Tax.Association
}
