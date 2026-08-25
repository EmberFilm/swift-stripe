#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Subscription.Payment.Settings {
    public struct MethodOptions: Codable, Hashable, Sendable {
        /// ACSS Debit payment method options
        public var acssDebit: ACSSDebit.Configuration?
        /// Bancontact payment method options
        public var bancontact: Bancontact.Configuration?
        /// Card payment method options
        public var card: Card.Configuration?
        /// Customer Balance payment method options
        public var customerBalance: CustomerBalance.Configuration?
        /// Konbini payment method options
        public var konbini: Konbini.Configuration?
        /// US Bank Account payment method options
        public var usBankAccount: USBankAccount.Configuration?

        private enum CodingKeys: String, CodingKey {
            case acssDebit
            case bancontact
            case card
            case customerBalance
            case konbini
            case usBankAccount
        }

        public init(
            acssDebit: ACSSDebit.Configuration? = nil,
            bancontact: Bancontact.Configuration? = nil,
            card: Card.Configuration? = nil,
            customerBalance: CustomerBalance.Configuration? = nil,
            konbini: Konbini.Configuration? = nil,
            usBankAccount: USBankAccount.Configuration? = nil
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

// MARK: - ACSS Debit
extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions {
    public enum ACSSDebit {}
}

extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions.ACSSDebit {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Additional fields for Mandate creation
        public var mandateOptions: MandateOptions?
        /// Bank account verification method
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
        /// Transaction type of the mandate
        public var transactionType: TransactionType?

        public init(
            transactionType: TransactionType? = nil
        ) {
            self.transactionType = transactionType
        }
    }

    public enum TransactionType: String, Codable, Sendable {
        case personal
        case business
    }

    public enum VerificationMethod: String, Codable, Sendable {
        case automatic
        case instant
        case microdeposits
    }
}

// MARK: - Bancontact
extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions {
    public enum Bancontact {}
}

extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions.Bancontact {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Preferred language for the authorization page
        public var preferredLanguage: String?

        public init(
            preferredLanguage: String? = nil
        ) {
            self.preferredLanguage = preferredLanguage
        }
    }
}

// MARK: - Card
extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions {
    public enum Card {}
}

extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions.Card {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Mandate options for this subscription
        public var mandateOptions: MandateOptions?
        /// Selected network to process this Subscription
        public var network: String?
        /// 3D Secure configuration
        public var requestThreeDSecure: RequestThreeDSecure?

        public init(
            mandateOptions: MandateOptions? = nil,
            network: String? = nil,
            requestThreeDSecure: RequestThreeDSecure? = nil
        ) {
            self.mandateOptions = mandateOptions
            self.network = network
            self.requestThreeDSecure = requestThreeDSecure
        }
    }

    public struct MandateOptions: Codable, Hashable, Sendable {
        /// Amount for future payments
        public var amount: Int?
        /// Amount type configuration
        public var amountType: AmountType?

        public init(
            amount: Int? = nil,
            amountType: AmountType? = nil
        ) {
            self.amount = amount
            self.amountType = amountType
        }
    }

    public enum AmountType: String, Codable, Sendable {
        case fixed
        case maximum
    }

    public enum RequestThreeDSecure: String, Codable, Sendable {
        case automatic
        case any
    }
}

// MARK: - Customer Balance
extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions {
    public enum CustomerBalance {}
}

extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions.CustomerBalance {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Bank transfer configuration
        public var bankTransfer: BankTransfer?
        /// Funding method type
        public var fundingType: FundingType?

        public init(
            bankTransfer: BankTransfer? = nil,
            fundingType: FundingType? = nil
        ) {
            self.bankTransfer = bankTransfer
            self.fundingType = fundingType
        }
    }

    public struct BankTransfer: Codable, Hashable, Sendable {
        /// EU bank transfer configuration
        public var euBankTransfer: EUBankTransfer?
        /// Bank transfer type
        public var type: TransferType?

        public init(
            euBankTransfer: EUBankTransfer? = nil,
            type: TransferType? = nil
        ) {
            self.euBankTransfer = euBankTransfer
            self.type = type
        }
    }

    public struct EUBankTransfer: Codable, Hashable, Sendable {
        /// Desired country code
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

    public enum FundingType: String, Codable, Sendable {
        case bankTransfer = "bank_transfer"
    }
}

// MARK: - Konbini
extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions {
    public enum Konbini {}
}

extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions.Konbini {
    public struct Configuration: Codable, Hashable, Sendable {
        public init() {}
    }
}

// MARK: - US Bank Account
extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions {
    public enum USBankAccount {}
}

extension Stripe.Billing.Subscription.Payment.Settings.MethodOptions.USBankAccount {
    public struct Configuration: Codable, Hashable, Sendable {
        /// Financial connections configuration
        public var financialConnections: FinancialConnections?
        /// Verification method
        public var verificationMethod: VerificationMethod?

        public init(
            financialConnections: FinancialConnections? = nil,
            verificationMethod: VerificationMethod? = nil
        ) {
            self.financialConnections = financialConnections
            self.verificationMethod = verificationMethod
        }
    }

    public struct FinancialConnections: Codable, Hashable, Sendable {
        /// Required permissions
        public var permissions: [Permission]?

        public init(
            permissions: [Permission]? = nil
        ) {
            self.permissions = permissions
        }
    }

    public enum Permission: String, Codable, Sendable {
        case paymentMethod = "payment_method"
        case balances
        case transactions
    }

    public enum VerificationMethod: String, Codable, Sendable {
        case automatic
        case instant
        case microdeposits
    }
}
