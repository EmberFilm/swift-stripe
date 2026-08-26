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

//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/charges/object.md

// The Charge struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Charges.Charge` that the generator spells differently.

extension Stripe.Charges.Charge {
    public enum Radar {}
}

extension Stripe.Charges.Charge {
    public enum Fraud {}
}

extension Stripe.Charges.Charge.Fraud {
    public struct Details: Codable, Hashable, Sendable {
        /// Assessments reported by you.
        ///
        /// If set, possible values of are `safe` and `fraudulent`.
        public var userReport: Stripe.Charges.Charge.Fraud.Details.Report.`Type`?
        /// Assessments from Stripe.
        ///
        /// If set, the value is `fraudulent`.
        public var stripeReport: Stripe.Charges.Charge.Fraud.Details.Report.`Type`?

        public init(
            userReport: Stripe.Charges.Charge.Fraud.Details.Report.`Type`? = nil,
            stripeReport: Stripe.Charges.Charge.Fraud.Details.Report.`Type`? = nil
        ) {
            self.userReport = userReport
            self.stripeReport = stripeReport
        }
    }
}

extension Stripe.Charges.Charge.Fraud.Details {
    public enum Report {}
}

extension Stripe.Charges.Charge.Fraud.Details.Report {
    public enum `Type`: String, Codable, Sendable {
        case safe
        case fraudulent
    }
}

extension Stripe.Charges.Charge {
    public enum Transfer {}
}

extension Stripe.Charges.Charge.Transfer {
    public struct Data: Codable, Hashable, Sendable {
        /// The amount transferred to the destination account, if specified.
        ///
        /// By default, the entire charge amount is transferred to the destination account.
        public var amount: Int?
        /// ID of an existing, connected Stripe account to transfer funds to if `transfer_data` was specified in the charge request.
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

extension Stripe.Charges.Charge.Search {
    public struct Result: Codable, Hashable, Sendable {
        /// A string describing the object type returned.
        public var object: String
        /// A list of charges, paginated by any request parameters.
        public var data: [Stripe.Charges.Charge]?
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
            data: [Stripe.Charges.Charge]? = nil,
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

extension Stripe.Charges.Charge {
    public enum PaymentMethod {}
}

extension Stripe.Charges.Charge.PaymentMethod {
    public struct Details: Codable, Hashable, Sendable {
        /// If this is a `ach_credit_transfer` payment, this hash contains a snapshot of the transaction specific details of the `ach_credit_transfer` payment method.
        public var achCreditTransfer: Stripe.Charges.Charge.PaymentMethod.Details.ACHCredit.Transfer?
        /// If this is a `ach_debit` payment, this hash contains a snapshot of the transaction specific details of the `ach_debit` payment method.
        public var achDebit: Stripe.Charges.Charge.PaymentMethod.Details.ACHDebit?
        /// If this is a `acss_debit` payment, this hash contains a snapshot of the transaction specific details of the `acss_debit` payment method.
        public var acssDebit: Stripe.Charges.Charge.PaymentMethod.Details.ACSSDebit?
        /// If this is a `affirm` payment, this hash contains a snapshot of the transaction specific details of the `affirm` payment method.
        public var affirm: Stripe.Charges.Charge.PaymentMethod.Details.Affirm?
        /// If this is a `afterpay_clearpay` payment, this hash contains a snapshot of the transaction specific details of the `afterpay_clearpay` payment method.
        public var afterpayClearpay: Stripe.Charges.Charge.PaymentMethod.Details.AfterpayClearpay?
        /// If this is a `alipay` payment, this hash contains a snapshot of the transaction specific details of the `alipay` payment method.
        public var alipay: Stripe.Charges.Charge.PaymentMethod.Details.Alipay?
        /// If this is a `au_becs_debit` payment, this hash contains a snapshot of the transaction specific details of the `au_becs_debit` payment method.
        public var auBecsDebit: Stripe.Charges.Charge.PaymentMethod.Details.AuBecsDebit?
        /// If this is a `bacs_debit` payment, this hash contains a snapshot of the transaction specific details of the `bacs_debit` payment method.
        public var bacsDebit: Stripe.Charges.Charge.PaymentMethod.Details.BacsDebit?
        /// If this is a `bancontact` payment, this hash contains a snapshot of the transaction specific details of the `bancontact` payment method.
        public var bancontact: Stripe.Charges.Charge.PaymentMethod.Details.Bancontact?
        /// If this is a `blik` payment, this hash contains a snapshot of the transaction specific details of the `blik` payment method.
        public var blik: Stripe.Charges.Charge.PaymentMethod.Details.Blik?
        /// If this is a `boleto` payment, this hash contains a snapshot of the transaction specific details of the `boleto` payment method.
        public var boleto: Stripe.Charges.Charge.PaymentMethod.Details.Boleto?
        /// If this is a `card` payment, this hash contains a snapshot of the transaction specific details of the `card` payment method.
        public var card: Stripe.Charges.Charge.PaymentMethod.Details.Card?
        /// If this is a `card_present` payment, this hash contains a snapshot of the transaction specific details of the `card_present` payment method.
        public var cardPresent: Stripe.Charges.Charge.PaymentMethod.Details.CardPresent?
        /// If this is a `cashapp` payment, this hash contains a snapshot of the transaction specific details of the `cashapp` payment method.
        public var cashapp: Stripe.Charges.Charge.PaymentMethod.Details.CashApp?
        /// If this is a `customer_balance` payment, this hash contains a snapshot of the transaction specific details of the `customer_balance` payment method.
        public var customerBalance: Stripe.Charges.Charge.PaymentMethod.Details.CustomerBalance?
        /// If this is a `eps` payment, this hash contains a snapshot of the transaction specific details of the `eps` payment method.
        public var eps: Stripe.Charges.Charge.PaymentMethod.Details.EPS?
        /// If this is a `fpx` payment, this hash contains a snapshot of the transaction specific details of the `fpx` payment method.
        public var fpx: Stripe.Charges.Charge.PaymentMethod.Details.Fpx?
        /// If this is a `grabpay` payment, this hash contains a snapshot of the transaction specific details of the `grabpay` payment method.
        public var grabpay: Stripe.Charges.Charge.PaymentMethod.Details.Grabpay?
        /// If this is a `giropay` payment, this hash contains a snapshot of the transaction specific details of the `giropay` payment method.
        public var giropay: Stripe.Charges.Charge.PaymentMethod.Details.Giropay?
        /// If this is a `ideal` payment, this hash contains a snapshot of the transaction specific details of the `ideal` payment method.
        public var ideal: Stripe.Charges.Charge.PaymentMethod.Details.Ideal?
        /// If this is a `interac_present` payment, this hash contains a snapshot of the transaction specific details of the `interac_present` payment method.
        public var interacPresent: Stripe.Charges.Charge.PaymentMethod.Details.InteracPresent?
        /// If this is a klarna payment, this hash contains a snapshot of the transaction specific details of the klarna payment method.
        public var klarna: Stripe.Charges.Charge.PaymentMethod.Details.Klarna?
        /// If this is a konbini payment, this hash contains a snapshot of the transaction specific details of the konbini payment method.
        public var konbini: Stripe.Charges.Charge.PaymentMethod.Details.Kobini?
        /// If this is a `link` payment, this hash contains a snapshot of the transaction specific details of the `link` payment method.
        public var link: Stripe.Charges.Charge.PaymentMethod.Details.Link?
        /// If this is a `multibanco` payment, this hash contains a snapshot of the transaction specific details of the `multibanco` payment method.
        public var multibanco: Stripe.Charges.Charge.PaymentMethod.Details.Multibanco?
        /// If this is a oxxo payment, this hash contains a snapshot of the transaction specific details of the oxxo payment method.
        public var oxxo: Stripe.Charges.Charge.PaymentMethod.Details.OXXO?
        /// If this is a `p24` payment, this hash contains a snapshot of the transaction specific details of the `p24` payment method.
        public var p24: Stripe.Charges.Charge.PaymentMethod.Details.P24?
        /// If this is a `paynow` payment, this hash contains a snapshot of the transaction specific details of the `paynow` payment method.
        public var paynow: Stripe.Charges.Charge.PaymentMethod.Details.Paynow?
        /// If this is a `paypal` payment, this hash contains a snapshot of the transaction specific details of the `paypal` payment method.
        public var paypal: Stripe.Charges.Charge.PaymentMethod.Details.Paypal?
        /// If this is a `pix` payment, this hash contains a snapshot of the transaction specific details of the `pix` payment method.
        public var pix: Stripe.Charges.Charge.PaymentMethod.Details.Pix?
        /// If this is a `promptpay` payment, this hash contains a snapshot of the transaction specific details of the `promptpay` payment method.
        public var promptpay: Stripe.Charges.Charge.PaymentMethod.Details.Promptpay?
        /// If this is a `sepa_debit` payment, this hash contains a snapshot of the transaction specific details of the `sepa_debit` payment method.
        public var sepaDebit: Stripe.Charges.Charge.PaymentMethod.Details.SepaDebit?
        /// If this is a `sofort` payment, this hash contains a snapshot of the transaction specific details of the `sofort` payment method.
        public var sofort: Stripe.Charges.Charge.PaymentMethod.Details.Sofort?
        /// If this is a `stripe_account` payment, this hash contains a snapshot of the transaction specific details of the `stripe_account` payment method.
        public var stripeAccount: Stripe.Charges.Charge.PaymentMethod.Details.StripeAccount?
        /// The type of transaction-specific details of the payment method used in the payment, one of `ach_credit_transfer`, `ach_debit`, `alipay`, `bancontact`, `card`, `card_present`, `eps`, `giropay`, `ideal`, `multibanco`, `p24`, `sepa_debit`, `sofort`, `stripe_account`, or `wechat`.
        ///
        /// An additional hash is included on `payment_method_details` with a name matching this value.
        /// It contains information specific to the payment method.
        public var type: Stripe.Charges.Charge.PaymentMethod.Details.`Type`?
        /// If this is a `us_bank_account` payment, this hash contains a snapshot of the transaction specific details of the `us_bank_account` payment method.
        public var usBankAccount: Stripe.Charges.Charge.PaymentMethod.Details.USBankAccount?
        /// If this is a `wechat` payment, this hash contains a snapshot of the transaction specific details of the `wechat` payment method.
        public var wechat: Stripe.Charges.Charge.PaymentMethod.Details.Wechat?
        /// If this is a `wechat_pay` payment, this hash contains a snapshot of the transaction specific details of the `wechat_pay` payment method.
        public var wechatPay: Stripe.Charges.Charge.PaymentMethod.Details.WechatPay?
        /// If this is a zip payment, this hash contains a snapshot of the transaction specific details of the zip payment method.
        public var zip: Stripe.Charges.Charge.PaymentMethod.Details.Zip?

        public init(
            achCreditTransfer: Stripe.Charges.Charge.PaymentMethod.Details.ACHCredit.Transfer? =
                nil,
            achDebit: Stripe.Charges.Charge.PaymentMethod.Details.ACHDebit? = nil,
            acssDebit: Stripe.Charges.Charge.PaymentMethod.Details.ACSSDebit? = nil,
            affirm: Stripe.Charges.Charge.PaymentMethod.Details.Affirm? = nil,
            afterpayClearpay: Stripe.Charges.Charge.PaymentMethod.Details.AfterpayClearpay? = nil,
            alipay: Stripe.Charges.Charge.PaymentMethod.Details.Alipay? = nil,
            auBecsDebit: Stripe.Charges.Charge.PaymentMethod.Details.AuBecsDebit? = nil,
            bacsDebit: Stripe.Charges.Charge.PaymentMethod.Details.BacsDebit? = nil,
            bancontact: Stripe.Charges.Charge.PaymentMethod.Details.Bancontact? = nil,
            blik: Stripe.Charges.Charge.PaymentMethod.Details.Blik? = nil,
            boleto: Stripe.Charges.Charge.PaymentMethod.Details.Boleto? = nil,
            card: Stripe.Charges.Charge.PaymentMethod.Details.Card? = nil,
            cardPresent: Stripe.Charges.Charge.PaymentMethod.Details.CardPresent? = nil,
            cashapp: Stripe.Charges.Charge.PaymentMethod.Details.CashApp? = nil,
            customerBalance: Stripe.Charges.Charge.PaymentMethod.Details.CustomerBalance? = nil,
            eps: Stripe.Charges.Charge.PaymentMethod.Details.EPS? = nil,
            fpx: Stripe.Charges.Charge.PaymentMethod.Details.Fpx? = nil,
            grabpay: Stripe.Charges.Charge.PaymentMethod.Details.Grabpay? = nil,
            giropay: Stripe.Charges.Charge.PaymentMethod.Details.Giropay? = nil,
            ideal: Stripe.Charges.Charge.PaymentMethod.Details.Ideal? = nil,
            interacPresent: Stripe.Charges.Charge.PaymentMethod.Details.InteracPresent? = nil,
            klarna: Stripe.Charges.Charge.PaymentMethod.Details.Klarna? = nil,
            konbini: Stripe.Charges.Charge.PaymentMethod.Details.Kobini? = nil,
            link: Stripe.Charges.Charge.PaymentMethod.Details.Link? = nil,
            multibanco: Stripe.Charges.Charge.PaymentMethod.Details.Multibanco? = nil,
            oxxo: Stripe.Charges.Charge.PaymentMethod.Details.OXXO? = nil,
            p24: Stripe.Charges.Charge.PaymentMethod.Details.P24? = nil,
            paynow: Stripe.Charges.Charge.PaymentMethod.Details.Paynow? = nil,
            paypal: Stripe.Charges.Charge.PaymentMethod.Details.Paypal? = nil,
            pix: Stripe.Charges.Charge.PaymentMethod.Details.Pix? = nil,
            promptpay: Stripe.Charges.Charge.PaymentMethod.Details.Promptpay? = nil,
            sepaDebit: Stripe.Charges.Charge.PaymentMethod.Details.SepaDebit? = nil,
            sofort: Stripe.Charges.Charge.PaymentMethod.Details.Sofort? = nil,
            stripeAccount: Stripe.Charges.Charge.PaymentMethod.Details.StripeAccount? = nil,
            type: Stripe.Charges.Charge.PaymentMethod.Details.`Type`? = nil,
            usBankAccount: Stripe.Charges.Charge.PaymentMethod.Details.USBankAccount? = nil,
            wechat: Stripe.Charges.Charge.PaymentMethod.Details.Wechat? = nil,
            wechatPay: Stripe.Charges.Charge.PaymentMethod.Details.WechatPay? = nil,
            zip: Stripe.Charges.Charge.PaymentMethod.Details.Zip? = nil
        ) {
            self.achCreditTransfer = achCreditTransfer
            self.achDebit = achDebit
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
            self.cashapp = cashapp
            self.customerBalance = customerBalance
            self.eps = eps
            self.fpx = fpx
            self.grabpay = grabpay
            self.giropay = giropay
            self.ideal = ideal
            self.interacPresent = interacPresent
            self.klarna = klarna
            self.link = link
            self.konbini = konbini
            self.multibanco = multibanco
            self.oxxo = oxxo
            self.p24 = p24
            self.paynow = paynow
            self.paypal = paypal
            self.pix = pix
            self.promptpay = promptpay
            self.sepaDebit = sepaDebit
            self.sofort = sofort
            self.stripeAccount = stripeAccount
            self.type = type
            self.usBankAccount = usBankAccount
            self.wechat = wechat
            self.wechatPay = wechatPay
            self.zip = zip
        }
    }
}

extension Stripe.Charges.Charge.PaymentMethod.Details {
    public enum `Type`: String, Codable, Sendable {
        case achCreditTransfer = "ach_credit_transfer"
        case achDebit = "ach_debit"
        case acssDebit = "acss_debit"
        case affirm
        case afterpayClearpay = "afterpay_clearpay"
        case alipay
        case auBecsDebit = "au_becs_debit"
        case bacsDebit = "bacs_debit"
        case bancontact
        case blik
        case boleto
        case card
        case cardPresent = "card_present"
        case cashapp
        case customerBalance = "customer_balance"
        case eps
        case fpx
        case giropay
        case grabpay
        case ideal
        case interacPresent = "interac_present"
        case klarna
        case konbini
        case link
        case multibanco
        case oxxo
        case p24
        case paynow
        case paypal
        case pix
        case promptpay
        case sepaDebit = "sepa_debit"
        case sofort
        case stripeAccount = "stripe_account"
        case usBankAccount = "us_bank_account"
        case wechat
        case wechatPay = "wechat_pay"
        case zip
    }
}

extension Stripe.Charges.Charge.Radar {
    public struct Options: Codable, Hashable, Sendable {
        /// A Radar Session is a snapshot of the browser metadata and device details that help Radar make more accurate predictions on your payments.
        public var session: String?

        public init(
            session: String? = nil
        ) {
            self.session = session
        }
    }
}

// MARK: - Level III card data
