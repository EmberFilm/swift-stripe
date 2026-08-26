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
    /// Tax ID Element for collecting tax identification numbers.
    ///
    /// See: https://docs.stripe.com/elements/tax-id-element
    public struct TaxID: Codable, Hashable, Sendable {
        public let options: Options?

        public init(options: Options? = nil) {
            self.options = options
        }

        public struct Options: Codable, Hashable, Sendable {
            public let supportedCountries: [String]?
            public let defaultCountry: String?
            public let allowedCountries: [String]?
            public let blockedCountries: [String]?
            public let placeholderCountry: String?
            public let value: Value?

            public init(
                supportedCountries: [String]? = nil,
                defaultCountry: String? = nil,
                allowedCountries: [String]? = nil,
                blockedCountries: [String]? = nil,
                placeholderCountry: String? = nil,
                value: Value? = nil
            ) {
                self.supportedCountries = supportedCountries
                self.defaultCountry = defaultCountry
                self.allowedCountries = allowedCountries
                self.blockedCountries = blockedCountries
                self.placeholderCountry = placeholderCountry
                self.value = value
            }
        }
    }
}

extension Stripe.WebElements.TaxID.Options {
    public struct Value: Codable, Hashable, Sendable {
        public let type: String?
        public let value: String?

        public init(
            type: String? = nil,
            value: String? = nil
        ) {
            self.type = type
            self.value = value
        }
    }
}
