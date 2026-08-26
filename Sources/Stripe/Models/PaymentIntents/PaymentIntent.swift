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

extension Stripe.PaymentIntents {
    /// A PaymentIntent guides you through the process of collecting a payment from your customer.
    public struct PaymentIntent: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The list of payment method types allowed for use with this payment.
        public var allowedPaymentMethodTypes: [AllowedPaymentMethodTypes]?
        /// Amount intended to be collected by this PaymentIntent.
        public var amount: Int?
        /// Amount that can be captured from this PaymentIntent.
        public var amountCapturable: Int?
        public var amountDetails: AmountDetails?
        /// Amount that this PaymentIntent collects.
        public var amountReceived: Int?
        /// ID of the Connect application that created the PaymentIntent.
        @Expandable<Stripe.Shared.Application, String> public var application: String?
        /// The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the.
        public var applicationFeeAmount: Int?
        /// Settings to configure compatible payment methods from the Stripe Dashboard.
        public var automaticPaymentMethods: AutomaticPaymentMethods?
        /// Populated when `status` is `canceled`, this is the time at which the PaymentIntent was canceled.
        public var canceledAt: Date?
        /// Reason for cancellation of this PaymentIntent, either user-provided (`duplicate`, `fraudulent`.
        public var cancellationReason: CancellationReason?
        /// Controls when the funds will be captured from the customer's account.
        public var captureMethod: CaptureMethod?
        /// The client secret of this PaymentIntent.
        public var clientSecret: String?
        /// Describes whether we can confirm this PaymentIntent automatically, or if it requires customer action to confirm the.
        public var confirmationMethod: ConfirmationMethod?
        /// Time at which the object was created.
        public var created: Date?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// ID of the Customer this PaymentIntent belongs to, if one exists.
        @Expandable<Stripe.Customers.Customer, String> public var customer: String?
        /// ID of the Account representing the customer that this PaymentIntent belongs to, if one exists.
        public var customerAccount: String?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// The list of payment method types to exclude from use with this payment.
        public var excludedPaymentMethodTypes: [ExcludedPaymentMethodTypes]?
        public var hooks: Hooks?
        /// The payment error encountered in the previous PaymentIntent confirmation.
        public var lastPaymentError: Stripe.Shared.ApiErrors?
        /// ID of the latest Charge object created by this PaymentIntent.
        @Expandable<Stripe.Charges.Charge, String> public var latestCharge: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Settings for Managed Payments.
        public var managedPayments: Stripe.Shared.SmorResourceManagedPayments?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// If present, this property tells you what actions you need to take in order for your customer to fulfill a payment.
        public var nextAction: NextAction?
        /// You can specify the settlement merchant as the connected account using the `on_behalf_of` attribute on the charge.
        @Expandable<Stripe.Connect.Account, String> public var onBehalfOf: String?
        public var paymentDetails: PaymentDetails?
        /// ID of the payment method used in this PaymentIntent.
        @Expandable<Stripe.PaymentMethods.PaymentMethod, String> public var paymentMethod: String?
        /// Information about the payment method configuration used for this PaymentIntent.
        public var paymentMethodConfigurationDetails: Stripe.Shared.PaymentMethodConfigurationDetails?
        /// Payment-method-specific configuration for this PaymentIntent.
        public var paymentMethodOptions: PaymentMethodOptions?
        /// The list of payment method types (e.g.
        public var paymentMethodTypes: [String]?
        public var presentmentDetails: Stripe.Shared.PresentmentDetails?
        /// If present, this property tells you about the processing state of the payment.
        public var processing: Processing?
        /// Email address that the receipt for the resulting payment will be sent to.
        public var receiptEmail: String?
        /// ID of the review associated with this PaymentIntent, if any.
        @Expandable<Stripe.Fraud.Reviews.Review, String> public var review: String?
        /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
        public var setupFutureUsage: SetupFutureUsage?
        /// Shipping information for this PaymentIntent.
        public var shipping: ShippingLabel?
        /// This is a legacy field that will be removed in the future.
        @Expandable<Stripe.PaymentSource, String> public var source: String?
        /// Text that appears on the customer's statement as the statement descriptor for a non-card charge.
        public var statementDescriptor: String?
        /// Provides information about a card charge.
        public var statementDescriptorSuffix: String?
        /// Status of this PaymentIntent, one of `requires_payment_method`, `requires_confirmation`, `requires_action`.
        public var status: Status?
        /// The data that automatically creates a Transfer after the payment finalizes.
        public var transferData: TransferData?
        /// A string that identifies the resulting payment as part of a group.
        public var transferGroup: String?

        public init(
            id: ID,
            object: String,
            allowedPaymentMethodTypes: [AllowedPaymentMethodTypes]? = nil,
            amount: Int? = nil,
            amountCapturable: Int? = nil,
            amountDetails: AmountDetails? = nil,
            amountReceived: Int? = nil,
            application: String? = nil,
            applicationFeeAmount: Int? = nil,
            automaticPaymentMethods: AutomaticPaymentMethods? = nil,
            canceledAt: Date? = nil,
            cancellationReason: CancellationReason? = nil,
            captureMethod: CaptureMethod? = nil,
            clientSecret: String? = nil,
            confirmationMethod: ConfirmationMethod? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            description: String? = nil,
            excludedPaymentMethodTypes: [ExcludedPaymentMethodTypes]? = nil,
            hooks: Hooks? = nil,
            lastPaymentError: Stripe.Shared.ApiErrors? = nil,
            latestCharge: String? = nil,
            livemode: Bool? = nil,
            managedPayments: Stripe.Shared.SmorResourceManagedPayments? = nil,
            metadata: [String: String]? = nil,
            nextAction: NextAction? = nil,
            onBehalfOf: String? = nil,
            paymentDetails: PaymentDetails? = nil,
            paymentMethod: String? = nil,
            paymentMethodConfigurationDetails: Stripe.Shared.PaymentMethodConfigurationDetails? = nil,
            paymentMethodOptions: PaymentMethodOptions? = nil,
            paymentMethodTypes: [String]? = nil,
            presentmentDetails: Stripe.Shared.PresentmentDetails? = nil,
            processing: Processing? = nil,
            receiptEmail: String? = nil,
            review: String? = nil,
            setupFutureUsage: SetupFutureUsage? = nil,
            shipping: ShippingLabel? = nil,
            source: String? = nil,
            statementDescriptor: String? = nil,
            statementDescriptorSuffix: String? = nil,
            status: Status? = nil,
            transferData: TransferData? = nil,
            transferGroup: String? = nil
        ) {
            self.id = id
            self.object = object
            self.allowedPaymentMethodTypes = allowedPaymentMethodTypes
            self.amount = amount
            self.amountCapturable = amountCapturable
            self.amountDetails = amountDetails
            self.amountReceived = amountReceived
            self._application = Expandable(id: application)
            self.applicationFeeAmount = applicationFeeAmount
            self.automaticPaymentMethods = automaticPaymentMethods
            self.canceledAt = canceledAt
            self.cancellationReason = cancellationReason
            self.captureMethod = captureMethod
            self.clientSecret = clientSecret
            self.confirmationMethod = confirmationMethod
            self.created = created
            self.currency = currency
            self._customer = Expandable(id: customer)
            self.customerAccount = customerAccount
            self.description = description
            self.excludedPaymentMethodTypes = excludedPaymentMethodTypes
            self.hooks = hooks
            self.lastPaymentError = lastPaymentError
            self._latestCharge = Expandable(id: latestCharge)
            self.livemode = livemode
            self.managedPayments = managedPayments
            self.metadata = metadata
            self.nextAction = nextAction
            self._onBehalfOf = Expandable(id: onBehalfOf)
            self.paymentDetails = paymentDetails
            self._paymentMethod = Expandable(id: paymentMethod)
            self.paymentMethodConfigurationDetails = paymentMethodConfigurationDetails
            self.paymentMethodOptions = paymentMethodOptions
            self.paymentMethodTypes = paymentMethodTypes
            self.presentmentDetails = presentmentDetails
            self.processing = processing
            self.receiptEmail = receiptEmail
            self._review = Expandable(id: review)
            self.setupFutureUsage = setupFutureUsage
            self.shipping = shipping
            self._source = Expandable(id: source)
            self.statementDescriptor = statementDescriptor
            self.statementDescriptorSuffix = statementDescriptorSuffix
            self.status = status
            self.transferData = transferData
            self.transferGroup = transferGroup
        }

        public enum AllowedPaymentMethodTypes: String, Codable, Hashable, Sendable {
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
            case bokuPromptpay = "boku_promptpay"
            case boleto
            case capchasePay = "capchase_pay"
            case card
            case cashapp
            case checkScan = "check_scan"
            case clickToPay = "click_to_pay"
            case crypto
            case customerBalance = "customer_balance"
            case demoPay = "demo_pay"
            case duitnow
            case dummyAuthPush = "dummy_auth_push"
            case dummyPassthroughCard = "dummy_passthrough_card"
            case edenred
            case eps
            case fpx
            case gcash
            case getbalance
            case giftCard = "gift_card"
            case giropay
            case gopay
            case grabpay
            case idBankTransfer = "id_bank_transfer"
            case ideal
            case kakaoPay = "kakao_pay"
            case klarna
            case knet
            case konbini
            case krCard = "kr_card"
            case krMarket = "kr_market"
            case kriya
            case link
            case mbWay = "mb_way"
            case mobilepay
            case momo
            case mondu
            case multibanco
            case naverPay = "naver_pay"
            case netbanking
            case ngBank = "ng_bank"
            case ngBankTransfer = "ng_bank_transfer"
            case ngCard = "ng_card"
            case ngMarket = "ng_market"
            case ngUssd = "ng_ussd"
            case ngWallet = "ng_wallet"
            case nzBankAccount = "nz_bank_account"
            case octopus
            case oxxo
            case p24
            case paperCheck = "paper_check"
            case payByBank = "pay_by_bank"
            case payco
            case paynow
            case paypal
            case paypay
            case payto
            case pix
            case promptpay
            case qris
            case rechnung
            case revolutPay = "revolut_pay"
            case samsungPay = "samsung_pay"
            case satispay
            case scalapay
            case sepaDebit = "sepa_debit"
            case sequra
            case shopPay = "shop_pay"
            case shopeepay
            case sofort
            case southKoreaMarket = "south_korea_market"
            case stripeBalance = "stripe_balance"
            case sunbit
            case swish
            case tamara
            case testPay = "test_pay"
            case truemoney
            case twint
            case upi
            case usBankAccount = "us_bank_account"
            case usCashVoucher = "us_cash_voucher"
            case vipps
            case wechatPay = "wechat_pay"
            case wero
            case zip
        }

        /// Reason for cancellation of this PaymentIntent, either user-provided (`duplicate`, `fraudulent`.
        public enum CancellationReason: String, Codable, Hashable, Sendable {
            case abandoned
            case automatic
            case duplicate
            case expired
            case failedInvoice = "failed_invoice"
            case fraudulent
            case requestedByCustomer = "requested_by_customer"
            case voidInvoice = "void_invoice"
        }

        /// Controls when the funds will be captured from the customer's account.
        public enum CaptureMethod: String, Codable, Hashable, Sendable {
            case automatic
            case automaticAsync = "automatic_async"
            case manual
        }

        /// Describes whether we can confirm this PaymentIntent automatically, or if it requires customer action to confirm the.
        public enum ConfirmationMethod: String, Codable, Hashable, Sendable {
            case automatic
            case manual
        }

        public enum ExcludedPaymentMethodTypes: String, Codable, Hashable, Sendable {
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
            case cashapp
            case crypto
            case customerBalance = "customer_balance"
            case eps
            case fpx
            case giropay
            case grabpay
            case ideal
            case kakaoPay = "kakao_pay"
            case klarna
            case konbini
            case krCard = "kr_card"
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

        /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
        public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
            case offSession = "off_session"
            case onSession = "on_session"
        }

        /// Status of this PaymentIntent, one of `requires_payment_method`, `requires_confirmation`, `requires_action`.
        public enum Status: String, Codable, Hashable, Sendable {
            case canceled
            case processing
            case requiresAction = "requires_action"
            case requiresCapture = "requires_capture"
            case requiresConfirmation = "requires_confirmation"
            case requiresPaymentMethod = "requires_payment_method"
            case succeeded
        }

        public struct AmountDetails: Codable, Hashable, Sendable {
            /// The total discount applied on the transaction represented in the smallest currency unit.
            public var discountAmount: Int?
            public var error: Error?
            /// A list of line items, each containing information about a product in the PaymentIntent.
            public var lineItems: LineItems?
            public var shipping: Shipping?
            public var tax: Tax?
            public var tip: Tip?

            public init(
                discountAmount: Int? = nil,
                error: Error? = nil,
                lineItems: LineItems? = nil,
                shipping: Shipping? = nil,
                tax: Tax? = nil,
                tip: Tip? = nil
            ) {
                self.discountAmount = discountAmount
                self.error = error
                self.lineItems = lineItems
                self.shipping = shipping
                self.tax = tax
                self.tip = tip
            }

            public struct Error: Codable, Hashable, Sendable {
                /// The code of the error that occurred when validating the current amount details.
                public var code: Code?
                /// A message providing more details about the error.
                public var message: String?

                public init(
                    code: Code? = nil,
                    message: String? = nil
                ) {
                    self.code = code
                    self.message = message
                }

                /// The code of the error that occurred when validating the current amount details.
                public enum Code: String, Codable, Hashable, Sendable {
                    case amountDetailsAmountMismatch = "amount_details_amount_mismatch"
                    case amountDetailsTaxShippingDiscountGreaterThanAmount = "amount_details_tax_shipping_discount_greater_than_amount"
                }
            }

            /// A list of line items, each containing information about a product in the PaymentIntent.
            public struct LineItems: Codable, Hashable, Sendable {
                /// String representing the object's type.
                public let object: String
                /// Details about each object.
                public var data: [Data]?
                /// True if this list has another page of items after this one that can be fetched.
                public var hasMore: Bool?
                /// The URL where this list can be accessed.
                public var url: String?

                public init(
                    object: String,
                    data: [Data]? = nil,
                    hasMore: Bool? = nil,
                    url: String? = nil
                ) {
                    self.object = object
                    self.data = data
                    self.hasMore = hasMore
                    self.url = url
                }

                public struct Data: Codable, Hashable, Sendable, Identifiable {
                    public typealias ID = String
                    public let id: ID
                    /// String representing the object's type.
                    public let object: String
                    /// The discount applied on this line item represented in the smallest currency unit.
                    public var discountAmount: Int?
                    /// Payment method-specific information for line items.
                    public var paymentMethodOptions: PaymentMethodOptions?
                    /// The product code of the line item, such as an SKU.
                    public var productCode: String?
                    /// The product name of the line item.
                    public var productName: String?
                    /// The quantity of items.
                    public var quantity: Int?
                    /// Contains information about the tax on the item.
                    public var tax: Tax?
                    /// The unit cost of the line item represented in the smallest currency unit.
                    public var unitCost: Int?
                    /// A unit of measure for the line item, such as gallons, feet, meters, etc.
                    public var unitOfMeasure: String?

                    public init(
                        id: ID,
                        object: String,
                        discountAmount: Int? = nil,
                        paymentMethodOptions: PaymentMethodOptions? = nil,
                        productCode: String? = nil,
                        productName: String? = nil,
                        quantity: Int? = nil,
                        tax: Tax? = nil,
                        unitCost: Int? = nil,
                        unitOfMeasure: String? = nil
                    ) {
                        self.id = id
                        self.object = object
                        self.discountAmount = discountAmount
                        self.paymentMethodOptions = paymentMethodOptions
                        self.productCode = productCode
                        self.productName = productName
                        self.quantity = quantity
                        self.tax = tax
                        self.unitCost = unitCost
                        self.unitOfMeasure = unitOfMeasure
                    }

                    public struct PaymentMethodOptions: Codable, Hashable, Sendable {
                        @Boxed public var card: Card?
                        public var cardPresent: CardPresent?
                        public var klarna: Klarna?
                        public var paypal: Paypal?

                        public init(
                            card: Card? = nil,
                            cardPresent: CardPresent? = nil,
                            klarna: Klarna? = nil,
                            paypal: Paypal? = nil
                        ) {
                            self._card = Boxed(wrappedValue: card)
                            self.cardPresent = cardPresent
                            self.klarna = klarna
                            self.paypal = paypal
                        }

                        public struct Card: Codable, Hashable, Sendable {
                            public var commodityCode: String?

                            public init(
                                commodityCode: String? = nil
                            ) {
                                self.commodityCode = commodityCode
                            }
                        }

                        public struct CardPresent: Codable, Hashable, Sendable {
                            public var commodityCode: String?

                            public init(
                                commodityCode: String? = nil
                            ) {
                                self.commodityCode = commodityCode
                            }
                        }

                        public struct Klarna: Codable, Hashable, Sendable {
                            public var imageUrl: String?
                            public var productUrl: String?
                            public var reference: String?
                            public var subscriptionReference: String?

                            public init(
                                imageUrl: String? = nil,
                                productUrl: String? = nil,
                                reference: String? = nil,
                                subscriptionReference: String? = nil
                            ) {
                                self.imageUrl = imageUrl
                                self.productUrl = productUrl
                                self.reference = reference
                                self.subscriptionReference = subscriptionReference
                            }
                        }

                        public struct Paypal: Codable, Hashable, Sendable {
                            /// Type of the line item.
                            public var category: Category?
                            /// Description of the line item.
                            public var description: String?
                            /// The Stripe account ID of the connected account that sells the item.
                            public var soldBy: String?

                            public init(
                                category: Category? = nil,
                                description: String? = nil,
                                soldBy: String? = nil
                            ) {
                                self.category = category
                                self.description = description
                                self.soldBy = soldBy
                            }

                            /// Type of the line item.
                            public enum Category: String, Codable, Hashable, Sendable {
                                case digitalGoods = "digital_goods"
                                case donation
                                case physicalGoods = "physical_goods"
                            }
                        }
                    }

                    public struct Tax: Codable, Hashable, Sendable {
                        /// The total amount of tax on the transaction represented in the smallest currency unit.
                        public var totalTaxAmount: Int?

                        public init(
                            totalTaxAmount: Int? = nil
                        ) {
                            self.totalTaxAmount = totalTaxAmount
                        }
                    }
                }
            }

            public struct Shipping: Codable, Hashable, Sendable {
                /// If a physical good is being shipped, the cost of shipping represented in the smallest currency unit.
                public var amount: Int?
                /// If a physical good is being shipped, the postal code of where it is being shipped from.
                public var fromPostalCode: String?
                /// If a physical good is being shipped, the postal code of where it is being shipped to.
                public var toPostalCode: String?

                public init(
                    amount: Int? = nil,
                    fromPostalCode: String? = nil,
                    toPostalCode: String? = nil
                ) {
                    self.amount = amount
                    self.fromPostalCode = fromPostalCode
                    self.toPostalCode = toPostalCode
                }
            }

            public struct Tax: Codable, Hashable, Sendable {
                /// The total amount of tax on the transaction represented in the smallest currency unit.
                public var totalTaxAmount: Int?

                public init(
                    totalTaxAmount: Int? = nil
                ) {
                    self.totalTaxAmount = totalTaxAmount
                }
            }

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

        public struct AutomaticPaymentMethods: Codable, Hashable, Sendable {
            /// Controls whether this PaymentIntent will accept redirect-based payment methods.
            public var allowRedirects: AllowRedirects?
            /// Automatically calculates compatible payment methods.
            public var enabled: Bool?

            public init(
                allowRedirects: AllowRedirects? = nil,
                enabled: Bool? = nil
            ) {
                self.allowRedirects = allowRedirects
                self.enabled = enabled
            }

            /// Controls whether this PaymentIntent will accept redirect-based payment methods.
            public enum AllowRedirects: String, Codable, Hashable, Sendable {
                case always
                case never
            }
        }

        public struct Hooks: Codable, Hashable, Sendable {
            public var inputs: Inputs?

            public init(
                inputs: Inputs? = nil
            ) {
                self.inputs = inputs
            }

            public struct Inputs: Codable, Hashable, Sendable {
                public var tax: Tax?

                public init(
                    tax: Tax? = nil
                ) {
                    self.tax = tax
                }

                public struct Tax: Codable, Hashable, Sendable {
                    /// The TaxCalculation id.
                    public var calculation: String?

                    public init(
                        calculation: String? = nil
                    ) {
                        self.calculation = calculation
                    }
                }
            }
        }

        public struct NextAction: Codable, Hashable, Sendable {
            /// Type of the next action to perform.
            public var `type`: String?
            /// The payload `type` selects.
            public var details: Details

            fileprivate enum CodingKeys: String, CodingKey {
                case `type`
                case alipayHandleRedirect
                case blikAuthorize
                case boletoDisplayDetails
                case cardAwaitNotification
                case cashappHandleRedirectOrDisplayQrCode
                case displayBankTransferInstructions
                case klarnaDisplayQrCode
                case konbiniDisplayDetails
                case multibancoDisplayDetails
                case oxxoDisplayDetails
                case paynowDisplayQrCode
                case pixDisplayQrCode
                case promptpayDisplayQrCode
                case redirectToUrl
                case swishHandleRedirectOrDisplayQrCode
                case upiHandleRedirectOrDisplayQrCode
                case useStripeSdk
                case verifyWithMicrodeposits
                case wechatPayDisplayQrCode
                case wechatPayRedirectToAndroidApp
                case wechatPayRedirectToIosApp
            }

            public init(
                `type`: String? = nil,
                details: Details
            ) {
                self.`type` = `type`
                self.details = details
            }

            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.`type` = try container.decodeIfPresent(String.self, forKey: .`type`)
                self.details = try Details(type: try container.decodeIfPresent(String.self, forKey: .type) ?? "", from: container)
            }

            public func encode(to encoder: any Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encodeIfPresent(`type`, forKey: .`type`)
                try details.encode(into: &container)
            }

            public struct AlipayHandleRedirect: Codable, Hashable, Sendable {
                /// The native data to be used with Alipay SDK you must redirect your customer to in order to authenticate the payment in.
                public var nativeData: String?
                /// The native URL you must redirect your customer to in order to authenticate the payment in an iOS App.
                public var nativeUrl: String?
                /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after.
                public var returnUrl: String?
                /// The URL you must redirect your customer to in order to authenticate the payment.
                public var url: String?

                public init(
                    nativeData: String? = nil,
                    nativeUrl: String? = nil,
                    returnUrl: String? = nil,
                    url: String? = nil
                ) {
                    self.nativeData = nativeData
                    self.nativeUrl = nativeUrl
                    self.returnUrl = returnUrl
                    self.url = url
                }
            }

            public struct BoletoDisplayDetails: Codable, Hashable, Sendable {
                /// The timestamp after which the boleto expires.
                public var expiresAt: Date?
                /// The URL to the hosted boleto voucher page, which allows customers to view the boleto voucher.
                public var hostedVoucherUrl: String?
                /// The boleto number.
                public var number: String?
                /// The URL to the downloadable boleto voucher PDF.
                public var pdf: String?

                public init(
                    expiresAt: Date? = nil,
                    hostedVoucherUrl: String? = nil,
                    number: String? = nil,
                    pdf: String? = nil
                ) {
                    self.expiresAt = expiresAt
                    self.hostedVoucherUrl = hostedVoucherUrl
                    self.number = number
                    self.pdf = pdf
                }
            }

            public struct CardAwaitNotification: Codable, Hashable, Sendable {
                /// The time that payment will be attempted.
                public var chargeAttemptAt: Date?
                /// For payments greater than INR 15000, the customer must provide explicit approval of the payment with their bank.
                public var customerApprovalRequired: Bool?

                public init(
                    chargeAttemptAt: Date? = nil,
                    customerApprovalRequired: Bool? = nil
                ) {
                    self.chargeAttemptAt = chargeAttemptAt
                    self.customerApprovalRequired = customerApprovalRequired
                }
            }

            public struct DisplayBankTransferInstructions: Codable, Hashable, Sendable {
                /// The remaining amount that needs to be transferred to complete the payment.
                public var amountRemaining: Int?
                /// Three-letter ISO currency code, in lowercase.
                public var currency: Stripe.Currency?
                /// A list of financial addresses that can be used to fund the customer balance.
                public var financialAddresses: [Stripe.Shared.FinancialAddresses]?
                /// A link to a hosted page that guides your customer through completing the transfer.
                public var hostedInstructionsUrl: String?
                /// A string identifying this payment.
                public var reference: String?
                /// Type of bank transfer.
                public var `type`: Type?

                public init(
                    amountRemaining: Int? = nil,
                    currency: Stripe.Currency? = nil,
                    financialAddresses: [Stripe.Shared.FinancialAddresses]? = nil,
                    hostedInstructionsUrl: String? = nil,
                    reference: String? = nil,
                    `type`: Type? = nil
                ) {
                    self.amountRemaining = amountRemaining
                    self.currency = currency
                    self.financialAddresses = financialAddresses
                    self.hostedInstructionsUrl = hostedInstructionsUrl
                    self.reference = reference
                    self.`type` = `type`
                }

                /// Type of bank transfer.
                public enum `Type`: String, Codable, Hashable, Sendable {
                    case euBankTransfer = "eu_bank_transfer"
                    case gbBankTransfer = "gb_bank_transfer"
                    case jpBankTransfer = "jp_bank_transfer"
                    case mxBankTransfer = "mx_bank_transfer"
                    case usBankTransfer = "us_bank_transfer"
                }
            }

            public struct KlarnaDisplayQrCode: Codable, Hashable, Sendable {
                /// The data being used to generate QR code.
                public var data: String?
                /// The timestamp at which the QR code expires.
                public var expiresAt: Date?
                /// The image_url_png string used to render QR code.
                public var imageUrlPng: String?
                /// The image_url_svg string used to render QR code.
                public var imageUrlSvg: String?

                public init(
                    data: String? = nil,
                    expiresAt: Date? = nil,
                    imageUrlPng: String? = nil,
                    imageUrlSvg: String? = nil
                ) {
                    self.data = data
                    self.expiresAt = expiresAt
                    self.imageUrlPng = imageUrlPng
                    self.imageUrlSvg = imageUrlSvg
                }
            }

            public struct KonbiniDisplayDetails: Codable, Hashable, Sendable {
                /// The timestamp at which the pending Konbini payment expires.
                public var expiresAt: Date?
                /// The URL for the Konbini payment instructions page, which allows customers to view and print a Konbini voucher.
                public var hostedVoucherUrl: String?
                public var stores: Stores?

                public init(
                    expiresAt: Date? = nil,
                    hostedVoucherUrl: String? = nil,
                    stores: Stores? = nil
                ) {
                    self.expiresAt = expiresAt
                    self.hostedVoucherUrl = hostedVoucherUrl
                    self.stores = stores
                }

                public struct Stores: Codable, Hashable, Sendable {
                    /// FamilyMart instruction details.
                    public var familymart: Familymart?
                    /// Lawson instruction details.
                    public var lawson: Lawson?
                    /// Ministop instruction details.
                    public var ministop: Ministop?
                    /// Seicomart instruction details.
                    public var seicomart: Seicomart?

                    public init(
                        familymart: Familymart? = nil,
                        lawson: Lawson? = nil,
                        ministop: Ministop? = nil,
                        seicomart: Seicomart? = nil
                    ) {
                        self.familymart = familymart
                        self.lawson = lawson
                        self.ministop = ministop
                        self.seicomart = seicomart
                    }

                    public struct Familymart: Codable, Hashable, Sendable {
                        /// The confirmation number.
                        public var confirmationNumber: String?
                        /// The payment code.
                        public var paymentCode: String?

                        public init(
                            confirmationNumber: String? = nil,
                            paymentCode: String? = nil
                        ) {
                            self.confirmationNumber = confirmationNumber
                            self.paymentCode = paymentCode
                        }
                    }

                    public struct Lawson: Codable, Hashable, Sendable {
                        /// The confirmation number.
                        public var confirmationNumber: String?
                        /// The payment code.
                        public var paymentCode: String?

                        public init(
                            confirmationNumber: String? = nil,
                            paymentCode: String? = nil
                        ) {
                            self.confirmationNumber = confirmationNumber
                            self.paymentCode = paymentCode
                        }
                    }

                    public struct Ministop: Codable, Hashable, Sendable {
                        /// The confirmation number.
                        public var confirmationNumber: String?
                        /// The payment code.
                        public var paymentCode: String?

                        public init(
                            confirmationNumber: String? = nil,
                            paymentCode: String? = nil
                        ) {
                            self.confirmationNumber = confirmationNumber
                            self.paymentCode = paymentCode
                        }
                    }

                    public struct Seicomart: Codable, Hashable, Sendable {
                        /// The confirmation number.
                        public var confirmationNumber: String?
                        /// The payment code.
                        public var paymentCode: String?

                        public init(
                            confirmationNumber: String? = nil,
                            paymentCode: String? = nil
                        ) {
                            self.confirmationNumber = confirmationNumber
                            self.paymentCode = paymentCode
                        }
                    }
                }
            }

            public struct MultibancoDisplayDetails: Codable, Hashable, Sendable {
                /// Entity number associated with this Multibanco payment.
                public var entity: String?
                /// The timestamp at which the Multibanco voucher expires.
                public var expiresAt: Date?
                /// The URL for the hosted Multibanco voucher page, which allows customers to view a Multibanco voucher.
                public var hostedVoucherUrl: String?
                /// Reference number associated with this Multibanco payment.
                public var reference: String?

                public init(
                    entity: String? = nil,
                    expiresAt: Date? = nil,
                    hostedVoucherUrl: String? = nil,
                    reference: String? = nil
                ) {
                    self.entity = entity
                    self.expiresAt = expiresAt
                    self.hostedVoucherUrl = hostedVoucherUrl
                    self.reference = reference
                }
            }

            public struct OxxoDisplayDetails: Codable, Hashable, Sendable {
                /// The timestamp after which the OXXO voucher expires.
                public var expiresAfter: Date?
                /// The URL for the hosted OXXO voucher page, which allows customers to view and print an OXXO voucher.
                public var hostedVoucherUrl: String?
                /// OXXO reference number.
                public var number: String?

                public init(
                    expiresAfter: Date? = nil,
                    hostedVoucherUrl: String? = nil,
                    number: String? = nil
                ) {
                    self.expiresAfter = expiresAfter
                    self.hostedVoucherUrl = hostedVoucherUrl
                    self.number = number
                }
            }

            public struct PaynowDisplayQrCode: Codable, Hashable, Sendable {
                /// The raw data string used to generate QR code, it should be used together with QR code library.
                public var data: String?
                /// The URL to the hosted PayNow instructions page, which allows customers to view the PayNow QR code.
                public var hostedInstructionsUrl: String?
                /// The image_url_png string used to render QR code.
                public var imageUrlPng: String?
                /// The image_url_svg string used to render QR code.
                public var imageUrlSvg: String?

                public init(
                    data: String? = nil,
                    hostedInstructionsUrl: String? = nil,
                    imageUrlPng: String? = nil,
                    imageUrlSvg: String? = nil
                ) {
                    self.data = data
                    self.hostedInstructionsUrl = hostedInstructionsUrl
                    self.imageUrlPng = imageUrlPng
                    self.imageUrlSvg = imageUrlSvg
                }
            }

            public struct PixDisplayQrCode: Codable, Hashable, Sendable {
                /// The raw data string used to generate QR code, it should be used together with QR code library.
                public var data: String?
                /// The date (unix timestamp) when the PIX expires.
                public var expiresAt: Int?
                /// The URL to the hosted pix instructions page, which allows customers to view the pix QR code.
                public var hostedInstructionsUrl: String?
                /// The image_url_png string used to render png QR code.
                public var imageUrlPng: String?
                /// The image_url_svg string used to render svg QR code.
                public var imageUrlSvg: String?

                public init(
                    data: String? = nil,
                    expiresAt: Int? = nil,
                    hostedInstructionsUrl: String? = nil,
                    imageUrlPng: String? = nil,
                    imageUrlSvg: String? = nil
                ) {
                    self.data = data
                    self.expiresAt = expiresAt
                    self.hostedInstructionsUrl = hostedInstructionsUrl
                    self.imageUrlPng = imageUrlPng
                    self.imageUrlSvg = imageUrlSvg
                }
            }

            public struct PromptpayDisplayQrCode: Codable, Hashable, Sendable {
                /// The raw data string used to generate QR code, it should be used together with QR code library.
                public var data: String?
                /// The URL to the hosted PromptPay instructions page, which allows customers to view the PromptPay QR code.
                public var hostedInstructionsUrl: String?
                /// The PNG path used to render the QR code, can be used as the source in an HTML img tag.
                public var imageUrlPng: String?
                /// The SVG path used to render the QR code, can be used as the source in an HTML img tag.
                public var imageUrlSvg: String?

                public init(
                    data: String? = nil,
                    hostedInstructionsUrl: String? = nil,
                    imageUrlPng: String? = nil,
                    imageUrlSvg: String? = nil
                ) {
                    self.data = data
                    self.hostedInstructionsUrl = hostedInstructionsUrl
                    self.imageUrlPng = imageUrlPng
                    self.imageUrlSvg = imageUrlSvg
                }
            }

            public struct RedirectToUrl: Codable, Hashable, Sendable {
                /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after.
                public var returnUrl: String?
                /// The URL you must redirect your customer to in order to authenticate the payment.
                public var url: String?

                public init(
                    returnUrl: String? = nil,
                    url: String? = nil
                ) {
                    self.returnUrl = returnUrl
                    self.url = url
                }
            }

            public struct SwishHandleRedirectOrDisplayQrCode: Codable, Hashable, Sendable {
                /// The URL to the hosted Swish instructions page, which allows customers to view the QR code.
                public var hostedInstructionsUrl: String?
                /// The url for mobile redirect based auth (for internal use only and not typically available in standard API requests).
                public var mobileAuthUrl: String?
                public var qrCode: QrCode?

                public init(
                    hostedInstructionsUrl: String? = nil,
                    mobileAuthUrl: String? = nil,
                    qrCode: QrCode? = nil
                ) {
                    self.hostedInstructionsUrl = hostedInstructionsUrl
                    self.mobileAuthUrl = mobileAuthUrl
                    self.qrCode = qrCode
                }

                public struct QrCode: Codable, Hashable, Sendable {
                    /// The raw data string used to generate QR code, it should be used together with QR code library.
                    public var data: String?
                    /// The image_url_png string used to render QR code.
                    public var imageUrlPng: String?
                    /// The image_url_svg string used to render QR code.
                    public var imageUrlSvg: String?

                    public init(
                        data: String? = nil,
                        imageUrlPng: String? = nil,
                        imageUrlSvg: String? = nil
                    ) {
                        self.data = data
                        self.imageUrlPng = imageUrlPng
                        self.imageUrlSvg = imageUrlSvg
                    }
                }
            }

            public struct VerifyWithMicrodeposits: Codable, Hashable, Sendable {
                /// The timestamp when the microdeposits are expected to land.
                public var arrivalDate: Date?
                /// The URL for the hosted verification page, which allows customers to verify their bank account.
                public var hostedVerificationUrl: String?
                /// The type of the microdeposit sent to the customer.
                public var microdepositType: MicrodepositType?

                public init(
                    arrivalDate: Date? = nil,
                    hostedVerificationUrl: String? = nil,
                    microdepositType: MicrodepositType? = nil
                ) {
                    self.arrivalDate = arrivalDate
                    self.hostedVerificationUrl = hostedVerificationUrl
                    self.microdepositType = microdepositType
                }

                /// The type of the microdeposit sent to the customer.
                public enum MicrodepositType: String, Codable, Hashable, Sendable {
                    case amounts
                    case descriptorCode = "descriptor_code"
                }
            }

            public struct WechatPayDisplayQrCode: Codable, Hashable, Sendable {
                /// The data being used to generate QR code.
                public var data: String?
                /// The URL to the hosted WeChat Pay instructions page, which allows customers to view the WeChat Pay QR code.
                public var hostedInstructionsUrl: String?
                /// The base64 image data for a pre-generated QR code.
                public var imageDataUrl: String?
                /// The image_url_png string used to render QR code.
                public var imageUrlPng: String?
                /// The image_url_svg string used to render QR code.
                public var imageUrlSvg: String?

                public init(
                    data: String? = nil,
                    hostedInstructionsUrl: String? = nil,
                    imageDataUrl: String? = nil,
                    imageUrlPng: String? = nil,
                    imageUrlSvg: String? = nil
                ) {
                    self.data = data
                    self.hostedInstructionsUrl = hostedInstructionsUrl
                    self.imageDataUrl = imageDataUrl
                    self.imageUrlPng = imageUrlPng
                    self.imageUrlSvg = imageUrlSvg
                }
            }

            public struct WechatPayRedirectToAndroidApp: Codable, Hashable, Sendable {
                /// app_id is the APP ID registered on WeChat open platform.
                public var appId: String?
                /// nonce_str is a random string.
                public var nonceStr: String?
                /// package is static value.
                public var package: String?
                /// an unique merchant ID assigned by WeChat Pay.
                public var partnerId: String?
                /// an unique trading ID assigned by WeChat Pay.
                public var prepayId: String?
                /// A signature.
                public var sign: String?
                /// Specifies the current time in epoch format.
                public var timestamp: String?

                public init(
                    appId: String? = nil,
                    nonceStr: String? = nil,
                    package: String? = nil,
                    partnerId: String? = nil,
                    prepayId: String? = nil,
                    sign: String? = nil,
                    timestamp: String? = nil
                ) {
                    self.appId = appId
                    self.nonceStr = nonceStr
                    self.package = package
                    self.partnerId = partnerId
                    self.prepayId = prepayId
                    self.sign = sign
                    self.timestamp = timestamp
                }
            }

            public struct WechatPayRedirectToIosApp: Codable, Hashable, Sendable {
                /// An universal link that redirect to WeChat Pay app.
                public var nativeUrl: String?

                public init(
                    nativeUrl: String? = nil
                ) {
                    self.nativeUrl = nativeUrl
                }
            }

            /// The payload `type` selects; `unknown` carries a type this package does not model.
            public indirect enum Details: Hashable, Sendable {
                case alipayHandleRedirect(AlipayHandleRedirect)
                case blikAuthorize(Stripe.Shared.BlikAuthorize)
                case boletoDisplayDetails(BoletoDisplayDetails)
                case cardAwaitNotification(CardAwaitNotification)
                case cashappHandleRedirectOrDisplayQrCode(Stripe.Shared.CashappHandleRedirectOrDisplayQrCode)
                case displayBankTransferInstructions(DisplayBankTransferInstructions)
                case klarnaDisplayQrCode(KlarnaDisplayQrCode)
                case konbiniDisplayDetails(KonbiniDisplayDetails)
                case multibancoDisplayDetails(MultibancoDisplayDetails)
                case oxxoDisplayDetails(OxxoDisplayDetails)
                case paynowDisplayQrCode(PaynowDisplayQrCode)
                case pixDisplayQrCode(PixDisplayQrCode)
                case promptpayDisplayQrCode(PromptpayDisplayQrCode)
                case redirectToUrl(RedirectToUrl)
                case swishHandleRedirectOrDisplayQrCode(SwishHandleRedirectOrDisplayQrCode)
                case upiHandleRedirectOrDisplayQrCode(Stripe.Shared.UpiHandleRedirectOrDisplayQrCode)
                case useStripeSdk([String: String])
                case verifyWithMicrodeposits(VerifyWithMicrodeposits)
                case wechatPayDisplayQrCode(WechatPayDisplayQrCode)
                case wechatPayRedirectToAndroidApp(WechatPayRedirectToAndroidApp)
                case wechatPayRedirectToIosApp(WechatPayRedirectToIosApp)
                case unknown(type: String)

                public var alipayHandleRedirect: AlipayHandleRedirect? {
                    if case .alipayHandleRedirect(let value) = self { return value }
                    return nil
                }
                public var blikAuthorize: Stripe.Shared.BlikAuthorize? {
                    if case .blikAuthorize(let value) = self { return value }
                    return nil
                }
                public var boletoDisplayDetails: BoletoDisplayDetails? {
                    if case .boletoDisplayDetails(let value) = self { return value }
                    return nil
                }
                public var cardAwaitNotification: CardAwaitNotification? {
                    if case .cardAwaitNotification(let value) = self { return value }
                    return nil
                }
                public var cashappHandleRedirectOrDisplayQrCode: Stripe.Shared.CashappHandleRedirectOrDisplayQrCode? {
                    if case .cashappHandleRedirectOrDisplayQrCode(let value) = self { return value }
                    return nil
                }
                public var displayBankTransferInstructions: DisplayBankTransferInstructions? {
                    if case .displayBankTransferInstructions(let value) = self { return value }
                    return nil
                }
                public var klarnaDisplayQrCode: KlarnaDisplayQrCode? {
                    if case .klarnaDisplayQrCode(let value) = self { return value }
                    return nil
                }
                public var konbiniDisplayDetails: KonbiniDisplayDetails? {
                    if case .konbiniDisplayDetails(let value) = self { return value }
                    return nil
                }
                public var multibancoDisplayDetails: MultibancoDisplayDetails? {
                    if case .multibancoDisplayDetails(let value) = self { return value }
                    return nil
                }
                public var oxxoDisplayDetails: OxxoDisplayDetails? {
                    if case .oxxoDisplayDetails(let value) = self { return value }
                    return nil
                }
                public var paynowDisplayQrCode: PaynowDisplayQrCode? {
                    if case .paynowDisplayQrCode(let value) = self { return value }
                    return nil
                }
                public var pixDisplayQrCode: PixDisplayQrCode? {
                    if case .pixDisplayQrCode(let value) = self { return value }
                    return nil
                }
                public var promptpayDisplayQrCode: PromptpayDisplayQrCode? {
                    if case .promptpayDisplayQrCode(let value) = self { return value }
                    return nil
                }
                public var redirectToUrl: RedirectToUrl? {
                    if case .redirectToUrl(let value) = self { return value }
                    return nil
                }
                public var swishHandleRedirectOrDisplayQrCode: SwishHandleRedirectOrDisplayQrCode? {
                    if case .swishHandleRedirectOrDisplayQrCode(let value) = self { return value }
                    return nil
                }
                public var upiHandleRedirectOrDisplayQrCode: Stripe.Shared.UpiHandleRedirectOrDisplayQrCode? {
                    if case .upiHandleRedirectOrDisplayQrCode(let value) = self { return value }
                    return nil
                }
                public var useStripeSdk: [String: String]? {
                    if case .useStripeSdk(let value) = self { return value }
                    return nil
                }
                public var verifyWithMicrodeposits: VerifyWithMicrodeposits? {
                    if case .verifyWithMicrodeposits(let value) = self { return value }
                    return nil
                }
                public var wechatPayDisplayQrCode: WechatPayDisplayQrCode? {
                    if case .wechatPayDisplayQrCode(let value) = self { return value }
                    return nil
                }
                public var wechatPayRedirectToAndroidApp: WechatPayRedirectToAndroidApp? {
                    if case .wechatPayRedirectToAndroidApp(let value) = self { return value }
                    return nil
                }
                public var wechatPayRedirectToIosApp: WechatPayRedirectToIosApp? {
                    if case .wechatPayRedirectToIosApp(let value) = self { return value }
                    return nil
                }

                fileprivate init(type: String, from container: KeyedDecodingContainer<CodingKeys>) throws {
                    switch type {
                    case "alipay_handle_redirect":
                        if let value = try container.decodeIfPresent(AlipayHandleRedirect.self, forKey: .alipayHandleRedirect) {
                            self = .alipayHandleRedirect(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "blik_authorize":
                        if let value = try container.decodeIfPresent(Stripe.Shared.BlikAuthorize.self, forKey: .blikAuthorize) {
                            self = .blikAuthorize(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "boleto_display_details":
                        if let value = try container.decodeIfPresent(BoletoDisplayDetails.self, forKey: .boletoDisplayDetails) {
                            self = .boletoDisplayDetails(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "card_await_notification":
                        if let value = try container.decodeIfPresent(CardAwaitNotification.self, forKey: .cardAwaitNotification) {
                            self = .cardAwaitNotification(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "cashapp_handle_redirect_or_display_qr_code":
                        if let value = try container.decodeIfPresent(
                            Stripe.Shared.CashappHandleRedirectOrDisplayQrCode.self,
                            forKey: .cashappHandleRedirectOrDisplayQrCode
                        ) {
                            self = .cashappHandleRedirectOrDisplayQrCode(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "display_bank_transfer_instructions":
                        if let value = try container.decodeIfPresent(DisplayBankTransferInstructions.self, forKey: .displayBankTransferInstructions) {
                            self = .displayBankTransferInstructions(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "klarna_display_qr_code":
                        if let value = try container.decodeIfPresent(KlarnaDisplayQrCode.self, forKey: .klarnaDisplayQrCode) {
                            self = .klarnaDisplayQrCode(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "konbini_display_details":
                        if let value = try container.decodeIfPresent(KonbiniDisplayDetails.self, forKey: .konbiniDisplayDetails) {
                            self = .konbiniDisplayDetails(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "multibanco_display_details":
                        if let value = try container.decodeIfPresent(MultibancoDisplayDetails.self, forKey: .multibancoDisplayDetails) {
                            self = .multibancoDisplayDetails(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "oxxo_display_details":
                        if let value = try container.decodeIfPresent(OxxoDisplayDetails.self, forKey: .oxxoDisplayDetails) {
                            self = .oxxoDisplayDetails(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "paynow_display_qr_code":
                        if let value = try container.decodeIfPresent(PaynowDisplayQrCode.self, forKey: .paynowDisplayQrCode) {
                            self = .paynowDisplayQrCode(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "pix_display_qr_code":
                        if let value = try container.decodeIfPresent(PixDisplayQrCode.self, forKey: .pixDisplayQrCode) {
                            self = .pixDisplayQrCode(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "promptpay_display_qr_code":
                        if let value = try container.decodeIfPresent(PromptpayDisplayQrCode.self, forKey: .promptpayDisplayQrCode) {
                            self = .promptpayDisplayQrCode(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "redirect_to_url":
                        if let value = try container.decodeIfPresent(RedirectToUrl.self, forKey: .redirectToUrl) {
                            self = .redirectToUrl(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "swish_handle_redirect_or_display_qr_code":
                        if let value = try container.decodeIfPresent(
                            SwishHandleRedirectOrDisplayQrCode.self,
                            forKey: .swishHandleRedirectOrDisplayQrCode
                        ) {
                            self = .swishHandleRedirectOrDisplayQrCode(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "upi_handle_redirect_or_display_qr_code":
                        if let value = try container.decodeIfPresent(
                            Stripe.Shared.UpiHandleRedirectOrDisplayQrCode.self,
                            forKey: .upiHandleRedirectOrDisplayQrCode
                        ) {
                            self = .upiHandleRedirectOrDisplayQrCode(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "use_stripe_sdk":
                        if let value = try container.decodeIfPresent([String: String].self, forKey: .useStripeSdk) {
                            self = .useStripeSdk(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "verify_with_microdeposits":
                        if let value = try container.decodeIfPresent(VerifyWithMicrodeposits.self, forKey: .verifyWithMicrodeposits) {
                            self = .verifyWithMicrodeposits(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "wechat_pay_display_qr_code":
                        if let value = try container.decodeIfPresent(WechatPayDisplayQrCode.self, forKey: .wechatPayDisplayQrCode) {
                            self = .wechatPayDisplayQrCode(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "wechat_pay_redirect_to_android_app":
                        if let value = try container.decodeIfPresent(WechatPayRedirectToAndroidApp.self, forKey: .wechatPayRedirectToAndroidApp) {
                            self = .wechatPayRedirectToAndroidApp(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "wechat_pay_redirect_to_ios_app":
                        if let value = try container.decodeIfPresent(WechatPayRedirectToIosApp.self, forKey: .wechatPayRedirectToIosApp) {
                            self = .wechatPayRedirectToIosApp(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    default: self = .unknown(type: type)
                    }
                }

                fileprivate func encode(into container: inout KeyedEncodingContainer<CodingKeys>) throws {
                    switch self {
                    case .alipayHandleRedirect(let value): try container.encode(value, forKey: .alipayHandleRedirect)
                    case .blikAuthorize(let value): try container.encode(value, forKey: .blikAuthorize)
                    case .boletoDisplayDetails(let value): try container.encode(value, forKey: .boletoDisplayDetails)
                    case .cardAwaitNotification(let value): try container.encode(value, forKey: .cardAwaitNotification)
                    case .cashappHandleRedirectOrDisplayQrCode(let value): try container.encode(value, forKey: .cashappHandleRedirectOrDisplayQrCode)
                    case .displayBankTransferInstructions(let value): try container.encode(value, forKey: .displayBankTransferInstructions)
                    case .klarnaDisplayQrCode(let value): try container.encode(value, forKey: .klarnaDisplayQrCode)
                    case .konbiniDisplayDetails(let value): try container.encode(value, forKey: .konbiniDisplayDetails)
                    case .multibancoDisplayDetails(let value): try container.encode(value, forKey: .multibancoDisplayDetails)
                    case .oxxoDisplayDetails(let value): try container.encode(value, forKey: .oxxoDisplayDetails)
                    case .paynowDisplayQrCode(let value): try container.encode(value, forKey: .paynowDisplayQrCode)
                    case .pixDisplayQrCode(let value): try container.encode(value, forKey: .pixDisplayQrCode)
                    case .promptpayDisplayQrCode(let value): try container.encode(value, forKey: .promptpayDisplayQrCode)
                    case .redirectToUrl(let value): try container.encode(value, forKey: .redirectToUrl)
                    case .swishHandleRedirectOrDisplayQrCode(let value): try container.encode(value, forKey: .swishHandleRedirectOrDisplayQrCode)
                    case .upiHandleRedirectOrDisplayQrCode(let value): try container.encode(value, forKey: .upiHandleRedirectOrDisplayQrCode)
                    case .useStripeSdk(let value): try container.encode(value, forKey: .useStripeSdk)
                    case .verifyWithMicrodeposits(let value): try container.encode(value, forKey: .verifyWithMicrodeposits)
                    case .wechatPayDisplayQrCode(let value): try container.encode(value, forKey: .wechatPayDisplayQrCode)
                    case .wechatPayRedirectToAndroidApp(let value): try container.encode(value, forKey: .wechatPayRedirectToAndroidApp)
                    case .wechatPayRedirectToIosApp(let value): try container.encode(value, forKey: .wechatPayRedirectToIosApp)
                    default: break
                    }
                }
            }
        }

        public struct PaymentDetails: Codable, Hashable, Sendable {
            /// A unique value to identify the customer.
            public var customerReference: String?
            /// A unique value assigned by the business to identify the transaction.
            public var orderReference: String?

            public init(
                customerReference: String? = nil,
                orderReference: String? = nil
            ) {
                self.customerReference = customerReference
                self.orderReference = orderReference
            }
        }

        public struct PaymentMethodOptions: Codable, Hashable, Sendable {
            public var acssDebit: AcssDebit?
            public var affirm: Affirm?
            public var afterpayClearpay: AfterpayClearpay?
            public var alipay: Alipay?
            public var alma: Alma?
            public var amazonPay: AmazonPay?
            public var auBecsDebit: AuBecsDebit?
            public var bacsDebit: BacsDebit?
            public var bancontact: Bancontact?
            public var billie: Billie?
            public var bizum: Bizum?
            public var blik: Blik?
            public var boleto: Boleto?
            @Boxed public var card: Card?
            public var cardPresent: CardPresent?
            public var cashapp: Cashapp?
            public var crypto: Crypto?
            public var customerBalance: CustomerBalance?
            public var eps: Eps?
            public var fpx: Fpx?
            public var giropay: Giropay?
            public var grabpay: Grabpay?
            public var ideal: Ideal?
            public var interacPresent: InteracPresent?
            public var kakaoPay: KakaoPay?
            public var klarna: Klarna?
            public var konbini: Konbini?
            public var krCard: KrCard?
            public var link: Link?
            public var mbWay: MbWay?
            public var mobilepay: Mobilepay?
            public var multibanco: Multibanco?
            public var naverPay: NaverPay?
            public var nzBankAccount: NzBankAccount?
            public var oxxo: Oxxo?
            public var p24: P24?
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
                acssDebit: AcssDebit? = nil,
                affirm: Affirm? = nil,
                afterpayClearpay: AfterpayClearpay? = nil,
                alipay: Alipay? = nil,
                alma: Alma? = nil,
                amazonPay: AmazonPay? = nil,
                auBecsDebit: AuBecsDebit? = nil,
                bacsDebit: BacsDebit? = nil,
                bancontact: Bancontact? = nil,
                billie: Billie? = nil,
                bizum: Bizum? = nil,
                blik: Blik? = nil,
                boleto: Boleto? = nil,
                card: Card? = nil,
                cardPresent: CardPresent? = nil,
                cashapp: Cashapp? = nil,
                crypto: Crypto? = nil,
                customerBalance: CustomerBalance? = nil,
                eps: Eps? = nil,
                fpx: Fpx? = nil,
                giropay: Giropay? = nil,
                grabpay: Grabpay? = nil,
                ideal: Ideal? = nil,
                interacPresent: InteracPresent? = nil,
                kakaoPay: KakaoPay? = nil,
                klarna: Klarna? = nil,
                konbini: Konbini? = nil,
                krCard: KrCard? = nil,
                link: Link? = nil,
                mbWay: MbWay? = nil,
                mobilepay: Mobilepay? = nil,
                multibanco: Multibanco? = nil,
                naverPay: NaverPay? = nil,
                nzBankAccount: NzBankAccount? = nil,
                oxxo: Oxxo? = nil,
                p24: P24? = nil,
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
                self.acssDebit = acssDebit
                self.affirm = affirm
                self.afterpayClearpay = afterpayClearpay
                self.alipay = alipay
                self.alma = alma
                self.amazonPay = amazonPay
                self.auBecsDebit = auBecsDebit
                self.bacsDebit = bacsDebit
                self.bancontact = bancontact
                self.billie = billie
                self.bizum = bizum
                self.blik = blik
                self.boleto = boleto
                self._card = Boxed(wrappedValue: card)
                self.cardPresent = cardPresent
                self.cashapp = cashapp
                self.crypto = crypto
                self.customerBalance = customerBalance
                self.eps = eps
                self.fpx = fpx
                self.giropay = giropay
                self.grabpay = grabpay
                self.ideal = ideal
                self.interacPresent = interacPresent
                self.kakaoPay = kakaoPay
                self.klarna = klarna
                self.konbini = konbini
                self.krCard = krCard
                self.link = link
                self.mbWay = mbWay
                self.mobilepay = mobilepay
                self.multibanco = multibanco
                self.naverPay = naverPay
                self.nzBankAccount = nzBankAccount
                self.oxxo = oxxo
                self.p24 = p24
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
                public var mandateOptions: MandateOptions?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?
                /// Controls when Stripe will attempt to debit the funds from the customer's account.
                public var targetDate: String?
                /// Bank account verification method.
                public var verificationMethod: VerificationMethod?

                public init(
                    mandateOptions: MandateOptions? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil,
                    targetDate: String? = nil,
                    verificationMethod: VerificationMethod? = nil
                ) {
                    self.mandateOptions = mandateOptions
                    self.setupFutureUsage = setupFutureUsage
                    self.targetDate = targetDate
                    self.verificationMethod = verificationMethod
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                    case onSession = "on_session"
                }

                /// Bank account verification method.
                public enum VerificationMethod: String, Codable, Hashable, Sendable {
                    case automatic
                    case instant
                    case microdeposits
                }

                public struct MandateOptions: Codable, Hashable, Sendable {
                    /// A URL for custom mandate text.
                    public var customMandateUrl: String?
                    /// Description of the interval.
                    public var intervalDescription: String?
                    /// Payment schedule for the mandate.
                    public var paymentSchedule: PaymentSchedule?
                    /// Transaction type of the mandate.
                    public var transactionType: TransactionType?

                    public init(
                        customMandateUrl: String? = nil,
                        intervalDescription: String? = nil,
                        paymentSchedule: PaymentSchedule? = nil,
                        transactionType: TransactionType? = nil
                    ) {
                        self.customMandateUrl = customMandateUrl
                        self.intervalDescription = intervalDescription
                        self.paymentSchedule = paymentSchedule
                        self.transactionType = transactionType
                    }

                    /// Payment schedule for the mandate.
                    public enum PaymentSchedule: String, Codable, Hashable, Sendable {
                        case combined
                        case interval
                        case sporadic
                    }

                    /// Transaction type of the mandate.
                    public enum TransactionType: String, Codable, Hashable, Sendable {
                        case business
                        case personal
                    }
                }
            }

            public struct Affirm: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Preferred language of the Affirm authorization page that the customer is redirected to.
                public var preferredLocale: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    captureMethod: String? = nil,
                    preferredLocale: String? = nil,
                    setupFutureUsage: String? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.preferredLocale = preferredLocale
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct AfterpayClearpay: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// An internal identifier or reference that this payment corresponds to.
                public var reference: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    captureMethod: String? = nil,
                    reference: String? = nil,
                    setupFutureUsage: String? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.reference = reference
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Alipay: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct Alma: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?

                public init(
                    captureMethod: String? = nil
                ) {
                    self.captureMethod = captureMethod
                }
            }

            public struct AmazonPay: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    captureMethod: String? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct AuBecsDebit: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?
                /// Controls when Stripe will attempt to debit the funds from the customer's account.
                public var targetDate: String?

                public init(
                    setupFutureUsage: SetupFutureUsage? = nil,
                    targetDate: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                    self.targetDate = targetDate
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                    case onSession = "on_session"
                }
            }

            public struct BacsDebit: Codable, Hashable, Sendable {
                public var mandateOptions: MandateOptions?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?
                /// Controls when Stripe will attempt to debit the funds from the customer's account.
                public var targetDate: String?

                public init(
                    mandateOptions: MandateOptions? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil,
                    targetDate: String? = nil
                ) {
                    self.mandateOptions = mandateOptions
                    self.setupFutureUsage = setupFutureUsage
                    self.targetDate = targetDate
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                    case onSession = "on_session"
                }

                public struct MandateOptions: Codable, Hashable, Sendable {
                    /// Prefix used to generate the Mandate reference.
                    public var referencePrefix: String?

                    public init(
                        referencePrefix: String? = nil
                    ) {
                        self.referencePrefix = referencePrefix
                    }
                }
            }

            public struct Bancontact: Codable, Hashable, Sendable {
                /// Preferred language of the Bancontact authorization page that the customer is redirected to.
                public var preferredLanguage: PreferredLanguage?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    preferredLanguage: PreferredLanguage? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.preferredLanguage = preferredLanguage
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Preferred language of the Bancontact authorization page that the customer is redirected to.
                public enum PreferredLanguage: String, Codable, Hashable, Sendable {
                    case de
                    case en
                    case fr
                    case nl
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct Billie: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?

                public init(
                    captureMethod: String? = nil
                ) {
                    self.captureMethod = captureMethod
                }
            }

            public struct Bizum: Codable, Hashable, Sendable {
                public init() {}
            }

            public struct Blik: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Boleto: Codable, Hashable, Sendable {
                /// The number of calendar days before a Boleto voucher expires.
                public var expiresAfterDays: Int?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    expiresAfterDays: Int? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.expiresAfterDays = expiresAfterDays
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                    case onSession = "on_session"
                }
            }

            public struct Card: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Installment details for this payment.
                public var installments: Installments?
                /// Configuration options for setting up an eMandate for cards issued in India.
                public var mandateOptions: MandateOptions?
                /// Selected network to process this payment intent on.
                public var network: Network?
                /// Request ability to capture beyond the standard authorization validity window for this PaymentIntent.
                public var requestExtendedAuthorization: RequestExtendedAuthorization?
                /// Request ability to increment the authorization for this PaymentIntent.
                public var requestIncrementalAuthorization: RequestIncrementalAuthorization?
                /// Request ability to make multiple captures for this PaymentIntent.
                public var requestMulticapture: RequestMulticapture?
                /// Request ability to overcapture for this PaymentIntent.
                public var requestOvercapture: RequestOvercapture?
                /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based.
                public var requestThreeDSecure: RequestThreeDSecure?
                /// When enabled, using a card that is attached to a customer will require the CVC to be provided again (i.e.
                public var requireCvcRecollection: Bool?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?
                /// Provides information about a card payment that customers see on their statements.
                public var statementDescriptorSuffixKana: String?
                /// Provides information about a card payment that customers see on their statements.
                public var statementDescriptorSuffixKanji: String?

                public init(
                    captureMethod: String? = nil,
                    installments: Installments? = nil,
                    mandateOptions: MandateOptions? = nil,
                    network: Network? = nil,
                    requestExtendedAuthorization: RequestExtendedAuthorization? = nil,
                    requestIncrementalAuthorization: RequestIncrementalAuthorization? = nil,
                    requestMulticapture: RequestMulticapture? = nil,
                    requestOvercapture: RequestOvercapture? = nil,
                    requestThreeDSecure: RequestThreeDSecure? = nil,
                    requireCvcRecollection: Bool? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil,
                    statementDescriptorSuffixKana: String? = nil,
                    statementDescriptorSuffixKanji: String? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.installments = installments
                    self.mandateOptions = mandateOptions
                    self.network = network
                    self.requestExtendedAuthorization = requestExtendedAuthorization
                    self.requestIncrementalAuthorization = requestIncrementalAuthorization
                    self.requestMulticapture = requestMulticapture
                    self.requestOvercapture = requestOvercapture
                    self.requestThreeDSecure = requestThreeDSecure
                    self.requireCvcRecollection = requireCvcRecollection
                    self.setupFutureUsage = setupFutureUsage
                    self.statementDescriptorSuffixKana = statementDescriptorSuffixKana
                    self.statementDescriptorSuffixKanji = statementDescriptorSuffixKanji
                }

                /// Selected network to process this payment intent on.
                public enum Network: String, Codable, Hashable, Sendable {
                    case amex
                    case cartesBancaires = "cartes_bancaires"
                    case diners
                    case discover
                    case eftposAu = "eftpos_au"
                    case girocard
                    case interac
                    case jcb
                    case link
                    case mastercard
                    case unionpay
                    case unknown
                    case visa
                }

                /// Request ability to capture beyond the standard authorization validity window for this PaymentIntent.
                public enum RequestExtendedAuthorization: String, Codable, Hashable, Sendable {
                    case ifAvailable = "if_available"
                    case never
                }

                /// Request ability to increment the authorization for this PaymentIntent.
                public enum RequestIncrementalAuthorization: String, Codable, Hashable, Sendable {
                    case ifAvailable = "if_available"
                    case never
                }

                /// Request ability to make multiple captures for this PaymentIntent.
                public enum RequestMulticapture: String, Codable, Hashable, Sendable {
                    case ifAvailable = "if_available"
                    case never
                }

                /// Request ability to overcapture for this PaymentIntent.
                public enum RequestOvercapture: String, Codable, Hashable, Sendable {
                    case ifAvailable = "if_available"
                    case never
                }

                /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based.
                public enum RequestThreeDSecure: String, Codable, Hashable, Sendable {
                    case `any`
                    case automatic
                    case challenge
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                    case onSession = "on_session"
                }

                public struct Installments: Codable, Hashable, Sendable {
                    /// Installment plans that may be selected for this PaymentIntent.
                    public var availablePlans: [Stripe.Shared.PaymentMethodDetailsCardInstallmentsPlan]?
                    /// Whether Installments are enabled for this PaymentIntent.
                    public var enabled: Bool?
                    /// Installment plan selected for this PaymentIntent.
                    public var plan: Stripe.Shared.PaymentMethodDetailsCardInstallmentsPlan?

                    public init(
                        availablePlans: [Stripe.Shared.PaymentMethodDetailsCardInstallmentsPlan]? = nil,
                        enabled: Bool? = nil,
                        plan: Stripe.Shared.PaymentMethodDetailsCardInstallmentsPlan? = nil
                    ) {
                        self.availablePlans = availablePlans
                        self.enabled = enabled
                        self.plan = plan
                    }
                }

                public struct MandateOptions: Codable, Hashable, Sendable {
                    /// Amount to be charged for future payments, specified in the presentment currency.
                    public var amount: Int?
                    /// One of `fixed` or `maximum`.
                    public var amountType: AmountType?
                    /// A description of the mandate or subscription that is meant to be displayed to the customer.
                    public var description: String?
                    /// End date of the mandate or subscription.
                    public var endDate: Date?
                    /// Specifies payment frequency.
                    public var interval: Interval?
                    /// The number of intervals between payments.
                    public var intervalCount: Int?
                    /// Unique identifier for the mandate or subscription.
                    public var reference: String?
                    /// Start date of the mandate or subscription.
                    public var startDate: Date?
                    /// Specifies the type of mandates supported.
                    public var supportedTypes: [String]?

                    public init(
                        amount: Int? = nil,
                        amountType: AmountType? = nil,
                        description: String? = nil,
                        endDate: Date? = nil,
                        interval: Interval? = nil,
                        intervalCount: Int? = nil,
                        reference: String? = nil,
                        startDate: Date? = nil,
                        supportedTypes: [String]? = nil
                    ) {
                        self.amount = amount
                        self.amountType = amountType
                        self.description = description
                        self.endDate = endDate
                        self.interval = interval
                        self.intervalCount = intervalCount
                        self.reference = reference
                        self.startDate = startDate
                        self.supportedTypes = supportedTypes
                    }

                    /// One of `fixed` or `maximum`.
                    public enum AmountType: String, Codable, Hashable, Sendable {
                        case fixed
                        case maximum
                    }

                    /// Specifies payment frequency.
                    public enum Interval: String, Codable, Hashable, Sendable {
                        case day
                        case month
                        case sporadic
                        case week
                        case year
                    }
                }
            }

            public struct CardPresent: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: CaptureMethod?
                /// Request ability to capture this payment beyond the standard authorization validity window.
                public var requestExtendedAuthorization: Bool?
                /// Request ability to increment this PaymentIntent if the combination of MCC and card brand is eligible.
                public var requestIncrementalAuthorizationSupport: Bool?
                public var routing: Routing?

                public init(
                    captureMethod: CaptureMethod? = nil,
                    requestExtendedAuthorization: Bool? = nil,
                    requestIncrementalAuthorizationSupport: Bool? = nil,
                    routing: Routing? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.requestExtendedAuthorization = requestExtendedAuthorization
                    self.requestIncrementalAuthorizationSupport = requestIncrementalAuthorizationSupport
                    self.routing = routing
                }

                /// Controls when the funds will be captured from the customer's account.
                public enum CaptureMethod: String, Codable, Hashable, Sendable {
                    case manual
                    case manualPreferred = "manual_preferred"
                }

                public struct Routing: Codable, Hashable, Sendable {
                    /// Requested routing priority.
                    public var requestedPriority: RequestedPriority?

                    public init(
                        requestedPriority: RequestedPriority? = nil
                    ) {
                        self.requestedPriority = requestedPriority
                    }

                    /// Requested routing priority.
                    public enum RequestedPriority: String, Codable, Hashable, Sendable {
                        case domestic
                        case international
                    }
                }
            }

            public struct Cashapp: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    captureMethod: String? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                    case onSession = "on_session"
                }
            }

            public struct Crypto: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct CustomerBalance: Codable, Hashable, Sendable {
                public var bankTransfer: BankTransfer?
                /// The funding method type to be used when there are not enough funds in the customer balance.
                public var fundingType: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    bankTransfer: BankTransfer? = nil,
                    fundingType: String? = nil,
                    setupFutureUsage: String? = nil
                ) {
                    self.bankTransfer = bankTransfer
                    self.fundingType = fundingType
                    self.setupFutureUsage = setupFutureUsage
                }

                public struct BankTransfer: Codable, Hashable, Sendable {
                    public var euBankTransfer: Stripe.Shared.EuBankTransfer?
                    /// List of address types that should be returned in the financial_addresses response.
                    public var requestedAddressTypes: [RequestedAddressTypes]?
                    /// The bank transfer type that this PaymentIntent is allowed to use for funding Permitted values include.
                    public var `type`: Type?

                    public init(
                        euBankTransfer: Stripe.Shared.EuBankTransfer? = nil,
                        requestedAddressTypes: [RequestedAddressTypes]? = nil,
                        `type`: Type? = nil
                    ) {
                        self.euBankTransfer = euBankTransfer
                        self.requestedAddressTypes = requestedAddressTypes
                        self.`type` = `type`
                    }

                    public enum RequestedAddressTypes: String, Codable, Hashable, Sendable {
                        case aba
                        case iban
                        case sepa
                        case sortCode = "sort_code"
                        case spei
                        case swift
                        case zengin
                    }

                    /// The bank transfer type that this PaymentIntent is allowed to use for funding Permitted values include.
                    public enum `Type`: String, Codable, Hashable, Sendable {
                        case euBankTransfer = "eu_bank_transfer"
                        case gbBankTransfer = "gb_bank_transfer"
                        case jpBankTransfer = "jp_bank_transfer"
                        case mxBankTransfer = "mx_bank_transfer"
                        case usBankTransfer = "us_bank_transfer"
                    }
                }
            }

            public struct Eps: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Fpx: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Giropay: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Grabpay: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Ideal: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct InteracPresent: Codable, Hashable, Sendable {
                public init() {}
            }

            public struct KakaoPay: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    captureMethod: String? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct Klarna: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Preferred locale of the Klarna checkout page that the customer is redirected to.
                public var preferredLocale: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    captureMethod: String? = nil,
                    preferredLocale: String? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.preferredLocale = preferredLocale
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                    case onSession = "on_session"
                }
            }

            public struct Konbini: Codable, Hashable, Sendable {
                /// An optional 10 to 11 digit numeric-only string determining the confirmation code at applicable convenience stores.
                public var confirmationNumber: String?
                /// The number of calendar days (between 1 and 60) after which Konbini payment instructions will expire.
                public var expiresAfterDays: Int?
                /// The timestamp at which the Konbini payment instructions will expire.
                public var expiresAt: Date?
                /// A product descriptor of up to 22 characters, which will appear to customers at the convenience store.
                public var productDescription: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    confirmationNumber: String? = nil,
                    expiresAfterDays: Int? = nil,
                    expiresAt: Date? = nil,
                    productDescription: String? = nil,
                    setupFutureUsage: String? = nil
                ) {
                    self.confirmationNumber = confirmationNumber
                    self.expiresAfterDays = expiresAfterDays
                    self.expiresAt = expiresAt
                    self.productDescription = productDescription
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct KrCard: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    captureMethod: String? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct Link: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// [Deprecated] This is a legacy parameter that no longer has any function.
                public var persistentToken: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    captureMethod: String? = nil,
                    persistentToken: String? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.persistentToken = persistentToken
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct MbWay: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Mobilepay: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    captureMethod: String? = nil,
                    setupFutureUsage: String? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Multibanco: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct NaverPay: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    captureMethod: String? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct NzBankAccount: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?
                /// Controls when Stripe will attempt to debit the funds from the customer's account.
                public var targetDate: String?

                public init(
                    setupFutureUsage: SetupFutureUsage? = nil,
                    targetDate: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                    self.targetDate = targetDate
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                    case onSession = "on_session"
                }
            }

            public struct Oxxo: Codable, Hashable, Sendable {
                /// The number of calendar days before an OXXO invoice expires.
                public var expiresAfterDays: Int?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    expiresAfterDays: Int? = nil,
                    setupFutureUsage: String? = nil
                ) {
                    self.expiresAfterDays = expiresAfterDays
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct P24: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct PayByBank: Codable, Hashable, Sendable {
                public init() {}
            }

            public struct Payco: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    captureMethod: String? = nil,
                    setupFutureUsage: String? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Paynow: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Paypal: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Preferred locale of the PayPal checkout page that the customer is redirected to.
                public var preferredLocale: String?
                /// A reference of the PayPal transaction visible to customer which is mapped to PayPal's invoice ID.
                public var reference: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    captureMethod: String? = nil,
                    preferredLocale: String? = nil,
                    reference: String? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.preferredLocale = preferredLocale
                    self.reference = reference
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct Payto: Codable, Hashable, Sendable {
                public var mandateOptions: MandateOptions?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    mandateOptions: MandateOptions? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.mandateOptions = mandateOptions
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }

                public struct MandateOptions: Codable, Hashable, Sendable {
                    /// Amount that will be collected.
                    public var amount: Int?
                    /// The type of amount that will be collected.
                    public var amountType: AmountType?
                    /// Date, in YYYY-MM-DD format, after which payments will not be collected.
                    public var endDate: String?
                    /// The periodicity at which payments will be collected.
                    public var paymentSchedule: PaymentSchedule?
                    /// The number of payments that will be made during a payment period.
                    public var paymentsPerPeriod: Int?
                    /// The purpose for which payments are made.
                    public var purpose: Purpose?

                    public init(
                        amount: Int? = nil,
                        amountType: AmountType? = nil,
                        endDate: String? = nil,
                        paymentSchedule: PaymentSchedule? = nil,
                        paymentsPerPeriod: Int? = nil,
                        purpose: Purpose? = nil
                    ) {
                        self.amount = amount
                        self.amountType = amountType
                        self.endDate = endDate
                        self.paymentSchedule = paymentSchedule
                        self.paymentsPerPeriod = paymentsPerPeriod
                        self.purpose = purpose
                    }

                    /// The type of amount that will be collected.
                    public enum AmountType: String, Codable, Hashable, Sendable {
                        case fixed
                        case maximum
                    }

                    /// The periodicity at which payments will be collected.
                    public enum PaymentSchedule: String, Codable, Hashable, Sendable {
                        case adhoc
                        case annual
                        case daily
                        case fortnightly
                        case monthly
                        case quarterly
                        case semiAnnual = "semi_annual"
                        case weekly
                    }

                    /// The purpose for which payments are made.
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
                /// The timestamp at which the Pix expires.
                public var expiresAt: Int?
                public var mandateOptions: Stripe.Shared.MandateOptions?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    amountIncludesIof: AmountIncludesIof? = nil,
                    expiresAfterSeconds: Int? = nil,
                    expiresAt: Int? = nil,
                    mandateOptions: Stripe.Shared.MandateOptions? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.amountIncludesIof = amountIncludesIof
                    self.expiresAfterSeconds = expiresAfterSeconds
                    self.expiresAt = expiresAt
                    self.mandateOptions = mandateOptions
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Determines if the amount includes the IOF tax.
                public enum AmountIncludesIof: String, Codable, Hashable, Sendable {
                    case always
                    case never
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct Promptpay: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct RevolutPay: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    captureMethod: String? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct SamsungPay: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    captureMethod: String? = nil,
                    setupFutureUsage: String? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Satispay: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    captureMethod: String? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                    case onSession = "on_session"
                }
            }

            public struct Scalapay: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?

                public init(
                    captureMethod: String? = nil
                ) {
                    self.captureMethod = captureMethod
                }
            }

            public struct SepaDebit: Codable, Hashable, Sendable {
                public var mandateOptions: MandateOptions?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?
                /// Controls when Stripe will attempt to debit the funds from the customer's account.
                public var targetDate: String?

                public init(
                    mandateOptions: MandateOptions? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil,
                    targetDate: String? = nil
                ) {
                    self.mandateOptions = mandateOptions
                    self.setupFutureUsage = setupFutureUsage
                    self.targetDate = targetDate
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                    case onSession = "on_session"
                }

                public struct MandateOptions: Codable, Hashable, Sendable {
                    /// Prefix used to generate the Mandate reference.
                    public var referencePrefix: String?

                    public init(
                        referencePrefix: String? = nil
                    ) {
                        self.referencePrefix = referencePrefix
                    }
                }
            }

            public struct Sofort: Codable, Hashable, Sendable {
                /// Preferred language of the SOFORT authorization page that the customer is redirected to.
                public var preferredLanguage: PreferredLanguage?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    preferredLanguage: PreferredLanguage? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.preferredLanguage = preferredLanguage
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Preferred language of the SOFORT authorization page that the customer is redirected to.
                public enum PreferredLanguage: String, Codable, Hashable, Sendable {
                    case de
                    case en
                    case es
                    case fr
                    case it
                    case nl
                    case pl
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct Sunbit: Codable, Hashable, Sendable {
                /// Controls when the funds will be captured from the customer's account.
                public var captureMethod: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    captureMethod: String? = nil,
                    setupFutureUsage: String? = nil
                ) {
                    self.captureMethod = captureMethod
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Swish: Codable, Hashable, Sendable {
                /// A reference for this payment to be displayed in the Swish app.
                public var reference: String?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    reference: String? = nil,
                    setupFutureUsage: String? = nil
                ) {
                    self.reference = reference
                    self.setupFutureUsage = setupFutureUsage
                }
            }

            public struct Twint: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                }
            }

            public struct Upi: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?

                public init(
                    setupFutureUsage: SetupFutureUsage? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case offSession = "off_session"
                    case onSession = "on_session"
                }
            }

            public struct UsBankAccount: Codable, Hashable, Sendable {
                public var financialConnections: Stripe.Shared.FinancialConnections?
                public var mandateOptions: Stripe.Shared.PaymentMethodOptionsUsBankAccountMandateOptions?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: SetupFutureUsage?
                /// Controls when Stripe will attempt to debit the funds from the customer's account.
                public var targetDate: String?
                /// The purpose of the transaction.
                public var transactionPurpose: TransactionPurpose?
                /// Bank account verification method.
                public var verificationMethod: VerificationMethod?

                public init(
                    financialConnections: Stripe.Shared.FinancialConnections? = nil,
                    mandateOptions: Stripe.Shared.PaymentMethodOptionsUsBankAccountMandateOptions? = nil,
                    setupFutureUsage: SetupFutureUsage? = nil,
                    targetDate: String? = nil,
                    transactionPurpose: TransactionPurpose? = nil,
                    verificationMethod: VerificationMethod? = nil
                ) {
                    self.financialConnections = financialConnections
                    self.mandateOptions = mandateOptions
                    self.setupFutureUsage = setupFutureUsage
                    self.targetDate = targetDate
                    self.transactionPurpose = transactionPurpose
                    self.verificationMethod = verificationMethod
                }

                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                    case none
                    case offSession = "off_session"
                    case onSession = "on_session"
                }

                /// The purpose of the transaction.
                public enum TransactionPurpose: String, Codable, Hashable, Sendable {
                    case goods
                    case other
                    case services
                    case unspecified
                }

                /// Bank account verification method.
                public enum VerificationMethod: String, Codable, Hashable, Sendable {
                    case automatic
                    case instant
                    case microdeposits
                }
            }

            public struct WechatPay: Codable, Hashable, Sendable {
                /// The app ID registered with WeChat Pay.
                public var appId: String?
                /// The client type that the end customer will pay from.
                public var client: Client?
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    appId: String? = nil,
                    client: Client? = nil,
                    setupFutureUsage: String? = nil
                ) {
                    self.appId = appId
                    self.client = client
                    self.setupFutureUsage = setupFutureUsage
                }

                /// The client type that the end customer will pay from.
                public enum Client: String, Codable, Hashable, Sendable {
                    case android
                    case ios
                    case web
                }
            }

            public struct Zip: Codable, Hashable, Sendable {
                /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
                public var setupFutureUsage: String?

                public init(
                    setupFutureUsage: String? = nil
                ) {
                    self.setupFutureUsage = setupFutureUsage
                }
            }
        }

        public struct Processing: Codable, Hashable, Sendable {
            @Boxed public var card: Card?
            /// Type of the payment method for which payment is in `processing` state, one of `card`.
            public var `type`: String?

            public init(
                card: Card? = nil,
                `type`: String? = nil
            ) {
                self._card = Boxed(wrappedValue: card)
                self.`type` = `type`
            }

            public struct Card: Codable, Hashable, Sendable {
                public var customerNotification: CustomerNotification?

                public init(
                    customerNotification: CustomerNotification? = nil
                ) {
                    self.customerNotification = customerNotification
                }

                public struct CustomerNotification: Codable, Hashable, Sendable {
                    /// Whether customer approval has been requested for this payment.
                    public var approvalRequested: Bool?
                    /// If customer approval is required, they need to provide approval before this time.
                    public var completesAt: Date?

                    public init(
                        approvalRequested: Bool? = nil,
                        completesAt: Date? = nil
                    ) {
                        self.approvalRequested = approvalRequested
                        self.completesAt = completesAt
                    }
                }
            }
        }

        public struct TransferData: Codable, Hashable, Sendable {
            /// The amount transferred to the destination account.
            public var amount: Int?
            /// An arbitrary string attached to the transfer.
            public var description: String?
            /// The account (if any) that the payment is attributed to for tax reporting, and where funds from the payment are.
            @Expandable<Stripe.Connect.Account, String> public var destination: String?
            /// Set of key-value pairs that you can attach to an object.
            public var metadata: [String: String]?
            public var paymentData: PaymentData?

            public init(
                amount: Int? = nil,
                description: String? = nil,
                destination: String? = nil,
                metadata: [String: String]? = nil,
                paymentData: PaymentData? = nil
            ) {
                self.amount = amount
                self.description = description
                self._destination = Expandable(id: destination)
                self.metadata = metadata
                self.paymentData = paymentData
            }

            public struct PaymentData: Codable, Hashable, Sendable {
                /// An arbitrary string attached to the destination payment.
                public var description: String?
                /// Set of key-value pairs that you can attach to an object.
                public var metadata: [String: String]?

                public init(
                    description: String? = nil,
                    metadata: [String: String]? = nil
                ) {
                    self.description = description
                    self.metadata = metadata
                }
            }
        }
    }
}
