//
//  File.swift
//  swift-stripe
//
//  Created by Coen ten Thije Boonkkamp on 07/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/customer_sessions/object.md

extension Stripe.Customers.Customer {
    /// The Customer Session object that includes a single-use client secret for client-side API access.
    public struct Session: Codable, Hashable, Sendable {
        /// The client secret of this Customer Session. Used on the client to set up secure access to the given customer.
        public var clientSecret: String

        /// This hash defines which component is enabled and the features it supports.
        public var components: Components

        /// The Customer the Customer Session was created for.
        @ExpandableOf<Stripe.Customers.Customer> public var customer: Stripe.Customers.Customer.ID?

        /// The timestamp at which this Customer Session will expire.
        public var expiresAt: Int

        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool

        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String

        public init(
            clientSecret: String,
            components: Components,
            customer: Stripe.Customers.Customer.ID,
            expiresAt: Int,
            livemode: Bool,
            object: String
        ) {
            self.clientSecret = clientSecret
            self.components = components
            self._customer = Expandable(id: customer)
            self.expiresAt = expiresAt
            self.livemode = livemode
            self.object = object
        }
    }
}

extension Stripe.Customers.Customer.Session {
    public struct Components: Codable, Hashable, Sendable {
        /// Configuration for buy button.
        public var buyButton: BuyButton?

        /// Configuration for the Payment Element.
        public var paymentElement: PaymentElement?

        /// Configuration for the pricing table.
        public var pricingTable: PricingTable?

        private enum CodingKeys: String, CodingKey {
            case buyButton
            case paymentElement
            case pricingTable
        }

        public init(
            buyButton: BuyButton? = nil,
            paymentElement: PaymentElement? = nil,
            pricingTable: PricingTable? = nil
        ) {
            self.buyButton = buyButton
            self.paymentElement = paymentElement
            self.pricingTable = pricingTable
        }
    }
}

extension Stripe.Customers.Customer.Session.Components {
    public struct BuyButton: Codable, Hashable, Sendable {
        /// Whether the buy button is enabled.
        public var enabled: Bool

        public init(enabled: Bool) {
            self.enabled = enabled
        }
    }

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
    }

    public struct PricingTable: Codable, Hashable, Sendable {
        /// Whether the pricing table is enabled.
        public var enabled: Bool

        public init(enabled: Bool) {
            self.enabled = enabled
        }
    }
}

extension Stripe.Customers.Customer.Session.Components.PaymentElement {
    public struct Features: Codable, Hashable, Sendable {
        /// A list of allow_redisplay values that controls which saved payment methods the Payment Element displays.
        public var paymentMethodAllowRedisplayFilters: [AllowRedisplayFilter]?

        /// Controls whether or not the Payment Element shows saved payment methods.
        public var paymentMethodRedisplay: Feature?

        /// Determines the max number of saved payment methods for the Payment Element to display.
        public var paymentMethodRedisplayLimit: Int?

        /// Controls whether the Payment Element displays the option to remove a saved payment method.
        public var paymentMethodRemove: Feature?

        /// Controls whether the Payment Element displays a checkbox offering to save a new payment method.
        public var paymentMethodSave: Feature?

        /// When using PaymentIntents and the customer checks the save checkbox, this determines the setup_future_usage value.
        public var paymentMethodSaveUsage: SaveUsage?

        private enum CodingKeys: String, CodingKey {
            case paymentMethodAllowRedisplayFilters
            case paymentMethodRedisplay
            case paymentMethodRedisplayLimit
            case paymentMethodRemove
            case paymentMethodSave
            case paymentMethodSaveUsage
        }

        public init(
            paymentMethodAllowRedisplayFilters: [AllowRedisplayFilter]? = nil,
            paymentMethodRedisplay: Feature? = nil,
            paymentMethodRedisplayLimit: Int? = nil,
            paymentMethodRemove: Feature? = nil,
            paymentMethodSave: Feature? = nil,
            paymentMethodSaveUsage: SaveUsage? = nil
        ) {
            self.paymentMethodAllowRedisplayFilters = paymentMethodAllowRedisplayFilters
            self.paymentMethodRedisplay = paymentMethodRedisplay
            self.paymentMethodRedisplayLimit = paymentMethodRedisplayLimit
            self.paymentMethodRemove = paymentMethodRemove
            self.paymentMethodSave = paymentMethodSave
            self.paymentMethodSaveUsage = paymentMethodSaveUsage
        }
    }
}

extension Stripe.Customers.Customer.Session.Components.PaymentElement.Features {
    /// Controls whether a payment method can be redisplayed.
    public enum AllowRedisplayFilter: String, Codable, Sendable {
        /// This payment method can always be shown to a customer in a checkout flow.
        case always
        /// This payment method can't always be shown to a customer in a checkout flow.
        case limited
        /// Default value for payment methods where allow_redisplay wasn't set.
        case unspecified
    }

    /// Controls whether a feature is enabled or disabled.
    public enum Feature: String, Codable, Sendable {
        case disabled
        case enabled
    }

    /// Determines when a payment method can be reused.
    public enum SaveUsage: String, Codable, Sendable {
        /// Use when customer may or may not be present in checkout flow.
        case offSession = "off_session"
        /// Use when customer will be present in checkout flow.
        case onSession = "on_session"
    }
}
