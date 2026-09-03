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
    /// Currency Selector Element for selecting payment currency.
    ///
    /// See: https://docs.stripe.com/elements/currency-selector-element
    public struct CurrencySelector: Codable, Hashable, Sendable {
        public let options: Options?

        public init(options: Options? = nil) {
            self.options = options
        }

        public struct Options: Codable, Hashable, Sendable {
            public let defaultCurrency: String?
            public let supportedCurrencies: [String]?
            public let locale: String?
            public let displayCurrencyCode: Bool?

            public init(
                defaultCurrency: String? = nil,
                supportedCurrencies: [String]? = nil,
                locale: String? = nil,
                displayCurrencyCode: Bool? = nil
            ) {
                self.defaultCurrency = defaultCurrency
                self.supportedCurrencies = supportedCurrencies
                self.locale = locale
                self.displayCurrencyCode = displayCurrencyCode
            }
        }
    }
}
