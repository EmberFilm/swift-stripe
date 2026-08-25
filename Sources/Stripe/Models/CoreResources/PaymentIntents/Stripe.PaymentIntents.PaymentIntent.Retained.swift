//
//  PaymentIntent.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/15/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/payment_intents/object.md

// The PaymentIntent struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.PaymentIntents.PaymentIntent` that the generator spells differently.

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Automatic {}
}

extension Stripe.PaymentIntents.PaymentIntent.Automatic {
    public enum Payment {}
}

extension Stripe.PaymentIntents.PaymentIntent.Automatic.Payment {
    public struct Methods: Codable, Hashable, Sendable {
        /// Automatically calculates compatible payment methods
        public var enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Transfer {}
}

extension Stripe.PaymentIntents.PaymentIntent.Transfer {
    public struct Data: Codable, Hashable, Sendable {
        /// Amount intended to be collected by this PaymentIntent. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
        public var amount: Int?
        /// The account (if any) the payment will be attributed to for tax reporting, and where funds from the payment will be transferred to upon payment success.
        @ExpandableOf<Stripe.Connect.Account> public var destination: Stripe.Connect.Account.ID?

        public init(
            amount: Int? = nil,
            destination: Stripe.Connect.Account.ID? = nil
        ) {
            self.amount = amount
            self._destination = Expandable(id: destination)
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Cancellation {}
}

extension Stripe.PaymentIntents.PaymentIntent.Cancellation {
    public enum Reason: String, Codable, Sendable {
        case abandoned
        case automatic
        case duplicate
        case failedInvoice = "failed_invoice"
        case fraudulent
        case requestedByCustomer = "requested_by_customer"
        case voidInvoice = "void_invoice"
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Capture {}
}

extension Stripe.PaymentIntents.PaymentIntent.Capture {
    public enum Method: String, Codable, Sendable {
        /// (Default) Stripe automatically captures funds when the customer authorizes the payment.
        case automatic
        case automaticAsync = "automatic_async"
        /// Place a hold on the funds when the customer authorizes the payment, but don’t capture the funds until later. (Not all payment methods support this.)
        case manual
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Confirmation {

    }
}

extension Stripe.PaymentIntents.PaymentIntent.Confirmation {
    public enum Method: String, Codable, Sendable {
        /// (Default) PaymentIntent can be confirmed using a publishable key. After `next_action`s are handled, no additional confirmation is required to complete the payment.
        case automatic
        /// All payment attempts must be made using a secret key. The PaymentIntent returns to the `requires_confirmation` state after handling `next_action`s, and requires your server to initiate each payment attempt with an explicit confirmation.
        case manual
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Amount {}
}

extension Stripe.PaymentIntents.PaymentIntent.Amount {
    public struct Details: Codable, Hashable, Sendable {
        /// Portion of the amount that corresponds to a tip.
        public var tip: Stripe.PaymentIntents.PaymentIntent.Amount.Details.Tip?

        public init(
            tip: Stripe.PaymentIntents.PaymentIntent.Amount.Details.Tip? = nil
        ) {
            self.tip = tip
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent.Amount.Details {
    public struct Tip: Codable, Hashable, Sendable {
        /// Portion of the amount that corresponds to a tip.
        public var amount: Int?

        public init(
            amount: Int? = nil
        ) {
            self.amount = amount
        }
    }
}

// extension Stripe.PaymentIntents.PaymentIntent {
//    public enum PaymentMethod {}
// }

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Payment {}
}

extension Stripe.PaymentIntents.PaymentIntent.Payment {
    public enum Method {}
}

extension Stripe.PaymentIntents.PaymentIntent.Payment.Method {

    public typealias Data = Options

    public struct Options: Codable, Hashable, Sendable {
        /// If the PaymentIntent’s `payment_method_types` includes `acss_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let acssDebit: Stripe.PaymentMethods.PaymentMethod.Options.ACSSDebit.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `affirm`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let affirm: Stripe.PaymentMethods.PaymentMethod.Options.Affirm.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `afterpay_clearpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let afterpayClearpay:
            Stripe.PaymentMethods.PaymentMethod.Options.AfterpayClearpay.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `alipay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let alipay: Stripe.PaymentMethods.PaymentMethod.Options.Alipay.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `au_becs_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let auBecsDebit:
            Stripe.PaymentMethods.PaymentMethod.Options.AUBecsDebit.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `bacs_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let bacsDebit: Stripe.PaymentMethods.PaymentMethod.Options.BacsDebit.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `bancontact`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let bancontact: Stripe.PaymentMethods.PaymentMethod.Options.Bancontact.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes blik, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let blik: Stripe.PaymentMethods.PaymentMethod.Options.Blik.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `boleto`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let boleto: Stripe.PaymentMethods.PaymentMethod.Options.Boleto.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `card`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let card: Stripe.PaymentMethods.PaymentMethod.Options.Card.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `card_present`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let cardPresent:
            Stripe.PaymentMethods.PaymentMethod.Options.CardPresent.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `customer_balance`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let customerBalance:
            Stripe.PaymentMethods.PaymentMethod.Options.CustomerBalance.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `eps`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let eps: Stripe.PaymentMethods.PaymentMethod.Options.EPS.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `fpx`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let fpx: Stripe.PaymentMethods.PaymentMethod.Options.FPX.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `giropay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let giropay: Stripe.PaymentMethods.PaymentMethod.Options.Giropay.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `grabpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let grabpay: Stripe.PaymentMethods.PaymentMethod.Options.GrabPay.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `ideal`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let ideal: Stripe.PaymentMethods.PaymentMethod.Options.Ideal.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `interac_present`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let interacPresent:
            Stripe.PaymentMethods.PaymentMethod.Options.InteracPresent.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `klarna`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let klarna: Stripe.PaymentMethods.PaymentMethod.Options.Klarna.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `konbini`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let konbini: Stripe.PaymentMethods.PaymentMethod.Options.Konbini.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `link`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let link: Stripe.PaymentMethods.PaymentMethod.Options.Link.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `oxxo`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let oxxo: Stripe.PaymentMethods.PaymentMethod.Options.OXXO.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `p24`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let p24: Stripe.PaymentMethods.PaymentMethod.Options.P24.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `paynow`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let paynow: Stripe.PaymentMethods.PaymentMethod.Options.Paynow.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `pix`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let pix: Stripe.PaymentMethods.PaymentMethod.Options.Pix.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `promptpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let promptpay: Stripe.PaymentMethods.PaymentMethod.Options.PromptPay.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `sepa_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let sepaDebit: Stripe.PaymentMethods.PaymentMethod.Options.SepaDebit.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `sofort`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let sofort: Stripe.PaymentMethods.PaymentMethod.Options.Sofort.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `us_bank_account`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let usBankAccount:
            Stripe.PaymentMethods.PaymentMethod.Options.USBankAccount.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `wechat_pay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let wechatPay: Stripe.PaymentMethods.PaymentMethod.Options.WechatPay.Configuration?

        public init(
            acssDebit: Stripe.PaymentMethods.PaymentMethod.Options.ACSSDebit.Configuration? = nil,
            affirm: Stripe.PaymentMethods.PaymentMethod.Options.Affirm.Configuration? = nil,
            afterpayClearpay: Stripe.PaymentMethods.PaymentMethod.Options.AfterpayClearpay
                .Configuration? = nil,
            alipay: Stripe.PaymentMethods.PaymentMethod.Options.Alipay.Configuration? = nil,
            auBecsDebit: Stripe.PaymentMethods.PaymentMethod.Options.AUBecsDebit.Configuration? =
                nil,
            bacsDebit: Stripe.PaymentMethods.PaymentMethod.Options.BacsDebit.Configuration? = nil,
            bancontact: Stripe.PaymentMethods.PaymentMethod.Options.Bancontact.Configuration? = nil,
            blik: Stripe.PaymentMethods.PaymentMethod.Options.Blik.Configuration? = nil,
            boleto: Stripe.PaymentMethods.PaymentMethod.Options.Boleto.Configuration? = nil,
            card: Stripe.PaymentMethods.PaymentMethod.Options.Card.Configuration? = nil,
            cardPresent: Stripe.PaymentMethods.PaymentMethod.Options.CardPresent.Configuration? =
                nil,
            customerBalance: Stripe.PaymentMethods.PaymentMethod.Options.CustomerBalance
                .Configuration? =
                nil,
            eps: Stripe.PaymentMethods.PaymentMethod.Options.EPS.Configuration? = nil,
            fpx: Stripe.PaymentMethods.PaymentMethod.Options.FPX.Configuration? = nil,
            giropay: Stripe.PaymentMethods.PaymentMethod.Options.Giropay.Configuration? = nil,
            grabpay: Stripe.PaymentMethods.PaymentMethod.Options.GrabPay.Configuration? = nil,
            ideal: Stripe.PaymentMethods.PaymentMethod.Options.Ideal.Configuration? = nil,
            interacPresent: Stripe.PaymentMethods.PaymentMethod.Options.InteracPresent
                .Configuration? =
                nil,
            klarna: Stripe.PaymentMethods.PaymentMethod.Options.Klarna.Configuration? = nil,
            konbini: Stripe.PaymentMethods.PaymentMethod.Options.Konbini.Configuration? = nil,
            link: Stripe.PaymentMethods.PaymentMethod.Options.Link.Configuration? = nil,
            oxxo: Stripe.PaymentMethods.PaymentMethod.Options.OXXO.Configuration? = nil,
            p24: Stripe.PaymentMethods.PaymentMethod.Options.P24.Configuration? = nil,
            paynow: Stripe.PaymentMethods.PaymentMethod.Options.Paynow.Configuration? = nil,
            pix: Stripe.PaymentMethods.PaymentMethod.Options.Pix.Configuration? = nil,
            promptpay: Stripe.PaymentMethods.PaymentMethod.Options.PromptPay.Configuration? = nil,
            sepaDebit: Stripe.PaymentMethods.PaymentMethod.Options.SepaDebit.Configuration? = nil,
            sofort: Stripe.PaymentMethods.PaymentMethod.Options.Sofort.Configuration? = nil,
            usBankAccount: Stripe.PaymentMethods.PaymentMethod.Options.USBankAccount
                .Configuration? = nil,
            wechatPay: Stripe.PaymentMethods.PaymentMethod.Options.WechatPay.Configuration? = nil
        ) {
            self.acssDebit = acssDebit
            self.affirm = affirm
            self.afterpayClearpay = afterpayClearpay
            self.alipay = alipay
            self.auBecsDebit = auBecsDebit
            self.bacsDebit = bacsDebit
            self.bancontact = bancontact
            self.blik = blik
            self.boleto = boleto
            self.card = card
            self.cardPresent = cardPresent
            self.customerBalance = customerBalance
            self.eps = eps
            self.fpx = fpx
            self.giropay = giropay
            self.grabpay = grabpay
            self.ideal = ideal
            self.interacPresent = interacPresent
            self.klarna = klarna
            self.konbini = konbini
            self.link = link
            self.oxxo = oxxo
            self.p24 = p24
            self.paynow = paynow
            self.pix = pix
            self.promptpay = promptpay
            self.sepaDebit = sepaDebit
            self.sofort = sofort
            self.usBankAccount = usBankAccount
            self.wechatPay = wechatPay
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Search {}
}

extension Stripe.PaymentIntents.PaymentIntent.Search {
    public struct Result: Codable, Hashable, Sendable {
        /// A string describing the object type returned.
        public var object: String
        /// A list of charges, paginated by any request parameters.
        public var data: [Stripe.PaymentIntents.PaymentIntent]?
        /// Whether or not there are more elements available after this set.
        public var hasMore: Bool?
        /// The URL for accessing this list.
        public var url: String?
        /// The URL for accessing the next page in search results.
        public var nextPage: String?
        /// The total count of entries in the search result, not just the current page.
        public var totalCount: Int?

        public init(
            object: String,
            data: [Stripe.PaymentIntents.PaymentIntent]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil,
            nextPage: String? = nil,
            totalCount: Int? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
            self.nextPage = nextPage
            self.totalCount = totalCount
        }
    }
}

// MARK: - Added in 2026 API versions
extension Stripe.PaymentIntents.PaymentIntent {

    /// Managed Payments settings for a PaymentIntent.
    public struct ManagedPayments: Codable, Hashable, Sendable {
        public var enabled: Bool?

        public init(enabled: Bool? = nil) {
            self.enabled = enabled
        }
    }

    /// The payment method configuration that produced the available payment methods.
    public struct PaymentMethodConfigurationDetails: Codable, Hashable, Sendable {
        public var id: String?
        /// The parent configuration this one inherits from, for connected accounts.
        public var parent: String?

        public init(id: String? = nil, parent: String? = nil) {
            self.id = id
            self.parent = parent
        }
    }
}
