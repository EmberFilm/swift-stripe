//
//  PaymentMethodConfiguration.swift
//  Stripe Types Models
//
//  Created for swift-stripe-types on 14/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/payment_method_configurations/object.md

// The Configuration struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.PaymentMethodConfigurations.Configuration` that the generator spells differently.

// MARK: - PaymentMethodConfig
extension Stripe.PaymentMethodConfigurations {
    /// Configuration for a specific payment method.
    public struct PaymentMethodConfig: Codable, Hashable, Sendable {
        /// Display preference for this payment method.
        public var displayPreference: DisplayPreference?

        private enum CodingKeys: String, CodingKey {
            case displayPreference
        }

        public init(displayPreference: DisplayPreference? = nil) {
            self.displayPreference = displayPreference
        }
    }

    /// Display preference configuration.
    public struct DisplayPreference: Codable, Hashable, Sendable {
        /// The display preference value.
        public var preference: Preference

        public init(preference: Preference) {
            self.preference = preference
        }
    }

    /// Display preference values.
    public enum Preference: String, Codable, CaseIterable, Sendable {
        /// Don't display the payment method.
        case none
        /// Payment method is disabled.
        case off
        /// Payment method is enabled.
        case on
    }
}
