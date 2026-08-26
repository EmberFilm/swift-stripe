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

extension Stripe.PaymentMethods {
    /// PaymentMethod objects represent your customer's payment instruments.
    public struct PaymentMethod: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// This field indicates whether this payment method can be shown again to its customer in a checkout flow.
        public var allowRedisplay: AllowRedisplay?
        public var billingDetails: Stripe.Shared.BillingDetails?
        /// Time at which the object was created.
        public var created: Date?
        /// The ID of the Customer to which this PaymentMethod is saved.
        @Expandable<Stripe.Customers.Customer, String> public var customer: String?
        public var customerAccount: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        public var radarOptions: Stripe.Shared.RadarOptions?
        /// The type of the PaymentMethod.
        public var `type`: Type?
        /// The payload `type` selects.
        public var details: Details

        fileprivate enum CodingKeys: String, CodingKey {
            case id
            case object
            case allowRedisplay
            case billingDetails
            case created
            case customer
            case customerAccount
            case livemode
            case metadata
            case radarOptions
            case `type`
            case acssDebit
            case affirm
            case afterpayClearpay
            case alipay
            case alma
            case amazonPay
            case auBecsDebit
            case bacsDebit
            case bancontact
            case billie
            case bizum
            case blik
            case boleto
            case card
            case cardPresent
            case cashapp
            case crypto
            case custom
            case customerBalance
            case eps
            case fpx
            case giropay
            case grabpay
            case ideal
            case interacPresent
            case kakaoPay
            case klarna
            case konbini
            case krCard
            case link
            case mbWay
            case mobilepay
            case multibanco
            case naverPay
            case nzBankAccount
            case oxxo
            case p24
            case payByBank
            case payco
            case paynow
            case paypal
            case payto
            case pix
            case promptpay
            case revolutPay
            case samsungPay
            case satispay
            case scalapay
            case sepaDebit
            case sofort
            case sunbit
            case swish
            case twint
            case upi
            case usBankAccount
            case wechatPay
            case zip
        }

        public init(
            id: ID,
            object: String,
            allowRedisplay: AllowRedisplay? = nil,
            billingDetails: Stripe.Shared.BillingDetails? = nil,
            created: Date? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            radarOptions: Stripe.Shared.RadarOptions? = nil,
            `type`: Type? = nil,
            details: Details
        ) {
            self.id = id
            self.object = object
            self.allowRedisplay = allowRedisplay
            self.billingDetails = billingDetails
            self.created = created
            self._customer = Expandable(id: customer)
            self.customerAccount = customerAccount
            self.livemode = livemode
            self.metadata = metadata
            self.radarOptions = radarOptions
            self.`type` = `type`
            self.details = details
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(ID.self, forKey: .id)
            self.object = try container.decode(String.self, forKey: .object)
            self.allowRedisplay = try container.decodeIfPresent(AllowRedisplay.self, forKey: .allowRedisplay)
            self.billingDetails = try container.decodeIfPresent(Stripe.Shared.BillingDetails.self, forKey: .billingDetails)
            self.created = try container.decodeIfPresent(Date.self, forKey: .created)
            self._customer = try container.decode(Expandable<Stripe.Customers.Customer, String>.self, forKey: .customer)
            self.customerAccount = try container.decodeIfPresent(String.self, forKey: .customerAccount)
            self.livemode = try container.decodeIfPresent(Bool.self, forKey: .livemode)
            self.metadata = try container.decodeIfPresent([String: String].self, forKey: .metadata)
            self.radarOptions = try container.decodeIfPresent(Stripe.Shared.RadarOptions.self, forKey: .radarOptions)
            self.`type` = try container.decodeIfPresent(Type.self, forKey: .`type`)
            self.details = try Details(type: try container.decodeIfPresent(String.self, forKey: .type) ?? "", from: container)
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(object, forKey: .object)
            try container.encodeIfPresent(allowRedisplay, forKey: .allowRedisplay)
            try container.encodeIfPresent(billingDetails, forKey: .billingDetails)
            try container.encodeIfPresent(created, forKey: .created)
            try container.encode(_customer, forKey: .customer)
            try container.encodeIfPresent(customerAccount, forKey: .customerAccount)
            try container.encodeIfPresent(livemode, forKey: .livemode)
            try container.encodeIfPresent(metadata, forKey: .metadata)
            try container.encodeIfPresent(radarOptions, forKey: .radarOptions)
            try container.encodeIfPresent(`type`, forKey: .`type`)
            try details.encode(into: &container)
        }

        /// This field indicates whether this payment method can be shown again to its customer in a checkout flow.
        public enum AllowRedisplay: String, Codable, Hashable, Sendable {
            case always
            case limited
            case unspecified
        }

        /// The type of the PaymentMethod.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case acssDebit = "acss_debit"
            case affirm
            case afterpayClearpay = "afterpay_clearpay"
            case alipay
            case alma
            case amazonPay = "amazon_pay"
            case auBecsDebit = "au_becs_debit"
            case bacsDebit = "bacs_debit"
            case bancontact
            case billie
            case bizum
            case blik
            case boleto
            case card
            case cardPresent = "card_present"
            case cashapp
            case crypto
            case custom
            case customerBalance = "customer_balance"
            case eps
            case fpx
            case giropay
            case grabpay
            case ideal
            case interacPresent = "interac_present"
            case kakaoPay = "kakao_pay"
            case klarna
            case konbini
            case krCard = "kr_card"
            case link
            case mbWay = "mb_way"
            case mobilepay
            case multibanco
            case naverPay = "naver_pay"
            case nzBankAccount = "nz_bank_account"
            case oxxo
            case p24
            case payByBank = "pay_by_bank"
            case payco
            case paynow
            case paypal
            case payto
            case pix
            case promptpay
            case revolutPay = "revolut_pay"
            case samsungPay = "samsung_pay"
            case satispay
            case scalapay
            case sepaDebit = "sepa_debit"
            case sofort
            case sunbit
            case swish
            case twint
            case upi
            case usBankAccount = "us_bank_account"
            case wechatPay = "wechat_pay"
            case zip
        }

        public struct Custom: Codable, Hashable, Sendable {
            /// Display name of the Dashboard-only CustomPaymentMethodType.
            public var displayName: String?
            /// Contains information about the Dashboard-only CustomPaymentMethodType logo.
            public var logo: Logo?
            /// ID of the Dashboard-only CustomPaymentMethodType.
            public var `type`: String?

            public init(
                displayName: String? = nil,
                logo: Logo? = nil,
                `type`: String? = nil
            ) {
                self.displayName = displayName
                self.logo = logo
                self.`type` = `type`
            }

            public struct Logo: Codable, Hashable, Sendable {
                /// Content type of the Dashboard-only CustomPaymentMethodType logo.
                public var contentType: String?
                /// URL of the Dashboard-only CustomPaymentMethodType logo.
                public var url: String?

                public init(
                    contentType: String? = nil,
                    url: String? = nil
                ) {
                    self.contentType = contentType
                    self.url = url
                }
            }
        }

        /// The payload `type` selects; `unknown` carries a type this package does not model.
        public indirect enum Details: Hashable, Sendable {
            case acssDebit(Stripe.Shared.PaymentMethodAcssDebit)
            case affirm(Stripe.Shared.Affirm)
            case afterpayClearpay(Stripe.Shared.AfterpayClearpay)
            case alipay(Stripe.Shared.Alipay)
            case alma(Stripe.Shared.Alma)
            case amazonPay(Stripe.Shared.AmazonPay)
            case auBecsDebit(Stripe.Shared.AuBecsDebit)
            case bacsDebit(Stripe.Shared.BacsDebit)
            case bancontact(Stripe.Shared.PaymentMethodBancontact)
            case billie(Stripe.Shared.Billie)
            case bizum(Stripe.Shared.Bizum)
            case blik(Stripe.Shared.Blik)
            case boleto(Stripe.Shared.Boleto)
            case card(Stripe.Shared.Card)
            case cardPresent(Stripe.Shared.PaymentMethodCardPresent)
            case cashapp(Stripe.Shared.Cashapp)
            case crypto(Stripe.Shared.PaymentMethodCrypto)
            case custom(Custom)
            case customerBalance(Stripe.Shared.PaymentMethodCustomerBalance)
            case eps(Stripe.Shared.Eps)
            case fpx(Stripe.Shared.PaymentMethodFpx)
            case giropay(Stripe.Shared.Giropay)
            case grabpay(Stripe.Shared.PaymentMethodGrabpay)
            case ideal(Stripe.Shared.Ideal)
            case interacPresent(Stripe.Shared.PaymentMethodInteracPresent)
            case kakaoPay(Stripe.Shared.KakaoPay)
            case klarna(Stripe.Shared.Klarna)
            case konbini(Stripe.Shared.PaymentMethodKonbini)
            case krCard(Stripe.Shared.PaymentMethodKrCard)
            case link(Stripe.Shared.PaymentMethodLink)
            case mbWay(Stripe.Shared.MbWay)
            case mobilepay(Stripe.Shared.Mobilepay)
            case multibanco(Stripe.Shared.Multibanco)
            case naverPay(Stripe.Shared.NaverPay)
            case nzBankAccount(Stripe.Shared.PaymentMethodNzBankAccount)
            case oxxo(Stripe.Shared.Oxxo)
            case p24(Stripe.Shared.P24)
            case payByBank(Stripe.Shared.PayByBank)
            case payco(Stripe.Shared.Payco)
            case paynow(Stripe.Shared.Paynow)
            case paypal(Stripe.Shared.PaymentMethodPaypal)
            case payto(Stripe.Shared.PaymentMethodPayto)
            case pix(Stripe.Shared.Pix)
            case promptpay(Stripe.Shared.Promptpay)
            case revolutPay(Stripe.Shared.RevolutPay)
            case samsungPay(Stripe.Shared.PaymentMethodSamsungPay)
            case satispay(Stripe.Shared.Satispay)
            case scalapay(Stripe.Shared.Scalapay)
            case sepaDebit(Stripe.Shared.PaymentMethodSepaDebit)
            case sofort(Stripe.Shared.Sofort)
            case sunbit(Stripe.Shared.Sunbit)
            case swish(Stripe.Shared.Swish)
            case twint(Stripe.Shared.Twint)
            case upi(Stripe.Shared.PaymentMethodUpi)
            case usBankAccount(Stripe.Shared.PaymentMethodUsBankAccount)
            case wechatPay(Stripe.Shared.WechatPay)
            case zip(Stripe.Shared.Zip)
            case unknown(type: String)

            public var acssDebit: Stripe.Shared.PaymentMethodAcssDebit? {
                if case .acssDebit(let value) = self { return value }
                return nil
            }
            public var affirm: Stripe.Shared.Affirm? {
                if case .affirm(let value) = self { return value }
                return nil
            }
            public var afterpayClearpay: Stripe.Shared.AfterpayClearpay? {
                if case .afterpayClearpay(let value) = self { return value }
                return nil
            }
            public var alipay: Stripe.Shared.Alipay? {
                if case .alipay(let value) = self { return value }
                return nil
            }
            public var alma: Stripe.Shared.Alma? {
                if case .alma(let value) = self { return value }
                return nil
            }
            public var amazonPay: Stripe.Shared.AmazonPay? {
                if case .amazonPay(let value) = self { return value }
                return nil
            }
            public var auBecsDebit: Stripe.Shared.AuBecsDebit? {
                if case .auBecsDebit(let value) = self { return value }
                return nil
            }
            public var bacsDebit: Stripe.Shared.BacsDebit? {
                if case .bacsDebit(let value) = self { return value }
                return nil
            }
            public var bancontact: Stripe.Shared.PaymentMethodBancontact? {
                if case .bancontact(let value) = self { return value }
                return nil
            }
            public var billie: Stripe.Shared.Billie? {
                if case .billie(let value) = self { return value }
                return nil
            }
            public var bizum: Stripe.Shared.Bizum? {
                if case .bizum(let value) = self { return value }
                return nil
            }
            public var blik: Stripe.Shared.Blik? {
                if case .blik(let value) = self { return value }
                return nil
            }
            public var boleto: Stripe.Shared.Boleto? {
                if case .boleto(let value) = self { return value }
                return nil
            }
            public var card: Stripe.Shared.Card? {
                if case .card(let value) = self { return value }
                return nil
            }
            public var cardPresent: Stripe.Shared.PaymentMethodCardPresent? {
                if case .cardPresent(let value) = self { return value }
                return nil
            }
            public var cashapp: Stripe.Shared.Cashapp? {
                if case .cashapp(let value) = self { return value }
                return nil
            }
            public var crypto: Stripe.Shared.PaymentMethodCrypto? {
                if case .crypto(let value) = self { return value }
                return nil
            }
            public var custom: Custom? {
                if case .custom(let value) = self { return value }
                return nil
            }
            public var customerBalance: Stripe.Shared.PaymentMethodCustomerBalance? {
                if case .customerBalance(let value) = self { return value }
                return nil
            }
            public var eps: Stripe.Shared.Eps? {
                if case .eps(let value) = self { return value }
                return nil
            }
            public var fpx: Stripe.Shared.PaymentMethodFpx? {
                if case .fpx(let value) = self { return value }
                return nil
            }
            public var giropay: Stripe.Shared.Giropay? {
                if case .giropay(let value) = self { return value }
                return nil
            }
            public var grabpay: Stripe.Shared.PaymentMethodGrabpay? {
                if case .grabpay(let value) = self { return value }
                return nil
            }
            public var ideal: Stripe.Shared.Ideal? {
                if case .ideal(let value) = self { return value }
                return nil
            }
            public var interacPresent: Stripe.Shared.PaymentMethodInteracPresent? {
                if case .interacPresent(let value) = self { return value }
                return nil
            }
            public var kakaoPay: Stripe.Shared.KakaoPay? {
                if case .kakaoPay(let value) = self { return value }
                return nil
            }
            public var klarna: Stripe.Shared.Klarna? {
                if case .klarna(let value) = self { return value }
                return nil
            }
            public var konbini: Stripe.Shared.PaymentMethodKonbini? {
                if case .konbini(let value) = self { return value }
                return nil
            }
            public var krCard: Stripe.Shared.PaymentMethodKrCard? {
                if case .krCard(let value) = self { return value }
                return nil
            }
            public var link: Stripe.Shared.PaymentMethodLink? {
                if case .link(let value) = self { return value }
                return nil
            }
            public var mbWay: Stripe.Shared.MbWay? {
                if case .mbWay(let value) = self { return value }
                return nil
            }
            public var mobilepay: Stripe.Shared.Mobilepay? {
                if case .mobilepay(let value) = self { return value }
                return nil
            }
            public var multibanco: Stripe.Shared.Multibanco? {
                if case .multibanco(let value) = self { return value }
                return nil
            }
            public var naverPay: Stripe.Shared.NaverPay? {
                if case .naverPay(let value) = self { return value }
                return nil
            }
            public var nzBankAccount: Stripe.Shared.PaymentMethodNzBankAccount? {
                if case .nzBankAccount(let value) = self { return value }
                return nil
            }
            public var oxxo: Stripe.Shared.Oxxo? {
                if case .oxxo(let value) = self { return value }
                return nil
            }
            public var p24: Stripe.Shared.P24? {
                if case .p24(let value) = self { return value }
                return nil
            }
            public var payByBank: Stripe.Shared.PayByBank? {
                if case .payByBank(let value) = self { return value }
                return nil
            }
            public var payco: Stripe.Shared.Payco? {
                if case .payco(let value) = self { return value }
                return nil
            }
            public var paynow: Stripe.Shared.Paynow? {
                if case .paynow(let value) = self { return value }
                return nil
            }
            public var paypal: Stripe.Shared.PaymentMethodPaypal? {
                if case .paypal(let value) = self { return value }
                return nil
            }
            public var payto: Stripe.Shared.PaymentMethodPayto? {
                if case .payto(let value) = self { return value }
                return nil
            }
            public var pix: Stripe.Shared.Pix? {
                if case .pix(let value) = self { return value }
                return nil
            }
            public var promptpay: Stripe.Shared.Promptpay? {
                if case .promptpay(let value) = self { return value }
                return nil
            }
            public var revolutPay: Stripe.Shared.RevolutPay? {
                if case .revolutPay(let value) = self { return value }
                return nil
            }
            public var samsungPay: Stripe.Shared.PaymentMethodSamsungPay? {
                if case .samsungPay(let value) = self { return value }
                return nil
            }
            public var satispay: Stripe.Shared.Satispay? {
                if case .satispay(let value) = self { return value }
                return nil
            }
            public var scalapay: Stripe.Shared.Scalapay? {
                if case .scalapay(let value) = self { return value }
                return nil
            }
            public var sepaDebit: Stripe.Shared.PaymentMethodSepaDebit? {
                if case .sepaDebit(let value) = self { return value }
                return nil
            }
            public var sofort: Stripe.Shared.Sofort? {
                if case .sofort(let value) = self { return value }
                return nil
            }
            public var sunbit: Stripe.Shared.Sunbit? {
                if case .sunbit(let value) = self { return value }
                return nil
            }
            public var swish: Stripe.Shared.Swish? {
                if case .swish(let value) = self { return value }
                return nil
            }
            public var twint: Stripe.Shared.Twint? {
                if case .twint(let value) = self { return value }
                return nil
            }
            public var upi: Stripe.Shared.PaymentMethodUpi? {
                if case .upi(let value) = self { return value }
                return nil
            }
            public var usBankAccount: Stripe.Shared.PaymentMethodUsBankAccount? {
                if case .usBankAccount(let value) = self { return value }
                return nil
            }
            public var wechatPay: Stripe.Shared.WechatPay? {
                if case .wechatPay(let value) = self { return value }
                return nil
            }
            public var zip: Stripe.Shared.Zip? {
                if case .zip(let value) = self { return value }
                return nil
            }

            fileprivate init(type: String, from container: KeyedDecodingContainer<CodingKeys>) throws {
                switch type {
                case "acss_debit":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodAcssDebit.self, forKey: .acssDebit) {
                        self = .acssDebit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "affirm":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Affirm.self, forKey: .affirm) {
                        self = .affirm(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "afterpay_clearpay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.AfterpayClearpay.self, forKey: .afterpayClearpay) {
                        self = .afterpayClearpay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "alipay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Alipay.self, forKey: .alipay) {
                        self = .alipay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "alma":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Alma.self, forKey: .alma) {
                        self = .alma(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "amazon_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.AmazonPay.self, forKey: .amazonPay) {
                        self = .amazonPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "au_becs_debit":
                    if let value = try container.decodeIfPresent(Stripe.Shared.AuBecsDebit.self, forKey: .auBecsDebit) {
                        self = .auBecsDebit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "bacs_debit":
                    if let value = try container.decodeIfPresent(Stripe.Shared.BacsDebit.self, forKey: .bacsDebit) {
                        self = .bacsDebit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "bancontact":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodBancontact.self, forKey: .bancontact) {
                        self = .bancontact(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "billie":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Billie.self, forKey: .billie) {
                        self = .billie(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "bizum":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Bizum.self, forKey: .bizum) {
                        self = .bizum(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "blik":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Blik.self, forKey: .blik) {
                        self = .blik(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "boleto":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Boleto.self, forKey: .boleto) {
                        self = .boleto(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "card":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Card.self, forKey: .card) {
                        self = .card(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "card_present":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodCardPresent.self, forKey: .cardPresent) {
                        self = .cardPresent(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "cashapp":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Cashapp.self, forKey: .cashapp) {
                        self = .cashapp(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "crypto":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodCrypto.self, forKey: .crypto) {
                        self = .crypto(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "custom":
                    if let value = try container.decodeIfPresent(Custom.self, forKey: .custom) {
                        self = .custom(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "customer_balance":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodCustomerBalance.self, forKey: .customerBalance) {
                        self = .customerBalance(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "eps":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Eps.self, forKey: .eps) {
                        self = .eps(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "fpx":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodFpx.self, forKey: .fpx) {
                        self = .fpx(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "giropay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Giropay.self, forKey: .giropay) {
                        self = .giropay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "grabpay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodGrabpay.self, forKey: .grabpay) {
                        self = .grabpay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "ideal":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Ideal.self, forKey: .ideal) {
                        self = .ideal(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "interac_present":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodInteracPresent.self, forKey: .interacPresent) {
                        self = .interacPresent(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "kakao_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.KakaoPay.self, forKey: .kakaoPay) {
                        self = .kakaoPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "klarna":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Klarna.self, forKey: .klarna) {
                        self = .klarna(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "konbini":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodKonbini.self, forKey: .konbini) {
                        self = .konbini(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "kr_card":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodKrCard.self, forKey: .krCard) {
                        self = .krCard(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "link":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodLink.self, forKey: .link) {
                        self = .link(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "mb_way":
                    if let value = try container.decodeIfPresent(Stripe.Shared.MbWay.self, forKey: .mbWay) {
                        self = .mbWay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "mobilepay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Mobilepay.self, forKey: .mobilepay) {
                        self = .mobilepay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "multibanco":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Multibanco.self, forKey: .multibanco) {
                        self = .multibanco(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "naver_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.NaverPay.self, forKey: .naverPay) {
                        self = .naverPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "nz_bank_account":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodNzBankAccount.self, forKey: .nzBankAccount) {
                        self = .nzBankAccount(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "oxxo":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Oxxo.self, forKey: .oxxo) {
                        self = .oxxo(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "p24":
                    if let value = try container.decodeIfPresent(Stripe.Shared.P24.self, forKey: .p24) {
                        self = .p24(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "pay_by_bank":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PayByBank.self, forKey: .payByBank) {
                        self = .payByBank(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "payco":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Payco.self, forKey: .payco) {
                        self = .payco(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "paynow":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Paynow.self, forKey: .paynow) {
                        self = .paynow(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "paypal":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodPaypal.self, forKey: .paypal) {
                        self = .paypal(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "payto":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodPayto.self, forKey: .payto) {
                        self = .payto(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "pix":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Pix.self, forKey: .pix) {
                        self = .pix(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "promptpay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Promptpay.self, forKey: .promptpay) {
                        self = .promptpay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "revolut_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.RevolutPay.self, forKey: .revolutPay) {
                        self = .revolutPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "samsung_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodSamsungPay.self, forKey: .samsungPay) {
                        self = .samsungPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "satispay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Satispay.self, forKey: .satispay) {
                        self = .satispay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "scalapay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Scalapay.self, forKey: .scalapay) {
                        self = .scalapay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "sepa_debit":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodSepaDebit.self, forKey: .sepaDebit) {
                        self = .sepaDebit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "sofort":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Sofort.self, forKey: .sofort) {
                        self = .sofort(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "sunbit":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Sunbit.self, forKey: .sunbit) {
                        self = .sunbit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "swish":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Swish.self, forKey: .swish) {
                        self = .swish(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "twint":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Twint.self, forKey: .twint) {
                        self = .twint(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "upi":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodUpi.self, forKey: .upi) {
                        self = .upi(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "us_bank_account":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodUsBankAccount.self, forKey: .usBankAccount) {
                        self = .usBankAccount(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "wechat_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.WechatPay.self, forKey: .wechatPay) {
                        self = .wechatPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "zip":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Zip.self, forKey: .zip) {
                        self = .zip(value)
                    } else {
                        self = .unknown(type: type)
                    }
                default: self = .unknown(type: type)
                }
            }

            fileprivate func encode(into container: inout KeyedEncodingContainer<CodingKeys>) throws {
                switch self {
                case .acssDebit(let value): try container.encode(value, forKey: .acssDebit)
                case .affirm(let value): try container.encode(value, forKey: .affirm)
                case .afterpayClearpay(let value): try container.encode(value, forKey: .afterpayClearpay)
                case .alipay(let value): try container.encode(value, forKey: .alipay)
                case .alma(let value): try container.encode(value, forKey: .alma)
                case .amazonPay(let value): try container.encode(value, forKey: .amazonPay)
                case .auBecsDebit(let value): try container.encode(value, forKey: .auBecsDebit)
                case .bacsDebit(let value): try container.encode(value, forKey: .bacsDebit)
                case .bancontact(let value): try container.encode(value, forKey: .bancontact)
                case .billie(let value): try container.encode(value, forKey: .billie)
                case .bizum(let value): try container.encode(value, forKey: .bizum)
                case .blik(let value): try container.encode(value, forKey: .blik)
                case .boleto(let value): try container.encode(value, forKey: .boleto)
                case .card(let value): try container.encode(value, forKey: .card)
                case .cardPresent(let value): try container.encode(value, forKey: .cardPresent)
                case .cashapp(let value): try container.encode(value, forKey: .cashapp)
                case .crypto(let value): try container.encode(value, forKey: .crypto)
                case .custom(let value): try container.encode(value, forKey: .custom)
                case .customerBalance(let value): try container.encode(value, forKey: .customerBalance)
                case .eps(let value): try container.encode(value, forKey: .eps)
                case .fpx(let value): try container.encode(value, forKey: .fpx)
                case .giropay(let value): try container.encode(value, forKey: .giropay)
                case .grabpay(let value): try container.encode(value, forKey: .grabpay)
                case .ideal(let value): try container.encode(value, forKey: .ideal)
                case .interacPresent(let value): try container.encode(value, forKey: .interacPresent)
                case .kakaoPay(let value): try container.encode(value, forKey: .kakaoPay)
                case .klarna(let value): try container.encode(value, forKey: .klarna)
                case .konbini(let value): try container.encode(value, forKey: .konbini)
                case .krCard(let value): try container.encode(value, forKey: .krCard)
                case .link(let value): try container.encode(value, forKey: .link)
                case .mbWay(let value): try container.encode(value, forKey: .mbWay)
                case .mobilepay(let value): try container.encode(value, forKey: .mobilepay)
                case .multibanco(let value): try container.encode(value, forKey: .multibanco)
                case .naverPay(let value): try container.encode(value, forKey: .naverPay)
                case .nzBankAccount(let value): try container.encode(value, forKey: .nzBankAccount)
                case .oxxo(let value): try container.encode(value, forKey: .oxxo)
                case .p24(let value): try container.encode(value, forKey: .p24)
                case .payByBank(let value): try container.encode(value, forKey: .payByBank)
                case .payco(let value): try container.encode(value, forKey: .payco)
                case .paynow(let value): try container.encode(value, forKey: .paynow)
                case .paypal(let value): try container.encode(value, forKey: .paypal)
                case .payto(let value): try container.encode(value, forKey: .payto)
                case .pix(let value): try container.encode(value, forKey: .pix)
                case .promptpay(let value): try container.encode(value, forKey: .promptpay)
                case .revolutPay(let value): try container.encode(value, forKey: .revolutPay)
                case .samsungPay(let value): try container.encode(value, forKey: .samsungPay)
                case .satispay(let value): try container.encode(value, forKey: .satispay)
                case .scalapay(let value): try container.encode(value, forKey: .scalapay)
                case .sepaDebit(let value): try container.encode(value, forKey: .sepaDebit)
                case .sofort(let value): try container.encode(value, forKey: .sofort)
                case .sunbit(let value): try container.encode(value, forKey: .sunbit)
                case .swish(let value): try container.encode(value, forKey: .swish)
                case .twint(let value): try container.encode(value, forKey: .twint)
                case .upi(let value): try container.encode(value, forKey: .upi)
                case .usBankAccount(let value): try container.encode(value, forKey: .usBankAccount)
                case .wechatPay(let value): try container.encode(value, forKey: .wechatPay)
                case .zip(let value): try container.encode(value, forKey: .zip)
                default: break
                }
            }
        }
    }
}
