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

extension Stripe.Billing.Credit.Grant {
    public enum Create {}
    public enum Expire {}
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
    public enum VoidGrant {}
}

// POST /v1/billing/credit_grants
extension Stripe.Billing.Credit.Grant.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Amount of this credit grant.
        public var amount: Amount
        /// Configuration specifying what this credit grant applies to.
        public var applicabilityConfig: ApplicabilityConfig
        /// The category of this credit grant.
        public var category: Category?
        /// ID of the customer receiving the billing credits.
        public var customer: String?
        /// ID of the account representing the customer receiving the billing credits.
        public var customerAccount: String?
        /// The time when the billing credits become effective-when they're eligible for use.
        public var effectiveAt: Date?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The time when the billing credits expire.
        public var expiresAt: Date?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// A descriptive name shown in the Dashboard.
        public var name: String?
        /// The desired priority for applying this credit grant.
        public var priority: Int?

        public init(
            amount: Amount,
            applicabilityConfig: ApplicabilityConfig,
            category: Category? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            effectiveAt: Date? = nil,
            expand: [String]? = nil,
            expiresAt: Date? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil,
            priority: Int? = nil
        ) {
            self.amount = amount
            self.applicabilityConfig = applicabilityConfig
            self.category = category
            self.customer = customer
            self.customerAccount = customerAccount
            self.effectiveAt = effectiveAt
            self.expand = expand
            self.expiresAt = expiresAt
            self.metadata = metadata
            self.name = name
            self.priority = priority
        }

        public enum Category: String, Codable, Hashable, Sendable {
            case paid
            case promotional
        }

        /// Amount of this credit grant.
        public struct Amount: Codable, Hashable, Sendable {
            /// The monetary amount.
            public var monetary: Monetary?
            /// The type of this amount.
            public var `type`: String

            public init(
                monetary: Monetary? = nil,
                `type`: String
            ) {
                self.monetary = monetary
                self.`type` = `type`
            }

            /// The monetary amount.
            public struct Monetary: Codable, Hashable, Sendable {
                /// Three-letter ISO code for the currency of the `value` parameter.
                public var currency: Stripe.Currency
                /// A positive integer representing the amount of the credit grant.
                public var value: Int

                public init(
                    currency: Stripe.Currency,
                    value: Int
                ) {
                    self.currency = currency
                    self.value = value
                }
            }
        }

        /// Configuration specifying what this credit grant applies to.
        public struct ApplicabilityConfig: Codable, Hashable, Sendable {
            /// Specify the scope of this applicability config.
            public var scope: Scope

            public init(
                scope: Scope
            ) {
                self.scope = scope
            }

            /// Specify the scope of this applicability config.
            public struct Scope: Codable, Hashable, Sendable {
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

    public typealias Response = Stripe.Billing.Credit.Grant
}

// POST /v1/billing/credit_grants/{id}/expire
extension Stripe.Billing.Credit.Grant.Expire {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Credit.Grant
}

// GET /v1/billing/credit_grants
extension Stripe.Billing.Credit.Grant.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return credit grants for this customer.
        public var customer: String?
        /// Only return credit grants for this account representing the customer.
        public var customerAccount: String?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            customer: String? = nil,
            customerAccount: String? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.customer = customer
            self.customerAccount = customerAccount
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Stripe.Billing.Credit.Grant>
}

// GET /v1/billing/credit_grants/{id}
extension Stripe.Billing.Credit.Grant.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Credit.Grant
}

// POST /v1/billing/credit_grants/{id}
extension Stripe.Billing.Credit.Grant.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The time when the billing credits created by this credit grant expire.
        public var expiresAt: Stripe.Clearable<Date>?
        /// Set of key-value pairs you can attach to an object.
        public var metadata: [String: String]?

        public init(
            expand: [String]? = nil,
            expiresAt: Stripe.Clearable<Date>? = nil,
            metadata: [String: String]? = nil
        ) {
            self.expand = expand
            self.expiresAt = expiresAt
            self.metadata = metadata
        }
    }

    public typealias Response = Stripe.Billing.Credit.Grant
}

// POST /v1/billing/credit_grants/{id}/void
extension Stripe.Billing.Credit.Grant.VoidGrant {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Credit.Grant
}
