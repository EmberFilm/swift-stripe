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

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.WebElements {
    /// Payment Element for collecting payment method details.
    ///
    /// See: https://docs.stripe.com/payments/payment-element
    public struct Payment: Codable, Hashable, Sendable {
        /// The type of Element being created.
        public var type: String { "payment" }
        /// Options for creating the Payment Element.
        public let options: Options?

        public init(options: Options? = nil) {
            self.options = options
        }
    }
}

// MARK: - Options

extension Stripe.WebElements.Payment {
    public struct Options: Codable, Hashable, Sendable {
        public let layout: Layout?
        public let defaultValues: DefaultValues?
        public let business: Business?
        public let paymentMethodOrder: [String]?
        public let fields: Fields?
        public let readOnly: Bool?
        public let terms: Terms?
        public let wallets: Wallets?
        public let applePay: ApplePay?

        public init(
            layout: Layout? = nil,
            defaultValues: DefaultValues? = nil,
            business: Business? = nil,
            paymentMethodOrder: [String]? = nil,
            fields: Fields? = nil,
            readOnly: Bool? = nil,
            terms: Terms? = nil,
            wallets: Wallets? = nil,
            applePay: ApplePay? = nil
        ) {
            self.layout = layout
            self.defaultValues = defaultValues
            self.business = business
            self.paymentMethodOrder = paymentMethodOrder
            self.fields = fields
            self.readOnly = readOnly
            self.terms = terms
            self.wallets = wallets
            self.applePay = applePay
        }
    }
}

// MARK: - Layout

extension Stripe.WebElements.Payment {
    public struct Layout: Codable, Hashable, Sendable {
        public let type: LayoutType
        public let defaultCollapsed: Bool?
        public let radios: Bool?
        public let spacedAccordionItems: Bool?
        public let visibleAccordionItemsCount: Int?

        public init(
            type: LayoutType,
            defaultCollapsed: Bool? = nil,
            radios: Bool? = nil,
            spacedAccordionItems: Bool? = nil,
            visibleAccordionItemsCount: Int? = nil
        ) {
            self.type = type
            self.defaultCollapsed = defaultCollapsed
            self.radios = radios
            self.spacedAccordionItems = spacedAccordionItems
            self.visibleAccordionItemsCount = visibleAccordionItemsCount
        }
    }

    public enum LayoutType: String, Codable, Sendable {
        case accordion
        case tabs
    }
}

// MARK: - Default Values

extension Stripe.WebElements.Payment {
    public struct DefaultValues: Codable, Hashable, Sendable {
        public let billingDetails: BillingDetails?
        public let paymentMethods: PaymentMethods?

        public init(
            billingDetails: BillingDetails? = nil,
            paymentMethods: PaymentMethods? = nil
        ) {
            self.billingDetails = billingDetails
            self.paymentMethods = paymentMethods
        }
    }
}

extension Stripe.WebElements.Payment.DefaultValues {
    public struct BillingDetails: Codable, Hashable, Sendable {
        public let name: String?
        public let email: String?
        public let phone: String?
        public let address: Address?

        public init(
            name: String? = nil,
            email: String? = nil,
            phone: String? = nil,
            address: Address? = nil
        ) {
            self.name = name
            self.email = email
            self.phone = phone
            self.address = address
        }
    }

    public struct Address: Codable, Hashable, Sendable {
        public let line1: String?
        public let line2: String?
        public let city: String?
        public let state: String?
        public let country: String?
        public let postalCode: String?

        public init(
            line1: String? = nil,
            line2: String? = nil,
            city: String? = nil,
            state: String? = nil,
            country: String? = nil,
            postalCode: String? = nil
        ) {
            self.line1 = line1
            self.line2 = line2
            self.city = city
            self.state = state
            self.country = country
            self.postalCode = postalCode
        }
    }
}

extension Stripe.WebElements.Payment.DefaultValues {
    public struct PaymentMethods: Codable, Hashable, Sendable {
        public let ideal: Ideal?
        public let card: Card?

        public init(
            ideal: Ideal? = nil,
            card: Card? = nil
        ) {
            self.ideal = ideal
            self.card = card
        }
    }

    public struct Ideal: Codable, Hashable, Sendable {
        public let bank: String?

        public init(bank: String? = nil) {
            self.bank = bank
        }
    }

    public struct Card: Codable, Hashable, Sendable {
        public let network: [String]?

        public init(network: [String]? = nil) {
            self.network = network
        }
    }
}

// MARK: - Business

extension Stripe.WebElements.Payment {
    public struct Business: Codable, Hashable, Sendable {
        public let name: String?

        public init(name: String? = nil) {
            self.name = name
        }
    }
}

// MARK: - Fields

extension Stripe.WebElements.Payment {
    public struct Fields: Codable, Hashable, Sendable {
        public let billingDetails: BillingDetailsConfig?

        public init(billingDetails: BillingDetailsConfig? = nil) {
            self.billingDetails = billingDetails
        }
    }

    public struct BillingDetailsConfig: Codable, Hashable, Sendable {
        public let name: FieldOption?
        public let email: FieldOption?
        public let phone: FieldOption?
        public let address: AddressConfig?

        public init(
            name: FieldOption? = nil,
            email: FieldOption? = nil,
            phone: FieldOption? = nil,
            address: AddressConfig? = nil
        ) {
            self.name = name
            self.email = email
            self.phone = phone
            self.address = address
        }
    }

    public enum FieldOption: String, Codable, Sendable {
        case never
        case auto
    }

    public enum AddressOption: String, Codable, Sendable {
        case never
        case auto
        case ifRequired = "if_required"
    }

    public struct AddressConfig: Codable, Hashable, Sendable {
        public let line1: FieldOption?
        public let line2: FieldOption?
        public let city: FieldOption?
        public let state: FieldOption?
        public let country: FieldOption?
        public let postalCode: FieldOption?

        public init(
            line1: FieldOption? = nil,
            line2: FieldOption? = nil,
            city: FieldOption? = nil,
            state: FieldOption? = nil,
            country: FieldOption? = nil,
            postalCode: FieldOption? = nil
        ) {
            self.line1 = line1
            self.line2 = line2
            self.city = city
            self.state = state
            self.country = country
            self.postalCode = postalCode
        }
    }
}

// MARK: - Terms

extension Stripe.WebElements.Payment {
    public struct Terms: Codable, Hashable, Sendable {
        public let applePay: TermOption?
        public let auBecsDebit: TermOption?
        public let bancontact: TermOption?
        public let card: TermOption?
        public let cashapp: TermOption?
        public let googlePay: TermOption?
        public let ideal: TermOption?
        public let paypal: TermOption?
        public let sepaDebit: TermOption?
        public let sofort: TermOption?
        public let usBankAccount: TermOption?

        public init(
            applePay: TermOption? = nil,
            auBecsDebit: TermOption? = nil,
            bancontact: TermOption? = nil,
            card: TermOption? = nil,
            cashapp: TermOption? = nil,
            googlePay: TermOption? = nil,
            ideal: TermOption? = nil,
            paypal: TermOption? = nil,
            sepaDebit: TermOption? = nil,
            sofort: TermOption? = nil,
            usBankAccount: TermOption? = nil
        ) {
            self.applePay = applePay
            self.auBecsDebit = auBecsDebit
            self.bancontact = bancontact
            self.card = card
            self.cashapp = cashapp
            self.googlePay = googlePay
            self.ideal = ideal
            self.paypal = paypal
            self.sepaDebit = sepaDebit
            self.sofort = sofort
            self.usBankAccount = usBankAccount
        }
    }

    public enum TermOption: String, Codable, Sendable {
        case auto
        case always
        case never
    }
}

// MARK: - Wallets

extension Stripe.WebElements.Payment {
    public struct Wallets: Codable, Hashable, Sendable {
        public let applePay: WalletOption?
        public let googlePay: WalletOption?

        public init(
            applePay: WalletOption? = nil,
            googlePay: WalletOption? = nil
        ) {
            self.applePay = applePay
            self.googlePay = googlePay
        }
    }

    public enum WalletOption: String, Codable, Sendable {
        case auto
        case never
    }
}

// MARK: - Apple Pay

extension Stripe.WebElements.Payment {
    public struct ApplePay: Codable, Hashable, Sendable {
        public let recurringPaymentRequest: RecurringPaymentRequest?
        public let deferredPaymentRequest: DeferredPaymentRequest?
        public let automaticReloadPaymentRequest: AutomaticReloadPaymentRequest?

        public init(
            recurringPaymentRequest: RecurringPaymentRequest? = nil,
            deferredPaymentRequest: DeferredPaymentRequest? = nil,
            automaticReloadPaymentRequest: AutomaticReloadPaymentRequest? = nil
        ) {
            self.recurringPaymentRequest = recurringPaymentRequest
            self.deferredPaymentRequest = deferredPaymentRequest
            self.automaticReloadPaymentRequest = automaticReloadPaymentRequest
        }
    }
}

// MARK: - Apple Pay Recurring Payment

extension Stripe.WebElements.Payment.ApplePay {
    public struct RecurringPaymentRequest: Codable, Hashable, Sendable {
        public let paymentDescription: String
        public let managementURL: String
        public let regularBilling: RegularBilling
        public let trialBilling: TrialBilling?
        public let billingAgreement: String?

        public init(
            paymentDescription: String,
            managementURL: String,
            regularBilling: RegularBilling,
            trialBilling: TrialBilling? = nil,
            billingAgreement: String? = nil
        ) {
            self.paymentDescription = paymentDescription
            self.managementURL = managementURL
            self.regularBilling = regularBilling
            self.trialBilling = trialBilling
            self.billingAgreement = billingAgreement
        }
    }

    public struct RegularBilling: Codable, Hashable, Sendable {
        public let amount: Int
        public let label: String
        public let recurringPaymentStartDate: Date?
        public let recurringPaymentEndDate: Date?
        public let recurringPaymentIntervalUnit: IntervalUnit?
        public let recurringPaymentIntervalCount: Int?

        public init(
            amount: Int,
            label: String,
            recurringPaymentStartDate: Date? = nil,
            recurringPaymentEndDate: Date? = nil,
            recurringPaymentIntervalUnit: IntervalUnit? = nil,
            recurringPaymentIntervalCount: Int? = nil
        ) {
            self.amount = amount
            self.label = label
            self.recurringPaymentStartDate = recurringPaymentStartDate
            self.recurringPaymentEndDate = recurringPaymentEndDate
            self.recurringPaymentIntervalUnit = recurringPaymentIntervalUnit
            self.recurringPaymentIntervalCount = recurringPaymentIntervalCount
        }
    }

    public struct TrialBilling: Codable, Hashable, Sendable {
        public let amount: Int
        public let label: String
        public let recurringPaymentStartDate: Date?
        public let recurringPaymentEndDate: Date?
        public let recurringPaymentIntervalUnit: IntervalUnit?
        public let recurringPaymentIntervalCount: Int?

        public init(
            amount: Int,
            label: String,
            recurringPaymentStartDate: Date? = nil,
            recurringPaymentEndDate: Date? = nil,
            recurringPaymentIntervalUnit: IntervalUnit? = nil,
            recurringPaymentIntervalCount: Int? = nil
        ) {
            self.amount = amount
            self.label = label
            self.recurringPaymentStartDate = recurringPaymentStartDate
            self.recurringPaymentEndDate = recurringPaymentEndDate
            self.recurringPaymentIntervalUnit = recurringPaymentIntervalUnit
            self.recurringPaymentIntervalCount = recurringPaymentIntervalCount
        }
    }

    public enum IntervalUnit: String, Codable, Sendable {
        case year
        case month
        case day
        case hour
        case minute
    }
}

// MARK: - Apple Pay Deferred Payment

extension Stripe.WebElements.Payment.ApplePay {
    public struct DeferredPaymentRequest: Codable, Hashable, Sendable {
        public let paymentDescription: String
        public let managementURL: String
        public let deferredBilling: DeferredBilling
        public let billingAgreement: String?
        public let freeCancellationDate: Date?
        public let freeCancellationDateTimeZone: String?

        public init(
            paymentDescription: String,
            managementURL: String,
            deferredBilling: DeferredBilling,
            billingAgreement: String? = nil,
            freeCancellationDate: Date? = nil,
            freeCancellationDateTimeZone: String? = nil
        ) {
            self.paymentDescription = paymentDescription
            self.managementURL = managementURL
            self.deferredBilling = deferredBilling
            self.billingAgreement = billingAgreement
            self.freeCancellationDate = freeCancellationDate
            self.freeCancellationDateTimeZone = freeCancellationDateTimeZone
        }
    }

    public struct DeferredBilling: Codable, Hashable, Sendable {
        public let amount: Int
        public let label: String
        public let deferredPaymentDate: Date

        public init(
            amount: Int,
            label: String,
            deferredPaymentDate: Date
        ) {
            self.amount = amount
            self.label = label
            self.deferredPaymentDate = deferredPaymentDate
        }
    }
}

// MARK: - Apple Pay Automatic Reload

extension Stripe.WebElements.Payment.ApplePay {
    public struct AutomaticReloadPaymentRequest: Codable, Hashable, Sendable {
        public let paymentDescription: String
        public let managementURL: String
        public let automaticReloadBilling: AutomaticReloadBilling
        public let billingAgreement: String?

        public init(
            paymentDescription: String,
            managementURL: String,
            automaticReloadBilling: AutomaticReloadBilling,
            billingAgreement: String? = nil
        ) {
            self.paymentDescription = paymentDescription
            self.managementURL = managementURL
            self.automaticReloadBilling = automaticReloadBilling
            self.billingAgreement = billingAgreement
        }
    }

    public struct AutomaticReloadBilling: Codable, Hashable, Sendable {
        public let amount: Int
        public let label: String
        public let automaticReloadPaymentThresholdAmount: Int

        public init(
            amount: Int,
            label: String,
            automaticReloadPaymentThresholdAmount: Int
        ) {
            self.amount = amount
            self.label = label
            self.automaticReloadPaymentThresholdAmount = automaticReloadPaymentThresholdAmount
        }
    }
}
