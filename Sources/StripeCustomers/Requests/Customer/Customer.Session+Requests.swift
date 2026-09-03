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
import StripePaymentMethods
import StripeProducts
import StripeTax

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Customers.Customer.Session {
    public enum Create {}
}

// POST /v1/customer_sessions
extension Stripe.Customers.Customer.Session.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Configuration for each component.
        public var components: Components
        /// The ID of an existing customer for which to create the Customer Session.
        public var customer: String?
        /// The ID of an existing Account for which to create the Customer Session.
        public var customerAccount: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            components: Components,
            customer: String? = nil,
            customerAccount: String? = nil,
            expand: [String]? = nil
        ) {
            self.components = components
            self.customer = customer
            self.customerAccount = customerAccount
            self.expand = expand
        }

        /// Configuration for each component.
        public struct Components: Codable, Hashable, Sendable {
            /// Configuration for active entitlements.
            public var activeEntitlements: ActiveEntitlements?
            /// Configuration for buy button.
            public var buyButton: BuyButton?
            /// Configuration for customer portal.
            public var customerPortal: CustomerPortal?
            /// Configuration for the customer sheet.
            public var customerSheet: CustomerSheet?
            /// Configuration for the mobile payment element.
            public var mobilePaymentElement: MobilePaymentElement?
            /// Configuration for the Payment Element.
            public var paymentElement: PaymentElement?
            /// Configuration for the pricing table.
            public var pricingTable: PricingTable?

            public init(
                activeEntitlements: ActiveEntitlements? = nil,
                buyButton: BuyButton? = nil,
                customerPortal: CustomerPortal? = nil,
                customerSheet: CustomerSheet? = nil,
                mobilePaymentElement: MobilePaymentElement? = nil,
                paymentElement: PaymentElement? = nil,
                pricingTable: PricingTable? = nil
            ) {
                self.activeEntitlements = activeEntitlements
                self.buyButton = buyButton
                self.customerPortal = customerPortal
                self.customerSheet = customerSheet
                self.mobilePaymentElement = mobilePaymentElement
                self.paymentElement = paymentElement
                self.pricingTable = pricingTable
            }

            /// Configuration for active entitlements.
            public struct ActiveEntitlements: Codable, Hashable, Sendable {
                /// Whether the active entitlements is enabled.
                public var enabled: Bool

                public init(
                    enabled: Bool
                ) {
                    self.enabled = enabled
                }
            }

            /// Configuration for buy button.
            public struct BuyButton: Codable, Hashable, Sendable {
                /// Whether the buy button is enabled.
                public var enabled: Bool

                public init(
                    enabled: Bool
                ) {
                    self.enabled = enabled
                }
            }

            /// Configuration for customer portal.
            public struct CustomerPortal: Codable, Hashable, Sendable {
                /// Whether the customer portal is enabled.
                public var enabled: Bool

                public init(
                    enabled: Bool
                ) {
                    self.enabled = enabled
                }
            }

            /// Configuration for the customer sheet.
            public struct CustomerSheet: Codable, Hashable, Sendable {
                /// Whether the customer sheet is enabled.
                public var enabled: Bool
                /// This hash defines whether the customer sheet supports certain features.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// This hash defines whether the customer sheet supports certain features.
                public struct Features: Codable, Hashable, Sendable {
                    /// A list of `allow_redisplay` values that controls which saved payment methods the customer sheet displays by filtering.
                    public var paymentMethodAllowRedisplayFilters: [PaymentMethodAllowRedisplayFilters]?
                    /// Controls whether the customer sheet displays the option to remove a saved payment method.
                    public var paymentMethodRemove: PaymentMethodRemove?

                    public init(
                        paymentMethodAllowRedisplayFilters: [PaymentMethodAllowRedisplayFilters]? = nil,
                        paymentMethodRemove: PaymentMethodRemove? = nil
                    ) {
                        self.paymentMethodAllowRedisplayFilters = paymentMethodAllowRedisplayFilters
                        self.paymentMethodRemove = paymentMethodRemove
                    }

                    public enum PaymentMethodAllowRedisplayFilters: String, Codable, Hashable, Sendable {
                        case always
                        case limited
                        case unspecified
                    }

                    public enum PaymentMethodRemove: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }
                }
            }

            /// Configuration for the mobile payment element.
            public struct MobilePaymentElement: Codable, Hashable, Sendable {
                /// Whether the mobile payment element is enabled.
                public var enabled: Bool
                /// This hash defines whether the mobile payment element supports certain features.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// This hash defines whether the mobile payment element supports certain features.
                public struct Features: Codable, Hashable, Sendable {
                    /// A list of `allow_redisplay` values that controls which saved payment methods the mobile payment element displays by.
                    public var paymentMethodAllowRedisplayFilters: [PaymentMethodAllowRedisplayFilters]?
                    /// Controls whether or not the mobile payment element shows saved payment methods.
                    public var paymentMethodRedisplay: PaymentMethodRedisplay?
                    /// Controls whether the mobile payment element displays the option to remove a saved payment method.
                    public var paymentMethodRemove: PaymentMethodRemove?
                    /// Controls whether the mobile payment element displays a checkbox offering to save a new payment method.
                    public var paymentMethodSave: PaymentMethodSave?
                    /// Allows overriding the value of allow_override when saving a new payment method when payment_method_save is set to.
                    public var paymentMethodSaveAllowRedisplayOverride: PaymentMethodSaveAllowRedisplayOverride?

                    public init(
                        paymentMethodAllowRedisplayFilters: [PaymentMethodAllowRedisplayFilters]? = nil,
                        paymentMethodRedisplay: PaymentMethodRedisplay? = nil,
                        paymentMethodRemove: PaymentMethodRemove? = nil,
                        paymentMethodSave: PaymentMethodSave? = nil,
                        paymentMethodSaveAllowRedisplayOverride: PaymentMethodSaveAllowRedisplayOverride? = nil
                    ) {
                        self.paymentMethodAllowRedisplayFilters = paymentMethodAllowRedisplayFilters
                        self.paymentMethodRedisplay = paymentMethodRedisplay
                        self.paymentMethodRemove = paymentMethodRemove
                        self.paymentMethodSave = paymentMethodSave
                        self.paymentMethodSaveAllowRedisplayOverride = paymentMethodSaveAllowRedisplayOverride
                    }

                    public enum PaymentMethodAllowRedisplayFilters: String, Codable, Hashable, Sendable {
                        case always
                        case limited
                        case unspecified
                    }

                    public enum PaymentMethodRedisplay: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    public enum PaymentMethodRemove: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    public enum PaymentMethodSave: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    public enum PaymentMethodSaveAllowRedisplayOverride: String, Codable, Hashable, Sendable {
                        case always
                        case limited
                        case unspecified
                    }
                }
            }

            /// Configuration for the Payment Element.
            public struct PaymentElement: Codable, Hashable, Sendable {
                /// Whether the Payment Element is enabled.
                public var enabled: Bool
                /// This hash defines whether the Payment Element supports certain features.
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// This hash defines whether the Payment Element supports certain features.
                public struct Features: Codable, Hashable, Sendable {
                    /// A list of `allow_redisplay` values that controls which saved payment methods the Payment Element displays by.
                    public var paymentMethodAllowRedisplayFilters: [PaymentMethodAllowRedisplayFilters]?
                    /// Controls whether or not the Payment Element shows saved payment methods.
                    public var paymentMethodRedisplay: PaymentMethodRedisplay?
                    /// Determines the max number of saved payment methods for the Payment Element to display.
                    public var paymentMethodRedisplayLimit: Int?
                    /// Controls whether the Payment Element displays the option to remove a saved payment method.
                    public var paymentMethodRemove: PaymentMethodRemove?
                    /// Controls whether the Payment Element displays a checkbox offering to save a new payment method.
                    public var paymentMethodSave: PaymentMethodSave?
                    /// When using PaymentIntents and the customer checks the save checkbox, this field determines the `setup_future_usage`.
                    public var paymentMethodSaveUsage: PaymentMethodSaveUsage?

                    public init(
                        paymentMethodAllowRedisplayFilters: [PaymentMethodAllowRedisplayFilters]? = nil,
                        paymentMethodRedisplay: PaymentMethodRedisplay? = nil,
                        paymentMethodRedisplayLimit: Int? = nil,
                        paymentMethodRemove: PaymentMethodRemove? = nil,
                        paymentMethodSave: PaymentMethodSave? = nil,
                        paymentMethodSaveUsage: PaymentMethodSaveUsage? = nil
                    ) {
                        self.paymentMethodAllowRedisplayFilters = paymentMethodAllowRedisplayFilters
                        self.paymentMethodRedisplay = paymentMethodRedisplay
                        self.paymentMethodRedisplayLimit = paymentMethodRedisplayLimit
                        self.paymentMethodRemove = paymentMethodRemove
                        self.paymentMethodSave = paymentMethodSave
                        self.paymentMethodSaveUsage = paymentMethodSaveUsage
                    }

                    public enum PaymentMethodAllowRedisplayFilters: String, Codable, Hashable, Sendable {
                        case always
                        case limited
                        case unspecified
                    }

                    public enum PaymentMethodRedisplay: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    public enum PaymentMethodRemove: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    public enum PaymentMethodSave: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    public enum PaymentMethodSaveUsage: String, Codable, Hashable, Sendable {
                        case offSession = "off_session"
                        case onSession = "on_session"
                    }
                }
            }

            /// Configuration for the pricing table.
            public struct PricingTable: Codable, Hashable, Sendable {
                /// Whether the pricing table is enabled.
                public var enabled: Bool

                public init(
                    enabled: Bool
                ) {
                    self.enabled = enabled
                }
            }
        }
    }

    public typealias Response = Stripe.Customers.Customer.Session
}
