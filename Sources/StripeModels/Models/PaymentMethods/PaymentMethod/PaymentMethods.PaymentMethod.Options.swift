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

// MARK: - PaymentMethod
extension Stripe.PaymentMethods.PaymentMethod {
    public enum Options {}
}

// MARK: - ACSS Debit
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum ACSSDebit {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.ACSSDebit {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Additional fields for Mandate creation.
        public var mandateOptions: MandateOptions?
        /// Bank account verification method.
        public var verificationMethod: VerificationMethod?

        public init(
            mandateOptions: MandateOptions? = nil,
            verificationMethod: VerificationMethod? = nil
        ) {
            self.mandateOptions = mandateOptions
            self.verificationMethod = verificationMethod
        }
    }

    public struct MandateOptions: Codable, Hashable, Sendable {
        /// A URL for custom mandate text.
        public var customMandateUrl: String?
        /// Description of the interval.
        ///
        /// Only required if `payment_schedule` parameter is `interval` or `combined`.
        public var intervalDescription: String?
        /// Payment schedule for the mandate.
        public var paymentSchedule: PaymentSchedule?
        /// Transaction type of the mandate.
        public var transactionType: TransactionType?

        public init(
            customMandateUrl: String? = nil,
            intervalDescription: String? = nil,
            paymentSchedule: PaymentSchedule? = nil,
            transactionType: TransactionType? = nil
        ) {
            self.customMandateUrl = customMandateUrl
            self.intervalDescription = intervalDescription
            self.paymentSchedule = paymentSchedule
            self.transactionType = transactionType
        }
    }

    public enum PaymentSchedule: String, Codable, Sendable {
        /// Payments are initiated at a regular pre-defined interval.
        case interval
        /// Payments are initiated sporadically.
        case sporadic
        /// Payments can be initiated at a pre-defined interval or sporadically.
        case combined
    }

    public enum TransactionType: String, Codable, Sendable {
        /// Transactions are made for personal reasons.
        case personal
        /// Transactions are made for business reasons.
        case business
    }

    public enum VerificationMethod: String, Codable, Sendable {
        /// Instant verification with fallback to microdeposits.
        case automatic
        /// Instant verification.
        case instant
        /// Verification using microdeposits.
        case microdeposits
    }
}

// MARK: - Affirm
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Affirm {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Affirm {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Controls when the funds will be captured from the customer's account.
        public var captureMethod: CaptureMethod?
        /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            captureMethod: CaptureMethod? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.captureMethod = captureMethod
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum CaptureMethod: String, Codable, Sendable {
        /// Use manual if you intend to place the funds on hold.
        case manual
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method.
        case none
    }
}

// MARK: - Afterpay Clearpay
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum AfterpayClearpay {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.AfterpayClearpay {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Controls when the funds will be captured from the customer's account.
        public var captureMethod: CaptureMethod?
        /// Order identifier shown to the merchant in Afterpay's online portal.
        public var reference: String?
        /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            captureMethod: CaptureMethod? = nil,
            reference: String? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.captureMethod = captureMethod
            self.reference = reference
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum CaptureMethod: String, Codable, Sendable {
        case manual
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - Alipay
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Alipay {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Alipay {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case offSession = "off_session"
        case none
    }
}

// MARK: - AU Becs Debit
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum AUBecsDebit {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.AUBecsDebit {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case onSession = "on_session"
        case offSession = "off_session"
        case none
    }
}

// MARK: - Bacs Debit
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum BacsDebit {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.BacsDebit {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case onSession = "on_session"
        case offSession = "off_session"
        case none
    }
}

// MARK: - Bancontact
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Bancontact {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Bancontact {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Preferred language of the Bancontact authorization page.
        public var preferredLanguage: String?
        /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            preferredLanguage: String? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.preferredLanguage = preferredLanguage
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case offSession = "off_session"
        case none
    }
}

// MARK: - Blik
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Blik {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Blik {
    public struct Configuration: Codable, Hashable, Sendable {
        public init() {}
    }
}

// MARK: - Boleto
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Boleto {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Boleto {
    public struct Configuration: Codable, Hashable, Sendable {
        /// The number of calendar days before a Boleto voucher expires.
        public var expiresAfterDays: Int?
        /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            expiresAfterDays: Int? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.expiresAfterDays = expiresAfterDays
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case onSession = "on_session"
        case offSession = "off_session"
        case none
    }
}

// MARK: - Card
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Card {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Card {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Controls when the funds will be captured from the customer's account.
        public var captureMethod: CaptureMethod?
        /// Installment details for this payment (Mexico only).
        public var installments: Installments?
        /// Configuration options for setting up an eMandate for cards issued in India.
        public var mandateOptions: MandateOptions?
        /// Selected network to process this PaymentIntent on.
        public var network: String?
        /// 3D Secure configuration.
        public var requestThreeDSecure: String?
        /// Future usage settings.
        public var setupFutureUsage: SetupFutureUsage?
        /// Statement descriptor suffix in Kana.
        public var statementDescriptorSuffixKana: String?
        /// Statement descriptor suffix in Kanji.
        public var statementDescriptorSuffixKanji: String?

        public init(
            captureMethod: CaptureMethod? = nil,
            installments: Installments? = nil,
            mandateOptions: MandateOptions? = nil,
            network: String? = nil,
            requestThreeDSecure: String? = nil,
            setupFutureUsage: SetupFutureUsage? = nil,
            statementDescriptorSuffixKana: String? = nil,
            statementDescriptorSuffixKanji: String? = nil
        ) {
            self.captureMethod = captureMethod
            self.installments = installments
            self.mandateOptions = mandateOptions
            self.network = network
            self.requestThreeDSecure = requestThreeDSecure
            self.setupFutureUsage = setupFutureUsage
            self.statementDescriptorSuffixKana = statementDescriptorSuffixKana
            self.statementDescriptorSuffixKanji = statementDescriptorSuffixKanji
        }
    }

    public enum CaptureMethod: String, Codable, Sendable {
        case manual
    }

    public struct Installments: Codable, Hashable, Sendable {
        public var availablePlans: [InstallmentPlan]?
        public var enabled: Bool?
        public var plan: InstallmentPlan?

        public init(
            availablePlans: [InstallmentPlan]? = nil,
            enabled: Bool? = nil,
            plan: InstallmentPlan? = nil
        ) {
            self.availablePlans = availablePlans
            self.enabled = enabled
            self.plan = plan
        }
    }

    public struct InstallmentPlan: Codable, Hashable, Sendable {
        public var count: Int?
        public var interval: String?
        public var type: String?

        public init(
            count: Int? = nil,
            interval: String? = nil,
            type: String? = nil
        ) {
            self.count = count
            self.interval = interval
            self.type = type
        }
    }

    public struct MandateOptions: Codable, Hashable, Sendable {
        public var amount: Int?
        public var amountType: String?
        public var description: String?
        public var endDate: Date?
        public var interval: String?
        public var intervalCount: Int?
        public var reference: String?
        public var startDate: Date?
        public var supportedTypes: [String]?

        public init(
            amount: Int? = nil,
            amountType: String? = nil,
            description: String? = nil,
            endDate: Date? = nil,
            interval: String? = nil,
            intervalCount: Int? = nil,
            reference: String? = nil,
            startDate: Date? = nil,
            supportedTypes: [String]? = nil
        ) {
            self.amount = amount
            self.amountType = amountType
            self.description = description
            self.endDate = endDate
            self.interval = interval
            self.intervalCount = intervalCount
            self.reference = reference
            self.startDate = startDate
            self.supportedTypes = supportedTypes
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case onSession = "on_session"
        case offSession = "off_session"
        case none
    }
}

// MARK: - Card Present
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum CardPresent {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.CardPresent {
    public struct Configuration: Codable, Hashable, Sendable {
        public var captureMethod: CaptureMethod?
        public var requestExtendedAuthorization: Bool?
        public var requestIncrementalAuthorizationSupport: Bool?
        public var routing: Routing?

        public init(
            captureMethod: CaptureMethod? = nil,
            requestExtendedAuthorization: Bool? = nil,
            requestIncrementalAuthorizationSupport: Bool? = nil,
            routing: Routing? = nil
        ) {
            self.captureMethod = captureMethod
            self.requestExtendedAuthorization = requestExtendedAuthorization
            self.requestIncrementalAuthorizationSupport = requestIncrementalAuthorizationSupport
            self.routing = routing
        }
    }

    public enum CaptureMethod: String, Codable, Sendable {
        case manualPreferred = "manual_preferred"
    }

    public struct Routing: Codable, Hashable, Sendable {
        public var requestedPriority: RequestedPriority?

        public init(
            requestedPriority: RequestedPriority? = nil
        ) {
            self.requestedPriority = requestedPriority
        }
    }

    public enum RequestedPriority: String, Codable, Sendable {
        case domestic
        case international
    }
}

// Previous code remains the same until Customer Balance...

// MARK: - Customer Balance
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum CustomerBalance {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.CustomerBalance {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Configuration for the bank transfer funding type.
        public var bankTransfer: BankTransfer?
        /// The funding method type to be used when there are not enough funds.
        public var fundingType: String?
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            bankTransfer: BankTransfer? = nil,
            fundingType: String? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.bankTransfer = bankTransfer
            self.fundingType = fundingType
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public struct BankTransfer: Codable, Hashable, Sendable {
        /// Configuration for EU bank transfer.
        public var euBankTransfer: EUBankTransfer?
        /// List of address types for financial addresses.
        public var requestedAddressTypes: RequestedAddressType?
        /// Bank transfer type.
        public var type: TransferType?

        public init(
            euBankTransfer: EUBankTransfer? = nil,
            requestedAddressTypes: RequestedAddressType? = nil,
            type: TransferType? = nil
        ) {
            self.euBankTransfer = euBankTransfer
            self.requestedAddressTypes = requestedAddressTypes
            self.type = type
        }
    }

    public struct EUBankTransfer: Codable, Hashable, Sendable {
        /// The desired country code of the bank account.
        public var country: String?

        public init(
            country: String? = nil
        ) {
            self.country = country
        }
    }

    public enum RequestedAddressType: String, Codable, Sendable {
        case sortCode = "sort_code"
        case zengin
        case sepa
        case spei
        case iban
    }

    public enum TransferType: String, Codable, Sendable {
        case euBankTransfer = "eu_bank_transfer"
        case gbBankTransfer = "gb_bank_transfer"
        case jpBankTransfer = "jp_bank_transfer"
        case mxBankTransfer = "mx_bank_transfer"
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - EPS
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum EPS {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.EPS {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - FPX
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum FPX {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.FPX {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - Giropay
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Giropay {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Giropay {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - GrabPay
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum GrabPay {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.GrabPay {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - Ideal
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Ideal {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Ideal {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case offSession = "off_session"
        case none
    }
}

// MARK: - InteracPresent
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum InteracPresent {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.InteracPresent {
    public struct Configuration: Codable, Hashable, Sendable {
        public init() {}
    }
}

// MARK: - Klarna
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Klarna {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Klarna {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Controls when the funds will be captured.
        public var captureMethod: CaptureMethod?
        /// Preferred locale of the Klarna checkout page.
        public var preferredLocale: String?
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            captureMethod: CaptureMethod? = nil,
            preferredLocale: String? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.captureMethod = captureMethod
            self.preferredLocale = preferredLocale
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum CaptureMethod: String, Codable, Sendable {
        case manual
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - Konbini
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Konbini {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Konbini {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Optional confirmation code string.
        public var confirmationNumber: String?
        /// Days until expiration.
        public var expiringAfterdays: Int?
        /// Expiration timestamp.
        public var expiresAt: Date?
        /// Product description.
        public var productDescription: String?
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            confirmationNumber: String? = nil,
            expiringAfterdays: Int? = nil,
            expiresAt: Date? = nil,
            productDescription: String? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.confirmationNumber = confirmationNumber
            self.expiringAfterdays = expiringAfterdays
            self.expiresAt = expiresAt
            self.productDescription = productDescription
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - Link
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Link {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Link {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Controls when the funds will be captured.
        public var captureMethod: CaptureMethod?
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            captureMethod: CaptureMethod? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.captureMethod = captureMethod
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum CaptureMethod: String, Codable, Sendable {
        case manual
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case offSession = "off_session"
        case none
    }
}

// MARK: - OXXO
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum OXXO {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.OXXO {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Days until expiration.
        public var expiresAfterDays: Int?
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            expiresAfterDays: Int? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.expiresAfterDays = expiresAfterDays
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - P24
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum P24 {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.P24 {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - Paynow
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Paynow {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Paynow {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - Pix
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Pix {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Pix {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Seconds until expiration.
        public var expiresAfterSeconds: Int?
        /// Expiration timestamp.
        public var expiresAt: Int?
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            expiresAfterSeconds: Int? = nil,
            expiresAt: Int? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.expiresAfterSeconds = expiresAfterSeconds
            self.expiresAt = expiresAt
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - PromptPay
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum PromptPay {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.PromptPay {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}

// MARK: - SEPA Debit
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum SepaDebit {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.SepaDebit {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Additional fields for mandate creation.
        public var mandateOptions: MandateOptions?
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            mandateOptions: MandateOptions? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.mandateOptions = mandateOptions
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public struct MandateOptions: Codable, Hashable, Sendable {
        public init() {}
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case onSession = "on_session"
        case offSession = "off_session"
        case none
    }
}

// MARK: - Sofort
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum Sofort {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.Sofort {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Preferred language for the authorization page.
        public var preferredLanguage: String?
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            preferredLanguage: String? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.preferredLanguage = preferredLanguage
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case offSession = "off_session"
        case none
    }
}

// MARK: - US Bank Account
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum USBankAccount {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.USBankAccount {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Additional fields for Financial Connections Session creation.
        public var financialConnections: FinancialConnections?
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?
        /// Bank account verification method.
        public var verificationMethod: VerificationMethod?

        public init(
            financialConnections: FinancialConnections? = nil,
            setupFutureUsage: SetupFutureUsage? = nil,
            verificationMethod: VerificationMethod? = nil
        ) {
            self.financialConnections = financialConnections
            self.setupFutureUsage = setupFutureUsage
            self.verificationMethod = verificationMethod
        }
    }

    public struct FinancialConnections: Codable, Hashable, Sendable {
        /// The list of permissions to request.
        ///
        /// The `payment_method` permission must be included.
        public var permissions: [Permission]?

        public init(
            permissions: [Permission]? = nil
        ) {
            self.permissions = permissions
        }
    }

    public enum Permission: String, Codable, Sendable {
        /// Allows the creation of a payment method from the account.
        case paymentMethod = "payment_method"
        /// Allows accessing balance data from the account.
        case balances
        /// Allows accessing transactions data from the account.
        case transactions
        /// Allows accessing ownership data from the account.
        case ownership
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        /// Use when customer is present in checkout flow.
        case onSession = "on_session"
        /// Use when customer may or may not be present.
        case offSession = "off_session"
        /// Do not reuse payment method.
        case none
    }

    public enum VerificationMethod: String, Codable, Sendable {
        /// Instant verification with fallback to microdeposits.
        case automatic
        /// Instant verification only.
        case instant
        /// Verification using microdeposits.
        case microdeposits
    }
}

// MARK: - WechatPay
extension Stripe.PaymentMethods.PaymentMethod.Options {
    public enum WechatPay {}
}

extension Stripe.PaymentMethods.PaymentMethod.Options.WechatPay {
    public struct Configuration: Codable, Hashable, Sendable {
        /// The app ID registered with WeChat Pay.
        public var appId: String?
        /// The client type for customer payment.
        public var client: Client?
        /// Future payment settings.
        public var setupFutureUsage: SetupFutureUsage?

        public init(
            appId: String? = nil,
            client: Client? = nil,
            setupFutureUsage: SetupFutureUsage? = nil
        ) {
            self.appId = appId
            self.client = client
            self.setupFutureUsage = setupFutureUsage
        }
    }

    public enum Client: String, Codable, Sendable {
        /// Web browser payment.
        case web
        /// iOS app payment.
        case ios
        /// Android app payment.
        case android
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case none
    }
}
