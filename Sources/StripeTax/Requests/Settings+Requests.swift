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

extension Stripe.Tax.Settings {
    public enum Retrieve {}
    public enum Update {}
}

// GET /v1/tax/settings
extension Stripe.Tax.Settings.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Tax.Settings
}

// POST /v1/tax/settings
extension Stripe.Tax.Settings.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Default configuration to be used on Stripe Tax calculations.
        public var defaults: Defaults?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The place where your business is located.
        public var headOffice: HeadOffice?

        public init(
            defaults: Defaults? = nil,
            expand: [String]? = nil,
            headOffice: HeadOffice? = nil
        ) {
            self.defaults = defaults
            self.expand = expand
            self.headOffice = headOffice
        }

        /// Default configuration to be used on Stripe Tax calculations.
        public struct Defaults: Codable, Hashable, Sendable {
            /// Specifies the default tax behavior to be used when the item's price has unspecified tax behavior.
            public var taxBehavior: TaxBehavior?
            /// A tax code ID.
            public var taxCode: String?

            public init(
                taxBehavior: TaxBehavior? = nil,
                taxCode: String? = nil
            ) {
                self.taxBehavior = taxBehavior
                self.taxCode = taxCode
            }

            public enum TaxBehavior: String, Codable, Hashable, Sendable {
                case exclusive
                case inclusive
                case inferredByCurrency = "inferred_by_currency"
            }
        }

        /// The place where your business is located.
        public struct HeadOffice: Codable, Hashable, Sendable {
            /// The location of the business for tax purposes.
            public var address: Address

            public init(
                address: Address
            ) {
                self.address = address
            }

            /// The location of the business for tax purposes.
            public struct Address: Codable, Hashable, Sendable {
                /// City, district, suburb, town, or village.
                public var city: String?
                /// Two-letter country code (ISO 3166-1 alpha-2).
                public var country: String?
                /// Address line 1, such as the street, PO Box, or company name.
                public var line1: String?
                /// Address line 2, such as the apartment, suite, unit, or building.
                public var line2: String?
                /// ZIP or postal code.
                public var postalCode: String?
                /// State/province as an ISO 3166-2 subdivision code, without country prefix, such as "NY" or "TX".
                public var state: String?

                public init(
                    city: String? = nil,
                    country: String? = nil,
                    line1: String? = nil,
                    line2: String? = nil,
                    postalCode: String? = nil,
                    state: String? = nil
                ) {
                    self.city = city
                    self.country = country
                    self.line1 = line1
                    self.line2 = line2
                    self.postalCode = postalCode
                    self.state = state
                }
            }
        }
    }

    public typealias Response = Stripe.Tax.Settings
}
