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

extension Stripe.Customers.Customer {
    /// A Customer Session allows you to grant Stripe's frontend SDKs (like Stripe.js) client-side access control over a.
    public struct Session: Codable, Hashable, Sendable {
        /// String representing the object's type.
        public let object: String
        /// The client secret of this Customer Session.
        public var clientSecret: String?
        public var components: Components?
        /// Time at which the object was created.
        public var created: Date?
        /// The Customer the Customer Session was created for.
        @Expandable<Stripe.Customers.Customer, String> public var customer: String?
        /// The Account that the Customer Session was created for.
        public var customerAccount: String?
        /// The timestamp at which this Customer Session will expire.
        public var expiresAt: Date?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?

        public init(
            object: String,
            clientSecret: String? = nil,
            components: Components? = nil,
            created: Date? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            expiresAt: Date? = nil,
            livemode: Bool? = nil
        ) {
            self.object = object
            self.clientSecret = clientSecret
            self.components = components
            self.created = created
            self._customer = Expandable(id: customer)
            self.customerAccount = customerAccount
            self.expiresAt = expiresAt
            self.livemode = livemode
        }

        /// Configuration for the components supported by this Customer Session.
        public struct Components: Codable, Hashable, Sendable {
            public var activeEntitlements: ActiveEntitlements?
            public var buyButton: BuyButton?
            public var customerPortal: CustomerPortal?
            public var customerSheet: CustomerSheet?
            public var mobilePaymentElement: MobilePaymentElement?
            public var paymentElement: PaymentElement?
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

            /// This hash contains whether the active entitlements is enabled.
            public struct ActiveEntitlements: Codable, Hashable, Sendable {
                /// Whether the active entitlements is enabled.
                public var enabled: Bool?

                public init(
                    enabled: Bool? = nil
                ) {
                    self.enabled = enabled
                }
            }

            /// This hash contains whether the buy button is enabled.
            public struct BuyButton: Codable, Hashable, Sendable {
                /// Whether the buy button is enabled.
                public var enabled: Bool?

                public init(
                    enabled: Bool? = nil
                ) {
                    self.enabled = enabled
                }
            }

            /// This hash contains whether the customer portal is enabled.
            public struct CustomerPortal: Codable, Hashable, Sendable {
                /// Whether the customer portal is enabled.
                public var enabled: Bool?

                public init(
                    enabled: Bool? = nil
                ) {
                    self.enabled = enabled
                }
            }

            /// This hash contains whether the customer sheet is enabled and the features it supports.
            public struct CustomerSheet: Codable, Hashable, Sendable {
                /// Whether the customer sheet is enabled.
                public var enabled: Bool?
                /// This hash defines whether the customer sheet supports certain features.
                public var features: Features?

                public init(
                    enabled: Bool? = nil,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// This hash contains the features the customer sheet supports.
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

                    /// Controls whether the customer sheet displays the option to remove a saved payment method.
                    public enum PaymentMethodRemove: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }
                }
            }

            /// This hash contains whether the mobile payment element is enabled and the features it supports.
            public struct MobilePaymentElement: Codable, Hashable, Sendable {
                /// Whether the mobile payment element is enabled.
                public var enabled: Bool?
                /// This hash defines whether the mobile payment element supports certain features.
                public var features: Features?

                public init(
                    enabled: Bool? = nil,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// This hash contains the features the mobile payment element supports.
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

                    /// Controls whether or not the mobile payment element shows saved payment methods.
                    public enum PaymentMethodRedisplay: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    /// Controls whether the mobile payment element displays the option to remove a saved payment method.
                    public enum PaymentMethodRemove: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    /// Controls whether the mobile payment element displays a checkbox offering to save a new payment method.
                    public enum PaymentMethodSave: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    /// Allows overriding the value of allow_override when saving a new payment method when payment_method_save is set to.
                    public enum PaymentMethodSaveAllowRedisplayOverride: String, Codable, Hashable, Sendable {
                        case always
                        case limited
                        case unspecified
                    }
                }
            }

            /// This hash contains whether the Payment Element is enabled and the features it supports.
            public struct PaymentElement: Codable, Hashable, Sendable {
                /// Whether the Payment Element is enabled.
                public var enabled: Bool?
                /// This hash defines whether the Payment Element supports certain features.
                public var features: Features?

                public init(
                    enabled: Bool? = nil,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                /// This hash contains the features the Payment Element supports.
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

                    /// Controls whether or not the Payment Element shows saved payment methods.
                    public enum PaymentMethodRedisplay: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    /// Controls whether the Payment Element displays the option to remove a saved payment method.
                    public enum PaymentMethodRemove: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    /// Controls whether the Payment Element displays a checkbox offering to save a new payment method.
                    public enum PaymentMethodSave: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }

                    /// When using PaymentIntents and the customer checks the save checkbox, this field determines the `setup_future_usage`.
                    public enum PaymentMethodSaveUsage: String, Codable, Hashable, Sendable {
                        case offSession = "off_session"
                        case onSession = "on_session"
                    }
                }
            }

            /// This hash contains whether the pricing table is enabled.
            public struct PricingTable: Codable, Hashable, Sendable {
                /// Whether the pricing table is enabled.
                public var enabled: Bool?

                public init(
                    enabled: Bool? = nil
                ) {
                    self.enabled = enabled
                }
            }
        }
    }
}
