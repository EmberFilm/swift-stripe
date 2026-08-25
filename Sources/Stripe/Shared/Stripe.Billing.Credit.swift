//
//  Stripe Namespaces.swift
//  swift-stripe-types
//
//  Created by Namespace centralization on 05/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe {
    // MARK: - Core Resources
    //    public enum Balance: Sendable {}
    public enum BalanceTransactions: Sendable {}
    public enum Charges: Sendable {}
    public enum Customers: Sendable {}
    public enum Disputes: Sendable {}
    public enum Events: Sendable {}
    public enum Files: Sendable {}
    public enum FileLinks: Sendable {}
    public enum Mandates: Sendable {}
    public enum PaymentIntents: Sendable {}
    public enum Setup: Sendable {}
    public enum Payouts: Sendable {}
    public enum Refunds: Sendable {}
    public enum Tokens: Sendable {}

    // MARK: - Billing
    public enum Billing: Sendable {}

    // MARK: - Products
    public enum Products: Sendable {}
    public enum ShippingRates: Sendable {}

    // MARK: - Payment Methods
    public enum PaymentMethods: Sendable {}
    public enum PaymentMethodConfigurations: Sendable {}
    public enum PaymentMethodDomains: Sendable {}

    // MARK: - Checkout
    public enum Checkout: Sendable {}
    public enum PaymentLinks: Sendable {}

    // MARK: - Connect
    public enum Connect: Sendable {}

    // MARK: - Reporting
    public enum Reporting: Sendable {}

    // MARK: - Capital
    public enum Capital: Sendable {}

    // MARK: - Webhooks
    public enum Webhooks: Sendable {}
    public enum WebhookEndpoint: Sendable {}

    // MARK: - Forwarding
    public enum Forwarding: Sendable {}

    // MARK: - Fraud (Radar)
    public enum Fraud: Sendable {}

    // MARK: - Terminal
    public enum Terminal: Sendable {}

    // MARK: - Tax
    public enum Tax: Sendable {}
}

// MARK: - Fraud Namespaces
extension Stripe.Fraud {
    public enum Reviews: Sendable {}
    public enum EarlyFraudWarnings: Sendable {}
    public enum ValueLists: Sendable {}
    public enum ValueListItems: Sendable {}
}

// MARK: - Billing Namespaces
extension Stripe.Billing {
    public enum Customer: Sendable {}
    public enum Credit: Sendable {}
    public enum Subscriptions: Sendable {}
    public enum Tax: Sendable {}
    public enum Usage: Sendable {}
    public enum Plans: Sendable {}
    public enum Quotes: Sendable {}
    public enum Meters: Sendable {}
    public enum MeterEvents: Sendable {}
    public enum MeterEventAdjustments: Sendable {}
    public enum MeterEventSummaries: Sendable {}
    public enum TestClocks: Sendable {}
    public enum Alerts: Sendable {}
    public enum CreditBalanceSummary: Sendable {}
    public enum UsageRecords: Sendable {}
    public enum UsageRecordSummary: Sendable {}
    public enum TaxIDs: Sendable {}
}

extension Stripe.Billing.Credit {
    public enum Balance: Sendable {}
}

extension Stripe.Billing.Tax {
    public enum IDs: Sendable {}
}
extension Stripe.Billing.Subscriptions {
    public enum Items: Sendable {}
    public enum Schedule: Sendable {}
}

extension Stripe.Billing.Customer {
    public enum Balance: Sendable {}

    public enum Portal: Sendable {}
}

// MARK: - Connect Namespaces
extension Stripe.Connect {
    public enum Accounts: Sendable {}
    public enum AccountSession: Sendable {}
}

// MARK: - Terminal Namespaces
extension Stripe.Terminal {
    public enum Readers: Sendable {}
    public enum Locations: Sendable {}
    public enum Configuration: Sendable {}
    public enum ConnectionToken: Sendable {}
    public enum HardwareOrders: Sendable {}
    public enum HardwareProducts: Sendable {}
    public enum HardwareSKUs: Sendable {}
    public enum HardwareShippingMethods: Sendable {}
}

// MARK: - Payment Methods Namespaces
extension Stripe.PaymentMethods {
    public enum Sources: Sendable {}
}

// MARK: - Products Namespaces
extension Stripe.Products {
    public enum Coupons: Sendable {}
    public enum Discounts: Sendable {}
    public enum Prices: Sendable {}
    public enum PromotionCodes: Sendable {}
    public enum ShippingRates: Sendable {}
    public enum TaxCodes: Sendable {}
    public enum TaxRates: Sendable {}
}

// MARK: - Tax Namespaces
extension Stripe.Tax {
    public enum Calculations: Sendable {}
    public enum Registrations: Sendable {}
    public enum Settings: Sendable {}
    public enum Transactions: Sendable {}
}
