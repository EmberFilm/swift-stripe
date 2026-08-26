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

extension Stripe.Billing.Customer.Portal {
    /// The Billing customer portal is a Stripe-hosted UI for subscription and billing management.
    public struct Session: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The configuration used by this session, describing the features available.
        @Expandable<Stripe.Billing.Customer.Portal.Configuration, String> public var configuration: String?
        /// Time at which the object was created.
        public var created: Date?
        /// The ID of the customer for this session.
        public var customer: String?
        /// The ID of the account for this session.
        public var customerAccount: String?
        /// Information about a specific flow for the customer to go through.
        public var flow: Flow?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// The IETF language tag of the locale Customer Portal is displayed in.
        public var locale: Locale?
        /// The account for which the session was created on behalf of.
        public var onBehalfOf: String?
        /// The URL to redirect customers to when they click on the portal's link to return to your website.
        public var returnUrl: String?
        /// The short-lived URL of the session that gives customers access to the customer portal.
        public var url: String?

        public init(
            id: ID,
            object: String,
            configuration: String? = nil,
            created: Date? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            flow: Flow? = nil,
            livemode: Bool? = nil,
            locale: Locale? = nil,
            onBehalfOf: String? = nil,
            returnUrl: String? = nil,
            url: String? = nil
        ) {
            self.id = id
            self.object = object
            self._configuration = Expandable(id: configuration)
            self.created = created
            self.customer = customer
            self.customerAccount = customerAccount
            self.flow = flow
            self.livemode = livemode
            self.locale = locale
            self.onBehalfOf = onBehalfOf
            self.returnUrl = returnUrl
            self.url = url
        }

        /// The IETF language tag of the locale Customer Portal is displayed in.
        public enum Locale: String, Codable, Hashable, Sendable {
            case auto
            case bg
            case cs
            case da
            case de
            case el
            case en
            case enAU = "en-AU"
            case enCA = "en-CA"
            case enGB = "en-GB"
            case enIE = "en-IE"
            case enIN = "en-IN"
            case enNZ = "en-NZ"
            case enSG = "en-SG"
            case es
            case es419 = "es-419"
            case et
            case fi
            case fil
            case fr
            case frCA = "fr-CA"
            case hr
            case hu
            case id
            case it
            case ja
            case ko
            case lt
            case lv
            case ms
            case mt
            case nb
            case nl
            case pl
            case pt
            case ptBR = "pt-BR"
            case ro
            case ru
            case sk
            case sl
            case sv
            case th
            case tr
            case vi
            case zh
            case zhHK = "zh-HK"
            case zhTW = "zh-TW"
        }

        public struct Flow: Codable, Hashable, Sendable {
            public var afterCompletion: AfterCompletion?
            /// Type of flow that the customer will go through.
            public var `type`: Type?
            /// The payload `type` selects.
            public var details: Details

            fileprivate enum CodingKeys: String, CodingKey {
                case afterCompletion
                case `type`
                case subscriptionCancel
                case subscriptionUpdate
                case subscriptionUpdateConfirm
            }

            public init(
                afterCompletion: AfterCompletion? = nil,
                `type`: Type? = nil,
                details: Details
            ) {
                self.afterCompletion = afterCompletion
                self.`type` = `type`
                self.details = details
            }

            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.afterCompletion = try container.decodeIfPresent(AfterCompletion.self, forKey: .afterCompletion)
                self.`type` = try container.decodeIfPresent(Type.self, forKey: .`type`)
                self.details = try Details(type: try container.decodeIfPresent(String.self, forKey: .type) ?? "", from: container)
            }

            public func encode(to encoder: any Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encodeIfPresent(afterCompletion, forKey: .afterCompletion)
                try container.encodeIfPresent(`type`, forKey: .`type`)
                try details.encode(into: &container)
            }

            /// Type of flow that the customer will go through.
            public enum `Type`: String, Codable, Hashable, Sendable {
                case paymentMethodUpdate = "payment_method_update"
                case subscriptionCancel = "subscription_cancel"
                case subscriptionUpdate = "subscription_update"
                case subscriptionUpdateConfirm = "subscription_update_confirm"
            }

            public struct AfterCompletion: Codable, Hashable, Sendable {
                /// Configuration when `after_completion.type=hosted_confirmation`.
                public var hostedConfirmation: HostedConfirmation?
                /// Configuration when `after_completion.type=redirect`.
                public var redirect: Redirect?
                /// The specified type of behavior after the flow is completed.
                public var `type`: Type?

                public init(
                    hostedConfirmation: HostedConfirmation? = nil,
                    redirect: Redirect? = nil,
                    `type`: Type? = nil
                ) {
                    self.hostedConfirmation = hostedConfirmation
                    self.redirect = redirect
                    self.`type` = `type`
                }

                /// The specified type of behavior after the flow is completed.
                public enum `Type`: String, Codable, Hashable, Sendable {
                    case hostedConfirmation = "hosted_confirmation"
                    case portalHomepage = "portal_homepage"
                    case redirect
                }

                public struct HostedConfirmation: Codable, Hashable, Sendable {
                    /// A custom message to display to the customer after the flow is completed.
                    public var customMessage: String?

                    public init(
                        customMessage: String? = nil
                    ) {
                        self.customMessage = customMessage
                    }
                }

                public struct Redirect: Codable, Hashable, Sendable {
                    /// The URL the customer will be redirected to after the flow is completed.
                    public var returnUrl: String?

                    public init(
                        returnUrl: String? = nil
                    ) {
                        self.returnUrl = returnUrl
                    }
                }
            }

            public struct SubscriptionCancel: Codable, Hashable, Sendable {
                /// Specify a retention strategy to be used in the cancellation flow.
                public var retention: Retention?
                /// The ID of the subscription to be canceled.
                public var subscription: String?

                public init(
                    retention: Retention? = nil,
                    subscription: String? = nil
                ) {
                    self.retention = retention
                    self.subscription = subscription
                }

                public struct Retention: Codable, Hashable, Sendable {
                    /// Configuration when `retention.type=coupon_offer`.
                    public var couponOffer: CouponOffer?
                    /// Type of retention strategy that will be used.
                    public var `type`: String?

                    public init(
                        couponOffer: CouponOffer? = nil,
                        `type`: String? = nil
                    ) {
                        self.couponOffer = couponOffer
                        self.`type` = `type`
                    }

                    public struct CouponOffer: Codable, Hashable, Sendable {
                        /// The ID of the coupon to be offered.
                        public var coupon: String?

                        public init(
                            coupon: String? = nil
                        ) {
                            self.coupon = coupon
                        }
                    }
                }
            }

            public struct SubscriptionUpdate: Codable, Hashable, Sendable {
                /// The ID of the subscription to be updated.
                public var subscription: String?

                public init(
                    subscription: String? = nil
                ) {
                    self.subscription = subscription
                }
            }

            public struct SubscriptionUpdateConfirm: Codable, Hashable, Sendable {
                /// The coupon or promotion code to apply to this subscription update.
                public var discounts: [Discounts]?
                /// The subscription item to be updated through this flow.
                public var items: [Items]?
                /// The ID of the subscription to be updated.
                public var subscription: String?

                public init(
                    discounts: [Discounts]? = nil,
                    items: [Items]? = nil,
                    subscription: String? = nil
                ) {
                    self.discounts = discounts
                    self.items = items
                    self.subscription = subscription
                }

                public struct Discounts: Codable, Hashable, Sendable {
                    /// The ID of the coupon to apply to this subscription update.
                    public var coupon: String?
                    /// The ID of a promotion code to apply to this subscription update.
                    public var promotionCode: String?

                    public init(
                        coupon: String? = nil,
                        promotionCode: String? = nil
                    ) {
                        self.coupon = coupon
                        self.promotionCode = promotionCode
                    }
                }

                public struct Items: Codable, Hashable, Sendable, Identifiable {
                    public typealias ID = String
                    public let id: ID
                    /// The price the customer should subscribe to through this flow.
                    public var price: String?
                    /// Quantity for this item that the customer should subscribe to through this flow.
                    public var quantity: Int?

                    public init(
                        id: ID,
                        price: String? = nil,
                        quantity: Int? = nil
                    ) {
                        self.id = id
                        self.price = price
                        self.quantity = quantity
                    }
                }
            }

            /// The payload `type` selects; `unknown` carries a type this package does not model.
            public indirect enum Details: Hashable, Sendable {
                case subscriptionCancel(SubscriptionCancel)
                case subscriptionUpdate(SubscriptionUpdate)
                case subscriptionUpdateConfirm(SubscriptionUpdateConfirm)
                case paymentMethodUpdate
                case unknown(type: String)

                public var subscriptionCancel: SubscriptionCancel? {
                    if case .subscriptionCancel(let value) = self { return value }
                    return nil
                }
                public var subscriptionUpdate: SubscriptionUpdate? {
                    if case .subscriptionUpdate(let value) = self { return value }
                    return nil
                }
                public var subscriptionUpdateConfirm: SubscriptionUpdateConfirm? {
                    if case .subscriptionUpdateConfirm(let value) = self { return value }
                    return nil
                }

                fileprivate init(type: String, from container: KeyedDecodingContainer<CodingKeys>) throws {
                    switch type {
                    case "subscription_cancel":
                        if let value = try container.decodeIfPresent(SubscriptionCancel.self, forKey: .subscriptionCancel) {
                            self = .subscriptionCancel(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "subscription_update":
                        if let value = try container.decodeIfPresent(SubscriptionUpdate.self, forKey: .subscriptionUpdate) {
                            self = .subscriptionUpdate(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "subscription_update_confirm":
                        if let value = try container.decodeIfPresent(SubscriptionUpdateConfirm.self, forKey: .subscriptionUpdateConfirm) {
                            self = .subscriptionUpdateConfirm(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "payment_method_update": self = .paymentMethodUpdate
                    default: self = .unknown(type: type)
                    }
                }

                fileprivate func encode(into container: inout KeyedEncodingContainer<CodingKeys>) throws {
                    switch self {
                    case .subscriptionCancel(let value): try container.encode(value, forKey: .subscriptionCancel)
                    case .subscriptionUpdate(let value): try container.encode(value, forKey: .subscriptionUpdate)
                    case .subscriptionUpdateConfirm(let value): try container.encode(value, forKey: .subscriptionUpdateConfirm)
                    default: break
                    }
                }
            }
        }
    }
}
