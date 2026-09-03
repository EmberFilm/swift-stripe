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

extension Stripe.PaymentMethodConfigurations {
    /// PaymentMethodConfigurations control which payment methods are displayed to your customers when you don't explicitly.
    public struct Configuration: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        public var acssDebit: AcssDebit?
        /// Whether the configuration can be used for new payments.
        public var active: Bool?
        public var affirm: Affirm?
        public var afterpayClearpay: AfterpayClearpay?
        public var alipay: Alipay?
        public var alma: Alma?
        public var amazonPay: AmazonPay?
        public var applePay: ApplePay?
        /// For child configs, the Connect application associated with the configuration.
        public var application: String?
        public var auBecsDebit: AuBecsDebit?
        public var bacsDebit: BacsDebit?
        public var bancontact: Bancontact?
        public var billie: Billie?
        public var bizum: Bizum?
        public var blik: Blik?
        public var boleto: Boleto?
        @Boxed public var card: Card?
        public var cartesBancaires: CartesBancaires?
        public var cashapp: Cashapp?
        public var crypto: Crypto?
        public var customerBalance: CustomerBalance?
        public var eps: Eps?
        public var fpx: Fpx?
        public var giropay: Giropay?
        public var googlePay: GooglePay?
        public var grabpay: Grabpay?
        public var ideal: Ideal?
        /// The default configuration is used whenever a payment method configuration is not specified.
        public var isDefault: Bool?
        public var jcb: Jcb?
        public var kakaoPay: KakaoPay?
        public var klarna: Klarna?
        public var konbini: Konbini?
        public var krCard: KrCard?
        public var link: Link?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        public var mbWay: MbWay?
        public var mobilepay: Mobilepay?
        public var multibanco: Multibanco?
        /// The configuration's name.
        public var name: String?
        public var naverPay: NaverPay?
        public var nzBankAccount: NzBankAccount?
        public var oxxo: Oxxo?
        public var p24: P24?
        /// For child configs, the configuration's parent configuration.
        public var parent: String?
        public var payByBank: PayByBank?
        public var payco: Payco?
        public var paynow: Paynow?
        public var paypal: Paypal?
        public var payto: Payto?
        public var pix: Pix?
        public var promptpay: Promptpay?
        public var revolutPay: RevolutPay?
        public var samsungPay: SamsungPay?
        public var satispay: Satispay?
        public var scalapay: Scalapay?
        public var sepaDebit: SepaDebit?
        public var sofort: Sofort?
        public var sunbit: Sunbit?
        public var swish: Swish?
        public var twint: Twint?
        public var upi: Upi?
        public var usBankAccount: UsBankAccount?
        public var wechatPay: WechatPay?
        public var zip: Zip?

        public init(
            id: ID,
            object: String,
            acssDebit: AcssDebit? = nil,
            active: Bool? = nil,
            affirm: Affirm? = nil,
            afterpayClearpay: AfterpayClearpay? = nil,
            alipay: Alipay? = nil,
            alma: Alma? = nil,
            amazonPay: AmazonPay? = nil,
            applePay: ApplePay? = nil,
            application: String? = nil,
            auBecsDebit: AuBecsDebit? = nil,
            bacsDebit: BacsDebit? = nil,
            bancontact: Bancontact? = nil,
            billie: Billie? = nil,
            bizum: Bizum? = nil,
            blik: Blik? = nil,
            boleto: Boleto? = nil,
            card: Card? = nil,
            cartesBancaires: CartesBancaires? = nil,
            cashapp: Cashapp? = nil,
            crypto: Crypto? = nil,
            customerBalance: CustomerBalance? = nil,
            eps: Eps? = nil,
            fpx: Fpx? = nil,
            giropay: Giropay? = nil,
            googlePay: GooglePay? = nil,
            grabpay: Grabpay? = nil,
            ideal: Ideal? = nil,
            isDefault: Bool? = nil,
            jcb: Jcb? = nil,
            kakaoPay: KakaoPay? = nil,
            klarna: Klarna? = nil,
            konbini: Konbini? = nil,
            krCard: KrCard? = nil,
            link: Link? = nil,
            livemode: Bool? = nil,
            mbWay: MbWay? = nil,
            mobilepay: Mobilepay? = nil,
            multibanco: Multibanco? = nil,
            name: String? = nil,
            naverPay: NaverPay? = nil,
            nzBankAccount: NzBankAccount? = nil,
            oxxo: Oxxo? = nil,
            p24: P24? = nil,
            parent: String? = nil,
            payByBank: PayByBank? = nil,
            payco: Payco? = nil,
            paynow: Paynow? = nil,
            paypal: Paypal? = nil,
            payto: Payto? = nil,
            pix: Pix? = nil,
            promptpay: Promptpay? = nil,
            revolutPay: RevolutPay? = nil,
            samsungPay: SamsungPay? = nil,
            satispay: Satispay? = nil,
            scalapay: Scalapay? = nil,
            sepaDebit: SepaDebit? = nil,
            sofort: Sofort? = nil,
            sunbit: Sunbit? = nil,
            swish: Swish? = nil,
            twint: Twint? = nil,
            upi: Upi? = nil,
            usBankAccount: UsBankAccount? = nil,
            wechatPay: WechatPay? = nil,
            zip: Zip? = nil
        ) {
            self.id = id
            self.object = object
            self.acssDebit = acssDebit
            self.active = active
            self.affirm = affirm
            self.afterpayClearpay = afterpayClearpay
            self.alipay = alipay
            self.alma = alma
            self.amazonPay = amazonPay
            self.applePay = applePay
            self.application = application
            self.auBecsDebit = auBecsDebit
            self.bacsDebit = bacsDebit
            self.bancontact = bancontact
            self.billie = billie
            self.bizum = bizum
            self.blik = blik
            self.boleto = boleto
            self._card = Boxed(wrappedValue: card)
            self.cartesBancaires = cartesBancaires
            self.cashapp = cashapp
            self.crypto = crypto
            self.customerBalance = customerBalance
            self.eps = eps
            self.fpx = fpx
            self.giropay = giropay
            self.googlePay = googlePay
            self.grabpay = grabpay
            self.ideal = ideal
            self.isDefault = isDefault
            self.jcb = jcb
            self.kakaoPay = kakaoPay
            self.klarna = klarna
            self.konbini = konbini
            self.krCard = krCard
            self.link = link
            self.livemode = livemode
            self.mbWay = mbWay
            self.mobilepay = mobilepay
            self.multibanco = multibanco
            self.name = name
            self.naverPay = naverPay
            self.nzBankAccount = nzBankAccount
            self.oxxo = oxxo
            self.p24 = p24
            self.parent = parent
            self.payByBank = payByBank
            self.payco = payco
            self.paynow = paynow
            self.paypal = paypal
            self.payto = payto
            self.pix = pix
            self.promptpay = promptpay
            self.revolutPay = revolutPay
            self.samsungPay = samsungPay
            self.satispay = satispay
            self.scalapay = scalapay
            self.sepaDebit = sepaDebit
            self.sofort = sofort
            self.sunbit = sunbit
            self.swish = swish
            self.twint = twint
            self.upi = upi
            self.usBankAccount = usBankAccount
            self.wechatPay = wechatPay
            self.zip = zip
        }

        public struct AcssDebit: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Affirm: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct AfterpayClearpay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Alipay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Alma: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct AmazonPay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct ApplePay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct AuBecsDebit: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct BacsDebit: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Bancontact: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Billie: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Bizum: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Blik: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Boleto: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Card: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct CartesBancaires: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Cashapp: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Crypto: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct CustomerBalance: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Eps: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Fpx: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Giropay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct GooglePay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Grabpay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Ideal: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Jcb: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct KakaoPay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Klarna: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Konbini: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct KrCard: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Link: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct MbWay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Mobilepay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Multibanco: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct NaverPay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct NzBankAccount: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Oxxo: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct P24: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct PayByBank: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Payco: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Paynow: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Paypal: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Payto: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Pix: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Promptpay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct RevolutPay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct SamsungPay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Satispay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Scalapay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct SepaDebit: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Sofort: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Sunbit: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Swish: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Twint: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Upi: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct UsBankAccount: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct WechatPay: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }

        public struct Zip: Codable, Hashable, Sendable {
            /// Whether this payment method may be offered at checkout.
            public var available: Bool?
            public var displayPreference: DisplayPreference?

            public init(
                available: Bool? = nil,
                displayPreference: DisplayPreference? = nil
            ) {
                self.available = available
                self.displayPreference = displayPreference
            }

            public struct DisplayPreference: Codable, Hashable, Sendable {
                /// For child configs, whether or not the account's preference will be observed.
                public var overridable: Bool?
                /// The account's display preference.
                public var preference: Preference?
                /// The effective display preference value.
                public var value: Value?

                public init(
                    overridable: Bool? = nil,
                    preference: Preference? = nil,
                    value: Value? = nil
                ) {
                    self.overridable = overridable
                    self.preference = preference
                    self.value = value
                }

                /// The account's display preference.
                public enum Preference: String, Codable, Hashable, Sendable {
                    case none
                    case off
                    case on
                }

                /// The effective display preference value.
                public enum Value: String, Codable, Hashable, Sendable {
                    case off
                    case on
                }
            }
        }
    }
}
