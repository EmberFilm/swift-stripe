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

extension TerminalConfiguration {
    public enum Create {}
    public enum Delete {}
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/terminal/configurations
extension TerminalConfiguration.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// An object containing device type specific settings for BBPOS WisePad 3 readers.
        public var bbposWisepad3: BbposWisepad3?
        /// An object containing device type specific settings for BBPOS WisePOS E readers.
        public var bbposWiseposE: BbposWiseposE?
        /// Configuration for cellular connectivity.
        public var cellular: Stripe.Clearable<Cellular>?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Name of the configuration.
        public var name: String?
        /// Configurations for collecting transactions offline.
        public var offline: Stripe.Clearable<Offline>?
        /// Reboot time settings for readers.
        public var rebootWindow: RebootWindow?
        /// An object containing device type specific settings for Stripe S700 readers.
        public var stripeS700: StripeS700?
        /// An object containing device type specific settings for Stripe S710 readers.
        public var stripeS710: StripeS710?
        /// Tipping configurations for readers that support on-reader tips.
        public var tipping: Stripe.Clearable<Tipping>?
        /// An object containing device type specific settings for Verifone M425 readers.
        public var verifoneM425: VerifoneM425?
        /// An object containing device type specific settings for Verifone P400 readers.
        public var verifoneP400: VerifoneP400?
        /// An object containing device type specific settings for Verifone P630 readers.
        public var verifoneP630: VerifoneP630?
        /// An object containing device type specific settings for Verifone UX700 readers.
        public var verifoneUx700: VerifoneUx700?
        /// An object containing device type specific settings for Verifone V660p readers.
        public var verifoneV660p: VerifoneV660p?
        /// Configurations for connecting to a WiFi network.
        public var wifi: Stripe.Clearable<Wifi>?

        public init(
            bbposWisepad3: BbposWisepad3? = nil,
            bbposWiseposE: BbposWiseposE? = nil,
            cellular: Stripe.Clearable<Cellular>? = nil,
            expand: [String]? = nil,
            name: String? = nil,
            offline: Stripe.Clearable<Offline>? = nil,
            rebootWindow: RebootWindow? = nil,
            stripeS700: StripeS700? = nil,
            stripeS710: StripeS710? = nil,
            tipping: Stripe.Clearable<Tipping>? = nil,
            verifoneM425: VerifoneM425? = nil,
            verifoneP400: VerifoneP400? = nil,
            verifoneP630: VerifoneP630? = nil,
            verifoneUx700: VerifoneUx700? = nil,
            verifoneV660p: VerifoneV660p? = nil,
            wifi: Stripe.Clearable<Wifi>? = nil
        ) {
            self.bbposWisepad3 = bbposWisepad3
            self.bbposWiseposE = bbposWiseposE
            self.cellular = cellular
            self.expand = expand
            self.name = name
            self.offline = offline
            self.rebootWindow = rebootWindow
            self.stripeS700 = stripeS700
            self.stripeS710 = stripeS710
            self.tipping = tipping
            self.verifoneM425 = verifoneM425
            self.verifoneP400 = verifoneP400
            self.verifoneP630 = verifoneP630
            self.verifoneUx700 = verifoneUx700
            self.verifoneV660p = verifoneV660p
            self.wifi = wifi
        }

        /// An object containing device type specific settings for BBPOS WisePad 3 readers.
        public struct BbposWisepad3: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        /// An object containing device type specific settings for BBPOS WisePOS E readers.
        public struct BbposWiseposE: Codable, Hashable, Sendable {
            /// A File ID representing an image to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct Cellular: Codable, Hashable, Sendable {
            /// Determines whether to allow the reader to connect to a cellular network.
            public var enabled: Bool

            public init(
                enabled: Bool
            ) {
                self.enabled = enabled
            }
        }

        public struct Offline: Codable, Hashable, Sendable {
            /// Determines whether to allow transactions to be collected while reader is offline.
            public var enabled: Bool

            public init(
                enabled: Bool
            ) {
                self.enabled = enabled
            }
        }

        /// Reboot time settings for readers.
        public struct RebootWindow: Codable, Hashable, Sendable {
            /// Integer between 0 to 23 that represents the end hour of the reboot time window.
            public var endHour: Int
            /// Integer between 0 to 23 that represents the start hour of the reboot time window.
            public var startHour: Int

            public init(
                endHour: Int,
                startHour: Int
            ) {
                self.endHour = endHour
                self.startHour = startHour
            }
        }

        /// An object containing device type specific settings for Stripe S700 readers.
        public struct StripeS700: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        /// An object containing device type specific settings for Stripe S710 readers.
        public struct StripeS710: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct Tipping: Codable, Hashable, Sendable {
            /// Tipping configuration for AED.
            public var aed: Aed?
            /// Tipping configuration for AUD.
            public var aud: Aud?
            /// Tipping configuration for CAD.
            public var cad: Cad?
            /// Tipping configuration for CHF.
            public var chf: Chf?
            /// Tipping configuration for CZK.
            public var czk: Czk?
            /// Tipping configuration for DKK.
            public var dkk: Dkk?
            /// Tipping configuration for EUR.
            public var eur: Eur?
            /// Tipping configuration for GBP.
            public var gbp: Gbp?
            /// Tipping configuration for GIP.
            public var gip: Gip?
            /// Tipping configuration for HKD.
            public var hkd: Hkd?
            /// Tipping configuration for HUF.
            public var huf: Huf?
            /// Tipping configuration for JPY.
            public var jpy: Jpy?
            /// Tipping configuration for MXN.
            public var mxn: Mxn?
            /// Tipping configuration for MYR.
            public var myr: Myr?
            /// Tipping configuration for NOK.
            public var nok: Nok?
            /// Tipping configuration for NZD.
            public var nzd: Nzd?
            /// Tipping configuration for PLN.
            public var pln: Pln?
            /// Tipping configuration for RON.
            public var ron: Ron?
            /// Tipping configuration for SEK.
            public var sek: Sek?
            /// Tipping configuration for SGD.
            public var sgd: Sgd?
            /// Tipping configuration for USD.
            public var usd: Usd?

            public init(
                aed: Aed? = nil,
                aud: Aud? = nil,
                cad: Cad? = nil,
                chf: Chf? = nil,
                czk: Czk? = nil,
                dkk: Dkk? = nil,
                eur: Eur? = nil,
                gbp: Gbp? = nil,
                gip: Gip? = nil,
                hkd: Hkd? = nil,
                huf: Huf? = nil,
                jpy: Jpy? = nil,
                mxn: Mxn? = nil,
                myr: Myr? = nil,
                nok: Nok? = nil,
                nzd: Nzd? = nil,
                pln: Pln? = nil,
                ron: Ron? = nil,
                sek: Sek? = nil,
                sgd: Sgd? = nil,
                usd: Usd? = nil
            ) {
                self.aed = aed
                self.aud = aud
                self.cad = cad
                self.chf = chf
                self.czk = czk
                self.dkk = dkk
                self.eur = eur
                self.gbp = gbp
                self.gip = gip
                self.hkd = hkd
                self.huf = huf
                self.jpy = jpy
                self.mxn = mxn
                self.myr = myr
                self.nok = nok
                self.nzd = nzd
                self.pln = pln
                self.ron = ron
                self.sek = sek
                self.sgd = sgd
                self.usd = usd
            }

            /// Tipping configuration for AED.
            public struct Aed: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for AUD.
            public struct Aud: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for CAD.
            public struct Cad: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for CHF.
            public struct Chf: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for CZK.
            public struct Czk: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for DKK.
            public struct Dkk: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for EUR.
            public struct Eur: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for GBP.
            public struct Gbp: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for GIP.
            public struct Gip: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for HKD.
            public struct Hkd: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for HUF.
            public struct Huf: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for JPY.
            public struct Jpy: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for MXN.
            public struct Mxn: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for MYR.
            public struct Myr: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for NOK.
            public struct Nok: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for NZD.
            public struct Nzd: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for PLN.
            public struct Pln: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for RON.
            public struct Ron: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for SEK.
            public struct Sek: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for SGD.
            public struct Sgd: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for USD.
            public struct Usd: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }
        }

        /// An object containing device type specific settings for Verifone M425 readers.
        public struct VerifoneM425: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        /// An object containing device type specific settings for Verifone P400 readers.
        public struct VerifoneP400: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        /// An object containing device type specific settings for Verifone P630 readers.
        public struct VerifoneP630: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        /// An object containing device type specific settings for Verifone UX700 readers.
        public struct VerifoneUx700: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        /// An object containing device type specific settings for Verifone V660p readers.
        public struct VerifoneV660p: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct Wifi: Codable, Hashable, Sendable {
            /// Credentials for a WPA-Enterprise WiFi network using the EAP-PEAP authentication method.
            public var enterpriseEapPeap: EnterpriseEapPeap?
            /// Credentials for a WPA-Enterprise WiFi network using the EAP-TLS authentication method.
            public var enterpriseEapTls: EnterpriseEapTls?
            /// Credentials for a WPA-Personal WiFi network.
            public var personalPsk: PersonalPsk?
            /// Security type of the WiFi network.
            public var `type`: Type

            public init(
                enterpriseEapPeap: EnterpriseEapPeap? = nil,
                enterpriseEapTls: EnterpriseEapTls? = nil,
                personalPsk: PersonalPsk? = nil,
                `type`: Type
            ) {
                self.enterpriseEapPeap = enterpriseEapPeap
                self.enterpriseEapTls = enterpriseEapTls
                self.personalPsk = personalPsk
                self.`type` = `type`
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case enterpriseEapPeap = "enterprise_eap_peap"
                case enterpriseEapTls = "enterprise_eap_tls"
                case personalPsk = "personal_psk"
            }

            /// Credentials for a WPA-Enterprise WiFi network using the EAP-PEAP authentication method.
            public struct EnterpriseEapPeap: Codable, Hashable, Sendable {
                /// A File ID representing a PEM file containing the server certificate.
                public var caCertificateFile: String?
                /// Password for connecting to the WiFi network.
                public var password: String
                /// Name of the WiFi network.
                public var ssid: String
                /// Username for connecting to the WiFi network.
                public var username: String

                public init(
                    caCertificateFile: String? = nil,
                    password: String,
                    ssid: String,
                    username: String
                ) {
                    self.caCertificateFile = caCertificateFile
                    self.password = password
                    self.ssid = ssid
                    self.username = username
                }
            }

            /// Credentials for a WPA-Enterprise WiFi network using the EAP-TLS authentication method.
            public struct EnterpriseEapTls: Codable, Hashable, Sendable {
                /// A File ID representing a PEM file containing the server certificate.
                public var caCertificateFile: String?
                /// A File ID representing a PEM file containing the client certificate.
                public var clientCertificateFile: String
                /// A File ID representing a PEM file containing the client RSA private key.
                public var privateKeyFile: String
                /// Password for the private key file.
                public var privateKeyFilePassword: String?
                /// Name of the WiFi network.
                public var ssid: String

                public init(
                    caCertificateFile: String? = nil,
                    clientCertificateFile: String,
                    privateKeyFile: String,
                    privateKeyFilePassword: String? = nil,
                    ssid: String
                ) {
                    self.caCertificateFile = caCertificateFile
                    self.clientCertificateFile = clientCertificateFile
                    self.privateKeyFile = privateKeyFile
                    self.privateKeyFilePassword = privateKeyFilePassword
                    self.ssid = ssid
                }
            }

            /// Credentials for a WPA-Personal WiFi network.
            public struct PersonalPsk: Codable, Hashable, Sendable {
                /// Password for connecting to the WiFi network.
                public var password: String
                /// Name of the WiFi network.
                public var ssid: String

                public init(
                    password: String,
                    ssid: String
                ) {
                    self.password = password
                    self.ssid = ssid
                }
            }
        }
    }

    public typealias Response = TerminalConfiguration
}

// DELETE /v1/terminal/configurations/{configuration}
extension TerminalConfiguration.Delete {
    public typealias Response = DeletedObject<TerminalConfiguration>
}

// GET /v1/terminal/configurations
extension TerminalConfiguration.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// if present, only return the account default or non-default configurations.
        public var isAccountDefault: Bool?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            isAccountDefault: Bool? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.isAccountDefault = isAccountDefault
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<TerminalConfiguration>
}

// GET /v1/terminal/configurations/{configuration}
extension TerminalConfiguration.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = TerminalConfiguration
}

// POST /v1/terminal/configurations/{configuration}
extension TerminalConfiguration.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// An object containing device type specific settings for BBPOS WisePad 3 readers.
        public var bbposWisepad3: Stripe.Clearable<BbposWisepad3>?
        /// An object containing device type specific settings for BBPOS WisePOS E readers.
        public var bbposWiseposE: Stripe.Clearable<BbposWiseposE>?
        /// Configuration for cellular connectivity.
        public var cellular: Stripe.Clearable<Cellular>?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Name of the configuration.
        public var name: String?
        /// Configurations for collecting transactions offline.
        public var offline: Stripe.Clearable<Offline>?
        /// Reboot time settings for readers.
        public var rebootWindow: Stripe.Clearable<RebootWindow>?
        /// An object containing device type specific settings for Stripe S700 readers.
        public var stripeS700: Stripe.Clearable<StripeS700>?
        /// An object containing device type specific settings for Stripe S710 readers.
        public var stripeS710: Stripe.Clearable<StripeS710>?
        /// Tipping configurations for readers that support on-reader tips.
        public var tipping: Stripe.Clearable<Tipping>?
        /// An object containing device type specific settings for Verifone M425 readers.
        public var verifoneM425: Stripe.Clearable<VerifoneM425>?
        /// An object containing device type specific settings for Verifone P400 readers.
        public var verifoneP400: Stripe.Clearable<VerifoneP400>?
        /// An object containing device type specific settings for Verifone P630 readers.
        public var verifoneP630: Stripe.Clearable<VerifoneP630>?
        /// An object containing device type specific settings for Verifone UX700 readers.
        public var verifoneUx700: Stripe.Clearable<VerifoneUx700>?
        /// An object containing device type specific settings for Verifone V660p readers.
        public var verifoneV660p: Stripe.Clearable<VerifoneV660p>?
        /// Configurations for connecting to a WiFi network.
        public var wifi: Stripe.Clearable<Wifi>?

        public init(
            bbposWisepad3: Stripe.Clearable<BbposWisepad3>? = nil,
            bbposWiseposE: Stripe.Clearable<BbposWiseposE>? = nil,
            cellular: Stripe.Clearable<Cellular>? = nil,
            expand: [String]? = nil,
            name: String? = nil,
            offline: Stripe.Clearable<Offline>? = nil,
            rebootWindow: Stripe.Clearable<RebootWindow>? = nil,
            stripeS700: Stripe.Clearable<StripeS700>? = nil,
            stripeS710: Stripe.Clearable<StripeS710>? = nil,
            tipping: Stripe.Clearable<Tipping>? = nil,
            verifoneM425: Stripe.Clearable<VerifoneM425>? = nil,
            verifoneP400: Stripe.Clearable<VerifoneP400>? = nil,
            verifoneP630: Stripe.Clearable<VerifoneP630>? = nil,
            verifoneUx700: Stripe.Clearable<VerifoneUx700>? = nil,
            verifoneV660p: Stripe.Clearable<VerifoneV660p>? = nil,
            wifi: Stripe.Clearable<Wifi>? = nil
        ) {
            self.bbposWisepad3 = bbposWisepad3
            self.bbposWiseposE = bbposWiseposE
            self.cellular = cellular
            self.expand = expand
            self.name = name
            self.offline = offline
            self.rebootWindow = rebootWindow
            self.stripeS700 = stripeS700
            self.stripeS710 = stripeS710
            self.tipping = tipping
            self.verifoneM425 = verifoneM425
            self.verifoneP400 = verifoneP400
            self.verifoneP630 = verifoneP630
            self.verifoneUx700 = verifoneUx700
            self.verifoneV660p = verifoneV660p
            self.wifi = wifi
        }

        public struct BbposWisepad3: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct BbposWiseposE: Codable, Hashable, Sendable {
            /// A File ID representing an image to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct Cellular: Codable, Hashable, Sendable {
            /// Determines whether to allow the reader to connect to a cellular network.
            public var enabled: Bool

            public init(
                enabled: Bool
            ) {
                self.enabled = enabled
            }
        }

        public struct Offline: Codable, Hashable, Sendable {
            /// Determines whether to allow transactions to be collected while reader is offline.
            public var enabled: Bool

            public init(
                enabled: Bool
            ) {
                self.enabled = enabled
            }
        }

        public struct RebootWindow: Codable, Hashable, Sendable {
            /// Integer between 0 to 23 that represents the end hour of the reboot time window.
            public var endHour: Int
            /// Integer between 0 to 23 that represents the start hour of the reboot time window.
            public var startHour: Int

            public init(
                endHour: Int,
                startHour: Int
            ) {
                self.endHour = endHour
                self.startHour = startHour
            }
        }

        public struct StripeS700: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct StripeS710: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct Tipping: Codable, Hashable, Sendable {
            /// Tipping configuration for AED.
            public var aed: Aed?
            /// Tipping configuration for AUD.
            public var aud: Aud?
            /// Tipping configuration for CAD.
            public var cad: Cad?
            /// Tipping configuration for CHF.
            public var chf: Chf?
            /// Tipping configuration for CZK.
            public var czk: Czk?
            /// Tipping configuration for DKK.
            public var dkk: Dkk?
            /// Tipping configuration for EUR.
            public var eur: Eur?
            /// Tipping configuration for GBP.
            public var gbp: Gbp?
            /// Tipping configuration for GIP.
            public var gip: Gip?
            /// Tipping configuration for HKD.
            public var hkd: Hkd?
            /// Tipping configuration for HUF.
            public var huf: Huf?
            /// Tipping configuration for JPY.
            public var jpy: Jpy?
            /// Tipping configuration for MXN.
            public var mxn: Mxn?
            /// Tipping configuration for MYR.
            public var myr: Myr?
            /// Tipping configuration for NOK.
            public var nok: Nok?
            /// Tipping configuration for NZD.
            public var nzd: Nzd?
            /// Tipping configuration for PLN.
            public var pln: Pln?
            /// Tipping configuration for RON.
            public var ron: Ron?
            /// Tipping configuration for SEK.
            public var sek: Sek?
            /// Tipping configuration for SGD.
            public var sgd: Sgd?
            /// Tipping configuration for USD.
            public var usd: Usd?

            public init(
                aed: Aed? = nil,
                aud: Aud? = nil,
                cad: Cad? = nil,
                chf: Chf? = nil,
                czk: Czk? = nil,
                dkk: Dkk? = nil,
                eur: Eur? = nil,
                gbp: Gbp? = nil,
                gip: Gip? = nil,
                hkd: Hkd? = nil,
                huf: Huf? = nil,
                jpy: Jpy? = nil,
                mxn: Mxn? = nil,
                myr: Myr? = nil,
                nok: Nok? = nil,
                nzd: Nzd? = nil,
                pln: Pln? = nil,
                ron: Ron? = nil,
                sek: Sek? = nil,
                sgd: Sgd? = nil,
                usd: Usd? = nil
            ) {
                self.aed = aed
                self.aud = aud
                self.cad = cad
                self.chf = chf
                self.czk = czk
                self.dkk = dkk
                self.eur = eur
                self.gbp = gbp
                self.gip = gip
                self.hkd = hkd
                self.huf = huf
                self.jpy = jpy
                self.mxn = mxn
                self.myr = myr
                self.nok = nok
                self.nzd = nzd
                self.pln = pln
                self.ron = ron
                self.sek = sek
                self.sgd = sgd
                self.usd = usd
            }

            /// Tipping configuration for AED.
            public struct Aed: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for AUD.
            public struct Aud: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for CAD.
            public struct Cad: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for CHF.
            public struct Chf: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for CZK.
            public struct Czk: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for DKK.
            public struct Dkk: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for EUR.
            public struct Eur: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for GBP.
            public struct Gbp: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for GIP.
            public struct Gip: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for HKD.
            public struct Hkd: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for HUF.
            public struct Huf: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for JPY.
            public struct Jpy: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for MXN.
            public struct Mxn: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for MYR.
            public struct Myr: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for NOK.
            public struct Nok: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for NZD.
            public struct Nzd: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for PLN.
            public struct Pln: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for RON.
            public struct Ron: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for SEK.
            public struct Sek: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for SGD.
            public struct Sgd: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }

            /// Tipping configuration for USD.
            public struct Usd: Codable, Hashable, Sendable {
                /// Fixed amounts displayed when collecting a tip.
                public var fixedAmounts: [Int]?
                /// Percentages displayed when collecting a tip.
                public var percentages: [Int]?
                /// Below this amount, fixed amounts will be displayed; above it, percentages will be displayed.
                public var smartTipThreshold: Int?

                public init(
                    fixedAmounts: [Int]? = nil,
                    percentages: [Int]? = nil,
                    smartTipThreshold: Int? = nil
                ) {
                    self.fixedAmounts = fixedAmounts
                    self.percentages = percentages
                    self.smartTipThreshold = smartTipThreshold
                }
            }
        }

        public struct VerifoneM425: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct VerifoneP400: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct VerifoneP630: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct VerifoneUx700: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct VerifoneV660p: Codable, Hashable, Sendable {
            /// A File ID representing an image you want to display on the reader.
            public var splashscreen: String?

            public init(
                splashscreen: String? = nil
            ) {
                self.splashscreen = splashscreen
            }
        }

        public struct Wifi: Codable, Hashable, Sendable {
            /// Credentials for a WPA-Enterprise WiFi network using the EAP-PEAP authentication method.
            public var enterpriseEapPeap: EnterpriseEapPeap?
            /// Credentials for a WPA-Enterprise WiFi network using the EAP-TLS authentication method.
            public var enterpriseEapTls: EnterpriseEapTls?
            /// Credentials for a WPA-Personal WiFi network.
            public var personalPsk: PersonalPsk?
            /// Security type of the WiFi network.
            public var `type`: Type

            public init(
                enterpriseEapPeap: EnterpriseEapPeap? = nil,
                enterpriseEapTls: EnterpriseEapTls? = nil,
                personalPsk: PersonalPsk? = nil,
                `type`: Type
            ) {
                self.enterpriseEapPeap = enterpriseEapPeap
                self.enterpriseEapTls = enterpriseEapTls
                self.personalPsk = personalPsk
                self.`type` = `type`
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case enterpriseEapPeap = "enterprise_eap_peap"
                case enterpriseEapTls = "enterprise_eap_tls"
                case personalPsk = "personal_psk"
            }

            /// Credentials for a WPA-Enterprise WiFi network using the EAP-PEAP authentication method.
            public struct EnterpriseEapPeap: Codable, Hashable, Sendable {
                /// A File ID representing a PEM file containing the server certificate.
                public var caCertificateFile: String?
                /// Password for connecting to the WiFi network.
                public var password: String
                /// Name of the WiFi network.
                public var ssid: String
                /// Username for connecting to the WiFi network.
                public var username: String

                public init(
                    caCertificateFile: String? = nil,
                    password: String,
                    ssid: String,
                    username: String
                ) {
                    self.caCertificateFile = caCertificateFile
                    self.password = password
                    self.ssid = ssid
                    self.username = username
                }
            }

            /// Credentials for a WPA-Enterprise WiFi network using the EAP-TLS authentication method.
            public struct EnterpriseEapTls: Codable, Hashable, Sendable {
                /// A File ID representing a PEM file containing the server certificate.
                public var caCertificateFile: String?
                /// A File ID representing a PEM file containing the client certificate.
                public var clientCertificateFile: String
                /// A File ID representing a PEM file containing the client RSA private key.
                public var privateKeyFile: String
                /// Password for the private key file.
                public var privateKeyFilePassword: String?
                /// Name of the WiFi network.
                public var ssid: String

                public init(
                    caCertificateFile: String? = nil,
                    clientCertificateFile: String,
                    privateKeyFile: String,
                    privateKeyFilePassword: String? = nil,
                    ssid: String
                ) {
                    self.caCertificateFile = caCertificateFile
                    self.clientCertificateFile = clientCertificateFile
                    self.privateKeyFile = privateKeyFile
                    self.privateKeyFilePassword = privateKeyFilePassword
                    self.ssid = ssid
                }
            }

            /// Credentials for a WPA-Personal WiFi network.
            public struct PersonalPsk: Codable, Hashable, Sendable {
                /// Password for connecting to the WiFi network.
                public var password: String
                /// Name of the WiFi network.
                public var ssid: String

                public init(
                    password: String,
                    ssid: String
                ) {
                    self.password = password
                    self.ssid = ssid
                }
            }
        }
    }

    public typealias Response = TerminalConfiguration
}
