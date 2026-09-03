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

extension Stripe.WebElements {
    /// Express Checkout Element for fast checkout with digital wallets.
    ///
    /// See: https://docs.stripe.com/elements/express-checkout-element
    public struct ExpressCheckout: Codable, Hashable, Sendable {
        public let options: Options?

        public init(options: Options? = nil) {
            self.options = options
        }

        public struct Options: Codable, Hashable, Sendable {
            public let buttonTheme: ButtonTheme?
            public let buttonType: ButtonType?
            public let paymentMethods: PaymentMethods?
            public let layout: Layout?

            public init(
                buttonTheme: ButtonTheme? = nil,
                buttonType: ButtonType? = nil,
                paymentMethods: PaymentMethods? = nil,
                layout: Layout? = nil
            ) {
                self.buttonTheme = buttonTheme
                self.buttonType = buttonType
                self.paymentMethods = paymentMethods
                self.layout = layout
            }
        }
    }
}

extension Stripe.WebElements.ExpressCheckout.Options {
    public enum ButtonTheme: String, Codable, Sendable {
        case black
        case white
        case whiteOutline = "white-outline"
    }

    public enum ButtonType: String, Codable, Sendable {
        case checkout
        case book
        case buy
        case donate
        case order
        case pay
        case plain
        case subscribe
    }

    public struct PaymentMethods: Codable, Hashable, Sendable {
        public let applePay: String?
        public let googlePay: String?
        public let paypal: String?
        public let link: String?

        public init(
            applePay: String? = nil,
            googlePay: String? = nil,
            paypal: String? = nil,
            link: String? = nil
        ) {
            self.applePay = applePay
            self.googlePay = googlePay
            self.paypal = paypal
            self.link = link
        }
    }

    public struct Layout: Codable, Hashable, Sendable {
        public let maxColumns: Int?
        public let maxRows: Int?
        public let overflow: Overflow?

        public init(
            maxColumns: Int? = nil,
            maxRows: Int? = nil,
            overflow: Overflow? = nil
        ) {
            self.maxColumns = maxColumns
            self.maxRows = maxRows
            self.overflow = overflow
        }

        public enum Overflow: String, Codable, Sendable {
            case auto
            case never
        }
    }
}
