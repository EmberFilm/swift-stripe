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

import StripeCheckout
import StripeCore
import StripeIssuing
import StripeModels
import StripeProducts

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Invoice {
    public enum AddLines {}
    public enum AttachPayment {}
    public enum Create {}
    public enum CreatePreview {}
    public enum Delete {}
    public enum FinalizeInvoice {}
    public enum List {}
    public enum MarkUncollectible {}
    public enum Pay {}
    public enum RemoveLines {}
    public enum Retrieve {}
    public enum Search {}
    public enum SendInvoice {}
    public enum Update {}
    public enum UpdateLines {}
    public enum VoidInvoice {}
}

// POST /v1/invoices/{invoice}/add_lines
extension Stripe.Billing.Invoice.AddLines {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var invoiceMetadata: Stripe.Clearable<[String: String]>?
        /// The line items to add.
        public var lines: [Lines]

        public init(
            expand: [String]? = nil,
            invoiceMetadata: Stripe.Clearable<[String: String]>? = nil,
            lines: [Lines]
        ) {
            self.expand = expand
            self.invoiceMetadata = invoiceMetadata
            self.lines = lines
        }

        public struct Lines: Codable, Hashable, Sendable {
            /// The integer amount in cents (or local equivalent) of the charge to be applied to the upcoming invoice.
            public var amount: Int?
            /// An arbitrary string which you can attach to the invoice item.
            public var description: String?
            /// Controls whether discounts apply to this line item.
            public var discountable: Bool?
            /// The coupons, promotion codes & existing discounts which apply to the line item.
            public var discounts: Stripe.Clearable<[Discounts]>?
            /// ID of an unassigned invoice item to assign to this invoice.
            public var invoiceItem: String?
            /// Set of key-value pairs that you can attach to an object.
            public var metadata: Stripe.Clearable<[String: String]>?
            /// The period associated with this invoice item.
            public var period: Period?
            /// Data used to generate a new Price object inline.
            public var priceData: PriceData?
            /// The pricing information for the invoice item.
            public var pricing: Pricing?
            /// Non-negative integer.
            public var quantity: Int?
            /// Non-negative decimal with at most 12 decimal places.
            public var quantityDecimal: String?
            /// A list of up to 20 tax amounts for this line item.
            public var taxAmounts: Stripe.Clearable<[TaxAmounts]>?
            /// The tax rates which apply to the line item.
            public var taxRates: Stripe.Clearable<[String]>?

            public init(
                amount: Int? = nil,
                description: String? = nil,
                discountable: Bool? = nil,
                discounts: Stripe.Clearable<[Discounts]>? = nil,
                invoiceItem: String? = nil,
                metadata: Stripe.Clearable<[String: String]>? = nil,
                period: Period? = nil,
                priceData: PriceData? = nil,
                pricing: Pricing? = nil,
                quantity: Int? = nil,
                quantityDecimal: String? = nil,
                taxAmounts: Stripe.Clearable<[TaxAmounts]>? = nil,
                taxRates: Stripe.Clearable<[String]>? = nil
            ) {
                self.amount = amount
                self.description = description
                self.discountable = discountable
                self.discounts = discounts
                self.invoiceItem = invoiceItem
                self.metadata = metadata
                self.period = period
                self.priceData = priceData
                self.pricing = pricing
                self.quantity = quantity
                self.quantityDecimal = quantityDecimal
                self.taxAmounts = taxAmounts
                self.taxRates = taxRates
            }

            public struct Discounts: Codable, Hashable, Sendable {
                /// ID of the coupon to create a new discount for.
                public var coupon: String?
                /// ID of an existing discount on the object (or one of its ancestors) to reuse.
                public var discount: String?
                /// ID of the promotion code to create a new discount for.
                public var promotionCode: String?

                public init(
                    coupon: String? = nil,
                    discount: String? = nil,
                    promotionCode: String? = nil
                ) {
                    self.coupon = coupon
                    self.discount = discount
                    self.promotionCode = promotionCode
                }
            }

            /// The period associated with this invoice item.
            public struct Period: Codable, Hashable, Sendable {
                /// The end of the period, which must be greater than or equal to the start.
                public var end: Date
                /// The start of the period.
                public var start: Date

                public init(
                    end: Date,
                    start: Date
                ) {
                    self.end = end
                    self.start = start
                }
            }

            /// Data used to generate a new Price object inline.
            public struct PriceData: Codable, Hashable, Sendable {
                /// Three-letter ISO currency code, in lowercase.
                public var currency: Stripe.Currency
                /// The ID of the Product that this Price will belong to.
                public var product: String?
                /// Data used to generate a new Product object inline.
                public var productData: ProductData?
                /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
                public var taxBehavior: TaxBehavior?
                /// A non-negative integer in cents (or local equivalent) representing how much to charge.
                public var unitAmount: Int?
                /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
                public var unitAmountDecimal: String?

                public init(
                    currency: Stripe.Currency,
                    product: String? = nil,
                    productData: ProductData? = nil,
                    taxBehavior: TaxBehavior? = nil,
                    unitAmount: Int? = nil,
                    unitAmountDecimal: String? = nil
                ) {
                    self.currency = currency
                    self.product = product
                    self.productData = productData
                    self.taxBehavior = taxBehavior
                    self.unitAmount = unitAmount
                    self.unitAmountDecimal = unitAmountDecimal
                }

                public enum TaxBehavior: String, Codable, Hashable, Sendable {
                    case exclusive
                    case inclusive
                    case unspecified
                }

                /// Data used to generate a new Product object inline.
                public struct ProductData: Codable, Hashable, Sendable {
                    /// The product's description, meant to be displayable to the customer.
                    public var description: String?
                    /// A list of up to 8 URLs of images for this product, meant to be displayable to the customer.
                    public var images: [String]?
                    /// Set of key-value pairs that you can attach to an object.
                    public var metadata: [String: String]?
                    /// The product's name, meant to be displayable to the customer.
                    public var name: String
                    /// A tax code ID.
                    public var taxCode: String?
                    /// A label that represents units of this product.
                    public var unitLabel: String?

                    public init(
                        description: String? = nil,
                        images: [String]? = nil,
                        metadata: [String: String]? = nil,
                        name: String,
                        taxCode: String? = nil,
                        unitLabel: String? = nil
                    ) {
                        self.description = description
                        self.images = images
                        self.metadata = metadata
                        self.name = name
                        self.taxCode = taxCode
                        self.unitLabel = unitLabel
                    }
                }
            }

            /// The pricing information for the invoice item.
            public struct Pricing: Codable, Hashable, Sendable {
                /// The ID of the price object.
                public var price: String?

                public init(
                    price: String? = nil
                ) {
                    self.price = price
                }
            }

            public struct TaxAmounts: Codable, Hashable, Sendable {
                /// The amount, in cents (or local equivalent), of the tax.
                public var amount: Int
                /// Data to find or create a TaxRate object.
                public var taxRateData: TaxRateData
                /// The reasoning behind this tax, for example, if the product is tax exempt.
                public var taxabilityReason: TaxabilityReason?
                /// The amount on which tax is calculated, in cents (or local equivalent).
                public var taxableAmount: Int

                public init(
                    amount: Int,
                    taxRateData: TaxRateData,
                    taxabilityReason: TaxabilityReason? = nil,
                    taxableAmount: Int
                ) {
                    self.amount = amount
                    self.taxRateData = taxRateData
                    self.taxabilityReason = taxabilityReason
                    self.taxableAmount = taxableAmount
                }

                public enum TaxabilityReason: String, Codable, Hashable, Sendable {
                    case customerExempt = "customer_exempt"
                    case notCollecting = "not_collecting"
                    case notSubjectToTax = "not_subject_to_tax"
                    case notSupported = "not_supported"
                    case portionProductExempt = "portion_product_exempt"
                    case portionReducedRated = "portion_reduced_rated"
                    case portionStandardRated = "portion_standard_rated"
                    case productExempt = "product_exempt"
                    case productExemptHoliday = "product_exempt_holiday"
                    case proportionallyRated = "proportionally_rated"
                    case reducedRated = "reduced_rated"
                    case reverseCharge = "reverse_charge"
                    case standardRated = "standard_rated"
                    case taxableBasisReduced = "taxable_basis_reduced"
                    case zeroRated = "zero_rated"
                }

                /// Data to find or create a TaxRate object.
                public struct TaxRateData: Codable, Hashable, Sendable {
                    /// Two-letter country code (ISO 3166-1 alpha-2).
                    public var country: String?
                    /// An arbitrary string attached to the tax rate for your internal use only.
                    public var description: String?
                    /// The display name of the tax rate, which will be shown to users.
                    public var displayName: String
                    /// This specifies if the tax rate is inclusive or exclusive.
                    public var inclusive: Bool
                    /// The jurisdiction for the tax rate.
                    public var jurisdiction: String?
                    /// The level of the jurisdiction that imposes this tax rate.
                    public var jurisdictionLevel: JurisdictionLevel?
                    /// The statutory tax rate percent.
                    public var percentage: Decimal
                    /// ISO 3166-2 subdivision code, without country prefix.
                    public var state: String?
                    /// The high-level tax type, such as `vat` or `sales_tax`.
                    public var taxType: TaxType?

                    public init(
                        country: String? = nil,
                        description: String? = nil,
                        displayName: String,
                        inclusive: Bool,
                        jurisdiction: String? = nil,
                        jurisdictionLevel: JurisdictionLevel? = nil,
                        percentage: Decimal,
                        state: String? = nil,
                        taxType: TaxType? = nil
                    ) {
                        self.country = country
                        self.description = description
                        self.displayName = displayName
                        self.inclusive = inclusive
                        self.jurisdiction = jurisdiction
                        self.jurisdictionLevel = jurisdictionLevel
                        self.percentage = percentage
                        self.state = state
                        self.taxType = taxType
                    }

                    public enum JurisdictionLevel: String, Codable, Hashable, Sendable {
                        case city
                        case country
                        case county
                        case district
                        case multiple
                        case state
                    }

                    public enum TaxType: String, Codable, Hashable, Sendable {
                        case amusementTax = "amusement_tax"
                        case communicationsTax = "communications_tax"
                        case gst
                        case hst
                        case igst
                        case jct
                        case leaseTax = "lease_tax"
                        case massTransitParkingTax = "mass_transit_parking_tax"
                        case parkingTax = "parking_tax"
                        case pst
                        case qst
                        case retailDeliveryFee = "retail_delivery_fee"
                        case rst
                        case salesTax = "sales_tax"
                        case serviceTax = "service_tax"
                        case vat
                    }
                }
            }
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// POST /v1/invoices/{invoice}/attach_payment
extension Stripe.Billing.Invoice.AttachPayment {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The ID of the PaymentIntent to attach to the invoice.
        public var paymentIntent: String?
        /// The ID of the PaymentRecord to attach to the invoice.
        public var paymentRecord: String?

        public init(
            expand: [String]? = nil,
            paymentIntent: String? = nil,
            paymentRecord: String? = nil
        ) {
            self.expand = expand
            self.paymentIntent = paymentIntent
            self.paymentRecord = paymentRecord
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// POST /v1/invoices
extension Stripe.Billing.Invoice.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// The account tax IDs associated with the invoice.
        public var accountTaxIds: Stripe.Clearable<[String]>?
        /// A fee in cents (or local equivalent) that will be applied to the invoice and transferred to the application owner's.
        public var applicationFeeAmount: Int?
        /// Controls whether Stripe performs automatic collection of the invoice.
        public var autoAdvance: Bool?
        /// Settings for automatic tax lookup for this invoice.
        public var automaticTax: AutomaticTax?
        /// The time when this invoice should be scheduled to finalize (up to 5 years in the future).
        public var automaticallyFinalizesAt: Date?
        /// Either `charge_automatically`, or `send_invoice`.
        public var collectionMethod: CollectionMethod?
        /// The currency to create this invoice in.
        public var currency: Stripe.Currency?
        /// A list of up to 4 custom fields to be displayed on the invoice.
        public var customFields: Stripe.Clearable<[CustomFields]>?
        /// The ID of the customer to bill.
        public var customer: String?
        /// The ID of the account to bill.
        public var customerAccount: String?
        /// The number of days from when the invoice is created until it is due.
        public var daysUntilDue: Int?
        /// ID of the default payment method for the invoice.
        public var defaultPaymentMethod: String?
        /// ID of the default payment source for the invoice.
        public var defaultSource: String?
        /// The tax rates that will apply to any line item that does not have `tax_rates` set.
        public var defaultTaxRates: [String]?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// The coupons and promotion codes to redeem into discounts for the invoice.
        public var discounts: Stripe.Clearable<[Discounts]>?
        /// The date on which payment for this invoice is due.
        public var dueDate: Date?
        /// The date when this invoice is in effect.
        public var effectiveAt: Date?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Footer to be displayed on the invoice.
        public var footer: String?
        /// Revise an existing invoice.
        public var fromInvoice: FromInvoice?
        /// The connected account that issues the invoice.
        public var issuer: Issuer?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?
        /// Set the number for this invoice.
        public var number: String?
        /// The account (if any) for which the funds of the invoice payment are intended.
        public var onBehalfOf: String?
        /// Configuration settings for the PaymentIntent that is generated when the invoice is finalized.
        public var paymentSettings: PaymentSettings?
        /// How to handle pending invoice items on invoice creation.
        public var pendingInvoiceItemsBehavior: PendingInvoiceItemsBehavior?
        /// The rendering-related settings that control how the invoice is displayed on customer-facing surfaces such as PDF and.
        public var rendering: Rendering?
        /// Settings for the cost of shipping for this invoice.
        public var shippingCost: ShippingCost?
        /// Shipping details for the invoice.
        public var shippingDetails: ShippingDetails?
        /// Extra information about a charge for the customer's credit card statement.
        public var statementDescriptor: String?
        /// The ID of the subscription to invoice, if any.
        public var subscription: String?
        /// If specified, the funds from the invoice will be transferred to the destination and the ID of the resulting transfer.
        public var transferData: TransferData?

        public init(
            accountTaxIds: Stripe.Clearable<[String]>? = nil,
            applicationFeeAmount: Int? = nil,
            autoAdvance: Bool? = nil,
            automaticTax: AutomaticTax? = nil,
            automaticallyFinalizesAt: Date? = nil,
            collectionMethod: CollectionMethod? = nil,
            currency: Stripe.Currency? = nil,
            customFields: Stripe.Clearable<[CustomFields]>? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            daysUntilDue: Int? = nil,
            defaultPaymentMethod: String? = nil,
            defaultSource: String? = nil,
            defaultTaxRates: [String]? = nil,
            description: String? = nil,
            discounts: Stripe.Clearable<[Discounts]>? = nil,
            dueDate: Date? = nil,
            effectiveAt: Date? = nil,
            expand: [String]? = nil,
            footer: String? = nil,
            fromInvoice: FromInvoice? = nil,
            issuer: Issuer? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil,
            number: String? = nil,
            onBehalfOf: String? = nil,
            paymentSettings: PaymentSettings? = nil,
            pendingInvoiceItemsBehavior: PendingInvoiceItemsBehavior? = nil,
            rendering: Rendering? = nil,
            shippingCost: ShippingCost? = nil,
            shippingDetails: ShippingDetails? = nil,
            statementDescriptor: String? = nil,
            subscription: String? = nil,
            transferData: TransferData? = nil
        ) {
            self.accountTaxIds = accountTaxIds
            self.applicationFeeAmount = applicationFeeAmount
            self.autoAdvance = autoAdvance
            self.automaticTax = automaticTax
            self.automaticallyFinalizesAt = automaticallyFinalizesAt
            self.collectionMethod = collectionMethod
            self.currency = currency
            self.customFields = customFields
            self.customer = customer
            self.customerAccount = customerAccount
            self.daysUntilDue = daysUntilDue
            self.defaultPaymentMethod = defaultPaymentMethod
            self.defaultSource = defaultSource
            self.defaultTaxRates = defaultTaxRates
            self.description = description
            self.discounts = discounts
            self.dueDate = dueDate
            self.effectiveAt = effectiveAt
            self.expand = expand
            self.footer = footer
            self.fromInvoice = fromInvoice
            self.issuer = issuer
            self.metadata = metadata
            self.number = number
            self.onBehalfOf = onBehalfOf
            self.paymentSettings = paymentSettings
            self.pendingInvoiceItemsBehavior = pendingInvoiceItemsBehavior
            self.rendering = rendering
            self.shippingCost = shippingCost
            self.shippingDetails = shippingDetails
            self.statementDescriptor = statementDescriptor
            self.subscription = subscription
            self.transferData = transferData
        }

        public enum CollectionMethod: String, Codable, Hashable, Sendable {
            case chargeAutomatically = "charge_automatically"
            case sendInvoice = "send_invoice"
        }

        public enum PendingInvoiceItemsBehavior: String, Codable, Hashable, Sendable {
            case exclude
            case include
        }

        /// Settings for automatic tax lookup for this invoice.
        public struct AutomaticTax: Codable, Hashable, Sendable {
            /// Whether Stripe automatically computes tax on this invoice.
            public var enabled: Bool
            /// The account that's liable for tax.
            public var liability: Liability?

            public init(
                enabled: Bool,
                liability: Liability? = nil
            ) {
                self.enabled = enabled
                self.liability = liability
            }

            /// The account that's liable for tax.
            public struct Liability: Codable, Hashable, Sendable {
                /// The connected account being referenced when `type` is `account`.
                public var account: String?
                /// Type of the account referenced in the request.
                public var `type`: Type

                public init(
                    account: String? = nil,
                    `type`: Type
                ) {
                    self.account = account
                    self.`type` = `type`
                }

                public enum `Type`: String, Codable, Hashable, Sendable {
                    case account
                    case `self`
                }
            }
        }

        public struct CustomFields: Codable, Hashable, Sendable {
            /// The name of the custom field.
            public var name: String
            /// The value of the custom field.
            public var value: String

            public init(
                name: String,
                value: String
            ) {
                self.name = name
                self.value = value
            }
        }

        public struct Discounts: Codable, Hashable, Sendable {
            /// ID of the coupon to create a new discount for.
            public var coupon: String?
            /// ID of an existing discount on the object (or one of its ancestors) to reuse.
            public var discount: String?
            /// ID of the promotion code to create a new discount for.
            public var promotionCode: String?

            public init(
                coupon: String? = nil,
                discount: String? = nil,
                promotionCode: String? = nil
            ) {
                self.coupon = coupon
                self.discount = discount
                self.promotionCode = promotionCode
            }
        }

        /// Revise an existing invoice.
        public struct FromInvoice: Codable, Hashable, Sendable {
            /// The relation between the new invoice and the original invoice.
            public var action: String
            /// The `id` of the invoice that will be cloned.
            public var invoice: String

            public init(
                action: String,
                invoice: String
            ) {
                self.action = action
                self.invoice = invoice
            }
        }

        /// The connected account that issues the invoice.
        public struct Issuer: Codable, Hashable, Sendable {
            /// The connected account being referenced when `type` is `account`.
            public var account: String?
            /// Type of the account referenced in the request.
            public var `type`: Type

            public init(
                account: String? = nil,
                `type`: Type
            ) {
                self.account = account
                self.`type` = `type`
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case account
                case `self`
            }
        }

        /// Configuration settings for the PaymentIntent that is generated when the invoice is finalized.
        public struct PaymentSettings: Codable, Hashable, Sendable {
            /// ID of the mandate to be used for this invoice.
            public var defaultMandate: String?
            /// Payment-method-specific configuration to provide to the invoice’s PaymentIntent.
            public var paymentMethodOptions: PaymentMethodOptions?
            /// The list of payment method types (e.g.
            public var paymentMethodTypes: Stripe.Clearable<[PaymentMethodTypes]>?

            public init(
                defaultMandate: String? = nil,
                paymentMethodOptions: PaymentMethodOptions? = nil,
                paymentMethodTypes: Stripe.Clearable<[PaymentMethodTypes]>? = nil
            ) {
                self.defaultMandate = defaultMandate
                self.paymentMethodOptions = paymentMethodOptions
                self.paymentMethodTypes = paymentMethodTypes
            }

            public enum PaymentMethodTypes: String, Codable, Hashable, Sendable {
                case achCreditTransfer = "ach_credit_transfer"
                case achDebit = "ach_debit"
                case acssDebit = "acss_debit"
                case affirm
                case alipay
                case amazonPay = "amazon_pay"
                case auBecsDebit = "au_becs_debit"
                case bacsDebit = "bacs_debit"
                case bancontact
                case billie
                case boleto
                case card
                case cashapp
                case crypto
                case custom
                case customerBalance = "customer_balance"
                case eps
                case fpx
                case giropay
                case grabpay
                case ideal
                case jpCreditTransfer = "jp_credit_transfer"
                case kakaoPay = "kakao_pay"
                case klarna
                case konbini
                case krCard = "kr_card"
                case link
                case mbWay = "mb_way"
                case multibanco
                case naverPay = "naver_pay"
                case nzBankAccount = "nz_bank_account"
                case p24
                case payByBank = "pay_by_bank"
                case payco
                case paynow
                case paypal
                case payto
                case pix
                case promptpay
                case revolutPay = "revolut_pay"
                case satispay
                case sepaCreditTransfer = "sepa_credit_transfer"
                case sepaDebit = "sepa_debit"
                case sofort
                case swish
                case twint
                case upi
                case usBankAccount = "us_bank_account"
                case wechatPay = "wechat_pay"
            }

            /// Payment-method-specific configuration to provide to the invoice’s PaymentIntent.
            public struct PaymentMethodOptions: Codable, Hashable, Sendable {
                /// If paying by `acss_debit`, this sub-hash contains details about the Canadian pre-authorized debit payment method.
                public var acssDebit: Stripe.Clearable<AcssDebit>?
                /// If paying by `bancontact`, this sub-hash contains details about the Bancontact payment method options to pass to the.
                public var bancontact: Stripe.Clearable<Bancontact>?
                /// If paying by `billie`, this sub-hash contains details about the Billie payment method options to pass to the.
                public var billie: Stripe.Clearable<Billie>?
                /// If paying by `card`, this sub-hash contains details about the Card payment method options to pass to the invoice’s.
                public var card: Stripe.Clearable<Card>?
                /// If paying by `customer_balance`, this sub-hash contains details about the Bank transfer payment method options to.
                public var customerBalance: Stripe.Clearable<CustomerBalance>?
                /// If paying by `konbini`, this sub-hash contains details about the Konbini payment method options to pass to the.
                public var konbini: Stripe.Clearable<Konbini>?
                /// If paying by `payto`, this sub-hash contains details about the PayTo payment method options to pass to the invoice’s.
                public var payto: Stripe.Clearable<Payto>?
                /// If paying by `pix`, this sub-hash contains details about the Pix payment method options to pass to the invoice’s.
                public var pix: Stripe.Clearable<Pix>?
                /// If paying by `sepa_debit`, this sub-hash contains details about the SEPA Direct Debit payment method options to pass.
                public var sepaDebit: Stripe.Clearable<SepaDebit>?
                /// If paying by `upi`, this sub-hash contains details about the UPI payment method options to pass to the invoice’s.
                public var upi: Stripe.Clearable<Upi>?
                /// If paying by `us_bank_account`, this sub-hash contains details about the ACH direct debit payment method options to.
                public var usBankAccount: Stripe.Clearable<UsBankAccount>?

                public init(
                    acssDebit: Stripe.Clearable<AcssDebit>? = nil,
                    bancontact: Stripe.Clearable<Bancontact>? = nil,
                    billie: Stripe.Clearable<Billie>? = nil,
                    card: Stripe.Clearable<Card>? = nil,
                    customerBalance: Stripe.Clearable<CustomerBalance>? = nil,
                    konbini: Stripe.Clearable<Konbini>? = nil,
                    payto: Stripe.Clearable<Payto>? = nil,
                    pix: Stripe.Clearable<Pix>? = nil,
                    sepaDebit: Stripe.Clearable<SepaDebit>? = nil,
                    upi: Stripe.Clearable<Upi>? = nil,
                    usBankAccount: Stripe.Clearable<UsBankAccount>? = nil
                ) {
                    self.acssDebit = acssDebit
                    self.bancontact = bancontact
                    self.billie = billie
                    self.card = card
                    self.customerBalance = customerBalance
                    self.konbini = konbini
                    self.payto = payto
                    self.pix = pix
                    self.sepaDebit = sepaDebit
                    self.upi = upi
                    self.usBankAccount = usBankAccount
                }

                public struct AcssDebit: Codable, Hashable, Sendable {
                    /// Additional fields for Mandate creation.
                    public var mandateOptions: MandateOptions?
                    /// Verification method for the intent.
                    public var verificationMethod: VerificationMethod?

                    public init(
                        mandateOptions: MandateOptions? = nil,
                        verificationMethod: VerificationMethod? = nil
                    ) {
                        self.mandateOptions = mandateOptions
                        self.verificationMethod = verificationMethod
                    }

                    public enum VerificationMethod: String, Codable, Hashable, Sendable {
                        case automatic
                        case instant
                        case microdeposits
                    }

                    /// Additional fields for Mandate creation.
                    public struct MandateOptions: Codable, Hashable, Sendable {
                        /// Transaction type of the mandate.
                        public var transactionType: TransactionType?

                        public init(
                            transactionType: TransactionType? = nil
                        ) {
                            self.transactionType = transactionType
                        }

                        public enum TransactionType: String, Codable, Hashable, Sendable {
                            case business
                            case personal
                        }
                    }
                }

                public struct Bancontact: Codable, Hashable, Sendable {
                    /// Preferred language of the Bancontact authorization page that the customer is redirected to.
                    public var preferredLanguage: PreferredLanguage?

                    public init(
                        preferredLanguage: PreferredLanguage? = nil
                    ) {
                        self.preferredLanguage = preferredLanguage
                    }

                    public enum PreferredLanguage: String, Codable, Hashable, Sendable {
                        case de
                        case en
                        case fr
                        case nl
                    }
                }

                public struct Billie: Codable, Hashable, Sendable {
                    public init() {}
                }

                public struct Card: Codable, Hashable, Sendable {
                    /// Installment configuration for payments attempted on this invoice.
                    public var installments: Installments?
                    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based.
                    public var requestThreeDSecure: RequestThreeDSecure?

                    public init(
                        installments: Installments? = nil,
                        requestThreeDSecure: RequestThreeDSecure? = nil
                    ) {
                        self.installments = installments
                        self.requestThreeDSecure = requestThreeDSecure
                    }

                    public enum RequestThreeDSecure: String, Codable, Hashable, Sendable {
                        case `any`
                        case automatic
                        case challenge
                    }

                    /// Installment configuration for payments attempted on this invoice.
                    public struct Installments: Codable, Hashable, Sendable {
                        /// Setting to true enables installments for this invoice.
                        public var enabled: Bool?
                        /// The selected installment plan to use for this invoice.
                        public var plan: Stripe.Clearable<Plan>?

                        public init(
                            enabled: Bool? = nil,
                            plan: Stripe.Clearable<Plan>? = nil
                        ) {
                            self.enabled = enabled
                            self.plan = plan
                        }

                        public struct Plan: Codable, Hashable, Sendable {
                            /// For `fixed_count` installment plans, this is required.
                            public var count: Int?
                            /// For `fixed_count` installment plans, this is required.
                            public var interval: String?
                            /// Type of installment plan, one of `fixed_count`, `bonus`, or `revolving`.
                            public var `type`: Type

                            public init(
                                count: Int? = nil,
                                interval: String? = nil,
                                `type`: Type
                            ) {
                                self.count = count
                                self.interval = interval
                                self.`type` = `type`
                            }

                            public enum `Type`: String, Codable, Hashable, Sendable {
                                case bonus
                                case fixedCount = "fixed_count"
                                case revolving
                            }
                        }
                    }
                }

                public struct CustomerBalance: Codable, Hashable, Sendable {
                    /// Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
                    public var bankTransfer: BankTransfer?
                    /// The funding method type to be used when there are not enough funds in the customer balance.
                    public var fundingType: String?

                    public init(
                        bankTransfer: BankTransfer? = nil,
                        fundingType: String? = nil
                    ) {
                        self.bankTransfer = bankTransfer
                        self.fundingType = fundingType
                    }

                    /// Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
                    public struct BankTransfer: Codable, Hashable, Sendable {
                        /// Configuration for eu_bank_transfer funding type.
                        public var euBankTransfer: EuBankTransfer?
                        /// The bank transfer type that can be used for funding.
                        public var `type`: String?

                        public init(
                            euBankTransfer: EuBankTransfer? = nil,
                            `type`: String? = nil
                        ) {
                            self.euBankTransfer = euBankTransfer
                            self.`type` = `type`
                        }

                        /// Configuration for eu_bank_transfer funding type.
                        public struct EuBankTransfer: Codable, Hashable, Sendable {
                            /// The desired country code of the bank account information.
                            public var country: String

                            public init(
                                country: String
                            ) {
                                self.country = country
                            }
                        }
                    }
                }

                public struct Konbini: Codable, Hashable, Sendable {
                    public init() {}
                }

                public struct Payto: Codable, Hashable, Sendable {
                    /// Additional fields for Mandate creation.
                    public var mandateOptions: MandateOptions?

                    public init(
                        mandateOptions: MandateOptions? = nil
                    ) {
                        self.mandateOptions = mandateOptions
                    }

                    /// Additional fields for Mandate creation.
                    public struct MandateOptions: Codable, Hashable, Sendable {
                        /// The maximum amount that can be collected in a single invoice.
                        public var amount: Int?
                        /// The purpose for which payments are made.
                        public var purpose: Purpose?

                        public init(
                            amount: Int? = nil,
                            purpose: Purpose? = nil
                        ) {
                            self.amount = amount
                            self.purpose = purpose
                        }

                        public enum Purpose: String, Codable, Hashable, Sendable {
                            case dependantSupport = "dependant_support"
                            case government
                            case loan
                            case mortgage
                            case other
                            case pension
                            case personal
                            case retail
                            case salary
                            case tax
                            case utility
                        }
                    }
                }

                public struct Pix: Codable, Hashable, Sendable {
                    /// Determines if the amount includes the IOF tax.
                    public var amountIncludesIof: AmountIncludesIof?
                    /// The number of seconds (between 10 and 1209600) after which Pix payment will expire.
                    public var expiresAfterSeconds: Int?

                    public init(
                        amountIncludesIof: AmountIncludesIof? = nil,
                        expiresAfterSeconds: Int? = nil
                    ) {
                        self.amountIncludesIof = amountIncludesIof
                        self.expiresAfterSeconds = expiresAfterSeconds
                    }

                    public enum AmountIncludesIof: String, Codable, Hashable, Sendable {
                        case always
                        case never
                    }
                }

                public struct SepaDebit: Codable, Hashable, Sendable {
                    public init() {}
                }

                public struct Upi: Codable, Hashable, Sendable {
                    /// Configuration options for setting up an eMandate.
                    public var mandateOptions: MandateOptions?

                    public init(
                        mandateOptions: MandateOptions? = nil
                    ) {
                        self.mandateOptions = mandateOptions
                    }

                    /// Configuration options for setting up an eMandate.
                    public struct MandateOptions: Codable, Hashable, Sendable {
                        /// Amount to be charged for future payments.
                        public var amount: Int?
                        /// One of `fixed` or `maximum`.
                        public var amountType: AmountType?
                        /// A description of the mandate or subscription that is meant to be displayed to the customer.
                        public var description: String?
                        /// End date of the mandate or subscription.
                        public var endDate: Date?

                        public init(
                            amount: Int? = nil,
                            amountType: AmountType? = nil,
                            description: String? = nil,
                            endDate: Date? = nil
                        ) {
                            self.amount = amount
                            self.amountType = amountType
                            self.description = description
                            self.endDate = endDate
                        }

                        public enum AmountType: String, Codable, Hashable, Sendable {
                            case fixed
                            case maximum
                        }
                    }
                }

                public struct UsBankAccount: Codable, Hashable, Sendable {
                    /// Additional fields for Financial Connections Session creation.
                    public var financialConnections: FinancialConnections?
                    /// Verification method for the intent.
                    public var verificationMethod: VerificationMethod?

                    public init(
                        financialConnections: FinancialConnections? = nil,
                        verificationMethod: VerificationMethod? = nil
                    ) {
                        self.financialConnections = financialConnections
                        self.verificationMethod = verificationMethod
                    }

                    public enum VerificationMethod: String, Codable, Hashable, Sendable {
                        case automatic
                        case instant
                        case microdeposits
                    }

                    /// Additional fields for Financial Connections Session creation.
                    public struct FinancialConnections: Codable, Hashable, Sendable {
                        /// Provide filters for the linked accounts that the customer can select for the payment method.
                        public var filters: Filters?
                        /// The list of permissions to request.
                        public var permissions: [Permissions]?
                        /// List of data features that you would like to retrieve upon account creation.
                        public var prefetch: [Prefetch]?

                        public init(
                            filters: Filters? = nil,
                            permissions: [Permissions]? = nil,
                            prefetch: [Prefetch]? = nil
                        ) {
                            self.filters = filters
                            self.permissions = permissions
                            self.prefetch = prefetch
                        }

                        public enum Permissions: String, Codable, Hashable, Sendable {
                            case balances
                            case ownership
                            case paymentMethod = "payment_method"
                            case transactions
                        }

                        public enum Prefetch: String, Codable, Hashable, Sendable {
                            case balances
                            case ownership
                            case transactions
                        }

                        /// Provide filters for the linked accounts that the customer can select for the payment method.
                        public struct Filters: Codable, Hashable, Sendable {
                            /// The account subcategories to use to filter for selectable accounts.
                            public var accountSubcategories: [AccountSubcategories]?

                            public init(
                                accountSubcategories: [AccountSubcategories]? = nil
                            ) {
                                self.accountSubcategories = accountSubcategories
                            }

                            public enum AccountSubcategories: String, Codable, Hashable, Sendable {
                                case checking
                                case savings
                            }
                        }
                    }
                }
            }
        }

        /// The rendering-related settings that control how the invoice is displayed on customer-facing surfaces such as PDF and.
        public struct Rendering: Codable, Hashable, Sendable {
            /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
            public var amountTaxDisplay: AmountTaxDisplay?
            /// Invoice pdf rendering options.
            public var pdf: Pdf?
            /// ID of the invoice rendering template to use for this invoice.
            public var template: String?
            /// The specific version of invoice rendering template to use for this invoice.
            public var templateVersion: Stripe.Clearable<Int>?

            public init(
                amountTaxDisplay: AmountTaxDisplay? = nil,
                pdf: Pdf? = nil,
                template: String? = nil,
                templateVersion: Stripe.Clearable<Int>? = nil
            ) {
                self.amountTaxDisplay = amountTaxDisplay
                self.pdf = pdf
                self.template = template
                self.templateVersion = templateVersion
            }

            public enum AmountTaxDisplay: String, Codable, Hashable, Sendable {
                case value = ""
                case excludeTax = "exclude_tax"
                case includeInclusiveTax = "include_inclusive_tax"
            }

            /// Invoice pdf rendering options.
            public struct Pdf: Codable, Hashable, Sendable {
                /// Page size for invoice PDF.
                public var pageSize: PageSize?

                public init(
                    pageSize: PageSize? = nil
                ) {
                    self.pageSize = pageSize
                }

                public enum PageSize: String, Codable, Hashable, Sendable {
                    case a4
                    case auto
                    case letter
                }
            }
        }

        /// Settings for the cost of shipping for this invoice.
        public struct ShippingCost: Codable, Hashable, Sendable {
            /// The ID of the shipping rate to use for this order.
            public var shippingRate: String?
            /// Parameters to create a new ad-hoc shipping rate for this order.
            public var shippingRateData: ShippingRateData?

            public init(
                shippingRate: String? = nil,
                shippingRateData: ShippingRateData? = nil
            ) {
                self.shippingRate = shippingRate
                self.shippingRateData = shippingRateData
            }

            /// Parameters to create a new ad-hoc shipping rate for this order.
            public struct ShippingRateData: Codable, Hashable, Sendable {
                /// The estimated range for how long shipping will take, meant to be displayable to the customer.
                public var deliveryEstimate: DeliveryEstimate?
                /// The name of the shipping rate, meant to be displayable to the customer.
                public var displayName: String
                /// Describes a fixed amount to charge for shipping.
                public var fixedAmount: FixedAmount?
                /// Set of key-value pairs that you can attach to an object.
                public var metadata: [String: String]?
                /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes.
                public var taxBehavior: TaxBehavior?
                /// A tax code ID.
                public var taxCode: String?
                /// The type of calculation to use on the shipping rate.
                public var `type`: String?

                public init(
                    deliveryEstimate: DeliveryEstimate? = nil,
                    displayName: String,
                    fixedAmount: FixedAmount? = nil,
                    metadata: [String: String]? = nil,
                    taxBehavior: TaxBehavior? = nil,
                    taxCode: String? = nil,
                    `type`: String? = nil
                ) {
                    self.deliveryEstimate = deliveryEstimate
                    self.displayName = displayName
                    self.fixedAmount = fixedAmount
                    self.metadata = metadata
                    self.taxBehavior = taxBehavior
                    self.taxCode = taxCode
                    self.`type` = `type`
                }

                public enum TaxBehavior: String, Codable, Hashable, Sendable {
                    case exclusive
                    case inclusive
                    case unspecified
                }

                /// The estimated range for how long shipping will take, meant to be displayable to the customer.
                public struct DeliveryEstimate: Codable, Hashable, Sendable {
                    /// The upper bound of the estimated range.
                    public var maximum: Maximum?
                    /// The lower bound of the estimated range.
                    public var minimum: Minimum?

                    public init(
                        maximum: Maximum? = nil,
                        minimum: Minimum? = nil
                    ) {
                        self.maximum = maximum
                        self.minimum = minimum
                    }

                    /// The upper bound of the estimated range.
                    public struct Maximum: Codable, Hashable, Sendable {
                        /// A unit of time.
                        public var unit: Unit
                        /// Must be greater than 0.
                        public var value: Int

                        public init(
                            unit: Unit,
                            value: Int
                        ) {
                            self.unit = unit
                            self.value = value
                        }

                        public enum Unit: String, Codable, Hashable, Sendable {
                            case businessDay = "business_day"
                            case day
                            case hour
                            case month
                            case week
                        }
                    }

                    /// The lower bound of the estimated range.
                    public struct Minimum: Codable, Hashable, Sendable {
                        /// A unit of time.
                        public var unit: Unit
                        /// Must be greater than 0.
                        public var value: Int

                        public init(
                            unit: Unit,
                            value: Int
                        ) {
                            self.unit = unit
                            self.value = value
                        }

                        public enum Unit: String, Codable, Hashable, Sendable {
                            case businessDay = "business_day"
                            case day
                            case hour
                            case month
                            case week
                        }
                    }
                }

                /// Describes a fixed amount to charge for shipping.
                public struct FixedAmount: Codable, Hashable, Sendable {
                    /// A non-negative integer in cents representing how much to charge.
                    public var amount: Int
                    /// Three-letter ISO currency code, in lowercase.
                    public var currency: Stripe.Currency
                    /// Shipping rates defined in each available currency option.
                    public var currencyOptions: [String: CurrencyOptions]?

                    public init(
                        amount: Int,
                        currency: Stripe.Currency,
                        currencyOptions: [String: CurrencyOptions]? = nil
                    ) {
                        self.amount = amount
                        self.currency = currency
                        self.currencyOptions = currencyOptions
                    }

                    public struct CurrencyOptions: Codable, Hashable, Sendable {
                        /// A non-negative integer in cents representing how much to charge.
                        public var amount: Int
                        /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes.
                        public var taxBehavior: TaxBehavior?

                        public init(
                            amount: Int,
                            taxBehavior: TaxBehavior? = nil
                        ) {
                            self.amount = amount
                            self.taxBehavior = taxBehavior
                        }

                        public enum TaxBehavior: String, Codable, Hashable, Sendable {
                            case exclusive
                            case inclusive
                            case unspecified
                        }
                    }
                }
            }
        }

        /// Shipping details for the invoice.
        public struct ShippingDetails: Codable, Hashable, Sendable {
            /// Shipping address.
            public var address: Address
            /// Recipient name.
            public var name: String
            /// Recipient phone (including extension).
            public var phone: String?

            public init(
                address: Address,
                name: String,
                phone: String? = nil
            ) {
                self.address = address
                self.name = name
                self.phone = phone
            }

            /// Shipping address.
            public struct Address: Codable, Hashable, Sendable {
                /// City, district, suburb, town, or village.
                public var city: String?
                /// Two-letter country code (ISO 3166-1 alpha-2).
                public var country: String?
                /// Address line 1, such as the street, PO Box, or company name.
                public var line1: String?
                /// Address line 2, such as the apartment, suite, unit, or building.
                public var line2: String?
                /// ZIP or postal code.
                public var postalCode: String?
                /// State, county, province, or region (ISO 3166-2).
                public var state: String?

                public init(
                    city: String? = nil,
                    country: String? = nil,
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

        /// If specified, the funds from the invoice will be transferred to the destination and the ID of the resulting transfer.
        public struct TransferData: Codable, Hashable, Sendable {
            /// The amount that will be transferred automatically when the invoice is paid.
            public var amount: Int?
            /// ID of an existing, connected Stripe account.
            public var destination: String

            public init(
                amount: Int? = nil,
                destination: String
            ) {
                self.amount = amount
                self.destination = destination
            }
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// POST /v1/invoices/create_preview
extension Stripe.Billing.Invoice.CreatePreview {
    public struct Request: Codable, Hashable, Sendable {
        /// Settings for automatic tax lookup for this invoice preview.
        public var automaticTax: AutomaticTax?
        /// The currency to preview this invoice in.
        public var currency: Stripe.Currency?
        /// The identifier of the customer whose upcoming invoice you're retrieving.
        public var customer: String?
        /// The identifier of the account representing the customer whose upcoming invoice you're retrieving.
        public var customerAccount: String?
        /// Details about the customer you want to invoice or overrides for an existing customer.
        public var customerDetails: CustomerDetails?
        /// The coupons to redeem into discounts for the invoice preview.
        public var discounts: Stripe.Clearable<[Discounts]>?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// List of invoice items to add or update in the upcoming invoice preview (up to 250).
        public var invoiceItems: [InvoiceItems]?
        /// The connected account that issues the invoice.
        public var issuer: Issuer?
        /// The account (if any) for which the funds of the invoice payment are intended.
        public var onBehalfOf: String?
        /// Customizes the types of values to include when calculating the invoice.
        public var previewMode: PreviewMode?
        /// The identifier of the schedule whose upcoming invoice you'd like to retrieve.
        public var schedule: String?
        /// The schedule creation or modification params to apply as a preview.
        public var scheduleDetails: ScheduleDetails?
        /// The identifier of the subscription for which you'd like to retrieve the upcoming invoice.
        public var subscription: String?
        /// The subscription creation or modification params to apply as a preview.
        public var subscriptionDetails: SubscriptionDetails?

        public init(
            automaticTax: AutomaticTax? = nil,
            currency: Stripe.Currency? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            customerDetails: CustomerDetails? = nil,
            discounts: Stripe.Clearable<[Discounts]>? = nil,
            expand: [String]? = nil,
            invoiceItems: [InvoiceItems]? = nil,
            issuer: Issuer? = nil,
            onBehalfOf: String? = nil,
            previewMode: PreviewMode? = nil,
            schedule: String? = nil,
            scheduleDetails: ScheduleDetails? = nil,
            subscription: String? = nil,
            subscriptionDetails: SubscriptionDetails? = nil
        ) {
            self.automaticTax = automaticTax
            self.currency = currency
            self.customer = customer
            self.customerAccount = customerAccount
            self.customerDetails = customerDetails
            self.discounts = discounts
            self.expand = expand
            self.invoiceItems = invoiceItems
            self.issuer = issuer
            self.onBehalfOf = onBehalfOf
            self.previewMode = previewMode
            self.schedule = schedule
            self.scheduleDetails = scheduleDetails
            self.subscription = subscription
            self.subscriptionDetails = subscriptionDetails
        }

        public enum PreviewMode: String, Codable, Hashable, Sendable {
            case next
            case recurring
        }

        /// Settings for automatic tax lookup for this invoice preview.
        public struct AutomaticTax: Codable, Hashable, Sendable {
            /// Whether Stripe automatically computes tax on this invoice.
            public var enabled: Bool
            /// The account that's liable for tax.
            public var liability: Liability?

            public init(
                enabled: Bool,
                liability: Liability? = nil
            ) {
                self.enabled = enabled
                self.liability = liability
            }

            /// The account that's liable for tax.
            public struct Liability: Codable, Hashable, Sendable {
                /// The connected account being referenced when `type` is `account`.
                public var account: String?
                /// Type of the account referenced in the request.
                public var `type`: Type

                public init(
                    account: String? = nil,
                    `type`: Type
                ) {
                    self.account = account
                    self.`type` = `type`
                }

                public enum `Type`: String, Codable, Hashable, Sendable {
                    case account
                    case `self`
                }
            }
        }

        /// Details about the customer you want to invoice or overrides for an existing customer.
        public struct CustomerDetails: Codable, Hashable, Sendable {
            /// The customer's address.
            public var address: Stripe.Clearable<Address>?
            /// The customer's shipping information.
            public var shipping: Stripe.Clearable<Shipping>?
            /// Tax details about the customer.
            public var tax: Tax?
            /// The customer's tax exemption.
            public var taxExempt: TaxExempt?
            /// The customer's tax IDs.
            public var taxIds: [TaxIds]?

            public init(
                address: Stripe.Clearable<Address>? = nil,
                shipping: Stripe.Clearable<Shipping>? = nil,
                tax: Tax? = nil,
                taxExempt: TaxExempt? = nil,
                taxIds: [TaxIds]? = nil
            ) {
                self.address = address
                self.shipping = shipping
                self.tax = tax
                self.taxExempt = taxExempt
                self.taxIds = taxIds
            }

            public enum TaxExempt: String, Codable, Hashable, Sendable {
                case value = ""
                case exempt
                case none
                case reverse
            }

            public struct Address: Codable, Hashable, Sendable {
                /// City, district, suburb, town, or village.
                public var city: String?
                /// Two-letter country code (ISO 3166-1 alpha-2).
                public var country: String?
                /// Address line 1, such as the street, PO Box, or company name.
                public var line1: String?
                /// Address line 2, such as the apartment, suite, unit, or building.
                public var line2: String?
                /// ZIP or postal code.
                public var postalCode: String?
                /// State, county, province, or region (ISO 3166-2).
                public var state: String?

                public init(
                    city: String? = nil,
                    country: String? = nil,
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

            public struct Shipping: Codable, Hashable, Sendable {
                /// Customer shipping address.
                public var address: Address
                /// Customer name.
                public var name: String
                /// Customer phone (including extension).
                public var phone: String?

                public init(
                    address: Address,
                    name: String,
                    phone: String? = nil
                ) {
                    self.address = address
                    self.name = name
                    self.phone = phone
                }

                /// Customer shipping address.
                public struct Address: Codable, Hashable, Sendable {
                    /// City, district, suburb, town, or village.
                    public var city: String?
                    /// A freeform text field for the country.
                    public var country: String?
                    /// Address line 1, such as the street, PO Box, or company name.
                    public var line1: String?
                    /// Address line 2, such as the apartment, suite, unit, or building.
                    public var line2: String?
                    /// ZIP or postal code.
                    public var postalCode: String?
                    /// State, county, province, or region (ISO 3166-2).
                    public var state: String?

                    public init(
                        city: String? = nil,
                        country: String? = nil,
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

            /// Tax details about the customer.
            public struct Tax: Codable, Hashable, Sendable {
                /// A recent IP address of the customer used for tax reporting and tax location inference.
                public var ipAddress: String?

                public init(
                    ipAddress: String? = nil
                ) {
                    self.ipAddress = ipAddress
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

        public struct Discounts: Codable, Hashable, Sendable {
            /// ID of the coupon to create a new discount for.
            public var coupon: String?
            /// ID of an existing discount on the object (or one of its ancestors) to reuse.
            public var discount: String?
            /// ID of the promotion code to create a new discount for.
            public var promotionCode: String?

            public init(
                coupon: String? = nil,
                discount: String? = nil,
                promotionCode: String? = nil
            ) {
                self.coupon = coupon
                self.discount = discount
                self.promotionCode = promotionCode
            }
        }

        public struct InvoiceItems: Codable, Hashable, Sendable {
            /// The integer amount in cents (or local equivalent) of previewed invoice item.
            public var amount: Int?
            /// Three-letter ISO currency code, in lowercase.
            public var currency: Stripe.Currency?
            /// An arbitrary string which you can attach to the invoice item.
            public var description: String?
            /// Explicitly controls whether discounts apply to this invoice item.
            public var discountable: Bool?
            /// The coupons to redeem into discounts for the invoice item in the preview.
            public var discounts: Stripe.Clearable<[Discounts]>?
            /// The ID of the invoice item to update in preview.
            public var invoiceitem: String?
            /// Set of key-value pairs that you can attach to an object.
            public var metadata: Stripe.Clearable<[String: String]>?
            /// The period associated with this invoice item.
            public var period: Period?
            /// The ID of the price object.
            public var price: String?
            /// Data used to generate a new Price object inline.
            public var priceData: PriceData?
            /// Non-negative integer.
            public var quantity: Int?
            /// Non-negative decimal with at most 12 decimal places.
            public var quantityDecimal: String?
            /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
            public var taxBehavior: TaxBehavior?
            /// A tax code ID.
            public var taxCode: String?
            /// The tax rates that apply to the item.
            public var taxRates: Stripe.Clearable<[String]>?
            /// The integer unit amount in cents (or local equivalent) of the charge to be applied to the upcoming invoice.
            public var unitAmount: Int?
            /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
            public var unitAmountDecimal: String?

            public init(
                amount: Int? = nil,
                currency: Stripe.Currency? = nil,
                description: String? = nil,
                discountable: Bool? = nil,
                discounts: Stripe.Clearable<[Discounts]>? = nil,
                invoiceitem: String? = nil,
                metadata: Stripe.Clearable<[String: String]>? = nil,
                period: Period? = nil,
                price: String? = nil,
                priceData: PriceData? = nil,
                quantity: Int? = nil,
                quantityDecimal: String? = nil,
                taxBehavior: TaxBehavior? = nil,
                taxCode: String? = nil,
                taxRates: Stripe.Clearable<[String]>? = nil,
                unitAmount: Int? = nil,
                unitAmountDecimal: String? = nil
            ) {
                self.amount = amount
                self.currency = currency
                self.description = description
                self.discountable = discountable
                self.discounts = discounts
                self.invoiceitem = invoiceitem
                self.metadata = metadata
                self.period = period
                self.price = price
                self.priceData = priceData
                self.quantity = quantity
                self.quantityDecimal = quantityDecimal
                self.taxBehavior = taxBehavior
                self.taxCode = taxCode
                self.taxRates = taxRates
                self.unitAmount = unitAmount
                self.unitAmountDecimal = unitAmountDecimal
            }

            public enum TaxBehavior: String, Codable, Hashable, Sendable {
                case exclusive
                case inclusive
                case unspecified
            }

            public struct Discounts: Codable, Hashable, Sendable {
                /// ID of the coupon to create a new discount for.
                public var coupon: String?
                /// ID of an existing discount on the object (or one of its ancestors) to reuse.
                public var discount: String?
                /// ID of the promotion code to create a new discount for.
                public var promotionCode: String?

                public init(
                    coupon: String? = nil,
                    discount: String? = nil,
                    promotionCode: String? = nil
                ) {
                    self.coupon = coupon
                    self.discount = discount
                    self.promotionCode = promotionCode
                }
            }

            /// The period associated with this invoice item.
            public struct Period: Codable, Hashable, Sendable {
                /// The end of the period, which must be greater than or equal to the start.
                public var end: Date
                /// The start of the period.
                public var start: Date

                public init(
                    end: Date,
                    start: Date
                ) {
                    self.end = end
                    self.start = start
                }
            }

            /// Data used to generate a new Price object inline.
            public struct PriceData: Codable, Hashable, Sendable {
                /// Three-letter ISO currency code, in lowercase.
                public var currency: Stripe.Currency
                /// The ID of the Product that this Price will belong to.
                public var product: String
                /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
                public var taxBehavior: TaxBehavior?
                /// A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
                public var unitAmount: Int?
                /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
                public var unitAmountDecimal: String?

                public init(
                    currency: Stripe.Currency,
                    product: String,
                    taxBehavior: TaxBehavior? = nil,
                    unitAmount: Int? = nil,
                    unitAmountDecimal: String? = nil
                ) {
                    self.currency = currency
                    self.product = product
                    self.taxBehavior = taxBehavior
                    self.unitAmount = unitAmount
                    self.unitAmountDecimal = unitAmountDecimal
                }

                public enum TaxBehavior: String, Codable, Hashable, Sendable {
                    case exclusive
                    case inclusive
                    case unspecified
                }
            }
        }

        /// The connected account that issues the invoice.
        public struct Issuer: Codable, Hashable, Sendable {
            /// The connected account being referenced when `type` is `account`.
            public var account: String?
            /// Type of the account referenced in the request.
            public var `type`: Type

            public init(
                account: String? = nil,
                `type`: Type
            ) {
                self.account = account
                self.`type` = `type`
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case account
                case `self`
            }
        }

        /// The schedule creation or modification params to apply as a preview.
        public struct ScheduleDetails: Codable, Hashable, Sendable {
            /// Controls how prorations and invoices for subscriptions are calculated and orchestrated.
            public var billingMode: BillingMode?
            /// Behavior of the subscription schedule and underlying subscription when it ends.
            public var endBehavior: EndBehavior?
            /// List representing phases of the subscription schedule.
            public var phases: [Phases]?
            /// In cases where the `schedule_details` params update the currently active phase, specifies if and how to prorate at.
            public var prorationBehavior: ProrationBehavior?

            public init(
                billingMode: BillingMode? = nil,
                endBehavior: EndBehavior? = nil,
                phases: [Phases]? = nil,
                prorationBehavior: ProrationBehavior? = nil
            ) {
                self.billingMode = billingMode
                self.endBehavior = endBehavior
                self.phases = phases
                self.prorationBehavior = prorationBehavior
            }

            public enum EndBehavior: String, Codable, Hashable, Sendable {
                case cancel
                case release
            }

            public enum ProrationBehavior: String, Codable, Hashable, Sendable {
                case alwaysInvoice = "always_invoice"
                case createProrations = "create_prorations"
                case none
            }

            /// Controls how prorations and invoices for subscriptions are calculated and orchestrated.
            public struct BillingMode: Codable, Hashable, Sendable {
                /// Configure behavior for flexible billing mode.
                public var flexible: Flexible?
                /// Controls the calculation and orchestration of prorations and invoices for subscriptions.
                public var `type`: Type

                public init(
                    flexible: Flexible? = nil,
                    `type`: Type
                ) {
                    self.flexible = flexible
                    self.`type` = `type`
                }

                public enum `Type`: String, Codable, Hashable, Sendable {
                    case classic
                    case flexible
                }

                /// Configure behavior for flexible billing mode.
                public struct Flexible: Codable, Hashable, Sendable {
                    /// Controls how invoices and invoice items display proration amounts and discount amounts.
                    public var prorationDiscounts: ProrationDiscounts?

                    public init(
                        prorationDiscounts: ProrationDiscounts? = nil
                    ) {
                        self.prorationDiscounts = prorationDiscounts
                    }

                    public enum ProrationDiscounts: String, Codable, Hashable, Sendable {
                        case included
                        case itemized
                    }
                }
            }

            public struct Phases: Codable, Hashable, Sendable {
                /// A list of prices and quantities that will generate invoice items appended to the next invoice for this phase.
                public var addInvoiceItems: [AddInvoiceItems]?
                /// A non-negative decimal between 0 and 100, with at most two decimal places.
                public var applicationFeePercent: Decimal?
                /// Automatic tax settings for this phase.
                public var automaticTax: AutomaticTax?
                /// Can be set to `phase_start` to set the anchor to the start of the phase or `automatic` to automatically change it if.
                public var billingCycleAnchor: BillingCycleAnchor?
                /// Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period.
                public var billingThresholds: Stripe.Clearable<BillingThresholds>?
                /// Either `charge_automatically`, or `send_invoice`.
                public var collectionMethod: CollectionMethod?
                /// Three-letter ISO currency code, in lowercase.
                public var currency: Stripe.Currency?
                /// ID of the default payment method for the subscription schedule.
                public var defaultPaymentMethod: String?
                /// A list of Tax Rate ids.
                public var defaultTaxRates: Stripe.Clearable<[String]>?
                /// Subscription description, meant to be displayable to the customer.
                public var description: String?
                /// The coupons to redeem into discounts for the schedule phase.
                public var discounts: Stripe.Clearable<[Discounts]>?
                /// The number of intervals the phase should last.
                public var duration: Duration?
                /// The date at which this phase of the subscription schedule ends.
                public var endDate: EndDate?
                /// All invoices will be billed using the specified settings.
                public var invoiceSettings: InvoiceSettings?
                /// List of configuration items, each with an attached price, to apply during this phase of the subscription schedule.
                public var items: [Items]
                /// Set of key-value pairs that you can attach to a phase.
                public var metadata: [String: String]?
                /// The account on behalf of which to charge, for each of the associated subscription's invoices.
                public var onBehalfOf: String?
                /// Controls whether the subscription schedule should create prorations when transitioning to this phase if there is a.
                public var prorationBehavior: ProrationBehavior?
                /// The date at which this phase of the subscription schedule starts or `now`.
                public var startDate: StartDate?
                /// The data with which to automatically create a Transfer for each of the associated subscription's invoices.
                public var transferData: TransferData?
                /// If set to true the entire phase is counted as a trial and the customer will not be charged for any fees.
                public var trial: Bool?
                /// Sets the phase to trialing from the start date to this date.
                public var trialEnd: TrialEnd?

                public init(
                    addInvoiceItems: [AddInvoiceItems]? = nil,
                    applicationFeePercent: Decimal? = nil,
                    automaticTax: AutomaticTax? = nil,
                    billingCycleAnchor: BillingCycleAnchor? = nil,
                    billingThresholds: Stripe.Clearable<BillingThresholds>? = nil,
                    collectionMethod: CollectionMethod? = nil,
                    currency: Stripe.Currency? = nil,
                    defaultPaymentMethod: String? = nil,
                    defaultTaxRates: Stripe.Clearable<[String]>? = nil,
                    description: String? = nil,
                    discounts: Stripe.Clearable<[Discounts]>? = nil,
                    duration: Duration? = nil,
                    endDate: EndDate? = nil,
                    invoiceSettings: InvoiceSettings? = nil,
                    items: [Items],
                    metadata: [String: String]? = nil,
                    onBehalfOf: String? = nil,
                    prorationBehavior: ProrationBehavior? = nil,
                    startDate: StartDate? = nil,
                    transferData: TransferData? = nil,
                    trial: Bool? = nil,
                    trialEnd: TrialEnd? = nil
                ) {
                    self.addInvoiceItems = addInvoiceItems
                    self.applicationFeePercent = applicationFeePercent
                    self.automaticTax = automaticTax
                    self.billingCycleAnchor = billingCycleAnchor
                    self.billingThresholds = billingThresholds
                    self.collectionMethod = collectionMethod
                    self.currency = currency
                    self.defaultPaymentMethod = defaultPaymentMethod
                    self.defaultTaxRates = defaultTaxRates
                    self.description = description
                    self.discounts = discounts
                    self.duration = duration
                    self.endDate = endDate
                    self.invoiceSettings = invoiceSettings
                    self.items = items
                    self.metadata = metadata
                    self.onBehalfOf = onBehalfOf
                    self.prorationBehavior = prorationBehavior
                    self.startDate = startDate
                    self.transferData = transferData
                    self.trial = trial
                    self.trialEnd = trialEnd
                }

                public enum BillingCycleAnchor: String, Codable, Hashable, Sendable {
                    case automatic
                    case phaseStart = "phase_start"
                }

                public enum CollectionMethod: String, Codable, Hashable, Sendable {
                    case chargeAutomatically = "charge_automatically"
                    case sendInvoice = "send_invoice"
                }

                public enum ProrationBehavior: String, Codable, Hashable, Sendable {
                    case alwaysInvoice = "always_invoice"
                    case createProrations = "create_prorations"
                    case none
                }

                public struct AddInvoiceItems: Codable, Hashable, Sendable {
                    /// Controls whether discounts apply to this invoice item.
                    public var discountable: Bool?
                    /// The coupons to redeem into discounts for the item.
                    public var discounts: [Discounts]?
                    /// Set of key-value pairs that you can attach to an object.
                    public var metadata: [String: String]?
                    /// The period associated with this invoice item.
                    public var period: Period?
                    /// The ID of the price object.
                    public var price: String?
                    /// Data used to generate a new Price object inline.
                    public var priceData: PriceData?
                    /// Quantity for this item.
                    public var quantity: Int?
                    /// The tax rates which apply to the item.
                    public var taxRates: Stripe.Clearable<[String]>?

                    public init(
                        discountable: Bool? = nil,
                        discounts: [Discounts]? = nil,
                        metadata: [String: String]? = nil,
                        period: Period? = nil,
                        price: String? = nil,
                        priceData: PriceData? = nil,
                        quantity: Int? = nil,
                        taxRates: Stripe.Clearable<[String]>? = nil
                    ) {
                        self.discountable = discountable
                        self.discounts = discounts
                        self.metadata = metadata
                        self.period = period
                        self.price = price
                        self.priceData = priceData
                        self.quantity = quantity
                        self.taxRates = taxRates
                    }

                    public struct Discounts: Codable, Hashable, Sendable {
                        /// ID of the coupon to create a new discount for.
                        public var coupon: String?
                        /// ID of an existing discount on the object (or one of its ancestors) to reuse.
                        public var discount: String?
                        /// ID of the promotion code to create a new discount for.
                        public var promotionCode: String?

                        public init(
                            coupon: String? = nil,
                            discount: String? = nil,
                            promotionCode: String? = nil
                        ) {
                            self.coupon = coupon
                            self.discount = discount
                            self.promotionCode = promotionCode
                        }
                    }

                    /// The period associated with this invoice item.
                    public struct Period: Codable, Hashable, Sendable {
                        /// End of the invoice item period.
                        public var end: End
                        /// Start of the invoice item period.
                        public var start: Start

                        public init(
                            end: End,
                            start: Start
                        ) {
                            self.end = end
                            self.start = start
                        }

                        /// End of the invoice item period.
                        public struct End: Codable, Hashable, Sendable {
                            /// A precise Unix timestamp for the end of the invoice item period.
                            public var timestamp: Date?
                            /// Select how to calculate the end of the invoice item period.
                            public var `type`: Type

                            public init(
                                timestamp: Date? = nil,
                                `type`: Type
                            ) {
                                self.timestamp = timestamp
                                self.`type` = `type`
                            }

                            public enum `Type`: String, Codable, Hashable, Sendable {
                                case minItemPeriodEnd = "min_item_period_end"
                                case phaseEnd = "phase_end"
                                case timestamp
                            }
                        }

                        /// Start of the invoice item period.
                        public struct Start: Codable, Hashable, Sendable {
                            /// A precise Unix timestamp for the start of the invoice item period.
                            public var timestamp: Date?
                            /// Select how to calculate the start of the invoice item period.
                            public var `type`: Type

                            public init(
                                timestamp: Date? = nil,
                                `type`: Type
                            ) {
                                self.timestamp = timestamp
                                self.`type` = `type`
                            }

                            public enum `Type`: String, Codable, Hashable, Sendable {
                                case maxItemPeriodStart = "max_item_period_start"
                                case phaseStart = "phase_start"
                                case timestamp
                            }
                        }
                    }

                    /// Data used to generate a new Price object inline.
                    public struct PriceData: Codable, Hashable, Sendable {
                        /// Three-letter ISO currency code, in lowercase.
                        public var currency: Stripe.Currency
                        /// The ID of the Product that this Price will belong to.
                        public var product: String
                        /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
                        public var taxBehavior: TaxBehavior?
                        /// A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge or a.
                        public var unitAmount: Int?
                        /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
                        public var unitAmountDecimal: String?

                        public init(
                            currency: Stripe.Currency,
                            product: String,
                            taxBehavior: TaxBehavior? = nil,
                            unitAmount: Int? = nil,
                            unitAmountDecimal: String? = nil
                        ) {
                            self.currency = currency
                            self.product = product
                            self.taxBehavior = taxBehavior
                            self.unitAmount = unitAmount
                            self.unitAmountDecimal = unitAmountDecimal
                        }

                        public enum TaxBehavior: String, Codable, Hashable, Sendable {
                            case exclusive
                            case inclusive
                            case unspecified
                        }
                    }
                }

                /// Automatic tax settings for this phase.
                public struct AutomaticTax: Codable, Hashable, Sendable {
                    /// Enabled automatic tax calculation which will automatically compute tax rates on all invoices generated by the.
                    public var enabled: Bool
                    /// The account that's liable for tax.
                    public var liability: Liability?

                    public init(
                        enabled: Bool,
                        liability: Liability? = nil
                    ) {
                        self.enabled = enabled
                        self.liability = liability
                    }

                    /// The account that's liable for tax.
                    public struct Liability: Codable, Hashable, Sendable {
                        /// The connected account being referenced when `type` is `account`.
                        public var account: String?
                        /// Type of the account referenced in the request.
                        public var `type`: Type

                        public init(
                            account: String? = nil,
                            `type`: Type
                        ) {
                            self.account = account
                            self.`type` = `type`
                        }

                        public enum `Type`: String, Codable, Hashable, Sendable {
                            case account
                            case `self`
                        }
                    }
                }

                public struct BillingThresholds: Codable, Hashable, Sendable {
                    /// Monetary threshold that triggers the subscription to advance to a new billing period.
                    public var amountGte: Int?
                    /// Indicates if the `billing_cycle_anchor` should be reset when a threshold is reached.
                    public var resetBillingCycleAnchor: Bool?

                    public init(
                        amountGte: Int? = nil,
                        resetBillingCycleAnchor: Bool? = nil
                    ) {
                        self.amountGte = amountGte
                        self.resetBillingCycleAnchor = resetBillingCycleAnchor
                    }
                }

                public struct Discounts: Codable, Hashable, Sendable {
                    /// ID of the coupon to create a new discount for.
                    public var coupon: String?
                    /// ID of an existing discount on the object (or one of its ancestors) to reuse.
                    public var discount: String?
                    /// ID of the promotion code to create a new discount for.
                    public var promotionCode: String?

                    public init(
                        coupon: String? = nil,
                        discount: String? = nil,
                        promotionCode: String? = nil
                    ) {
                        self.coupon = coupon
                        self.discount = discount
                        self.promotionCode = promotionCode
                    }
                }

                /// The number of intervals the phase should last.
                public struct Duration: Codable, Hashable, Sendable {
                    /// Specifies phase duration.
                    public var interval: Interval
                    /// The multiplier applied to the interval.
                    public var intervalCount: Int?

                    public init(
                        interval: Interval,
                        intervalCount: Int? = nil
                    ) {
                        self.interval = interval
                        self.intervalCount = intervalCount
                    }

                    public enum Interval: String, Codable, Hashable, Sendable {
                        case day
                        case month
                        case week
                        case year
                    }
                }

                /// The date at which this phase of the subscription schedule ends.
                public enum EndDate: Codable, Hashable, Sendable {
                    case value(Date)
                    case now

                    public init(from decoder: any Decoder) throws {
                        let container = try decoder.singleValueContainer()
                        if let value = try? container.decode(Date.self) {
                            self = .value(value)
                            return
                        }
                        switch try container.decode(String.self) {
                        case "now": self = .now
                        case let other: throw DecodingError.dataCorruptedError(in: container, debugDescription: "unknown keyword \(other)")
                        }
                    }

                    public func encode(to encoder: any Encoder) throws {
                        var container = encoder.singleValueContainer()
                        switch self {
                        case .value(let value): try container.encode(value)
                        case .now: try container.encode("now")
                        }
                    }
                }

                /// All invoices will be billed using the specified settings.
                public struct InvoiceSettings: Codable, Hashable, Sendable {
                    /// The account tax IDs associated with this phase of the subscription schedule.
                    public var accountTaxIds: Stripe.Clearable<[String]>?
                    /// Number of days within which a customer must pay invoices generated by this subscription schedule.
                    public var daysUntilDue: Int?
                    /// The connected account that issues the invoice.
                    public var issuer: Issuer?

                    public init(
                        accountTaxIds: Stripe.Clearable<[String]>? = nil,
                        daysUntilDue: Int? = nil,
                        issuer: Issuer? = nil
                    ) {
                        self.accountTaxIds = accountTaxIds
                        self.daysUntilDue = daysUntilDue
                        self.issuer = issuer
                    }

                    /// The connected account that issues the invoice.
                    public struct Issuer: Codable, Hashable, Sendable {
                        /// The connected account being referenced when `type` is `account`.
                        public var account: String?
                        /// Type of the account referenced in the request.
                        public var `type`: Type

                        public init(
                            account: String? = nil,
                            `type`: Type
                        ) {
                            self.account = account
                            self.`type` = `type`
                        }

                        public enum `Type`: String, Codable, Hashable, Sendable {
                            case account
                            case `self`
                        }
                    }
                }

                public struct Items: Codable, Hashable, Sendable {
                    /// Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period.
                    public var billingThresholds: Stripe.Clearable<BillingThresholds>?
                    /// The coupons to redeem into discounts for the subscription item.
                    public var discounts: Stripe.Clearable<[Discounts]>?
                    /// Set of key-value pairs that you can attach to a configuration item.
                    public var metadata: [String: String]?
                    /// The plan ID to subscribe to.
                    public var plan: String?
                    /// The ID of the price object.
                    public var price: String?
                    /// Data used to generate a new Price object inline.
                    public var priceData: PriceData?
                    /// Quantity for the given price.
                    public var quantity: Int?
                    /// A list of Tax Rate ids.
                    public var taxRates: Stripe.Clearable<[String]>?

                    public init(
                        billingThresholds: Stripe.Clearable<BillingThresholds>? = nil,
                        discounts: Stripe.Clearable<[Discounts]>? = nil,
                        metadata: [String: String]? = nil,
                        plan: String? = nil,
                        price: String? = nil,
                        priceData: PriceData? = nil,
                        quantity: Int? = nil,
                        taxRates: Stripe.Clearable<[String]>? = nil
                    ) {
                        self.billingThresholds = billingThresholds
                        self.discounts = discounts
                        self.metadata = metadata
                        self.plan = plan
                        self.price = price
                        self.priceData = priceData
                        self.quantity = quantity
                        self.taxRates = taxRates
                    }

                    public struct BillingThresholds: Codable, Hashable, Sendable {
                        /// Number of units that meets the billing threshold to advance the subscription to a new billing period (e.g., it takes.
                        public var usageGte: Int

                        public init(
                            usageGte: Int
                        ) {
                            self.usageGte = usageGte
                        }
                    }

                    public struct Discounts: Codable, Hashable, Sendable {
                        /// ID of the coupon to create a new discount for.
                        public var coupon: String?
                        /// ID of an existing discount on the object (or one of its ancestors) to reuse.
                        public var discount: String?
                        /// ID of the promotion code to create a new discount for.
                        public var promotionCode: String?

                        public init(
                            coupon: String? = nil,
                            discount: String? = nil,
                            promotionCode: String? = nil
                        ) {
                            self.coupon = coupon
                            self.discount = discount
                            self.promotionCode = promotionCode
                        }
                    }

                    /// Data used to generate a new Price object inline.
                    public struct PriceData: Codable, Hashable, Sendable {
                        /// Three-letter ISO currency code, in lowercase.
                        public var currency: Stripe.Currency
                        /// The ID of the Product that this Price will belong to.
                        public var product: String
                        /// The recurring components of a price such as `interval` and `interval_count`.
                        public var recurring: Recurring
                        /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
                        public var taxBehavior: TaxBehavior?
                        /// A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
                        public var unitAmount: Int?
                        /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
                        public var unitAmountDecimal: String?

                        public init(
                            currency: Stripe.Currency,
                            product: String,
                            recurring: Recurring,
                            taxBehavior: TaxBehavior? = nil,
                            unitAmount: Int? = nil,
                            unitAmountDecimal: String? = nil
                        ) {
                            self.currency = currency
                            self.product = product
                            self.recurring = recurring
                            self.taxBehavior = taxBehavior
                            self.unitAmount = unitAmount
                            self.unitAmountDecimal = unitAmountDecimal
                        }

                        public enum TaxBehavior: String, Codable, Hashable, Sendable {
                            case exclusive
                            case inclusive
                            case unspecified
                        }

                        /// The recurring components of a price such as `interval` and `interval_count`.
                        public struct Recurring: Codable, Hashable, Sendable {
                            /// Specifies billing frequency.
                            public var interval: Interval
                            /// The number of intervals between subscription billings.
                            public var intervalCount: Int?

                            public init(
                                interval: Interval,
                                intervalCount: Int? = nil
                            ) {
                                self.interval = interval
                                self.intervalCount = intervalCount
                            }

                            public enum Interval: String, Codable, Hashable, Sendable {
                                case day
                                case month
                                case week
                                case year
                            }
                        }
                    }
                }

                /// The date at which this phase of the subscription schedule starts or `now`.
                public enum StartDate: Codable, Hashable, Sendable {
                    case value(Date)
                    case now

                    public init(from decoder: any Decoder) throws {
                        let container = try decoder.singleValueContainer()
                        if let value = try? container.decode(Date.self) {
                            self = .value(value)
                            return
                        }
                        switch try container.decode(String.self) {
                        case "now": self = .now
                        case let other: throw DecodingError.dataCorruptedError(in: container, debugDescription: "unknown keyword \(other)")
                        }
                    }

                    public func encode(to encoder: any Encoder) throws {
                        var container = encoder.singleValueContainer()
                        switch self {
                        case .value(let value): try container.encode(value)
                        case .now: try container.encode("now")
                        }
                    }
                }

                /// The data with which to automatically create a Transfer for each of the associated subscription's invoices.
                public struct TransferData: Codable, Hashable, Sendable {
                    /// A non-negative decimal between 0 and 100, with at most two decimal places.
                    public var amountPercent: Decimal?
                    /// ID of an existing, connected Stripe account.
                    public var destination: String

                    public init(
                        amountPercent: Decimal? = nil,
                        destination: String
                    ) {
                        self.amountPercent = amountPercent
                        self.destination = destination
                    }
                }

                /// Sets the phase to trialing from the start date to this date.
                public enum TrialEnd: Codable, Hashable, Sendable {
                    case value(Date)
                    case now

                    public init(from decoder: any Decoder) throws {
                        let container = try decoder.singleValueContainer()
                        if let value = try? container.decode(Date.self) {
                            self = .value(value)
                            return
                        }
                        switch try container.decode(String.self) {
                        case "now": self = .now
                        case let other: throw DecodingError.dataCorruptedError(in: container, debugDescription: "unknown keyword \(other)")
                        }
                    }

                    public func encode(to encoder: any Encoder) throws {
                        var container = encoder.singleValueContainer()
                        switch self {
                        case .value(let value): try container.encode(value)
                        case .now: try container.encode("now")
                        }
                    }
                }
            }
        }

        /// The subscription creation or modification params to apply as a preview.
        public struct SubscriptionDetails: Codable, Hashable, Sendable {
            /// For new subscriptions, a future timestamp to anchor the subscription's billing cycle.
            public var billingCycleAnchor: BillingCycleAnchor?
            /// Controls how prorations and invoices for subscriptions are calculated and orchestrated.
            public var billingMode: BillingMode?
            /// Sets the billing schedules for the subscription.
            public var billingSchedules: Stripe.Clearable<[BillingSchedules]>?
            /// A timestamp at which the subscription should cancel.
            public var cancelAt: CancelAt?
            /// Indicate whether this subscription should cancel at the end of the current period (`current_period_end`).
            public var cancelAtPeriodEnd: Bool?
            /// This simulates the subscription being canceled or expired immediately.
            public var cancelNow: Bool?
            /// If provided, the invoice returned will preview updating or creating a subscription with these default tax rates.
            public var defaultTaxRates: Stripe.Clearable<[String]>?
            /// A list of up to 20 subscription items, each with an attached price.
            public var items: [Items]?
            /// Set of key-value pairs that you can attach to an object.
            public var metadata: Stripe.Clearable<[String: String]>?
            /// Determines how to handle prorations when the billing cycle changes (e.g., when switching plans, resetting.
            public var prorationBehavior: ProrationBehavior?
            /// If previewing an update to a subscription, and doing proration, `subscription_details.proration_date` forces the.
            public var prorationDate: Date?
            /// For paused subscriptions, setting `subscription_details.resume_at` to `now` will preview the invoice that will be.
            public var resumeAt: String?
            /// Date a subscription is intended to start (can be future or past).
            public var startDate: Date?
            /// If provided, the invoice returned will preview updating or creating a subscription with that trial end.
            public var trialEnd: TrialEnd?

            public init(
                billingCycleAnchor: BillingCycleAnchor? = nil,
                billingMode: BillingMode? = nil,
                billingSchedules: Stripe.Clearable<[BillingSchedules]>? = nil,
                cancelAt: CancelAt? = nil,
                cancelAtPeriodEnd: Bool? = nil,
                cancelNow: Bool? = nil,
                defaultTaxRates: Stripe.Clearable<[String]>? = nil,
                items: [Items]? = nil,
                metadata: Stripe.Clearable<[String: String]>? = nil,
                prorationBehavior: ProrationBehavior? = nil,
                prorationDate: Date? = nil,
                resumeAt: String? = nil,
                startDate: Date? = nil,
                trialEnd: TrialEnd? = nil
            ) {
                self.billingCycleAnchor = billingCycleAnchor
                self.billingMode = billingMode
                self.billingSchedules = billingSchedules
                self.cancelAt = cancelAt
                self.cancelAtPeriodEnd = cancelAtPeriodEnd
                self.cancelNow = cancelNow
                self.defaultTaxRates = defaultTaxRates
                self.items = items
                self.metadata = metadata
                self.prorationBehavior = prorationBehavior
                self.prorationDate = prorationDate
                self.resumeAt = resumeAt
                self.startDate = startDate
                self.trialEnd = trialEnd
            }

            public enum ProrationBehavior: String, Codable, Hashable, Sendable {
                case alwaysInvoice = "always_invoice"
                case createProrations = "create_prorations"
                case none
            }

            /// For new subscriptions, a future timestamp to anchor the subscription's billing cycle.
            public enum BillingCycleAnchor: Codable, Hashable, Sendable {
                case value(Date)
                case now
                case unchanged

                public init(from decoder: any Decoder) throws {
                    let container = try decoder.singleValueContainer()
                    if let value = try? container.decode(Date.self) {
                        self = .value(value)
                        return
                    }
                    switch try container.decode(String.self) {
                    case "now": self = .now
                    case "unchanged": self = .unchanged
                    case let other: throw DecodingError.dataCorruptedError(in: container, debugDescription: "unknown keyword \(other)")
                    }
                }

                public func encode(to encoder: any Encoder) throws {
                    var container = encoder.singleValueContainer()
                    switch self {
                    case .value(let value): try container.encode(value)
                    case .now: try container.encode("now")
                    case .unchanged: try container.encode("unchanged")
                    }
                }
            }

            /// Controls how prorations and invoices for subscriptions are calculated and orchestrated.
            public struct BillingMode: Codable, Hashable, Sendable {
                /// Configure behavior for flexible billing mode.
                public var flexible: Flexible?
                /// Controls the calculation and orchestration of prorations and invoices for subscriptions.
                public var `type`: Type

                public init(
                    flexible: Flexible? = nil,
                    `type`: Type
                ) {
                    self.flexible = flexible
                    self.`type` = `type`
                }

                public enum `Type`: String, Codable, Hashable, Sendable {
                    case classic
                    case flexible
                }

                /// Configure behavior for flexible billing mode.
                public struct Flexible: Codable, Hashable, Sendable {
                    /// Controls how invoices and invoice items display proration amounts and discount amounts.
                    public var prorationDiscounts: ProrationDiscounts?

                    public init(
                        prorationDiscounts: ProrationDiscounts? = nil
                    ) {
                        self.prorationDiscounts = prorationDiscounts
                    }

                    public enum ProrationDiscounts: String, Codable, Hashable, Sendable {
                        case included
                        case itemized
                    }
                }
            }

            public struct BillingSchedules: Codable, Hashable, Sendable {
                /// Configure billing schedule differently for individual subscription items.
                public var appliesTo: [AppliesTo]?
                /// The end date for the billing schedule.
                public var billUntil: BillUntil?
                /// Specify a key for the billing schedule.
                public var key: String?

                public init(
                    appliesTo: [AppliesTo]? = nil,
                    billUntil: BillUntil? = nil,
                    key: String? = nil
                ) {
                    self.appliesTo = appliesTo
                    self.billUntil = billUntil
                    self.key = key
                }

                public struct AppliesTo: Codable, Hashable, Sendable {
                    /// The ID of the price object.
                    public var price: String?
                    /// Controls which subscription items the billing schedule applies to.
                    public var `type`: String

                    public init(
                        price: String? = nil,
                        `type`: String
                    ) {
                        self.price = price
                        self.`type` = `type`
                    }
                }

                /// The end date for the billing schedule.
                public struct BillUntil: Codable, Hashable, Sendable {
                    /// Specifies the billing period.
                    public var duration: Duration?
                    /// The end date of the billing schedule.
                    public var timestamp: Date?
                    /// Describes how the billing schedule will determine the end date.
                    public var `type`: Type

                    public init(
                        duration: Duration? = nil,
                        timestamp: Date? = nil,
                        `type`: Type
                    ) {
                        self.duration = duration
                        self.timestamp = timestamp
                        self.`type` = `type`
                    }

                    public enum `Type`: String, Codable, Hashable, Sendable {
                        case duration
                        case timestamp
                    }

                    /// Specifies the billing period.
                    public struct Duration: Codable, Hashable, Sendable {
                        /// Specifies billing duration.
                        public var interval: Interval
                        /// The multiplier applied to the interval.
                        public var intervalCount: Int?

                        public init(
                            interval: Interval,
                            intervalCount: Int? = nil
                        ) {
                            self.interval = interval
                            self.intervalCount = intervalCount
                        }

                        public enum Interval: String, Codable, Hashable, Sendable {
                            case day
                            case month
                            case week
                            case year
                        }
                    }
                }
            }

            /// A timestamp at which the subscription should cancel.
            public enum CancelAt: Codable, Hashable, Sendable {
                case value(Date)
                case maxBilledUntil
                case maxPeriodEnd
                case minPeriodEnd
                /// Unsets the field.
                case clear

                public init(from decoder: any Decoder) throws {
                    let container = try decoder.singleValueContainer()
                    if let value = try? container.decode(Date.self) {
                        self = .value(value)
                        return
                    }
                    switch try container.decode(String.self) {
                    case "max_billed_until": self = .maxBilledUntil
                    case "max_period_end": self = .maxPeriodEnd
                    case "min_period_end": self = .minPeriodEnd
                    case "": self = .clear
                    case let other: throw DecodingError.dataCorruptedError(in: container, debugDescription: "unknown keyword \(other)")
                    }
                }

                public func encode(to encoder: any Encoder) throws {
                    var container = encoder.singleValueContainer()
                    switch self {
                    case .value(let value): try container.encode(value)
                    case .maxBilledUntil: try container.encode("max_billed_until")
                    case .maxPeriodEnd: try container.encode("max_period_end")
                    case .minPeriodEnd: try container.encode("min_period_end")
                    case .clear: try container.encode("")
                    }
                }
            }

            public struct Items: Codable, Hashable, Sendable {
                /// Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period.
                public var billingThresholds: Stripe.Clearable<BillingThresholds>?
                /// Delete all usage for a given subscription item.
                public var clearUsage: Bool?
                /// A flag that, if set to `true`, will delete the specified item.
                public var deleted: Bool?
                /// The coupons to redeem into discounts for the subscription item.
                public var discounts: Stripe.Clearable<[Discounts]>?
                /// Subscription item to update.
                public var id: String?
                /// Set of key-value pairs that you can attach to an object.
                public var metadata: Stripe.Clearable<[String: String]>?
                /// Plan ID for this item, as a string.
                public var plan: String?
                /// The ID of the price object.
                public var price: String?
                /// Data used to generate a new Price object inline.
                public var priceData: PriceData?
                /// Quantity for this item.
                public var quantity: Int?
                /// A list of Tax Rate ids.
                public var taxRates: Stripe.Clearable<[String]>?

                public init(
                    billingThresholds: Stripe.Clearable<BillingThresholds>? = nil,
                    clearUsage: Bool? = nil,
                    deleted: Bool? = nil,
                    discounts: Stripe.Clearable<[Discounts]>? = nil,
                    id: String? = nil,
                    metadata: Stripe.Clearable<[String: String]>? = nil,
                    plan: String? = nil,
                    price: String? = nil,
                    priceData: PriceData? = nil,
                    quantity: Int? = nil,
                    taxRates: Stripe.Clearable<[String]>? = nil
                ) {
                    self.billingThresholds = billingThresholds
                    self.clearUsage = clearUsage
                    self.deleted = deleted
                    self.discounts = discounts
                    self.id = id
                    self.metadata = metadata
                    self.plan = plan
                    self.price = price
                    self.priceData = priceData
                    self.quantity = quantity
                    self.taxRates = taxRates
                }

                public struct BillingThresholds: Codable, Hashable, Sendable {
                    /// Number of units that meets the billing threshold to advance the subscription to a new billing period (e.g., it takes.
                    public var usageGte: Int

                    public init(
                        usageGte: Int
                    ) {
                        self.usageGte = usageGte
                    }
                }

                public struct Discounts: Codable, Hashable, Sendable {
                    /// ID of the coupon to create a new discount for.
                    public var coupon: String?
                    /// ID of an existing discount on the object (or one of its ancestors) to reuse.
                    public var discount: String?
                    /// ID of the promotion code to create a new discount for.
                    public var promotionCode: String?

                    public init(
                        coupon: String? = nil,
                        discount: String? = nil,
                        promotionCode: String? = nil
                    ) {
                        self.coupon = coupon
                        self.discount = discount
                        self.promotionCode = promotionCode
                    }
                }

                /// Data used to generate a new Price object inline.
                public struct PriceData: Codable, Hashable, Sendable {
                    /// Three-letter ISO currency code, in lowercase.
                    public var currency: Stripe.Currency
                    /// The ID of the Product that this Price will belong to.
                    public var product: String
                    /// The recurring components of a price such as `interval` and `interval_count`.
                    public var recurring: Recurring
                    /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
                    public var taxBehavior: TaxBehavior?
                    /// A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
                    public var unitAmount: Int?
                    /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
                    public var unitAmountDecimal: String?

                    public init(
                        currency: Stripe.Currency,
                        product: String,
                        recurring: Recurring,
                        taxBehavior: TaxBehavior? = nil,
                        unitAmount: Int? = nil,
                        unitAmountDecimal: String? = nil
                    ) {
                        self.currency = currency
                        self.product = product
                        self.recurring = recurring
                        self.taxBehavior = taxBehavior
                        self.unitAmount = unitAmount
                        self.unitAmountDecimal = unitAmountDecimal
                    }

                    public enum TaxBehavior: String, Codable, Hashable, Sendable {
                        case exclusive
                        case inclusive
                        case unspecified
                    }

                    /// The recurring components of a price such as `interval` and `interval_count`.
                    public struct Recurring: Codable, Hashable, Sendable {
                        /// Specifies billing frequency.
                        public var interval: Interval
                        /// The number of intervals between subscription billings.
                        public var intervalCount: Int?

                        public init(
                            interval: Interval,
                            intervalCount: Int? = nil
                        ) {
                            self.interval = interval
                            self.intervalCount = intervalCount
                        }

                        public enum Interval: String, Codable, Hashable, Sendable {
                            case day
                            case month
                            case week
                            case year
                        }
                    }
                }
            }

            /// If provided, the invoice returned will preview updating or creating a subscription with that trial end.
            public enum TrialEnd: Codable, Hashable, Sendable {
                case value(Date)
                case now

                public init(from decoder: any Decoder) throws {
                    let container = try decoder.singleValueContainer()
                    if let value = try? container.decode(Date.self) {
                        self = .value(value)
                        return
                    }
                    switch try container.decode(String.self) {
                    case "now": self = .now
                    case let other: throw DecodingError.dataCorruptedError(in: container, debugDescription: "unknown keyword \(other)")
                    }
                }

                public func encode(to encoder: any Encoder) throws {
                    var container = encoder.singleValueContainer()
                    switch self {
                    case .value(let value): try container.encode(value)
                    case .now: try container.encode("now")
                    }
                }
            }
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// DELETE /v1/invoices/{invoice}
extension Stripe.Billing.Invoice.Delete {
    public typealias Response = DeletedObject<Stripe.Billing.Invoice>
}

// POST /v1/invoices/{invoice}/finalize
extension Stripe.Billing.Invoice.FinalizeInvoice {
    public struct Request: Codable, Hashable, Sendable {
        /// Controls whether Stripe performs automatic collection of the invoice.
        public var autoAdvance: Bool?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            autoAdvance: Bool? = nil,
            expand: [String]? = nil
        ) {
            self.autoAdvance = autoAdvance
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// GET /v1/invoices
extension Stripe.Billing.Invoice.List {
    public struct Request: Codable, Hashable, Sendable {
        /// The collection method of the invoice to retrieve.
        public var collectionMethod: CollectionMethod?
        /// Only return invoices that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// Only return invoices for the customer specified by this customer ID.
        public var customer: String?
        /// Only return invoices for the account representing the customer specified by this account ID.
        public var customerAccount: String?
        public var dueDate: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// The status of the invoice, one of `draft`, `open`, `paid`, `uncollectible`, or `void`.
        public var status: Status?
        /// Only return invoices for the subscription specified by this subscription ID.
        public var subscription: String?

        public init(
            collectionMethod: CollectionMethod? = nil,
            created: Stripe.RangeQuery? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            dueDate: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            status: Status? = nil,
            subscription: String? = nil
        ) {
            self.collectionMethod = collectionMethod
            self.created = created
            self.customer = customer
            self.customerAccount = customerAccount
            self.dueDate = dueDate
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
            self.status = status
            self.subscription = subscription
        }

        public enum CollectionMethod: String, Codable, Hashable, Sendable {
            case chargeAutomatically = "charge_automatically"
            case sendInvoice = "send_invoice"
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case draft
            case open
            case paid
            case uncollectible
            case void
        }
    }

    public typealias Response = Stripe.Page<Stripe.Billing.Invoice>
}

// POST /v1/invoices/{invoice}/mark_uncollectible
extension Stripe.Billing.Invoice.MarkUncollectible {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// POST /v1/invoices/{invoice}/pay
extension Stripe.Billing.Invoice.Pay {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// In cases where the source used to pay the invoice has insufficient funds, passing `forgive=true` controls whether a.
        public var forgive: Bool?
        /// ID of the mandate to be used for this invoice.
        public var mandate: String?
        /// Indicates if a customer is on or off-session while an invoice payment is attempted.
        public var offSession: Bool?
        /// Boolean representing whether an invoice is paid outside of Stripe.
        public var paidOutOfBand: Bool?
        /// A PaymentMethod to be charged.
        public var paymentMethod: String?
        /// A payment source to be charged.
        public var source: String?

        public init(
            expand: [String]? = nil,
            forgive: Bool? = nil,
            mandate: String? = nil,
            offSession: Bool? = nil,
            paidOutOfBand: Bool? = nil,
            paymentMethod: String? = nil,
            source: String? = nil
        ) {
            self.expand = expand
            self.forgive = forgive
            self.mandate = mandate
            self.offSession = offSession
            self.paidOutOfBand = paidOutOfBand
            self.paymentMethod = paymentMethod
            self.source = source
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// POST /v1/invoices/{invoice}/remove_lines
extension Stripe.Billing.Invoice.RemoveLines {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var invoiceMetadata: Stripe.Clearable<[String: String]>?
        /// The line items to remove.
        public var lines: [Lines]

        public init(
            expand: [String]? = nil,
            invoiceMetadata: Stripe.Clearable<[String: String]>? = nil,
            lines: [Lines]
        ) {
            self.expand = expand
            self.invoiceMetadata = invoiceMetadata
            self.lines = lines
        }

        public struct Lines: Codable, Hashable, Sendable {
            /// Either `delete` or `unassign`.
            public var behavior: Behavior
            /// ID of an existing line item to remove from this invoice.
            public var id: String

            public init(
                behavior: Behavior,
                id: String
            ) {
                self.behavior = behavior
                self.id = id
            }

            public enum Behavior: String, Codable, Hashable, Sendable {
                case delete
                case unassign
            }
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// GET /v1/invoices/{invoice}
extension Stripe.Billing.Invoice.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// GET /v1/invoices/search
extension Stripe.Billing.Invoice.Search {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for pagination across multiple pages of results.
        public var page: String?
        /// The search query string.
        public var query: String

        public init(
            expand: [String]? = nil,
            limit: Int? = nil,
            page: String? = nil,
            query: String
        ) {
            self.expand = expand
            self.limit = limit
            self.page = page
            self.query = query
        }
    }

    public typealias Response = Stripe.SearchPage<Stripe.Billing.Invoice>
}

// POST /v1/invoices/{invoice}/send
extension Stripe.Billing.Invoice.SendInvoice {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// POST /v1/invoices/{invoice}
extension Stripe.Billing.Invoice.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// The account tax IDs associated with the invoice.
        public var accountTaxIds: Stripe.Clearable<[String]>?
        /// A fee in cents (or local equivalent) that will be applied to the invoice and transferred to the application owner's.
        public var applicationFeeAmount: Int?
        /// Controls whether Stripe performs automatic collection of the invoice.
        public var autoAdvance: Bool?
        /// Settings for automatic tax lookup for this invoice.
        public var automaticTax: AutomaticTax?
        /// The time when this invoice should be scheduled to finalize (up to 5 years in the future).
        public var automaticallyFinalizesAt: Date?
        /// Either `charge_automatically` or `send_invoice`.
        public var collectionMethod: CollectionMethod?
        /// A list of up to 4 custom fields to be displayed on the invoice.
        public var customFields: Stripe.Clearable<[CustomFields]>?
        /// The number of days from which the invoice is created until it is due.
        public var daysUntilDue: Int?
        /// ID of the default payment method for the invoice.
        public var defaultPaymentMethod: String?
        /// ID of the default payment source for the invoice.
        public var defaultSource: String?
        /// The tax rates that will apply to any line item that does not have `tax_rates` set.
        public var defaultTaxRates: Stripe.Clearable<[String]>?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// The discounts that will apply to the invoice.
        public var discounts: Stripe.Clearable<[Discounts]>?
        /// The date on which payment for this invoice is due.
        public var dueDate: Date?
        /// The date when this invoice is in effect.
        public var effectiveAt: Stripe.Clearable<Date>?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Footer to be displayed on the invoice.
        public var footer: String?
        /// The connected account that issues the invoice.
        public var issuer: Issuer?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?
        /// Set the number for this invoice.
        public var number: String?
        /// The account (if any) for which the funds of the invoice payment are intended.
        public var onBehalfOf: String?
        /// Configuration settings for the PaymentIntent that is generated when the invoice is finalized.
        public var paymentSettings: PaymentSettings?
        /// The rendering-related settings that control how the invoice is displayed on customer-facing surfaces such as PDF and.
        public var rendering: Rendering?
        /// Settings for the cost of shipping for this invoice.
        public var shippingCost: Stripe.Clearable<ShippingCost>?
        /// Shipping details for the invoice.
        public var shippingDetails: Stripe.Clearable<ShippingDetails>?
        /// Extra information about a charge for the customer's credit card statement.
        public var statementDescriptor: String?
        /// If specified, the funds from the invoice will be transferred to the destination and the ID of the resulting transfer.
        public var transferData: Stripe.Clearable<TransferData>?

        public init(
            accountTaxIds: Stripe.Clearable<[String]>? = nil,
            applicationFeeAmount: Int? = nil,
            autoAdvance: Bool? = nil,
            automaticTax: AutomaticTax? = nil,
            automaticallyFinalizesAt: Date? = nil,
            collectionMethod: CollectionMethod? = nil,
            customFields: Stripe.Clearable<[CustomFields]>? = nil,
            daysUntilDue: Int? = nil,
            defaultPaymentMethod: String? = nil,
            defaultSource: String? = nil,
            defaultTaxRates: Stripe.Clearable<[String]>? = nil,
            description: String? = nil,
            discounts: Stripe.Clearable<[Discounts]>? = nil,
            dueDate: Date? = nil,
            effectiveAt: Stripe.Clearable<Date>? = nil,
            expand: [String]? = nil,
            footer: String? = nil,
            issuer: Issuer? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil,
            number: String? = nil,
            onBehalfOf: String? = nil,
            paymentSettings: PaymentSettings? = nil,
            rendering: Rendering? = nil,
            shippingCost: Stripe.Clearable<ShippingCost>? = nil,
            shippingDetails: Stripe.Clearable<ShippingDetails>? = nil,
            statementDescriptor: String? = nil,
            transferData: Stripe.Clearable<TransferData>? = nil
        ) {
            self.accountTaxIds = accountTaxIds
            self.applicationFeeAmount = applicationFeeAmount
            self.autoAdvance = autoAdvance
            self.automaticTax = automaticTax
            self.automaticallyFinalizesAt = automaticallyFinalizesAt
            self.collectionMethod = collectionMethod
            self.customFields = customFields
            self.daysUntilDue = daysUntilDue
            self.defaultPaymentMethod = defaultPaymentMethod
            self.defaultSource = defaultSource
            self.defaultTaxRates = defaultTaxRates
            self.description = description
            self.discounts = discounts
            self.dueDate = dueDate
            self.effectiveAt = effectiveAt
            self.expand = expand
            self.footer = footer
            self.issuer = issuer
            self.metadata = metadata
            self.number = number
            self.onBehalfOf = onBehalfOf
            self.paymentSettings = paymentSettings
            self.rendering = rendering
            self.shippingCost = shippingCost
            self.shippingDetails = shippingDetails
            self.statementDescriptor = statementDescriptor
            self.transferData = transferData
        }

        public enum CollectionMethod: String, Codable, Hashable, Sendable {
            case chargeAutomatically = "charge_automatically"
            case sendInvoice = "send_invoice"
        }

        /// Settings for automatic tax lookup for this invoice.
        public struct AutomaticTax: Codable, Hashable, Sendable {
            /// Whether Stripe automatically computes tax on this invoice.
            public var enabled: Bool
            /// The account that's liable for tax.
            public var liability: Liability?

            public init(
                enabled: Bool,
                liability: Liability? = nil
            ) {
                self.enabled = enabled
                self.liability = liability
            }

            /// The account that's liable for tax.
            public struct Liability: Codable, Hashable, Sendable {
                /// The connected account being referenced when `type` is `account`.
                public var account: String?
                /// Type of the account referenced in the request.
                public var `type`: Type

                public init(
                    account: String? = nil,
                    `type`: Type
                ) {
                    self.account = account
                    self.`type` = `type`
                }

                public enum `Type`: String, Codable, Hashable, Sendable {
                    case account
                    case `self`
                }
            }
        }

        public struct CustomFields: Codable, Hashable, Sendable {
            /// The name of the custom field.
            public var name: String
            /// The value of the custom field.
            public var value: String

            public init(
                name: String,
                value: String
            ) {
                self.name = name
                self.value = value
            }
        }

        public struct Discounts: Codable, Hashable, Sendable {
            /// ID of the coupon to create a new discount for.
            public var coupon: String?
            /// ID of an existing discount on the object (or one of its ancestors) to reuse.
            public var discount: String?
            /// ID of the promotion code to create a new discount for.
            public var promotionCode: String?

            public init(
                coupon: String? = nil,
                discount: String? = nil,
                promotionCode: String? = nil
            ) {
                self.coupon = coupon
                self.discount = discount
                self.promotionCode = promotionCode
            }
        }

        /// The connected account that issues the invoice.
        public struct Issuer: Codable, Hashable, Sendable {
            /// The connected account being referenced when `type` is `account`.
            public var account: String?
            /// Type of the account referenced in the request.
            public var `type`: Type

            public init(
                account: String? = nil,
                `type`: Type
            ) {
                self.account = account
                self.`type` = `type`
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case account
                case `self`
            }
        }

        /// Configuration settings for the PaymentIntent that is generated when the invoice is finalized.
        public struct PaymentSettings: Codable, Hashable, Sendable {
            /// ID of the mandate to be used for this invoice.
            public var defaultMandate: String?
            /// Payment-method-specific configuration to provide to the invoice’s PaymentIntent.
            public var paymentMethodOptions: PaymentMethodOptions?
            /// The list of payment method types (e.g.
            public var paymentMethodTypes: Stripe.Clearable<[PaymentMethodTypes]>?

            public init(
                defaultMandate: String? = nil,
                paymentMethodOptions: PaymentMethodOptions? = nil,
                paymentMethodTypes: Stripe.Clearable<[PaymentMethodTypes]>? = nil
            ) {
                self.defaultMandate = defaultMandate
                self.paymentMethodOptions = paymentMethodOptions
                self.paymentMethodTypes = paymentMethodTypes
            }

            public enum PaymentMethodTypes: String, Codable, Hashable, Sendable {
                case achCreditTransfer = "ach_credit_transfer"
                case achDebit = "ach_debit"
                case acssDebit = "acss_debit"
                case affirm
                case alipay
                case amazonPay = "amazon_pay"
                case auBecsDebit = "au_becs_debit"
                case bacsDebit = "bacs_debit"
                case bancontact
                case billie
                case boleto
                case card
                case cashapp
                case crypto
                case custom
                case customerBalance = "customer_balance"
                case eps
                case fpx
                case giropay
                case grabpay
                case ideal
                case jpCreditTransfer = "jp_credit_transfer"
                case kakaoPay = "kakao_pay"
                case klarna
                case konbini
                case krCard = "kr_card"
                case link
                case mbWay = "mb_way"
                case multibanco
                case naverPay = "naver_pay"
                case nzBankAccount = "nz_bank_account"
                case p24
                case payByBank = "pay_by_bank"
                case payco
                case paynow
                case paypal
                case payto
                case pix
                case promptpay
                case revolutPay = "revolut_pay"
                case satispay
                case sepaCreditTransfer = "sepa_credit_transfer"
                case sepaDebit = "sepa_debit"
                case sofort
                case swish
                case twint
                case upi
                case usBankAccount = "us_bank_account"
                case wechatPay = "wechat_pay"
            }

            /// Payment-method-specific configuration to provide to the invoice’s PaymentIntent.
            public struct PaymentMethodOptions: Codable, Hashable, Sendable {
                /// If paying by `acss_debit`, this sub-hash contains details about the Canadian pre-authorized debit payment method.
                public var acssDebit: Stripe.Clearable<AcssDebit>?
                /// If paying by `bancontact`, this sub-hash contains details about the Bancontact payment method options to pass to the.
                public var bancontact: Stripe.Clearable<Bancontact>?
                /// If paying by `billie`, this sub-hash contains details about the Billie payment method options to pass to the.
                public var billie: Stripe.Clearable<Billie>?
                /// If paying by `card`, this sub-hash contains details about the Card payment method options to pass to the invoice’s.
                public var card: Stripe.Clearable<Card>?
                /// If paying by `customer_balance`, this sub-hash contains details about the Bank transfer payment method options to.
                public var customerBalance: Stripe.Clearable<CustomerBalance>?
                /// If paying by `konbini`, this sub-hash contains details about the Konbini payment method options to pass to the.
                public var konbini: Stripe.Clearable<Konbini>?
                /// If paying by `payto`, this sub-hash contains details about the PayTo payment method options to pass to the invoice’s.
                public var payto: Stripe.Clearable<Payto>?
                /// If paying by `pix`, this sub-hash contains details about the Pix payment method options to pass to the invoice’s.
                public var pix: Stripe.Clearable<Pix>?
                /// If paying by `sepa_debit`, this sub-hash contains details about the SEPA Direct Debit payment method options to pass.
                public var sepaDebit: Stripe.Clearable<SepaDebit>?
                /// If paying by `upi`, this sub-hash contains details about the UPI payment method options to pass to the invoice’s.
                public var upi: Stripe.Clearable<Upi>?
                /// If paying by `us_bank_account`, this sub-hash contains details about the ACH direct debit payment method options to.
                public var usBankAccount: Stripe.Clearable<UsBankAccount>?

                public init(
                    acssDebit: Stripe.Clearable<AcssDebit>? = nil,
                    bancontact: Stripe.Clearable<Bancontact>? = nil,
                    billie: Stripe.Clearable<Billie>? = nil,
                    card: Stripe.Clearable<Card>? = nil,
                    customerBalance: Stripe.Clearable<CustomerBalance>? = nil,
                    konbini: Stripe.Clearable<Konbini>? = nil,
                    payto: Stripe.Clearable<Payto>? = nil,
                    pix: Stripe.Clearable<Pix>? = nil,
                    sepaDebit: Stripe.Clearable<SepaDebit>? = nil,
                    upi: Stripe.Clearable<Upi>? = nil,
                    usBankAccount: Stripe.Clearable<UsBankAccount>? = nil
                ) {
                    self.acssDebit = acssDebit
                    self.bancontact = bancontact
                    self.billie = billie
                    self.card = card
                    self.customerBalance = customerBalance
                    self.konbini = konbini
                    self.payto = payto
                    self.pix = pix
                    self.sepaDebit = sepaDebit
                    self.upi = upi
                    self.usBankAccount = usBankAccount
                }

                public struct AcssDebit: Codable, Hashable, Sendable {
                    /// Additional fields for Mandate creation.
                    public var mandateOptions: MandateOptions?
                    /// Verification method for the intent.
                    public var verificationMethod: VerificationMethod?

                    public init(
                        mandateOptions: MandateOptions? = nil,
                        verificationMethod: VerificationMethod? = nil
                    ) {
                        self.mandateOptions = mandateOptions
                        self.verificationMethod = verificationMethod
                    }

                    public enum VerificationMethod: String, Codable, Hashable, Sendable {
                        case automatic
                        case instant
                        case microdeposits
                    }

                    /// Additional fields for Mandate creation.
                    public struct MandateOptions: Codable, Hashable, Sendable {
                        /// Transaction type of the mandate.
                        public var transactionType: TransactionType?

                        public init(
                            transactionType: TransactionType? = nil
                        ) {
                            self.transactionType = transactionType
                        }

                        public enum TransactionType: String, Codable, Hashable, Sendable {
                            case business
                            case personal
                        }
                    }
                }

                public struct Bancontact: Codable, Hashable, Sendable {
                    /// Preferred language of the Bancontact authorization page that the customer is redirected to.
                    public var preferredLanguage: PreferredLanguage?

                    public init(
                        preferredLanguage: PreferredLanguage? = nil
                    ) {
                        self.preferredLanguage = preferredLanguage
                    }

                    public enum PreferredLanguage: String, Codable, Hashable, Sendable {
                        case de
                        case en
                        case fr
                        case nl
                    }
                }

                public struct Billie: Codable, Hashable, Sendable {
                    public init() {}
                }

                public struct Card: Codable, Hashable, Sendable {
                    /// Installment configuration for payments attempted on this invoice.
                    public var installments: Installments?
                    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based.
                    public var requestThreeDSecure: RequestThreeDSecure?

                    public init(
                        installments: Installments? = nil,
                        requestThreeDSecure: RequestThreeDSecure? = nil
                    ) {
                        self.installments = installments
                        self.requestThreeDSecure = requestThreeDSecure
                    }

                    public enum RequestThreeDSecure: String, Codable, Hashable, Sendable {
                        case `any`
                        case automatic
                        case challenge
                    }

                    /// Installment configuration for payments attempted on this invoice.
                    public struct Installments: Codable, Hashable, Sendable {
                        /// Setting to true enables installments for this invoice.
                        public var enabled: Bool?
                        /// The selected installment plan to use for this invoice.
                        public var plan: Stripe.Clearable<Plan>?

                        public init(
                            enabled: Bool? = nil,
                            plan: Stripe.Clearable<Plan>? = nil
                        ) {
                            self.enabled = enabled
                            self.plan = plan
                        }

                        public struct Plan: Codable, Hashable, Sendable {
                            /// For `fixed_count` installment plans, this is required.
                            public var count: Int?
                            /// For `fixed_count` installment plans, this is required.
                            public var interval: String?
                            /// Type of installment plan, one of `fixed_count`, `bonus`, or `revolving`.
                            public var `type`: Type

                            public init(
                                count: Int? = nil,
                                interval: String? = nil,
                                `type`: Type
                            ) {
                                self.count = count
                                self.interval = interval
                                self.`type` = `type`
                            }

                            public enum `Type`: String, Codable, Hashable, Sendable {
                                case bonus
                                case fixedCount = "fixed_count"
                                case revolving
                            }
                        }
                    }
                }

                public struct CustomerBalance: Codable, Hashable, Sendable {
                    /// Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
                    public var bankTransfer: BankTransfer?
                    /// The funding method type to be used when there are not enough funds in the customer balance.
                    public var fundingType: String?

                    public init(
                        bankTransfer: BankTransfer? = nil,
                        fundingType: String? = nil
                    ) {
                        self.bankTransfer = bankTransfer
                        self.fundingType = fundingType
                    }

                    /// Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
                    public struct BankTransfer: Codable, Hashable, Sendable {
                        /// Configuration for eu_bank_transfer funding type.
                        public var euBankTransfer: EuBankTransfer?
                        /// The bank transfer type that can be used for funding.
                        public var `type`: String?

                        public init(
                            euBankTransfer: EuBankTransfer? = nil,
                            `type`: String? = nil
                        ) {
                            self.euBankTransfer = euBankTransfer
                            self.`type` = `type`
                        }

                        /// Configuration for eu_bank_transfer funding type.
                        public struct EuBankTransfer: Codable, Hashable, Sendable {
                            /// The desired country code of the bank account information.
                            public var country: String

                            public init(
                                country: String
                            ) {
                                self.country = country
                            }
                        }
                    }
                }

                public struct Konbini: Codable, Hashable, Sendable {
                    public init() {}
                }

                public struct Payto: Codable, Hashable, Sendable {
                    /// Additional fields for Mandate creation.
                    public var mandateOptions: MandateOptions?

                    public init(
                        mandateOptions: MandateOptions? = nil
                    ) {
                        self.mandateOptions = mandateOptions
                    }

                    /// Additional fields for Mandate creation.
                    public struct MandateOptions: Codable, Hashable, Sendable {
                        /// The maximum amount that can be collected in a single invoice.
                        public var amount: Int?
                        /// The purpose for which payments are made.
                        public var purpose: Purpose?

                        public init(
                            amount: Int? = nil,
                            purpose: Purpose? = nil
                        ) {
                            self.amount = amount
                            self.purpose = purpose
                        }

                        public enum Purpose: String, Codable, Hashable, Sendable {
                            case dependantSupport = "dependant_support"
                            case government
                            case loan
                            case mortgage
                            case other
                            case pension
                            case personal
                            case retail
                            case salary
                            case tax
                            case utility
                        }
                    }
                }

                public struct Pix: Codable, Hashable, Sendable {
                    /// Determines if the amount includes the IOF tax.
                    public var amountIncludesIof: AmountIncludesIof?
                    /// The number of seconds (between 10 and 1209600) after which Pix payment will expire.
                    public var expiresAfterSeconds: Int?

                    public init(
                        amountIncludesIof: AmountIncludesIof? = nil,
                        expiresAfterSeconds: Int? = nil
                    ) {
                        self.amountIncludesIof = amountIncludesIof
                        self.expiresAfterSeconds = expiresAfterSeconds
                    }

                    public enum AmountIncludesIof: String, Codable, Hashable, Sendable {
                        case always
                        case never
                    }
                }

                public struct SepaDebit: Codable, Hashable, Sendable {
                    public init() {}
                }

                public struct Upi: Codable, Hashable, Sendable {
                    /// Configuration options for setting up an eMandate.
                    public var mandateOptions: MandateOptions?

                    public init(
                        mandateOptions: MandateOptions? = nil
                    ) {
                        self.mandateOptions = mandateOptions
                    }

                    /// Configuration options for setting up an eMandate.
                    public struct MandateOptions: Codable, Hashable, Sendable {
                        /// Amount to be charged for future payments.
                        public var amount: Int?
                        /// One of `fixed` or `maximum`.
                        public var amountType: AmountType?
                        /// A description of the mandate or subscription that is meant to be displayed to the customer.
                        public var description: String?
                        /// End date of the mandate or subscription.
                        public var endDate: Date?

                        public init(
                            amount: Int? = nil,
                            amountType: AmountType? = nil,
                            description: String? = nil,
                            endDate: Date? = nil
                        ) {
                            self.amount = amount
                            self.amountType = amountType
                            self.description = description
                            self.endDate = endDate
                        }

                        public enum AmountType: String, Codable, Hashable, Sendable {
                            case fixed
                            case maximum
                        }
                    }
                }

                public struct UsBankAccount: Codable, Hashable, Sendable {
                    /// Additional fields for Financial Connections Session creation.
                    public var financialConnections: FinancialConnections?
                    /// Verification method for the intent.
                    public var verificationMethod: VerificationMethod?

                    public init(
                        financialConnections: FinancialConnections? = nil,
                        verificationMethod: VerificationMethod? = nil
                    ) {
                        self.financialConnections = financialConnections
                        self.verificationMethod = verificationMethod
                    }

                    public enum VerificationMethod: String, Codable, Hashable, Sendable {
                        case automatic
                        case instant
                        case microdeposits
                    }

                    /// Additional fields for Financial Connections Session creation.
                    public struct FinancialConnections: Codable, Hashable, Sendable {
                        /// Provide filters for the linked accounts that the customer can select for the payment method.
                        public var filters: Filters?
                        /// The list of permissions to request.
                        public var permissions: [Permissions]?
                        /// List of data features that you would like to retrieve upon account creation.
                        public var prefetch: [Prefetch]?

                        public init(
                            filters: Filters? = nil,
                            permissions: [Permissions]? = nil,
                            prefetch: [Prefetch]? = nil
                        ) {
                            self.filters = filters
                            self.permissions = permissions
                            self.prefetch = prefetch
                        }

                        public enum Permissions: String, Codable, Hashable, Sendable {
                            case balances
                            case ownership
                            case paymentMethod = "payment_method"
                            case transactions
                        }

                        public enum Prefetch: String, Codable, Hashable, Sendable {
                            case balances
                            case ownership
                            case transactions
                        }

                        /// Provide filters for the linked accounts that the customer can select for the payment method.
                        public struct Filters: Codable, Hashable, Sendable {
                            /// The account subcategories to use to filter for selectable accounts.
                            public var accountSubcategories: [AccountSubcategories]?

                            public init(
                                accountSubcategories: [AccountSubcategories]? = nil
                            ) {
                                self.accountSubcategories = accountSubcategories
                            }

                            public enum AccountSubcategories: String, Codable, Hashable, Sendable {
                                case checking
                                case savings
                            }
                        }
                    }
                }
            }
        }

        /// The rendering-related settings that control how the invoice is displayed on customer-facing surfaces such as PDF and.
        public struct Rendering: Codable, Hashable, Sendable {
            /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
            public var amountTaxDisplay: AmountTaxDisplay?
            /// Invoice pdf rendering options.
            public var pdf: Pdf?
            /// ID of the invoice rendering template to use for this invoice.
            public var template: String?
            /// The specific version of invoice rendering template to use for this invoice.
            public var templateVersion: Stripe.Clearable<Int>?

            public init(
                amountTaxDisplay: AmountTaxDisplay? = nil,
                pdf: Pdf? = nil,
                template: String? = nil,
                templateVersion: Stripe.Clearable<Int>? = nil
            ) {
                self.amountTaxDisplay = amountTaxDisplay
                self.pdf = pdf
                self.template = template
                self.templateVersion = templateVersion
            }

            public enum AmountTaxDisplay: String, Codable, Hashable, Sendable {
                case value = ""
                case excludeTax = "exclude_tax"
                case includeInclusiveTax = "include_inclusive_tax"
            }

            /// Invoice pdf rendering options.
            public struct Pdf: Codable, Hashable, Sendable {
                /// Page size for invoice PDF.
                public var pageSize: PageSize?

                public init(
                    pageSize: PageSize? = nil
                ) {
                    self.pageSize = pageSize
                }

                public enum PageSize: String, Codable, Hashable, Sendable {
                    case a4
                    case auto
                    case letter
                }
            }
        }

        public struct ShippingCost: Codable, Hashable, Sendable {
            /// The ID of the shipping rate to use for this order.
            public var shippingRate: String?
            /// Parameters to create a new ad-hoc shipping rate for this order.
            public var shippingRateData: ShippingRateData?

            public init(
                shippingRate: String? = nil,
                shippingRateData: ShippingRateData? = nil
            ) {
                self.shippingRate = shippingRate
                self.shippingRateData = shippingRateData
            }

            /// Parameters to create a new ad-hoc shipping rate for this order.
            public struct ShippingRateData: Codable, Hashable, Sendable {
                /// The estimated range for how long shipping will take, meant to be displayable to the customer.
                public var deliveryEstimate: DeliveryEstimate?
                /// The name of the shipping rate, meant to be displayable to the customer.
                public var displayName: String
                /// Describes a fixed amount to charge for shipping.
                public var fixedAmount: FixedAmount?
                /// Set of key-value pairs that you can attach to an object.
                public var metadata: [String: String]?
                /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes.
                public var taxBehavior: TaxBehavior?
                /// A tax code ID.
                public var taxCode: String?
                /// The type of calculation to use on the shipping rate.
                public var `type`: String?

                public init(
                    deliveryEstimate: DeliveryEstimate? = nil,
                    displayName: String,
                    fixedAmount: FixedAmount? = nil,
                    metadata: [String: String]? = nil,
                    taxBehavior: TaxBehavior? = nil,
                    taxCode: String? = nil,
                    `type`: String? = nil
                ) {
                    self.deliveryEstimate = deliveryEstimate
                    self.displayName = displayName
                    self.fixedAmount = fixedAmount
                    self.metadata = metadata
                    self.taxBehavior = taxBehavior
                    self.taxCode = taxCode
                    self.`type` = `type`
                }

                public enum TaxBehavior: String, Codable, Hashable, Sendable {
                    case exclusive
                    case inclusive
                    case unspecified
                }

                /// The estimated range for how long shipping will take, meant to be displayable to the customer.
                public struct DeliveryEstimate: Codable, Hashable, Sendable {
                    /// The upper bound of the estimated range.
                    public var maximum: Maximum?
                    /// The lower bound of the estimated range.
                    public var minimum: Minimum?

                    public init(
                        maximum: Maximum? = nil,
                        minimum: Minimum? = nil
                    ) {
                        self.maximum = maximum
                        self.minimum = minimum
                    }

                    /// The upper bound of the estimated range.
                    public struct Maximum: Codable, Hashable, Sendable {
                        /// A unit of time.
                        public var unit: Unit
                        /// Must be greater than 0.
                        public var value: Int

                        public init(
                            unit: Unit,
                            value: Int
                        ) {
                            self.unit = unit
                            self.value = value
                        }

                        public enum Unit: String, Codable, Hashable, Sendable {
                            case businessDay = "business_day"
                            case day
                            case hour
                            case month
                            case week
                        }
                    }

                    /// The lower bound of the estimated range.
                    public struct Minimum: Codable, Hashable, Sendable {
                        /// A unit of time.
                        public var unit: Unit
                        /// Must be greater than 0.
                        public var value: Int

                        public init(
                            unit: Unit,
                            value: Int
                        ) {
                            self.unit = unit
                            self.value = value
                        }

                        public enum Unit: String, Codable, Hashable, Sendable {
                            case businessDay = "business_day"
                            case day
                            case hour
                            case month
                            case week
                        }
                    }
                }

                /// Describes a fixed amount to charge for shipping.
                public struct FixedAmount: Codable, Hashable, Sendable {
                    /// A non-negative integer in cents representing how much to charge.
                    public var amount: Int
                    /// Three-letter ISO currency code, in lowercase.
                    public var currency: Stripe.Currency
                    /// Shipping rates defined in each available currency option.
                    public var currencyOptions: [String: CurrencyOptions]?

                    public init(
                        amount: Int,
                        currency: Stripe.Currency,
                        currencyOptions: [String: CurrencyOptions]? = nil
                    ) {
                        self.amount = amount
                        self.currency = currency
                        self.currencyOptions = currencyOptions
                    }

                    public struct CurrencyOptions: Codable, Hashable, Sendable {
                        /// A non-negative integer in cents representing how much to charge.
                        public var amount: Int
                        /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes.
                        public var taxBehavior: TaxBehavior?

                        public init(
                            amount: Int,
                            taxBehavior: TaxBehavior? = nil
                        ) {
                            self.amount = amount
                            self.taxBehavior = taxBehavior
                        }

                        public enum TaxBehavior: String, Codable, Hashable, Sendable {
                            case exclusive
                            case inclusive
                            case unspecified
                        }
                    }
                }
            }
        }

        public struct ShippingDetails: Codable, Hashable, Sendable {
            /// Shipping address.
            public var address: Address
            /// Recipient name.
            public var name: String
            /// Recipient phone (including extension).
            public var phone: String?

            public init(
                address: Address,
                name: String,
                phone: String? = nil
            ) {
                self.address = address
                self.name = name
                self.phone = phone
            }

            /// Shipping address.
            public struct Address: Codable, Hashable, Sendable {
                /// City, district, suburb, town, or village.
                public var city: String?
                /// Two-letter country code (ISO 3166-1 alpha-2).
                public var country: String?
                /// Address line 1, such as the street, PO Box, or company name.
                public var line1: String?
                /// Address line 2, such as the apartment, suite, unit, or building.
                public var line2: String?
                /// ZIP or postal code.
                public var postalCode: String?
                /// State, county, province, or region (ISO 3166-2).
                public var state: String?

                public init(
                    city: String? = nil,
                    country: String? = nil,
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

        public struct TransferData: Codable, Hashable, Sendable {
            /// The amount that will be transferred automatically when the invoice is paid.
            public var amount: Int?
            /// ID of an existing, connected Stripe account.
            public var destination: String

            public init(
                amount: Int? = nil,
                destination: String
            ) {
                self.amount = amount
                self.destination = destination
            }
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// POST /v1/invoices/{invoice}/update_lines
extension Stripe.Billing.Invoice.UpdateLines {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var invoiceMetadata: Stripe.Clearable<[String: String]>?
        /// The line items to update.
        public var lines: [Lines]

        public init(
            expand: [String]? = nil,
            invoiceMetadata: Stripe.Clearable<[String: String]>? = nil,
            lines: [Lines]
        ) {
            self.expand = expand
            self.invoiceMetadata = invoiceMetadata
            self.lines = lines
        }

        public struct Lines: Codable, Hashable, Sendable {
            /// The integer amount in cents (or local equivalent) of the charge to be applied to the upcoming invoice.
            public var amount: Int?
            /// An arbitrary string which you can attach to the invoice item.
            public var description: String?
            /// Controls whether discounts apply to this line item.
            public var discountable: Bool?
            /// The coupons, promotion codes & existing discounts which apply to the line item.
            public var discounts: Stripe.Clearable<[Discounts]>?
            /// ID of an existing line item on the invoice.
            public var id: String
            /// Set of key-value pairs that you can attach to an object.
            public var metadata: Stripe.Clearable<[String: String]>?
            /// The period associated with this invoice item.
            public var period: Period?
            /// Data used to generate a new Price object inline.
            public var priceData: PriceData?
            /// The pricing information for the invoice item.
            public var pricing: Pricing?
            /// Non-negative integer.
            public var quantity: Int?
            /// Non-negative decimal with at most 12 decimal places.
            public var quantityDecimal: String?
            /// A list of up to 20 tax amounts for this line item.
            public var taxAmounts: Stripe.Clearable<[TaxAmounts]>?
            /// The tax rates which apply to the line item.
            public var taxRates: Stripe.Clearable<[String]>?

            public init(
                amount: Int? = nil,
                description: String? = nil,
                discountable: Bool? = nil,
                discounts: Stripe.Clearable<[Discounts]>? = nil,
                id: String,
                metadata: Stripe.Clearable<[String: String]>? = nil,
                period: Period? = nil,
                priceData: PriceData? = nil,
                pricing: Pricing? = nil,
                quantity: Int? = nil,
                quantityDecimal: String? = nil,
                taxAmounts: Stripe.Clearable<[TaxAmounts]>? = nil,
                taxRates: Stripe.Clearable<[String]>? = nil
            ) {
                self.amount = amount
                self.description = description
                self.discountable = discountable
                self.discounts = discounts
                self.id = id
                self.metadata = metadata
                self.period = period
                self.priceData = priceData
                self.pricing = pricing
                self.quantity = quantity
                self.quantityDecimal = quantityDecimal
                self.taxAmounts = taxAmounts
                self.taxRates = taxRates
            }

            public struct Discounts: Codable, Hashable, Sendable {
                /// ID of the coupon to create a new discount for.
                public var coupon: String?
                /// ID of an existing discount on the object (or one of its ancestors) to reuse.
                public var discount: String?
                /// ID of the promotion code to create a new discount for.
                public var promotionCode: String?

                public init(
                    coupon: String? = nil,
                    discount: String? = nil,
                    promotionCode: String? = nil
                ) {
                    self.coupon = coupon
                    self.discount = discount
                    self.promotionCode = promotionCode
                }
            }

            /// The period associated with this invoice item.
            public struct Period: Codable, Hashable, Sendable {
                /// The end of the period, which must be greater than or equal to the start.
                public var end: Date
                /// The start of the period.
                public var start: Date

                public init(
                    end: Date,
                    start: Date
                ) {
                    self.end = end
                    self.start = start
                }
            }

            /// Data used to generate a new Price object inline.
            public struct PriceData: Codable, Hashable, Sendable {
                /// Three-letter ISO currency code, in lowercase.
                public var currency: Stripe.Currency
                /// The ID of the Product that this Price will belong to.
                public var product: String?
                /// Data used to generate a new Product object inline.
                public var productData: ProductData?
                /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
                public var taxBehavior: TaxBehavior?
                /// A non-negative integer in cents (or local equivalent) representing how much to charge.
                public var unitAmount: Int?
                /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
                public var unitAmountDecimal: String?

                public init(
                    currency: Stripe.Currency,
                    product: String? = nil,
                    productData: ProductData? = nil,
                    taxBehavior: TaxBehavior? = nil,
                    unitAmount: Int? = nil,
                    unitAmountDecimal: String? = nil
                ) {
                    self.currency = currency
                    self.product = product
                    self.productData = productData
                    self.taxBehavior = taxBehavior
                    self.unitAmount = unitAmount
                    self.unitAmountDecimal = unitAmountDecimal
                }

                public enum TaxBehavior: String, Codable, Hashable, Sendable {
                    case exclusive
                    case inclusive
                    case unspecified
                }

                /// Data used to generate a new Product object inline.
                public struct ProductData: Codable, Hashable, Sendable {
                    /// The product's description, meant to be displayable to the customer.
                    public var description: String?
                    /// A list of up to 8 URLs of images for this product, meant to be displayable to the customer.
                    public var images: [String]?
                    /// Set of key-value pairs that you can attach to an object.
                    public var metadata: [String: String]?
                    /// The product's name, meant to be displayable to the customer.
                    public var name: String
                    /// A tax code ID.
                    public var taxCode: String?
                    /// A label that represents units of this product.
                    public var unitLabel: String?

                    public init(
                        description: String? = nil,
                        images: [String]? = nil,
                        metadata: [String: String]? = nil,
                        name: String,
                        taxCode: String? = nil,
                        unitLabel: String? = nil
                    ) {
                        self.description = description
                        self.images = images
                        self.metadata = metadata
                        self.name = name
                        self.taxCode = taxCode
                        self.unitLabel = unitLabel
                    }
                }
            }

            /// The pricing information for the invoice item.
            public struct Pricing: Codable, Hashable, Sendable {
                /// The ID of the price object.
                public var price: String?

                public init(
                    price: String? = nil
                ) {
                    self.price = price
                }
            }

            public struct TaxAmounts: Codable, Hashable, Sendable {
                /// The amount, in cents (or local equivalent), of the tax.
                public var amount: Int
                /// Data to find or create a TaxRate object.
                public var taxRateData: TaxRateData
                /// The reasoning behind this tax, for example, if the product is tax exempt.
                public var taxabilityReason: TaxabilityReason?
                /// The amount on which tax is calculated, in cents (or local equivalent).
                public var taxableAmount: Int

                public init(
                    amount: Int,
                    taxRateData: TaxRateData,
                    taxabilityReason: TaxabilityReason? = nil,
                    taxableAmount: Int
                ) {
                    self.amount = amount
                    self.taxRateData = taxRateData
                    self.taxabilityReason = taxabilityReason
                    self.taxableAmount = taxableAmount
                }

                public enum TaxabilityReason: String, Codable, Hashable, Sendable {
                    case customerExempt = "customer_exempt"
                    case notCollecting = "not_collecting"
                    case notSubjectToTax = "not_subject_to_tax"
                    case notSupported = "not_supported"
                    case portionProductExempt = "portion_product_exempt"
                    case portionReducedRated = "portion_reduced_rated"
                    case portionStandardRated = "portion_standard_rated"
                    case productExempt = "product_exempt"
                    case productExemptHoliday = "product_exempt_holiday"
                    case proportionallyRated = "proportionally_rated"
                    case reducedRated = "reduced_rated"
                    case reverseCharge = "reverse_charge"
                    case standardRated = "standard_rated"
                    case taxableBasisReduced = "taxable_basis_reduced"
                    case zeroRated = "zero_rated"
                }

                /// Data to find or create a TaxRate object.
                public struct TaxRateData: Codable, Hashable, Sendable {
                    /// Two-letter country code (ISO 3166-1 alpha-2).
                    public var country: String?
                    /// An arbitrary string attached to the tax rate for your internal use only.
                    public var description: String?
                    /// The display name of the tax rate, which will be shown to users.
                    public var displayName: String
                    /// This specifies if the tax rate is inclusive or exclusive.
                    public var inclusive: Bool
                    /// The jurisdiction for the tax rate.
                    public var jurisdiction: String?
                    /// The level of the jurisdiction that imposes this tax rate.
                    public var jurisdictionLevel: JurisdictionLevel?
                    /// The statutory tax rate percent.
                    public var percentage: Decimal
                    /// ISO 3166-2 subdivision code, without country prefix.
                    public var state: String?
                    /// The high-level tax type, such as `vat` or `sales_tax`.
                    public var taxType: TaxType?

                    public init(
                        country: String? = nil,
                        description: String? = nil,
                        displayName: String,
                        inclusive: Bool,
                        jurisdiction: String? = nil,
                        jurisdictionLevel: JurisdictionLevel? = nil,
                        percentage: Decimal,
                        state: String? = nil,
                        taxType: TaxType? = nil
                    ) {
                        self.country = country
                        self.description = description
                        self.displayName = displayName
                        self.inclusive = inclusive
                        self.jurisdiction = jurisdiction
                        self.jurisdictionLevel = jurisdictionLevel
                        self.percentage = percentage
                        self.state = state
                        self.taxType = taxType
                    }

                    public enum JurisdictionLevel: String, Codable, Hashable, Sendable {
                        case city
                        case country
                        case county
                        case district
                        case multiple
                        case state
                    }

                    public enum TaxType: String, Codable, Hashable, Sendable {
                        case amusementTax = "amusement_tax"
                        case communicationsTax = "communications_tax"
                        case gst
                        case hst
                        case igst
                        case jct
                        case leaseTax = "lease_tax"
                        case massTransitParkingTax = "mass_transit_parking_tax"
                        case parkingTax = "parking_tax"
                        case pst
                        case qst
                        case retailDeliveryFee = "retail_delivery_fee"
                        case rst
                        case salesTax = "sales_tax"
                        case serviceTax = "service_tax"
                        case vat
                    }
                }
            }
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}

// POST /v1/invoices/{invoice}/void
extension Stripe.Billing.Invoice.VoidInvoice {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Invoice
}
