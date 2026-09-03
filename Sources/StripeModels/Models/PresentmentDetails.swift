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

extension Stripe {
    /// The amount and currency a payment was presented to the customer in.
    ///
    /// Present when that differs from the settlement currency.
    ///
    /// Shared by Charge and PaymentIntent, which the spec backs with one schema.
    public struct PresentmentDetails: Codable, Hashable, Sendable {
        public var presentmentAmount: Int?
        public var presentmentCurrency: String?

        public init(presentmentAmount: Int? = nil, presentmentCurrency: String? = nil) {
            self.presentmentAmount = presentmentAmount
            self.presentmentCurrency = presentmentCurrency
        }
    }
}
