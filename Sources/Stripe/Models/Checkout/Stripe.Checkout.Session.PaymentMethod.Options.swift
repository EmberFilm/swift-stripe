//
//  Session.PaymentMethod.Options.swift
//
//
//  Created by Andrew Edwards on 5/6/23.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Checkout.Session.PaymentMethod {
    public struct Options: Codable, Hashable, Sendable {
        /// If the Checkout Session’s `payment_method_types` includes `acss_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var acssDebit: Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit?
        /// If the Checkout Session’s `payment_method_types` includes `affirm`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var affirm: Stripe.Checkout.Session.PaymentMethod.Options.Affirm?
        /// If the Checkout Session’s `payment_method_types` includes `afterpay_clearpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var afterpayClearpay: Stripe.Checkout.Session.PaymentMethod.Options.AfterpayClearpay?
        /// If the Checkout Session’s `payment_method_types` includes `alipay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var alipay: Stripe.Checkout.Session.PaymentMethod.Options.Alipay?
        /// If the Checkout Session’s `payment_method_types` includes `au_becs_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var auBecsDebit: Stripe.Checkout.Session.PaymentMethod.Options.AuBecsDebit?
        /// If the Checkout Session’s `payment_method_types` includes `bacs_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var bacsDebit: Stripe.Checkout.Session.PaymentMethod.Options.BacsDebit?
        /// If the Checkout Session’s `payment_method_types` includes `bancontact`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var bancontact: Stripe.Checkout.Session.PaymentMethod.Options.Bancontact?
        /// If the Checkout Session’s `payment_method_types` includes `boleto`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var boleto: Stripe.Checkout.Session.PaymentMethod.Options.Boleto?
        /// If the Checkout Session’s `payment_method_types` includes `card`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var card: Stripe.Checkout.Session.PaymentMethod.Options.Card?
        /// If the Checkout Session’s `payment_method_types` includes `cashapp`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var cashapp: Stripe.Checkout.Session.PaymentMethod.Options.Cashapp?
        /// If the Checkout Session’s `payment_method_types` includes `customer_balance`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var customerBalance: Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance?
        /// If the Checkout Session’s `payment_method_types` includes `eps`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var eps: Stripe.Checkout.Session.PaymentMethod.Options.Eps?
        /// If the Checkout Session’s `payment_method_types` includes `fpx`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var fpx: Stripe.Checkout.Session.PaymentMethod.Options.Fpx?
        /// If the Checkout Session’s `payment_method_types` includes `giropay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var giropay: Stripe.Checkout.Session.PaymentMethod.Options.Giropay?
        /// If the Checkout Session’s `payment_method_types` includes `grabpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var grabpay: Stripe.Checkout.Session.PaymentMethod.Options.Grabpay?
        /// If the Checkout Session’s `payment_method_types` includes `ideal`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var ideal: Stripe.Checkout.Session.PaymentMethod.Options.Ideal?
        /// If the Checkout Session’s `payment_method_types` includes `klarna`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var klarna: Stripe.Checkout.Session.PaymentMethod.Options.Klarna?
        /// If the Checkout Session’s `payment_method_types` includes `konbini`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var konbini: Stripe.Checkout.Session.PaymentMethod.Options.Konbini?
        /// If the Checkout Session’s `payment_method_types` includes `link`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var link: Stripe.Checkout.Session.PaymentMethod.Options.Link?
        /// If the Checkout Session’s `payment_method_types` includes `oxxo`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var oxxo: Stripe.Checkout.Session.PaymentMethod.Options.OXXO?
        /// If the Checkout Session’s `payment_method_types` includes `p24`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var p24: Stripe.Checkout.Session.PaymentMethod.Options.P24?
        /// If the Checkout Session’s `payment_method_types` includes `paynow`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var paynow: Stripe.Checkout.Session.PaymentMethod.Options.Paynow?
        /// If the Checkout Session’s `payment_method_types` includes `pix`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var pix: Stripe.Checkout.Session.PaymentMethod.Options.Pix?
        /// If the Checkout Session’s `payment_method_types` includes `sepa_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var sepaDebit: Stripe.Checkout.Session.PaymentMethod.Options.SepaDebit?
        /// If the Checkout Session’s `payment_method_types` includes `sofort`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var sofort: Stripe.Checkout.Session.PaymentMethod.Options.Sofort?
        /// If the Checkout Session’s `payment_method_types` includes `us_bank_account`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public var usBankAccount: Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount?

        public init(
            acssDebit: Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit? = nil,
            affirm: Stripe.Checkout.Session.PaymentMethod.Options.Affirm? = nil,
            afterpayClearpay: Stripe.Checkout.Session.PaymentMethod.Options.AfterpayClearpay? = nil,
            alipay: Stripe.Checkout.Session.PaymentMethod.Options.Alipay? = nil,
            auBecsDebit: Stripe.Checkout.Session.PaymentMethod.Options.AuBecsDebit? = nil,
            bacsDebit: Stripe.Checkout.Session.PaymentMethod.Options.BacsDebit? = nil,
            bancontact: Stripe.Checkout.Session.PaymentMethod.Options.Bancontact? = nil,
            boleto: Stripe.Checkout.Session.PaymentMethod.Options.Boleto? = nil,
            card: Stripe.Checkout.Session.PaymentMethod.Options.Card? = nil,
            cashapp: Stripe.Checkout.Session.PaymentMethod.Options.Cashapp? = nil,
            customerBalance: Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance? = nil,
            eps: Stripe.Checkout.Session.PaymentMethod.Options.Eps? = nil,
            fpx: Stripe.Checkout.Session.PaymentMethod.Options.Fpx? = nil,
            giropay: Stripe.Checkout.Session.PaymentMethod.Options.Giropay? = nil,
            grabpay: Stripe.Checkout.Session.PaymentMethod.Options.Grabpay? = nil,
            ideal: Stripe.Checkout.Session.PaymentMethod.Options.Ideal? = nil,
            klarna: Stripe.Checkout.Session.PaymentMethod.Options.Klarna? = nil,
            konbini: Stripe.Checkout.Session.PaymentMethod.Options.Konbini? = nil,
            link: Stripe.Checkout.Session.PaymentMethod.Options.Link? = nil,
            oxxo: Stripe.Checkout.Session.PaymentMethod.Options.OXXO? = nil,
            p24: Stripe.Checkout.Session.PaymentMethod.Options.P24? = nil,
            paynow: Stripe.Checkout.Session.PaymentMethod.Options.Paynow? = nil,
            pix: Stripe.Checkout.Session.PaymentMethod.Options.Pix? = nil,
            sepaDebit: Stripe.Checkout.Session.PaymentMethod.Options.SepaDebit? = nil,
            sofort: Stripe.Checkout.Session.PaymentMethod.Options.Sofort? = nil,
            usBankAccount: Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount? = nil
        ) {
            self.acssDebit = acssDebit
            self.affirm = affirm
            self.afterpayClearpay = afterpayClearpay
            self.alipay = alipay
            self.auBecsDebit = auBecsDebit
            self.bacsDebit = bacsDebit
            self.bancontact = bancontact
            self.boleto = boleto
            self.card = card
            self.cashapp = cashapp
            self.customerBalance = customerBalance
            self.eps = eps
            self.fpx = fpx
            self.giropay = giropay
            self.grabpay = grabpay
            self.ideal = ideal
            self.klarna = klarna
            self.konbini = konbini
            self.link = link
            self.oxxo = oxxo
            self.p24 = p24
            self.paynow = paynow
            self.pix = pix
            self.sepaDebit = sepaDebit
            self.sofort = sofort
            self.usBankAccount = usBankAccount
        }
    }
}

// MARK: Acss Debit
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct AcssDebit: Codable, Hashable, Sendable {
        /// Currency supported by the bank account. Returned when the Session is in `setup` mode.
        public var currency: Stripe.Currency?
        /// Additional fields for Mandate creation
        public var mandateOptions:
            Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Mandate.Options?
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Setup.FutureUsage?
        /// Bank account verification method.
        public var verificationMethod:
            Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Verification.Method?

        public init(
            currency: Stripe.Currency? = nil,
            mandateOptions: Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Mandate
                .Options? =
                nil,
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Setup
                .FutureUsage? =
                nil,
            verificationMethod: Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Verification
                .Method? = nil
        ) {
            self.currency = currency
            self.mandateOptions = mandateOptions
            self.setupFutureUsage = setupFutureUsage
            self.verificationMethod = verificationMethod
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit {
    public enum Mandate {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit {
    public enum Verification {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Mandate {
    public struct Options: Codable, Hashable, Sendable {
        /// A URL for custom mandate text
        public var customMandateUrl: String?
        /// List of Stripe products where this mandate can be selected automatically. Returned when the Session is in setup mode.
        public var defaultFor:
            [Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Mandate.Options.DefaultFor]?
        /// Description of the interval. Only required if `payment_schedule` parmeter is `interval` or `combined`.
        public var intervalDescription: String?
        /// Payment schedule for the mandate.
        public var paymentSchedule:
            Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Mandate.Options.PaymentSchedule?
        /// Transaction type of the mandate.
        public var transactionType:
            Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Mandate.Options.TransactionType?

        public init(
            customMandateUrl: String? = nil,
            intervalDescription: String? = nil,
            paymentSchedule: Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Mandate.Options
                .PaymentSchedule? = nil,
            transactionType: Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Mandate.Options
                .TransactionType? = nil
        ) {
            self.customMandateUrl = customMandateUrl
            self.intervalDescription = intervalDescription
            self.paymentSchedule = paymentSchedule
            self.transactionType = transactionType
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Mandate.Options {
    public enum DefaultFor: Codable, Hashable, Sendable {
        /// Enables payments for Stripe Invoices. ‘subscription’ must also be provided.
        case invoice
        /// Enables payments for Stripe Subscriptions. ‘invoice’ must also be provided.
        case subscription
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Mandate.Options {
    public enum PaymentSchedule: String, Codable, Sendable {
        /// Payments are initiated at a regular pre-defined interval
        case interval
        /// Payments are initiated sporadically
        case sporadic
        /// Payments can be initiated at a pre-defined interval or sporadically
        case combined
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Mandate.Options {
    public enum TransactionType: String, Codable, Sendable {
        /// Transaction are made for personal reasons
        case personal
        /// Transactions are made for business reasons
        case business
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
        case onSession = "on_session"
        /// Use `off_session` if your customer may or may not be present in your checkout flow.
        case offSession = "off_session"
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AcssDebit.Verification {
    public enum Method: String, Codable, Sendable {
        /// Instant verification with fallback to microdeposits.
        case automatic
        /// Instant verification.
        case instant
        /// Verification using microdeposits.
        case microdeposits
    }
}

// MARK: Affirm
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Affirm: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.

        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Affirm.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Affirm.Setup
                .FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Affirm {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Affirm.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Afterpay Clearpay
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct AfterpayClearpay: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.AfterpayClearpay.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.AfterpayClearpay.Setup
                .FutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AfterpayClearpay {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AfterpayClearpay.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Alipay
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Alipay: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Alipay.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Alipay.Setup
                .FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Alipay {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Alipay.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Au Becs Debit
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct AuBecsDebit: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.AuBecsDebit.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.AuBecsDebit.Setup
                .FutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AuBecsDebit {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.AuBecsDebit.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Bacs Debit

extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct BacsDebit: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.BacsDebit.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.BacsDebit.Setup
                .FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.BacsDebit {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.BacsDebit.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
        case onSession = "on_session"
        /// Use `off_session` if your customer may or may not be present in your checkout flow.
        case offSession = "off_session"
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Bancontact
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Bancontact: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Bancontact.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Bancontact.Setup
                .FutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Bancontact {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Bancontact.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Boleto
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Boleto: Codable, Hashable, Sendable {
        /// The number of calendar days before a Boleto voucher expires. For example, if you create a Boleto voucher on Monday and you set  `expires_after_days` to 2, the Boleto voucher will expire on Wednesday at 23:59 America/Sao_Paulo time.
        public var expiresAfterDays: Int?
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Boleto.Setup.FutureUsage?

        public init(
            expiresAfterDays: Int? = nil,
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Boleto.Setup
                .FutureUsage? =
                nil
        ) {
            self.expiresAfterDays = expiresAfterDays
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Boleto {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Boleto.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
        case onSession = "on_session"
        /// Use `off_session` if your customer may or may not be present in your checkout flow.
        case offSession = "off_session"
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Card
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Card: Codable, Hashable, Sendable {
        /// Additional fields for Installments configuration
        public var installments: Stripe.Checkout.Session.PaymentMethod.Options.Card.Installments?
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Card.Setup.FutureUsage?
        /// Provides information about a card payment that customers see on their statements. Concatenated with the Kana prefix (shortened Kana descriptor) or Kana statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters. On card statements, the concatenation of both prefix and suffix (including separators) will appear truncated to 22 characters.
        public var statementDescriptorSuffixKana: String?
        /// Provides information about a card payment that customers see on their statements. Concatenated with the Kanji prefix (shortened Kanji descriptor) or Kanji statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 17 characters. On card statements, the concatenation of both prefix and suffix (including separators) will appear truncated to 17 characters.
        public var statementDescriptorSuffixKanji: String?

        public init(
            installments: Stripe.Checkout.Session.PaymentMethod.Options.Card.Installments? = nil,
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Card.Setup
                .FutureUsage? = nil,
            statementDescriptorSuffixKana: String? = nil,
            statementDescriptorSuffixKanji: String? = nil
        ) {
            self.installments = installments
            self.setupFutureUsage = setupFutureUsage
            self.statementDescriptorSuffixKana = statementDescriptorSuffixKana
            self.statementDescriptorSuffixKanji = statementDescriptorSuffixKanji
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Card {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Card {
    public struct Installments: Codable, Hashable, Sendable {
        /// Indicates if installments are enabled
        public var enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Card.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
        case onSession = "on_session"
        /// Use `off_session` if your customer may or may not be present in your checkout flow.
        case offSession = "off_session"
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Cashapp
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Cashapp: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Cashapp.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Cashapp.Setup
                .FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Cashapp {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Cashapp.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Customer Balance
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct CustomerBalance: Codable, Hashable, Sendable {
        /// Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
        public var bankTransfer:
            Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance.BankTransfer?
        /// The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: `bank_transfer`.
        public var fundingType: String?
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance.Setup.FutureUsage?

        public init(
            bankTransfer: Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance
                .BankTransfer? =
                nil,
            fundingType: String? = nil,
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance.Setup
                .FutureUsage? = nil
        ) {
            self.bankTransfer = bankTransfer
            self.fundingType = fundingType
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance {
    public struct BankTransfer: Codable, Hashable, Sendable {
        /// Configuration for `eu_bank_transfer`
        public var euBankTransfer:
            Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance.BankTransfer
                .EuBankTransfer?
        /// List of address types that should be returned in the `financial_addresses` response. If not specified, all valid types will be returned.
        ///
        /// Permitted values include: `sort_code`, `zengin`, `iban`, or `spei`.
        public var requestedAddressTypes:
            [Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance.BankTransfer
                .RequestedAddressType]?
        /// The bank transfer type that this PaymentIntent is allowed to use for funding Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, or `mx_bank_transfer`.
        public var type:
            Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance.BankTransferType?

        public init(
            euBankTransfer: Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance
                .BankTransfer
                .EuBankTransfer? = nil,
            requestedAddressTypes: [Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance
                .BankTransfer.RequestedAddressType]? = nil,
            type: Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance.BankTransferType? =
                nil
        ) {
            self.euBankTransfer = euBankTransfer
            self.requestedAddressTypes = requestedAddressTypes
            self.type = type
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance.BankTransfer {
    public enum RequestedAddressType: String, Codable, Sendable {
        /// `sort_code` bank account address type
        case sortCode = "sort_code"
        /// `zengin` bank account address type
        case zengin
        /// `sepa` bank account address type
        case sepa
        /// `spei` bank account address type
        case spei
        /// `iban` bank account address type
        case iban
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance {
    public enum BankTransferType: String, Codable, Sendable {
        /// A bank transfer of type `eu_bank_transfer`
        case euBankTransfer = "eu_bank_transfer"
        /// A bank transfer of type `gb_bank_transfer`
        case gbBankTransfer = "gb_bank_transfer"
        /// A bank transfer of type `jp_bank_transfer`
        case jpBankTransfer = "jp_bank_transfer"
        /// A bank transfer of type `mx_bank_transfer`
        case mxBankTransfer = "mx_bank_transfer"
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance.BankTransfer {
    public struct EuBankTransfer: Codable, Hashable, Sendable {
        /// The desired country code of the bank account information. Permitted values include: `BE`, `DE`, `ES`, `FR`, `IE`, or `NL`.
        public var country: String?

        public init(
            country: String? = nil
        ) {
            self.country = country
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.CustomerBalance.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: EPS
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Eps: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Eps.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Eps.Setup.FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Eps {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Eps.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: FPX
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Fpx: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Fpx.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Fpx.Setup.FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Fpx {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Fpx.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Giropay
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Giropay: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Giropay.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Giropay.Setup
                .FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Giropay {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Giropay.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Grabpay
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Grabpay: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Grabpay.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Grabpay.Setup
                .FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Grabpay {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Grabpay.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Ideal
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Ideal: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Ideal.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Ideal.Setup
                .FutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Ideal {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Ideal.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Klarna
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Klarna: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Klarna.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Klarna.Setup
                .FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Klarna {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Klarna.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
        case onSession = "on_session"
        /// Use `off_session` if your customer may or may not be present in your checkout flow.
        case offSession = "off_session"
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Konbini
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Konbini: Codable, Hashable, Sendable {
        /// The number of calendar days (between 1 and 60) after which `Konbini` payment instructions will expire. For example, if a PaymentIntent is confirmed with `Konbini` and `expires_after_days` set to 2 on Monday JST, the instructions will expire on Wednesday 23:59:59 JST.
        public var expiresAfterDays: Int?
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Konbini.Setup.FutureUsage?

        public init(
            expiresAfterDays: Int? = nil,
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Konbini.Setup
                .FutureUsage? =
                nil
        ) {
            self.expiresAfterDays = expiresAfterDays
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Konbini {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Konbini.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Link
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Link: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Link.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Link.Setup
                .FutureUsage? = nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Link {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Link.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `off_session` if your customer may or may not be present in your checkout flow.
        case offSession = "off_session"
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: OXXO
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct OXXO: Codable, Hashable, Sendable {
        /// The number of calendar days before an OXXO invoice expires. For example, if you create an OXXO invoice on Monday and you set `expires_after_days` to 2, the OXXO invoice will expire on Wednesday at 23:59 America/Mexico_City time.
        public var expiresAfterDays: Int?
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.OXXO.Setup.FutureUsage?

        public init(
            expiresAfterDays: Int? = nil,
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.OXXO.Setup
                .FutureUsage? = nil
        ) {
            self.expiresAfterDays = expiresAfterDays
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.OXXO {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.OXXO.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: P24
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct P24: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.P24.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.P24.Setup.FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.P24 {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.P24.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Paynow
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Paynow: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Paynow.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Paynow.Setup
                .FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Paynow {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Paynow.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `off_session` if your customer may or may not be present in your checkout flow.
        case offSession = "off_session"
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Pix
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Pix: Codable, Hashable, Sendable {
        /// The number of seconds after which Pix payment will expire.
        public var expiresAfterSeconds: Int?

        public init(
            expiresAfterSeconds: Int? = nil
        ) {
            self.expiresAfterSeconds = expiresAfterSeconds
        }
    }
}

// MARK: SepaDebit
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct SepaDebit: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.SepaDebit.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.SepaDebit.Setup
                .FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.SepaDebit {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.SepaDebit.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
        case onSession = "on_session"
        /// Use `off_session` if your customer may or may not be present in your checkout flow.
        case offSession = "off_session"
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: Sofort
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct Sofort: Codable, Hashable, Sendable {
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.Sofort.Setup.FutureUsage?

        public init(
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.Sofort.Setup
                .FutureUsage? =
                nil
        ) {
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Sofort {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.Sofort.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

// MARK: US Bank Account
extension Stripe.Checkout.Session.PaymentMethod.Options {
    public struct USBankAccount: Codable, Hashable, Sendable {
        /// Additional fields for Financial Connections Session creation
        public var financialConnections:
            Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount.FinancialConnections?
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
        ///
        /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
        ///
        /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
        public var setupFutureUsage:
            Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount.Setup.FutureUsage?
        /// Bank account verification method.
        public var verificationMethod:
            Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount.Verification.Method?

        public init(
            financialConnections: Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount
                .FinancialConnections? = nil,
            setupFutureUsage: Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount.Setup
                .FutureUsage? = nil,
            verificationMethod: Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount
                .Verification
                .Method? = nil
        ) {
            self.financialConnections = financialConnections
            self.setupFutureUsage = setupFutureUsage
            self.verificationMethod = verificationMethod
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount {
    public enum Setup {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount {
    public enum Verification {}
}

extension Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount {
    public struct FinancialConnections: Codable, Hashable, Sendable {
        /// The list of permissions to request. The p`ayment_method` permission must be included.
        public var permissions:
            [Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount.FinancialConnections
                .Permission]?

        public init(
            permissions: [Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount
                .FinancialConnections
                .Permission]? = nil
        ) {
            self.permissions = permissions
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount.FinancialConnections {
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
}

extension Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
        case onSession = "on_session"
        /// Use `off_session` if your customer may or may not be present in your checkout flow.
        case offSession = "off_session"
        /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
        case `none`
    }
}

extension Stripe.Checkout.Session.PaymentMethod.Options.USBankAccount.Verification {
    public enum Method: String, Codable, Sendable {
        /// Instant verification with fallback to microdeposits.
        case automatic
        /// Instant verification only.
        case instant
    }
}
