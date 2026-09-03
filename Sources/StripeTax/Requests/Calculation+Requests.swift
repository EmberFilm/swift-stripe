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
import StripeIssuing
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Tax.Calculation {
    public enum Create {}
    public enum ListLineItems {}
    public enum Retrieve {}
}

// POST /v1/tax/calculations
extension Stripe.Tax.Calculation.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency
        /// The ID of an existing customer to use for this calculation.
        public var customer: String?
        /// Details about the customer, including address and tax IDs.
        public var customerDetails: CustomerDetails?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A list of items the customer is purchasing.
        public var lineItems: [LineItems]
        /// Details about the address from which the goods are being shipped.
        public var shipFromDetails: ShipFromDetails?
        /// Shipping cost details to be used for the calculation.
        public var shippingCost: ShippingCost?
        /// The calculation uses the tax rules and rates that are in effect at this timestamp.
        public var taxDate: Int?

        public init(
            currency: Stripe.Currency,
            customer: String? = nil,
            customerDetails: CustomerDetails? = nil,
            expand: [String]? = nil,
            lineItems: [LineItems],
            shipFromDetails: ShipFromDetails? = nil,
            shippingCost: ShippingCost? = nil,
            taxDate: Int? = nil
        ) {
            self.currency = currency
            self.customer = customer
            self.customerDetails = customerDetails
            self.expand = expand
            self.lineItems = lineItems
            self.shipFromDetails = shipFromDetails
            self.shippingCost = shippingCost
            self.taxDate = taxDate
        }

        /// Details about the customer, including address and tax IDs.
        public struct CustomerDetails: Codable, Hashable, Sendable {
            /// The customer's postal address (for example, home or business location).
            public var address: Address?
            /// The type of customer address provided.
            public var addressSource: AddressSource?
            /// The customer's IP address (IPv4 or IPv6).
            public var ipAddress: String?
            /// The customer's tax IDs.
            public var taxIds: [TaxIds]?
            /// Overrides the tax calculation result to allow you to not collect tax from your customer.
            public var taxabilityOverride: TaxabilityOverride?

            public init(
                address: Address? = nil,
                addressSource: AddressSource? = nil,
                ipAddress: String? = nil,
                taxIds: [TaxIds]? = nil,
                taxabilityOverride: TaxabilityOverride? = nil
            ) {
                self.address = address
                self.addressSource = addressSource
                self.ipAddress = ipAddress
                self.taxIds = taxIds
                self.taxabilityOverride = taxabilityOverride
            }

            public enum AddressSource: String, Codable, Hashable, Sendable {
                case billing
                case shipping
            }

            public enum TaxabilityOverride: String, Codable, Hashable, Sendable {
                case customerExempt = "customer_exempt"
                case none
                case reverseCharge = "reverse_charge"
            }

            /// The customer's postal address (for example, home or business location).
            public struct Address: Codable, Hashable, Sendable {
                /// City, district, suburb, town, or village.
                public var city: String?
                /// Two-letter country code (ISO 3166-1 alpha-2).
                public var country: String
                /// Address line 1, such as the street, PO Box, or company name.
                public var line1: String?
                /// Address line 2, such as the apartment, suite, unit, or building.
                public var line2: String?
                /// ZIP or postal code.
                public var postalCode: String?
                /// State, county, province, or region.
                public var state: String?

                public init(
                    city: String? = nil,
                    country: String,
                    line1: String? = nil,
                    line2: String? = nil,
                    postalCode: String? = nil,
                    state: String? = nil
                ) {
                    self.city = city
                    self.country = country
                    self.line1 = line1
                    self.line2 = line2
                    self.postalCode = postalCode
                    self.state = state
                }
            }

            public struct TaxIds: Codable, Hashable, Sendable {
                /// Type of the tax ID, one of `ad_nrt`, `ae_trn`, `al_tin`, `am_tin`, `ao_tin`, `ar_cuit`, `au_abn`, `au_arn`, `aw_tin`.
                public var `type`: Type
                /// Value of the tax ID.
                public var value: String

                public init(
                    `type`: Type,
                    value: String
                ) {
                    self.`type` = `type`
                    self.value = value
                }

                public enum `Type`: String, Codable, Hashable, Sendable {
                    case adNrt = "ad_nrt"
                    case aeTrn = "ae_trn"
                    case alTin = "al_tin"
                    case amTin = "am_tin"
                    case aoTin = "ao_tin"
                    case arCuit = "ar_cuit"
                    case auAbn = "au_abn"
                    case auArn = "au_arn"
                    case awTin = "aw_tin"
                    case azTin = "az_tin"
                    case baTin = "ba_tin"
                    case bbTin = "bb_tin"
                    case bdBin = "bd_bin"
                    case bfIfu = "bf_ifu"
                    case bgUic = "bg_uic"
                    case bhVat = "bh_vat"
                    case bjIfu = "bj_ifu"
                    case boTin = "bo_tin"
                    case brCnpj = "br_cnpj"
                    case brCpf = "br_cpf"
                    case bsTin = "bs_tin"
                    case byTin = "by_tin"
                    case caBn = "ca_bn"
                    case caGstHst = "ca_gst_hst"
                    case caPstBc = "ca_pst_bc"
                    case caPstMb = "ca_pst_mb"
                    case caPstSk = "ca_pst_sk"
                    case caQst = "ca_qst"
                    case cdNif = "cd_nif"
                    case chUid = "ch_uid"
                    case chVat = "ch_vat"
                    case clTin = "cl_tin"
                    case cmNiu = "cm_niu"
                    case cnTin = "cn_tin"
                    case coNit = "co_nit"
                    case crTin = "cr_tin"
                    case cvNif = "cv_nif"
                    case deStn = "de_stn"
                    case doRcn = "do_rcn"
                    case ecRuc = "ec_ruc"
                    case egTin = "eg_tin"
                    case esCif = "es_cif"
                    case etTin = "et_tin"
                    case euOssVat = "eu_oss_vat"
                    case euVat = "eu_vat"
                    case foVat = "fo_vat"
                    case gbVat = "gb_vat"
                    case geVat = "ge_vat"
                    case giTin = "gi_tin"
                    case gnNif = "gn_nif"
                    case hkBr = "hk_br"
                    case hrOib = "hr_oib"
                    case huTin = "hu_tin"
                    case icNif = "ic_nif"
                    case idNpwp = "id_npwp"
                    case ilVat = "il_vat"
                    case inGst = "in_gst"
                    case isVat = "is_vat"
                    case itCf = "it_cf"
                    case jpCn = "jp_cn"
                    case jpRn = "jp_rn"
                    case jpTrn = "jp_trn"
                    case kePin = "ke_pin"
                    case kgTin = "kg_tin"
                    case khTin = "kh_tin"
                    case krBrn = "kr_brn"
                    case kzBin = "kz_bin"
                    case laTin = "la_tin"
                    case liUid = "li_uid"
                    case liVat = "li_vat"
                    case lkVat = "lk_vat"
                    case maVat = "ma_vat"
                    case mdVat = "md_vat"
                    case mePib = "me_pib"
                    case mkVat = "mk_vat"
                    case mrNif = "mr_nif"
                    case mxRfc = "mx_rfc"
                    case myFrp = "my_frp"
                    case myItn = "my_itn"
                    case mySst = "my_sst"
                    case ngTin = "ng_tin"
                    case noVat = "no_vat"
                    case noVoec = "no_voec"
                    case npPan = "np_pan"
                    case nzGst = "nz_gst"
                    case omVat = "om_vat"
                    case peRuc = "pe_ruc"
                    case phTin = "ph_tin"
                    case plNip = "pl_nip"
                    case pyRuc = "py_ruc"
                    case roTin = "ro_tin"
                    case rsPib = "rs_pib"
                    case ruInn = "ru_inn"
                    case ruKpp = "ru_kpp"
                    case saVat = "sa_vat"
                    case sgGst = "sg_gst"
                    case sgUen = "sg_uen"
                    case siTin = "si_tin"
                    case snNinea = "sn_ninea"
                    case srFin = "sr_fin"
                    case svNit = "sv_nit"
                    case thVat = "th_vat"
                    case tjTin = "tj_tin"
                    case trTin = "tr_tin"
                    case twVat = "tw_vat"
                    case tzVat = "tz_vat"
                    case uaVat = "ua_vat"
                    case ugTin = "ug_tin"
                    case usEin = "us_ein"
                    case uyRuc = "uy_ruc"
                    case uzTin = "uz_tin"
                    case uzVat = "uz_vat"
                    case veRif = "ve_rif"
                    case vnTin = "vn_tin"
                    case zaVat = "za_vat"
                    case zmTin = "zm_tin"
                    case zwTin = "zw_tin"
                }
            }
        }

        public struct LineItems: Codable, Hashable, Sendable {
            /// A positive integer representing the line item's total price in the smallest currency unit.
            public var amount: Int
            /// Set of key-value pairs that you can attach to an object.
            public var metadata: [String: String]?
            /// If provided, the product's `tax_code` will be used as the line item's `tax_code`.
            public var product: String?
            /// The number of units of the item being purchased.
            public var quantity: Int?
            /// A custom identifier for this line item, which must be unique across the line items in the calculation.
            public var reference: String?
            /// Specifies whether the `amount` includes taxes.
            public var taxBehavior: TaxBehavior?
            /// A tax code ID to use for this line item.
            public var taxCode: String?

            public init(
                amount: Int,
                metadata: [String: String]? = nil,
                product: String? = nil,
                quantity: Int? = nil,
                reference: String? = nil,
                taxBehavior: TaxBehavior? = nil,
                taxCode: String? = nil
            ) {
                self.amount = amount
                self.metadata = metadata
                self.product = product
                self.quantity = quantity
                self.reference = reference
                self.taxBehavior = taxBehavior
                self.taxCode = taxCode
            }

            public enum TaxBehavior: String, Codable, Hashable, Sendable {
                case exclusive
                case inclusive
            }
        }

        /// Details about the address from which the goods are being shipped.
        public struct ShipFromDetails: Codable, Hashable, Sendable {
            /// The address from which the goods are being shipped from.
            public var address: Address

            public init(
                address: Address
            ) {
                self.address = address
            }

            /// The address from which the goods are being shipped from.
            public struct Address: Codable, Hashable, Sendable {
                /// City, district, suburb, town, or village.
                public var city: String?
                /// Two-letter country code (ISO 3166-1 alpha-2).
                public var country: String
                /// Address line 1, such as the street, PO Box, or company name.
                public var line1: String?
                /// Address line 2, such as the apartment, suite, unit, or building.
                public var line2: String?
                /// ZIP or postal code.
                public var postalCode: String?
                /// State/province as an ISO 3166-2 subdivision code, without country prefix, such as "NY" or "TX".
                public var state: String?

                public init(
                    city: String? = nil,
                    country: String,
                    line1: String? = nil,
                    line2: String? = nil,
                    postalCode: String? = nil,
                    state: String? = nil
                ) {
                    self.city = city
                    self.country = country
                    self.line1 = line1
                    self.line2 = line2
                    self.postalCode = postalCode
                    self.state = state
                }
            }
        }

        /// Shipping cost details to be used for the calculation.
        public struct ShippingCost: Codable, Hashable, Sendable {
            /// A positive integer in the smallest currency unit representing the shipping charge.
            public var amount: Int?
            /// If provided, the shipping rate's `amount`, `tax_code` and `tax_behavior` are used.
            public var shippingRate: String?
            /// Specifies whether the `amount` includes taxes.
            public var taxBehavior: TaxBehavior?
            /// The tax code used to calculate tax on shipping.
            public var taxCode: String?

            public init(
                amount: Int? = nil,
                shippingRate: String? = nil,
                taxBehavior: TaxBehavior? = nil,
                taxCode: String? = nil
            ) {
                self.amount = amount
                self.shippingRate = shippingRate
                self.taxBehavior = taxBehavior
                self.taxCode = taxCode
            }

            public enum TaxBehavior: String, Codable, Hashable, Sendable {
                case exclusive
                case inclusive
            }
        }
    }

    public typealias Response = Stripe.Tax.Calculation
}

// GET /v1/tax/calculations/{calculation}/line_items
extension Stripe.Tax.Calculation.ListLineItems {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Stripe.Tax.CalculationLineItem>
}

// GET /v1/tax/calculations/{calculation}
extension Stripe.Tax.Calculation.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Tax.Calculation
}
