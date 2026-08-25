//
//  InvoicePaymentMethodOptions.swift
//
//
//  Created by Andrew Edwards on 5/12/23.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Invoice.PaymentSettings {
    public struct PaymentMethodOptions: Codable, Hashable, Sendable {
        /// If paying by `acss_debit`, this sub-hash contains details about the Canadian pre-authorized debit payment method options to pass to the invoice's PaymentIntent.
        public var acssDebit: AcssDebit?
        /// If paying by `bancontact`, this sub-hash contains details about the Bancontact payment method options to pass to the invoice's PaymentIntent.
        public var bancontact: Bancontact?
        /// If paying by `card`, this sub-hash contains details about the Card payment method options to pass to the invoice's PaymentIntent.
        public var card: Card?
        /// If paying by `customer_balance`, this sub-hash contains details about the Bank transfer payment method options to pass to the invoice's PaymentIntent.
        public var customerBalance: CustomerBalance?
        /// If paying by `konbini`, this sub-hash contains details about the Konbini payment method options to pass to the invoice's PaymentIntent.
        public var konbini: Konbini?
        /// If paying by `us_bank_account`, this sub-hash contains details about the ACH direct debit payment method options to pass to the invoice's PaymentIntent.
        public var usBankAccount: USBankAccount?

        public init(
            acssDebit: AcssDebit? = nil,
            bancontact: Bancontact? = nil,
            card: Card? = nil,
            customerBalance: CustomerBalance? = nil,
            konbini: Konbini? = nil,
            usBankAccount: USBankAccount? = nil
        ) {
            self.acssDebit = acssDebit
            self.bancontact = bancontact
            self.card = card
            self.customerBalance = customerBalance
            self.konbini = konbini
            self.usBankAccount = usBankAccount
        }
    }
}

// MARK: ACSS Debit
extension Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions {
    public struct AcssDebit: Codable, Hashable, Sendable {
        /// Additional fields for Mandate creation
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
}

extension Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions.AcssDebit {
    public struct MandateOptions: Codable, Hashable, Sendable {
        /// Transaction type of the mandate.
        public var transactionType: TransactionType?

        public init(
            transactionType: TransactionType? = nil
        ) {
            self.transactionType = transactionType
        }
    }

    public enum TransactionType: String, Codable, Sendable {
        /// Transactions are made for personal reasons
        case personal
        /// Transactions are made for business reasons
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

// MARK: Bancontact
extension Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions {
    public struct Bancontact: Codable, Hashable, Sendable {
        /// Preferred language of the Bancontact authorization page that the customer is redirected to.
        public var preferredLanguage: String?

        public init(
            preferredLanguage: String? = nil
        ) {
            self.preferredLanguage = preferredLanguage
        }
    }
}

// MARK: Card
extension Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions {
    public struct Card: Codable, Hashable, Sendable {
        /// Installment details for this Invoice (Mexico only). For more information, see the installments integration guide.
        public var installments: Installments?

        /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and other requirements. However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Read our guide on manually requesting 3D Secure for more information on how this configuration interacts with Radar and our SCA Engine.
        public var requestThreeDSecure: RequestThreeDSecure?

        public init(
            installments: Installments? = nil,
            requestThreeDSecure: RequestThreeDSecure? = nil
        ) {
            self.installments = installments
            self.requestThreeDSecure = requestThreeDSecure
        }
    }
}

extension Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions.Card {
    public struct Installments: Codable, Hashable, Sendable {
        /// Whether Installments are enabled for this Invoice.
        public var enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }

    public enum RequestThreeDSecure: String, Codable, Sendable {
        /// Triggers 3D Secure authentication only if it is required.
        case automatic
        /// Requires 3D Secure authentication if it is available.
        case any
    }
}

// MARK: Customer Balance
extension Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions {
    public struct CustomerBalance: Codable, Hashable, Sendable {
        /// Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
        public var bankTransfer: BankTransfer?
        /// The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: `bank_transfer`
        public var fundingType: FundingType?

        public init(
            bankTransfer: BankTransfer? = nil,
            fundingType: FundingType? = nil
        ) {
            self.bankTransfer = bankTransfer
            self.fundingType = fundingType
        }
    }
}

extension Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions.CustomerBalance {
    public struct BankTransfer: Codable, Hashable, Sendable {
        /// Configuration for `eu_bank_transfer` funding type.
        public var euBankTransfer: EUBankTransfer?
        /// The bank transfer type that can be used for funding. Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, or `mx_bank_transfe`.
        public var type: TransferType?

        public init(
            euBankTransfer: EUBankTransfer? = nil,
            type: TransferType? = nil
        ) {
            self.euBankTransfer = euBankTransfer
            self.type = type
        }
    }

    public enum FundingType: String, Codable, Sendable {
        case bankTransfer = "bank_transfer"
    }
}

extension Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions.CustomerBalance.BankTransfer {
    public struct EUBankTransfer: Codable, Hashable, Sendable {
        /// The desired country code of the bank account information. Permitted values include: `BE`, `DE`, `ES`, `FR`, `IE`, or `NL`.
        public var country: String?

        public init(
            country: String? = nil
        ) {
            self.country = country
        }
    }

    public enum TransferType: String, Codable, Sendable {
        case euBankTransfer = "eu_bank_transfer"
        case gbBankTransfer = "gb_bank_transfer"
        case jpBankTransfer = "jp_bank_transfer"
        case mxBankTransfer = "mx_bank_transfer"
    }
}

// MARK: Konbini
extension Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions {
    public struct Konbini: Codable, Hashable, Sendable {
        public init() {}
    }
}

// MARK: US Bank Account
extension Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions {
    public struct USBankAccount: Codable, Hashable, Sendable {
        /// Additional fields for Financial Connections Session creation
        public var financialConnections: FinancialConnections?
        /// Bank account verification method.
        public var verificationMethod: VerificationMethod?

        public init(
            financialConnections: FinancialConnections? = nil,
            verificationMethod: VerificationMethod? = nil
        ) {
            self.financialConnections = financialConnections
            self.verificationMethod = verificationMethod
        }
    }
}

extension Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions.USBankAccount {
    public struct FinancialConnections: Codable, Hashable, Sendable {
        /// The list of permissions to request. The `payment_method` permission must be included.
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
    }

    public enum VerificationMethod: String, Codable, Sendable {
        /// Instant verification with fallback to microdeposits.
        case automatic
        /// Instant verification only.
        case instant
        /// Verification using microdeposits. Cannot be used with Stripe Checkout or Hosted Invoices.
        case microdeposits
    }
}
