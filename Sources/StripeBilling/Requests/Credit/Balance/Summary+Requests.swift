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
import StripeProducts

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Credit.Balance.Summary {
    public enum Retrieve {}
}

// GET /v1/billing/credit_balance_summary
extension Stripe.Billing.Credit.Balance.Summary.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// The customer whose credit balance summary you're retrieving.
        public var customer: String?
        /// The account representing the customer whose credit balance summary you're retrieving.
        public var customerAccount: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The filter criteria for the credit balance summary.
        public var filter: Filter

        public init(
            customer: String? = nil,
            customerAccount: String? = nil,
            expand: [String]? = nil,
            filter: Filter
        ) {
            self.customer = customer
            self.customerAccount = customerAccount
            self.expand = expand
            self.filter = filter
        }

        /// The filter criteria for the credit balance summary.
        public struct Filter: Codable, Hashable, Sendable {
            /// The billing credit applicability scope for which to fetch credit balance summary.
            public var applicabilityScope: ApplicabilityScope?
            /// The credit grant for which to fetch credit balance summary.
            public var creditGrant: String?
            /// Specify the type of this filter.
            public var `type`: Type

            public init(
                applicabilityScope: ApplicabilityScope? = nil,
                creditGrant: String? = nil,
                `type`: Type
            ) {
                self.applicabilityScope = applicabilityScope
                self.creditGrant = creditGrant
                self.`type` = `type`
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case applicabilityScope = "applicability_scope"
                case creditGrant = "credit_grant"
            }

            /// The billing credit applicability scope for which to fetch credit balance summary.
            public struct ApplicabilityScope: Codable, Hashable, Sendable {
                /// The price type that credit grants can apply to.
                public var priceType: String?
                /// A list of prices that the credit grant can apply to.
                public var prices: [Prices]?

                public init(
                    priceType: String? = nil,
                    prices: [Prices]? = nil
                ) {
                    self.priceType = priceType
                    self.prices = prices
                }

                public struct Prices: Codable, Hashable, Sendable {
                    /// The price ID this credit grant should apply to.
                    public var id: String

                    public init(
                        id: String
                    ) {
                        self.id = id
                    }
                }
            }
        }
    }

    public typealias Response = Stripe.Billing.Credit.Balance.Summary
}
