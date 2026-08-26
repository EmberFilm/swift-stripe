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

extension Stripe.WebElements {
    /// Payment Method Messaging Element for displaying payment method messaging.
    ///
    /// See: https://docs.stripe.com/elements/payment-method-messaging
    public struct PaymentMethodMessaging: Codable, Hashable, Sendable {
        public let options: Options?

        public init(options: Options? = nil) {
            self.options = options
        }

        public struct Options: Codable, Hashable, Sendable {
            public let amount: Int?
            public let currency: Stripe.Currency?
            public let paymentMethodTypes: [String]?
            public let countryCode: String?
            public let displayType: DisplayType?

            public init(
                amount: Int? = nil,
                currency: Stripe.Currency? = nil,
                paymentMethodTypes: [String]? = nil,
                countryCode: String? = nil,
                displayType: DisplayType? = nil
            ) {
                self.amount = amount
                self.currency = currency
                self.paymentMethodTypes = paymentMethodTypes
                self.countryCode = countryCode
                self.displayType = displayType
            }
        }
    }
}

extension Stripe.WebElements.PaymentMethodMessaging.Options {
    public enum DisplayType: String, Codable, Sendable {
        case promotional
        case text
        case flex
    }
}
