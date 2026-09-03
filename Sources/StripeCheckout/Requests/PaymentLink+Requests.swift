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

extension Stripe.PaymentLink {
    public enum Create {}
    public enum List {}
    public enum ListLineItems {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/payment_links
extension Stripe.PaymentLink.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Behavior after the purchase is complete.
        public var afterCompletion: AfterCompletion?
        /// Enables user redeemable promotion codes.
        public var allowPromotionCodes: Bool?
        /// The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the.
        public var applicationFeeAmount: Int?
        /// A non-negative decimal between 0 and 100, with at most two decimal places.
        public var applicationFeePercent: Decimal?
        /// Configuration for automatic tax collection.
        public var automaticTax: AutomaticTax?
        /// Configuration for collecting the customer's billing address.
        public var billingAddressCollection: BillingAddressCollection?
        /// Configure fields to gather active consent from customers.
        public var consentCollection: ConsentCollection?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// Collect additional information from your customer using custom fields.
        public var customFields: [CustomFields]?
        /// Display additional text for your customers using custom text.
        public var customText: CustomText?
        /// Configures whether checkout sessions created by this payment link create a Customer.
        public var customerCreation: CustomerCreation?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The custom message to be displayed to a customer when a payment link is no longer active.
        public var inactiveMessage: String?
        /// Generate a post-purchase Invoice for one-time payments.
        public var invoiceCreation: InvoiceCreation?
        /// The line items representing what is being sold.
        public var lineItems: [LineItems]
        /// Settings for Managed Payments for this Payment Link and resulting CheckoutSessions, PaymentIntents, Invoices, and.
        public var managedPayments: ManagedPayments?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// Controls settings applied for collecting the customer's name.
        public var nameCollection: NameCollection?
        /// The account on behalf of which to charge.
        public var onBehalfOf: String?
        /// A list of optional items the customer can add to their order at checkout.
        public var optionalItems: [OptionalItems]?
        /// A subset of parameters to be passed to PaymentIntent creation for Checkout Sessions in `payment` mode.
        public var paymentIntentData: PaymentIntentData?
        /// Specify whether Checkout should collect a payment method.
        public var paymentMethodCollection: PaymentMethodCollection?
        /// Payment-method-specific configuration.
        public var paymentMethodOptions: PaymentMethodOptions?
        /// The list of payment method types that customers can use.
        public var paymentMethodTypes: [PaymentMethodTypes]?
        /// Controls phone number collection settings during checkout.
        public var phoneNumberCollection: PhoneNumberCollection?
        /// Settings that restrict the usage of a payment link.
        public var restrictions: Restrictions?
        /// Configuration for collecting the customer's shipping address.
        public var shippingAddressCollection: ShippingAddressCollection?
        /// The shipping rate options to apply to checkout sessions created by this payment link.
        public var shippingOptions: [ShippingOptions]?
        /// Describes the type of transaction being performed in order to customize relevant text on the page, such as the submit.
        public var submitType: SubmitType?
        /// When creating a subscription, the specified configuration data will be used.
        public var subscriptionData: SubscriptionData?
        /// Controls tax ID collection during checkout.
        public var taxIdCollection: TaxIdCollection?
        /// The account (if any) the payments will be attributed to for tax reporting, and where funds from each payment will be.
        public var transferData: TransferData?

        public init(
            afterCompletion: AfterCompletion? = nil,
            allowPromotionCodes: Bool? = nil,
            applicationFeeAmount: Int? = nil,
            applicationFeePercent: Decimal? = nil,
            automaticTax: AutomaticTax? = nil,
            billingAddressCollection: BillingAddressCollection? = nil,
            consentCollection: ConsentCollection? = nil,
            currency: Stripe.Currency? = nil,
            customFields: [CustomFields]? = nil,
            customText: CustomText? = nil,
            customerCreation: CustomerCreation? = nil,
            expand: [String]? = nil,
            inactiveMessage: String? = nil,
            invoiceCreation: InvoiceCreation? = nil,
            lineItems: [LineItems],
            managedPayments: ManagedPayments? = nil,
            metadata: [String: String]? = nil,
            nameCollection: NameCollection? = nil,
            onBehalfOf: String? = nil,
            optionalItems: [OptionalItems]? = nil,
            paymentIntentData: PaymentIntentData? = nil,
            paymentMethodCollection: PaymentMethodCollection? = nil,
            paymentMethodOptions: PaymentMethodOptions? = nil,
            paymentMethodTypes: [PaymentMethodTypes]? = nil,
            phoneNumberCollection: PhoneNumberCollection? = nil,
            restrictions: Restrictions? = nil,
            shippingAddressCollection: ShippingAddressCollection? = nil,
            shippingOptions: [ShippingOptions]? = nil,
            submitType: SubmitType? = nil,
            subscriptionData: SubscriptionData? = nil,
            taxIdCollection: TaxIdCollection? = nil,
            transferData: TransferData? = nil
        ) {
            self.afterCompletion = afterCompletion
            self.allowPromotionCodes = allowPromotionCodes
            self.applicationFeeAmount = applicationFeeAmount
            self.applicationFeePercent = applicationFeePercent
            self.automaticTax = automaticTax
            self.billingAddressCollection = billingAddressCollection
            self.consentCollection = consentCollection
            self.currency = currency
            self.customFields = customFields
            self.customText = customText
            self.customerCreation = customerCreation
            self.expand = expand
            self.inactiveMessage = inactiveMessage
            self.invoiceCreation = invoiceCreation
            self.lineItems = lineItems
            self.managedPayments = managedPayments
            self.metadata = metadata
            self.nameCollection = nameCollection
            self.onBehalfOf = onBehalfOf
            self.optionalItems = optionalItems
            self.paymentIntentData = paymentIntentData
            self.paymentMethodCollection = paymentMethodCollection
            self.paymentMethodOptions = paymentMethodOptions
            self.paymentMethodTypes = paymentMethodTypes
            self.phoneNumberCollection = phoneNumberCollection
            self.restrictions = restrictions
            self.shippingAddressCollection = shippingAddressCollection
            self.shippingOptions = shippingOptions
            self.submitType = submitType
            self.subscriptionData = subscriptionData
            self.taxIdCollection = taxIdCollection
            self.transferData = transferData
        }

        public enum BillingAddressCollection: String, Codable, Hashable, Sendable {
            case auto
            case required
        }

        public enum CustomerCreation: String, Codable, Hashable, Sendable {
            case always
            case ifRequired = "if_required"
        }

        public enum PaymentMethodCollection: String, Codable, Hashable, Sendable {
            case always
            case ifRequired = "if_required"
        }

        public enum PaymentMethodTypes: String, Codable, Hashable, Sendable {
            case affirm
            case afterpayClearpay = "afterpay_clearpay"
            case alipay
            case alma
            case auBecsDebit = "au_becs_debit"
            case bacsDebit = "bacs_debit"
            case bancontact
            case billie
            case bizum
            case blik
            case boleto
            case card
            case cashapp
            case eps
            case fpx
            case giropay
            case grabpay
            case ideal
            case klarna
            case konbini
            case link
            case mbWay = "mb_way"
            case mobilepay
            case multibanco
            case oxxo
            case p24
            case payByBank = "pay_by_bank"
            case paynow
            case paypal
            case payto
            case pix
            case promptpay
            case satispay
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

        public enum SubmitType: String, Codable, Hashable, Sendable {
            case auto
            case book
            case donate
            case pay
            case subscribe
        }

        /// Behavior after the purchase is complete.
        public struct AfterCompletion: Codable, Hashable, Sendable {
            /// Configuration when `type=hosted_confirmation`.
            public var hostedConfirmation: HostedConfirmation?
            /// Configuration when `type=redirect`.
            public var redirect: Redirect?
            /// The specified behavior after the purchase is complete.
            public var `type`: Type

            public init(
                hostedConfirmation: HostedConfirmation? = nil,
                redirect: Redirect? = nil,
                `type`: Type
            ) {
                self.hostedConfirmation = hostedConfirmation
                self.redirect = redirect
                self.`type` = `type`
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case hostedConfirmation = "hosted_confirmation"
                case redirect
            }

            /// Configuration when `type=hosted_confirmation`.
            public struct HostedConfirmation: Codable, Hashable, Sendable {
                /// A custom message to display to the customer after the purchase is complete.
                public var customMessage: String?

                public init(
                    customMessage: String? = nil
                ) {
                    self.customMessage = customMessage
                }
            }

            /// Configuration when `type=redirect`.
            public struct Redirect: Codable, Hashable, Sendable {
                /// The URL the customer will be redirected to after the purchase is complete.
                public var url: String

                public init(
                    url: String
                ) {
                    self.url = url
                }
            }
        }

        /// Configuration for automatic tax collection.
        public struct AutomaticTax: Codable, Hashable, Sendable {
            /// Set to `true` to calculate tax automatically using the customer's location.
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

        /// Configure fields to gather active consent from customers.
        public struct ConsentCollection: Codable, Hashable, Sendable {
            /// Determines the display of payment method reuse agreement text in the UI.
            public var paymentMethodReuseAgreement: PaymentMethodReuseAgreement?
            /// If set to `auto`, enables the collection of customer consent for promotional communications.
            public var promotions: Promotions?
            /// If set to `required`, it requires customers to check a terms of service checkbox before being able to pay.
            public var termsOfService: TermsOfService?

            public init(
                paymentMethodReuseAgreement: PaymentMethodReuseAgreement? = nil,
                promotions: Promotions? = nil,
                termsOfService: TermsOfService? = nil
            ) {
                self.paymentMethodReuseAgreement = paymentMethodReuseAgreement
                self.promotions = promotions
                self.termsOfService = termsOfService
            }

            public enum Promotions: String, Codable, Hashable, Sendable {
                case auto
                case none
            }

            public enum TermsOfService: String, Codable, Hashable, Sendable {
                case none
                case required
            }

            /// Determines the display of payment method reuse agreement text in the UI.
            public struct PaymentMethodReuseAgreement: Codable, Hashable, Sendable {
                /// Determines the position and visibility of the payment method reuse agreement in the UI.
                public var position: Position

                public init(
                    position: Position
                ) {
                    self.position = position
                }

                public enum Position: String, Codable, Hashable, Sendable {
                    case auto
                    case hidden
                }
            }
        }

        public struct CustomFields: Codable, Hashable, Sendable {
            /// Configuration for `type=dropdown` fields.
            public var dropdown: Dropdown?
            /// String of your choice that your integration can use to reconcile this field.
            public var key: String
            /// The label for the field, displayed to the customer.
            public var label: Label
            /// Configuration for `type=numeric` fields.
            public var numeric: Numeric?
            /// Whether the customer is required to complete the field before completing the Checkout Session.
            public var optional: Bool?
            /// Configuration for `type=text` fields.
            public var text: Text?
            /// The type of the field.
            public var `type`: Type

            public init(
                dropdown: Dropdown? = nil,
                key: String,
                label: Label,
                numeric: Numeric? = nil,
                optional: Bool? = nil,
                text: Text? = nil,
                `type`: Type
            ) {
                self.dropdown = dropdown
                self.key = key
                self.label = label
                self.numeric = numeric
                self.optional = optional
                self.text = text
                self.`type` = `type`
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case dropdown
                case numeric
                case text
            }

            /// Configuration for `type=dropdown` fields.
            public struct Dropdown: Codable, Hashable, Sendable {
                /// The value that pre-fills the field on the payment page.
                public var defaultValue: String?
                /// The options available for the customer to select.
                public var options: [Options]

                public init(
                    defaultValue: String? = nil,
                    options: [Options]
                ) {
                    self.defaultValue = defaultValue
                    self.options = options
                }

                public struct Options: Codable, Hashable, Sendable {
                    /// The label for the option, displayed to the customer.
                    public var label: String
                    /// The value for this option, not displayed to the customer, used by your integration to reconcile the option selected.
                    public var value: String

                    public init(
                        label: String,
                        value: String
                    ) {
                        self.label = label
                        self.value = value
                    }
                }
            }

            /// The label for the field, displayed to the customer.
            public struct Label: Codable, Hashable, Sendable {
                /// Custom text for the label, displayed to the customer.
                public var custom: String
                /// The type of the label.
                public var `type`: String

                public init(
                    custom: String,
                    `type`: String
                ) {
                    self.custom = custom
                    self.`type` = `type`
                }
            }

            /// Configuration for `type=numeric` fields.
            public struct Numeric: Codable, Hashable, Sendable {
                /// The value that pre-fills the field on the payment page.
                public var defaultValue: String?
                /// The maximum character length constraint for the customer's input.
                public var maximumLength: Int?
                /// The minimum character length requirement for the customer's input.
                public var minimumLength: Int?

                public init(
                    defaultValue: String? = nil,
                    maximumLength: Int? = nil,
                    minimumLength: Int? = nil
                ) {
                    self.defaultValue = defaultValue
                    self.maximumLength = maximumLength
                    self.minimumLength = minimumLength
                }
            }

            /// Configuration for `type=text` fields.
            public struct Text: Codable, Hashable, Sendable {
                /// The value that pre-fills the field on the payment page.
                public var defaultValue: String?
                /// The maximum character length constraint for the customer's input.
                public var maximumLength: Int?
                /// The minimum character length requirement for the customer's input.
                public var minimumLength: Int?

                public init(
                    defaultValue: String? = nil,
                    maximumLength: Int? = nil,
                    minimumLength: Int? = nil
                ) {
                    self.defaultValue = defaultValue
                    self.maximumLength = maximumLength
                    self.minimumLength = minimumLength
                }
            }
        }

        /// Display additional text for your customers using custom text.
        public struct CustomText: Codable, Hashable, Sendable {
            /// Custom text that should be displayed after the payment confirmation button.
            public var afterSubmit: Stripe.Clearable<AfterSubmit>?
            /// Custom text that should be displayed alongside shipping address collection.
            public var shippingAddress: Stripe.Clearable<ShippingAddress>?
            /// Custom text that should be displayed alongside the payment confirmation button.
            public var submit: Stripe.Clearable<Submit>?
            /// Custom text that should be displayed in place of the default terms of service agreement text.
            public var termsOfServiceAcceptance: Stripe.Clearable<TermsOfServiceAcceptance>?

            public init(
                afterSubmit: Stripe.Clearable<AfterSubmit>? = nil,
                shippingAddress: Stripe.Clearable<ShippingAddress>? = nil,
                submit: Stripe.Clearable<Submit>? = nil,
                termsOfServiceAcceptance: Stripe.Clearable<TermsOfServiceAcceptance>? = nil
            ) {
                self.afterSubmit = afterSubmit
                self.shippingAddress = shippingAddress
                self.submit = submit
                self.termsOfServiceAcceptance = termsOfServiceAcceptance
            }

            public struct AfterSubmit: Codable, Hashable, Sendable {
                /// Text can be up to 1200 characters in length.
                public var message: String

                public init(
                    message: String
                ) {
                    self.message = message
                }
            }

            public struct ShippingAddress: Codable, Hashable, Sendable {
                /// Text can be up to 1200 characters in length.
                public var message: String

                public init(
                    message: String
                ) {
                    self.message = message
                }
            }

            public struct Submit: Codable, Hashable, Sendable {
                /// Text can be up to 1200 characters in length.
                public var message: String

                public init(
                    message: String
                ) {
                    self.message = message
                }
            }

            public struct TermsOfServiceAcceptance: Codable, Hashable, Sendable {
                /// Text can be up to 1200 characters in length.
                public var message: String

                public init(
                    message: String
                ) {
                    self.message = message
                }
            }
        }

        /// Generate a post-purchase Invoice for one-time payments.
        public struct InvoiceCreation: Codable, Hashable, Sendable {
            /// Whether the feature is enabled.
            public var enabled: Bool
            /// Invoice PDF configuration.
            public var invoiceData: InvoiceData?

            public init(
                enabled: Bool,
                invoiceData: InvoiceData? = nil
            ) {
                self.enabled = enabled
                self.invoiceData = invoiceData
            }

            /// Invoice PDF configuration.
            public struct InvoiceData: Codable, Hashable, Sendable {
                /// The account tax IDs associated with the invoice.
                public var accountTaxIds: Stripe.Clearable<[String]>?
                /// Default custom fields to be displayed on invoices for this customer.
                public var customFields: Stripe.Clearable<[CustomFields]>?
                /// An arbitrary string attached to the object.
                public var description: String?
                /// Default footer to be displayed on invoices for this customer.
                public var footer: String?
                /// The connected account that issues the invoice.
                public var issuer: Issuer?
                /// Set of key-value pairs that you can attach to an object.
                public var metadata: Stripe.Clearable<[String: String]>?
                /// Default options for invoice PDF rendering for this customer.
                public var renderingOptions: Stripe.Clearable<RenderingOptions>?

                public init(
                    accountTaxIds: Stripe.Clearable<[String]>? = nil,
                    customFields: Stripe.Clearable<[CustomFields]>? = nil,
                    description: String? = nil,
                    footer: String? = nil,
                    issuer: Issuer? = nil,
                    metadata: Stripe.Clearable<[String: String]>? = nil,
                    renderingOptions: Stripe.Clearable<RenderingOptions>? = nil
                ) {
                    self.accountTaxIds = accountTaxIds
                    self.customFields = customFields
                    self.description = description
                    self.footer = footer
                    self.issuer = issuer
                    self.metadata = metadata
                    self.renderingOptions = renderingOptions
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

                public struct RenderingOptions: Codable, Hashable, Sendable {
                    /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
                    public var amountTaxDisplay: AmountTaxDisplay?
                    /// ID of the invoice rendering template to use for this invoice.
                    public var template: String?

                    public init(
                        amountTaxDisplay: AmountTaxDisplay? = nil,
                        template: String? = nil
                    ) {
                        self.amountTaxDisplay = amountTaxDisplay
                        self.template = template
                    }

                    public enum AmountTaxDisplay: String, Codable, Hashable, Sendable {
                        case value = ""
                        case excludeTax = "exclude_tax"
                        case includeInclusiveTax = "include_inclusive_tax"
                    }
                }
            }
        }

        public struct LineItems: Codable, Hashable, Sendable {
            /// When set, provides configuration for this item’s quantity to be adjusted by the customer during checkout.
            public var adjustableQuantity: AdjustableQuantity?
            /// The ID of the Price or Plan object.
            public var price: String?
            /// Data used to generate a new Price object inline.
            public var priceData: PriceData?
            /// The quantity of the line item being purchased.
            public var quantity: Int

            public init(
                adjustableQuantity: AdjustableQuantity? = nil,
                price: String? = nil,
                priceData: PriceData? = nil,
                quantity: Int
            ) {
                self.adjustableQuantity = adjustableQuantity
                self.price = price
                self.priceData = priceData
                self.quantity = quantity
            }

            /// When set, provides configuration for this item’s quantity to be adjusted by the customer during checkout.
            public struct AdjustableQuantity: Codable, Hashable, Sendable {
                /// Set to true if the quantity can be adjusted to any non-negative Integer.
                public var enabled: Bool
                /// The maximum quantity the customer can purchase.
                public var maximum: Int?
                /// The minimum quantity the customer can purchase.
                public var minimum: Int?

                public init(
                    enabled: Bool,
                    maximum: Int? = nil,
                    minimum: Int? = nil
                ) {
                    self.enabled = enabled
                    self.maximum = maximum
                    self.minimum = minimum
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
                /// The recurring components of a price such as `interval` and `interval_count`.
                public var recurring: Recurring?
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
                    recurring: Recurring? = nil,
                    taxBehavior: TaxBehavior? = nil,
                    unitAmount: Int? = nil,
                    unitAmountDecimal: String? = nil
                ) {
                    self.currency = currency
                    self.product = product
                    self.productData = productData
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

        /// Settings for Managed Payments for this Payment Link and resulting CheckoutSessions, PaymentIntents, Invoices, and.
        public struct ManagedPayments: Codable, Hashable, Sendable {
            /// Set to `true` to enable Managed Payments, Stripe's merchant of record solution, for this session.
            public var enabled: Bool?

            public init(
                enabled: Bool? = nil
            ) {
                self.enabled = enabled
            }
        }

        /// Controls settings applied for collecting the customer's name.
        public struct NameCollection: Codable, Hashable, Sendable {
            /// Controls settings applied for collecting the customer's business name.
            public var business: Business?
            /// Controls settings applied for collecting the customer's individual name.
            public var individual: Individual?

            public init(
                business: Business? = nil,
                individual: Individual? = nil
            ) {
                self.business = business
                self.individual = individual
            }

            /// Controls settings applied for collecting the customer's business name.
            public struct Business: Codable, Hashable, Sendable {
                /// Enable business name collection on the payment link.
                public var enabled: Bool
                /// Whether the customer is required to provide their business name before checking out.
                public var optional: Bool?

                public init(
                    enabled: Bool,
                    optional: Bool? = nil
                ) {
                    self.enabled = enabled
                    self.optional = optional
                }
            }

            /// Controls settings applied for collecting the customer's individual name.
            public struct Individual: Codable, Hashable, Sendable {
                /// Enable individual name collection on the payment link.
                public var enabled: Bool
                /// Whether the customer is required to provide their full name before checking out.
                public var optional: Bool?

                public init(
                    enabled: Bool,
                    optional: Bool? = nil
                ) {
                    self.enabled = enabled
                    self.optional = optional
                }
            }
        }

        public struct OptionalItems: Codable, Hashable, Sendable {
            /// When set, provides configuration for the customer to adjust the quantity of the line item created when a customer.
            public var adjustableQuantity: AdjustableQuantity?
            /// The ID of the Price or Plan object.
            public var price: String
            /// The initial quantity of the line item created when a customer chooses to add this optional item to their order.
            public var quantity: Int

            public init(
                adjustableQuantity: AdjustableQuantity? = nil,
                price: String,
                quantity: Int
            ) {
                self.adjustableQuantity = adjustableQuantity
                self.price = price
                self.quantity = quantity
            }

            /// When set, provides configuration for the customer to adjust the quantity of the line item created when a customer.
            public struct AdjustableQuantity: Codable, Hashable, Sendable {
                /// Set to true if the quantity can be adjusted to any non-negative integer.
                public var enabled: Bool
                /// The maximum quantity of this item the customer can purchase.
                public var maximum: Int?
                /// The minimum quantity of this item the customer must purchase, if they choose to purchase it.
                public var minimum: Int?

                public init(
                    enabled: Bool,
                    maximum: Int? = nil,
                    minimum: Int? = nil
                ) {
                    self.enabled = enabled
                    self.maximum = maximum
                    self.minimum = minimum
                }
            }
        }

        /// A subset of parameters to be passed to PaymentIntent creation for Checkout Sessions in `payment` mode.
        public struct PaymentIntentData: Codable, Hashable, Sendable {
            /// Controls when the funds will be captured from the customer's account.
            public var captureMethod: CaptureMethod?
            /// An arbitrary string attached to the object.
            public var description: String?
            /// Set of key-value pairs that will declaratively set metadata on Payment Intents generated from this payment link.
            public var metadata: [String: String]?
            /// Indicates that you intend to make future payments with the payment method collected by this Checkout Session.
            public var setupFutureUsage: SetupFutureUsage?
            /// Text that appears on the customer's statement as the statement descriptor for a non-card charge.
            public var statementDescriptor: String?
            /// Provides information about a card charge.
            public var statementDescriptorSuffix: String?
            /// A string that identifies the resulting payment as part of a group.
            public var transferGroup: String?

            public init(
                captureMethod: CaptureMethod? = nil,
                description: String? = nil,
                metadata: [String: String]? = nil,
                setupFutureUsage: SetupFutureUsage? = nil,
                statementDescriptor: String? = nil,
                statementDescriptorSuffix: String? = nil,
                transferGroup: String? = nil
            ) {
                self.captureMethod = captureMethod
                self.description = description
                self.metadata = metadata
                self.setupFutureUsage = setupFutureUsage
                self.statementDescriptor = statementDescriptor
                self.statementDescriptorSuffix = statementDescriptorSuffix
                self.transferGroup = transferGroup
            }

            public enum CaptureMethod: String, Codable, Hashable, Sendable {
                case automatic
                case automaticAsync = "automatic_async"
                case manual
            }

            public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                case offSession = "off_session"
                case onSession = "on_session"
            }
        }

        /// Payment-method-specific configuration.
        public struct PaymentMethodOptions: Codable, Hashable, Sendable {
            /// Configuration for `card` payment methods.
            public var card: Card?

            public init(
                card: Card? = nil
            ) {
                self.card = card
            }

            /// Configuration for `card` payment methods.
            public struct Card: Codable, Hashable, Sendable {
                /// Restrictions to apply to the card payment method.
                public var restrictions: Restrictions?

                public init(
                    restrictions: Restrictions? = nil
                ) {
                    self.restrictions = restrictions
                }

                /// Restrictions to apply to the card payment method.
                public struct Restrictions: Codable, Hashable, Sendable {
                    /// The card brands to block.
                    public var brandsBlocked: [BrandsBlocked]?

                    public init(
                        brandsBlocked: [BrandsBlocked]? = nil
                    ) {
                        self.brandsBlocked = brandsBlocked
                    }

                    public enum BrandsBlocked: String, Codable, Hashable, Sendable {
                        case americanExpress = "american_express"
                        case discoverGlobalNetwork = "discover_global_network"
                        case mastercard
                        case visa
                    }
                }
            }
        }

        /// Controls phone number collection settings during checkout.
        public struct PhoneNumberCollection: Codable, Hashable, Sendable {
            /// Set to `true` to enable phone number collection.
            public var enabled: Bool

            public init(
                enabled: Bool
            ) {
                self.enabled = enabled
            }
        }

        /// Settings that restrict the usage of a payment link.
        public struct Restrictions: Codable, Hashable, Sendable {
            /// Configuration for the `completed_sessions` restriction type.
            public var completedSessions: CompletedSessions

            public init(
                completedSessions: CompletedSessions
            ) {
                self.completedSessions = completedSessions
            }

            /// Configuration for the `completed_sessions` restriction type.
            public struct CompletedSessions: Codable, Hashable, Sendable {
                /// The maximum number of checkout sessions that can be completed for the `completed_sessions` restriction to be met.
                public var limit: Int

                public init(
                    limit: Int
                ) {
                    self.limit = limit
                }
            }
        }

        /// Configuration for collecting the customer's shipping address.
        public struct ShippingAddressCollection: Codable, Hashable, Sendable {
            /// An array of two-letter ISO country codes representing which countries Checkout should provide as options for shipping.
            public var allowedCountries: [AllowedCountries]

            public init(
                allowedCountries: [AllowedCountries]
            ) {
                self.allowedCountries = allowedCountries
            }

            public enum AllowedCountries: String, Codable, Hashable, Sendable {
                case AC
                case AD
                case AE
                case AF
                case AG
                case AI
                case AL
                case AM
                case AO
                case AQ
                case AR
                case AT
                case AU
                case AW
                case AX
                case AZ
                case BA
                case BB
                case BD
                case BE
                case BF
                case BG
                case BH
                case BI
                case BJ
                case BL
                case BM
                case BN
                case BO
                case BQ
                case BR
                case BS
                case BT
                case BV
                case BW
                case BY
                case BZ
                case CA
                case CD
                case CF
                case CG
                case CH
                case CI
                case CK
                case CL
                case CM
                case CN
                case CO
                case CR
                case CV
                case CW
                case CY
                case CZ
                case DE
                case DJ
                case DK
                case DM
                case DO
                case DZ
                case EC
                case EE
                case EG
                case EH
                case ER
                case ES
                case ET
                case FI
                case FJ
                case FK
                case FO
                case FR
                case GA
                case GB
                case GD
                case GE
                case GF
                case GG
                case GH
                case GI
                case GL
                case GM
                case GN
                case GP
                case GQ
                case GR
                case GS
                case GT
                case GU
                case GW
                case GY
                case HK
                case HN
                case HR
                case HT
                case HU
                case ID
                case IE
                case IL
                case IM
                case IN
                case IO
                case IQ
                case IS
                case IT
                case JE
                case JM
                case JO
                case JP
                case KE
                case KG
                case KH
                case KI
                case KM
                case KN
                case KR
                case KW
                case KY
                case KZ
                case LA
                case LB
                case LC
                case LI
                case LK
                case LR
                case LS
                case LT
                case LU
                case LV
                case LY
                case MA
                case MC
                case MD
                case ME
                case MF
                case MG
                case MK
                case ML
                case MM
                case MN
                case MO
                case MQ
                case MR
                case MS
                case MT
                case MU
                case MV
                case MW
                case MX
                case MY
                case MZ
                case NA
                case NC
                case NE
                case NG
                case NI
                case NL
                case NO
                case NP
                case NR
                case NU
                case NZ
                case OM
                case PA
                case PE
                case PF
                case PG
                case PH
                case PK
                case PL
                case PM
                case PN
                case PR
                case PS
                case PT
                case PY
                case QA
                case RE
                case RO
                case RS
                case RU
                case RW
                case SA
                case SB
                case SC
                case SD
                case SE
                case SG
                case SH
                case SI
                case SJ
                case SK
                case SL
                case SM
                case SN
                case SO
                case SR
                case SS
                case ST
                case SV
                case SX
                case SZ
                case TA
                case TC
                case TD
                case TF
                case TG
                case TH
                case TJ
                case TK
                case TL
                case TM
                case TN
                case TO
                case TR
                case TT
                case TV
                case TW
                case TZ
                case UA
                case UG
                case US
                case UY
                case UZ
                case VA
                case VC
                case VE
                case VG
                case VN
                case VU
                case WF
                case WS
                case XK
                case YE
                case YT
                case ZA
                case ZM
                case ZW
                case ZZ
            }
        }

        public struct ShippingOptions: Codable, Hashable, Sendable {
            /// The ID of the Shipping Rate to use for this shipping option.
            public var shippingRate: String?

            public init(
                shippingRate: String? = nil
            ) {
                self.shippingRate = shippingRate
            }
        }

        /// When creating a subscription, the specified configuration data will be used.
        public struct SubscriptionData: Codable, Hashable, Sendable {
            /// The subscription's description, meant to be displayable to the customer.
            public var description: String?
            /// All invoices will be billed using the specified settings.
            public var invoiceSettings: InvoiceSettings?
            /// Set of key-value pairs that will declaratively set metadata on Subscriptions generated from this payment link.
            public var metadata: [String: String]?
            /// Integer representing the number of trial period days before the customer is charged for the first time.
            public var trialPeriodDays: Int?
            /// Settings related to subscription trials.
            public var trialSettings: TrialSettings?

            public init(
                description: String? = nil,
                invoiceSettings: InvoiceSettings? = nil,
                metadata: [String: String]? = nil,
                trialPeriodDays: Int? = nil,
                trialSettings: TrialSettings? = nil
            ) {
                self.description = description
                self.invoiceSettings = invoiceSettings
                self.metadata = metadata
                self.trialPeriodDays = trialPeriodDays
                self.trialSettings = trialSettings
            }

            /// All invoices will be billed using the specified settings.
            public struct InvoiceSettings: Codable, Hashable, Sendable {
                /// The connected account that issues the invoice.
                public var issuer: Issuer?

                public init(
                    issuer: Issuer? = nil
                ) {
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

            /// Settings related to subscription trials.
            public struct TrialSettings: Codable, Hashable, Sendable {
                /// Defines how the subscription should behave when the user's free trial ends.
                public var endBehavior: EndBehavior

                public init(
                    endBehavior: EndBehavior
                ) {
                    self.endBehavior = endBehavior
                }

                /// Defines how the subscription should behave when the user's free trial ends.
                public struct EndBehavior: Codable, Hashable, Sendable {
                    /// Indicates how the subscription should change when the trial ends if the user did not provide a payment method.
                    public var missingPaymentMethod: MissingPaymentMethod

                    public init(
                        missingPaymentMethod: MissingPaymentMethod
                    ) {
                        self.missingPaymentMethod = missingPaymentMethod
                    }

                    public enum MissingPaymentMethod: String, Codable, Hashable, Sendable {
                        case cancel
                        case createInvoice = "create_invoice"
                        case pause
                    }
                }
            }
        }

        /// Controls tax ID collection during checkout.
        public struct TaxIdCollection: Codable, Hashable, Sendable {
            /// Enable tax ID collection during checkout.
            public var enabled: Bool
            /// Describes whether a tax ID is required during checkout.
            public var required: Required?

            public init(
                enabled: Bool,
                required: Required? = nil
            ) {
                self.enabled = enabled
                self.required = required
            }

            public enum Required: String, Codable, Hashable, Sendable {
                case ifSupported = "if_supported"
                case never
            }
        }

        /// The account (if any) the payments will be attributed to for tax reporting, and where funds from each payment will be.
        public struct TransferData: Codable, Hashable, Sendable {
            /// The amount that will be transferred automatically when a charge succeeds.
            public var amount: Int?
            /// If specified, successful charges will be attributed to the destination account for tax reporting, and the funds from.
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

    public typealias Response = Stripe.PaymentLink
}

// GET /v1/payment_links
extension Stripe.PaymentLink.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return payment links that are active or inactive (e.g., pass `false` to list all inactive payment links).
        public var active: Bool?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            active: Bool? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.active = active
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Stripe.PaymentLink>
}

// GET /v1/payment_links/{payment_link}/line_items
extension Stripe.PaymentLink.ListLineItems {
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

    public typealias Response = Stripe.Page<Stripe.Checkout.Session.LineItem>
}

// GET /v1/payment_links/{payment_link}
extension Stripe.PaymentLink.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.PaymentLink
}

// POST /v1/payment_links/{payment_link}
extension Stripe.PaymentLink.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Whether the payment link's `url` is active.
        public var active: Bool?
        /// Behavior after the purchase is complete.
        public var afterCompletion: AfterCompletion?
        /// Enables user redeemable promotion codes.
        public var allowPromotionCodes: Bool?
        /// The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the.
        public var applicationFeeAmount: Stripe.Clearable<Int>?
        /// A non-negative decimal between 0 and 100, with at most two decimal places.
        public var applicationFeePercent: Stripe.Clearable<Decimal>?
        /// Configuration for automatic tax collection.
        public var automaticTax: AutomaticTax?
        /// Configuration for collecting the customer's billing address.
        public var billingAddressCollection: BillingAddressCollection?
        /// Configure fields to gather active consent from customers.
        public var consentCollection: ConsentCollection?
        /// Collect additional information from your customer using custom fields.
        public var customFields: Stripe.Clearable<[CustomFields]>?
        /// Display additional text for your customers using custom text.
        public var customText: CustomText?
        /// Configures whether checkout sessions created by this payment link create a Customer.
        public var customerCreation: CustomerCreation?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The custom message to be displayed to a customer when a payment link is no longer active.
        public var inactiveMessage: String?
        /// Generate a post-purchase Invoice for one-time payments.
        public var invoiceCreation: InvoiceCreation?
        /// The line items representing what is being sold.
        public var lineItems: [LineItems]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// Controls settings applied for collecting the customer's name.
        public var nameCollection: Stripe.Clearable<NameCollection>?
        /// The account on behalf of which to charge.
        public var onBehalfOf: String?
        /// A list of optional items the customer can add to their order at checkout.
        public var optionalItems: Stripe.Clearable<[OptionalItems]>?
        /// A subset of parameters to be passed to PaymentIntent creation for Checkout Sessions in `payment` mode.
        public var paymentIntentData: PaymentIntentData?
        /// Specify whether Checkout should collect a payment method.
        public var paymentMethodCollection: PaymentMethodCollection?
        /// Payment-method-specific configuration.
        public var paymentMethodOptions: Stripe.Clearable<PaymentMethodOptions>?
        /// The list of payment method types that customers can use.
        public var paymentMethodTypes: Stripe.Clearable<[PaymentMethodTypes]>?
        /// Controls phone number collection settings during checkout.
        public var phoneNumberCollection: PhoneNumberCollection?
        /// Settings that restrict the usage of a payment link.
        public var restrictions: Stripe.Clearable<Restrictions>?
        /// Configuration for collecting the customer's shipping address.
        public var shippingAddressCollection: Stripe.Clearable<ShippingAddressCollection>?
        /// The shipping rate options to apply to checkout sessions created by this payment link.
        public var shippingOptions: Stripe.Clearable<[ShippingOptions]>?
        /// Describes the type of transaction being performed in order to customize relevant text on the page, such as the submit.
        public var submitType: SubmitType?
        /// When creating a subscription, the specified configuration data will be used.
        public var subscriptionData: SubscriptionData?
        /// Controls tax ID collection during checkout.
        public var taxIdCollection: TaxIdCollection?
        /// The account (if any) the payments will be attributed to for tax reporting, and where funds from each payment will be.
        public var transferData: Stripe.Clearable<TransferData>?

        public init(
            active: Bool? = nil,
            afterCompletion: AfterCompletion? = nil,
            allowPromotionCodes: Bool? = nil,
            applicationFeeAmount: Stripe.Clearable<Int>? = nil,
            applicationFeePercent: Stripe.Clearable<Decimal>? = nil,
            automaticTax: AutomaticTax? = nil,
            billingAddressCollection: BillingAddressCollection? = nil,
            consentCollection: ConsentCollection? = nil,
            customFields: Stripe.Clearable<[CustomFields]>? = nil,
            customText: CustomText? = nil,
            customerCreation: CustomerCreation? = nil,
            expand: [String]? = nil,
            inactiveMessage: String? = nil,
            invoiceCreation: InvoiceCreation? = nil,
            lineItems: [LineItems]? = nil,
            metadata: [String: String]? = nil,
            nameCollection: Stripe.Clearable<NameCollection>? = nil,
            onBehalfOf: String? = nil,
            optionalItems: Stripe.Clearable<[OptionalItems]>? = nil,
            paymentIntentData: PaymentIntentData? = nil,
            paymentMethodCollection: PaymentMethodCollection? = nil,
            paymentMethodOptions: Stripe.Clearable<PaymentMethodOptions>? = nil,
            paymentMethodTypes: Stripe.Clearable<[PaymentMethodTypes]>? = nil,
            phoneNumberCollection: PhoneNumberCollection? = nil,
            restrictions: Stripe.Clearable<Restrictions>? = nil,
            shippingAddressCollection: Stripe.Clearable<ShippingAddressCollection>? = nil,
            shippingOptions: Stripe.Clearable<[ShippingOptions]>? = nil,
            submitType: SubmitType? = nil,
            subscriptionData: SubscriptionData? = nil,
            taxIdCollection: TaxIdCollection? = nil,
            transferData: Stripe.Clearable<TransferData>? = nil
        ) {
            self.active = active
            self.afterCompletion = afterCompletion
            self.allowPromotionCodes = allowPromotionCodes
            self.applicationFeeAmount = applicationFeeAmount
            self.applicationFeePercent = applicationFeePercent
            self.automaticTax = automaticTax
            self.billingAddressCollection = billingAddressCollection
            self.consentCollection = consentCollection
            self.customFields = customFields
            self.customText = customText
            self.customerCreation = customerCreation
            self.expand = expand
            self.inactiveMessage = inactiveMessage
            self.invoiceCreation = invoiceCreation
            self.lineItems = lineItems
            self.metadata = metadata
            self.nameCollection = nameCollection
            self.onBehalfOf = onBehalfOf
            self.optionalItems = optionalItems
            self.paymentIntentData = paymentIntentData
            self.paymentMethodCollection = paymentMethodCollection
            self.paymentMethodOptions = paymentMethodOptions
            self.paymentMethodTypes = paymentMethodTypes
            self.phoneNumberCollection = phoneNumberCollection
            self.restrictions = restrictions
            self.shippingAddressCollection = shippingAddressCollection
            self.shippingOptions = shippingOptions
            self.submitType = submitType
            self.subscriptionData = subscriptionData
            self.taxIdCollection = taxIdCollection
            self.transferData = transferData
        }

        public enum BillingAddressCollection: String, Codable, Hashable, Sendable {
            case auto
            case required
        }

        public enum CustomerCreation: String, Codable, Hashable, Sendable {
            case always
            case ifRequired = "if_required"
        }

        public enum PaymentMethodCollection: String, Codable, Hashable, Sendable {
            case always
            case ifRequired = "if_required"
        }

        public enum PaymentMethodTypes: String, Codable, Hashable, Sendable {
            case affirm
            case afterpayClearpay = "afterpay_clearpay"
            case alipay
            case alma
            case auBecsDebit = "au_becs_debit"
            case bacsDebit = "bacs_debit"
            case bancontact
            case billie
            case bizum
            case blik
            case boleto
            case card
            case cashapp
            case eps
            case fpx
            case giropay
            case grabpay
            case ideal
            case klarna
            case konbini
            case link
            case mbWay = "mb_way"
            case mobilepay
            case multibanco
            case oxxo
            case p24
            case payByBank = "pay_by_bank"
            case paynow
            case paypal
            case payto
            case pix
            case promptpay
            case satispay
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

        public enum SubmitType: String, Codable, Hashable, Sendable {
            case auto
            case book
            case donate
            case pay
            case subscribe
        }

        /// Behavior after the purchase is complete.
        public struct AfterCompletion: Codable, Hashable, Sendable {
            /// Configuration when `type=hosted_confirmation`.
            public var hostedConfirmation: HostedConfirmation?
            /// Configuration when `type=redirect`.
            public var redirect: Redirect?
            /// The specified behavior after the purchase is complete.
            public var `type`: Type

            public init(
                hostedConfirmation: HostedConfirmation? = nil,
                redirect: Redirect? = nil,
                `type`: Type
            ) {
                self.hostedConfirmation = hostedConfirmation
                self.redirect = redirect
                self.`type` = `type`
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case hostedConfirmation = "hosted_confirmation"
                case redirect
            }

            /// Configuration when `type=hosted_confirmation`.
            public struct HostedConfirmation: Codable, Hashable, Sendable {
                /// A custom message to display to the customer after the purchase is complete.
                public var customMessage: String?

                public init(
                    customMessage: String? = nil
                ) {
                    self.customMessage = customMessage
                }
            }

            /// Configuration when `type=redirect`.
            public struct Redirect: Codable, Hashable, Sendable {
                /// The URL the customer will be redirected to after the purchase is complete.
                public var url: String

                public init(
                    url: String
                ) {
                    self.url = url
                }
            }
        }

        /// Configuration for automatic tax collection.
        public struct AutomaticTax: Codable, Hashable, Sendable {
            /// Set to `true` to calculate tax automatically using the customer's location.
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

        /// Configure fields to gather active consent from customers.
        public struct ConsentCollection: Codable, Hashable, Sendable {
            /// Determines the display of payment method reuse agreement text in the UI.
            public var paymentMethodReuseAgreement: PaymentMethodReuseAgreement?
            /// If set to `auto`, enables the collection of customer consent for promotional communications.
            public var promotions: Promotions?
            /// If set to `required`, it requires customers to check a terms of service checkbox before being able to pay.
            public var termsOfService: TermsOfService?

            public init(
                paymentMethodReuseAgreement: PaymentMethodReuseAgreement? = nil,
                promotions: Promotions? = nil,
                termsOfService: TermsOfService? = nil
            ) {
                self.paymentMethodReuseAgreement = paymentMethodReuseAgreement
                self.promotions = promotions
                self.termsOfService = termsOfService
            }

            public enum Promotions: String, Codable, Hashable, Sendable {
                case auto
                case none
            }

            public enum TermsOfService: String, Codable, Hashable, Sendable {
                case none
                case required
            }

            /// Determines the display of payment method reuse agreement text in the UI.
            public struct PaymentMethodReuseAgreement: Codable, Hashable, Sendable {
                /// Determines the position and visibility of the payment method reuse agreement in the UI.
                public var position: Position

                public init(
                    position: Position
                ) {
                    self.position = position
                }

                public enum Position: String, Codable, Hashable, Sendable {
                    case auto
                    case hidden
                }
            }
        }

        public struct CustomFields: Codable, Hashable, Sendable {
            /// Configuration for `type=dropdown` fields.
            public var dropdown: Dropdown?
            /// String of your choice that your integration can use to reconcile this field.
            public var key: String
            /// The label for the field, displayed to the customer.
            public var label: Label
            /// Configuration for `type=numeric` fields.
            public var numeric: Numeric?
            /// Whether the customer is required to complete the field before completing the Checkout Session.
            public var optional: Bool?
            /// Configuration for `type=text` fields.
            public var text: Text?
            /// The type of the field.
            public var `type`: Type

            public init(
                dropdown: Dropdown? = nil,
                key: String,
                label: Label,
                numeric: Numeric? = nil,
                optional: Bool? = nil,
                text: Text? = nil,
                `type`: Type
            ) {
                self.dropdown = dropdown
                self.key = key
                self.label = label
                self.numeric = numeric
                self.optional = optional
                self.text = text
                self.`type` = `type`
            }

            public enum `Type`: String, Codable, Hashable, Sendable {
                case dropdown
                case numeric
                case text
            }

            /// Configuration for `type=dropdown` fields.
            public struct Dropdown: Codable, Hashable, Sendable {
                /// The value that pre-fills the field on the payment page.
                public var defaultValue: String?
                /// The options available for the customer to select.
                public var options: [Options]

                public init(
                    defaultValue: String? = nil,
                    options: [Options]
                ) {
                    self.defaultValue = defaultValue
                    self.options = options
                }

                public struct Options: Codable, Hashable, Sendable {
                    /// The label for the option, displayed to the customer.
                    public var label: String
                    /// The value for this option, not displayed to the customer, used by your integration to reconcile the option selected.
                    public var value: String

                    public init(
                        label: String,
                        value: String
                    ) {
                        self.label = label
                        self.value = value
                    }
                }
            }

            /// The label for the field, displayed to the customer.
            public struct Label: Codable, Hashable, Sendable {
                /// Custom text for the label, displayed to the customer.
                public var custom: String
                /// The type of the label.
                public var `type`: String

                public init(
                    custom: String,
                    `type`: String
                ) {
                    self.custom = custom
                    self.`type` = `type`
                }
            }

            /// Configuration for `type=numeric` fields.
            public struct Numeric: Codable, Hashable, Sendable {
                /// The value that pre-fills the field on the payment page.
                public var defaultValue: String?
                /// The maximum character length constraint for the customer's input.
                public var maximumLength: Int?
                /// The minimum character length requirement for the customer's input.
                public var minimumLength: Int?

                public init(
                    defaultValue: String? = nil,
                    maximumLength: Int? = nil,
                    minimumLength: Int? = nil
                ) {
                    self.defaultValue = defaultValue
                    self.maximumLength = maximumLength
                    self.minimumLength = minimumLength
                }
            }

            /// Configuration for `type=text` fields.
            public struct Text: Codable, Hashable, Sendable {
                /// The value that pre-fills the field on the payment page.
                public var defaultValue: String?
                /// The maximum character length constraint for the customer's input.
                public var maximumLength: Int?
                /// The minimum character length requirement for the customer's input.
                public var minimumLength: Int?

                public init(
                    defaultValue: String? = nil,
                    maximumLength: Int? = nil,
                    minimumLength: Int? = nil
                ) {
                    self.defaultValue = defaultValue
                    self.maximumLength = maximumLength
                    self.minimumLength = minimumLength
                }
            }
        }

        /// Display additional text for your customers using custom text.
        public struct CustomText: Codable, Hashable, Sendable {
            /// Custom text that should be displayed after the payment confirmation button.
            public var afterSubmit: Stripe.Clearable<AfterSubmit>?
            /// Custom text that should be displayed alongside shipping address collection.
            public var shippingAddress: Stripe.Clearable<ShippingAddress>?
            /// Custom text that should be displayed alongside the payment confirmation button.
            public var submit: Stripe.Clearable<Submit>?
            /// Custom text that should be displayed in place of the default terms of service agreement text.
            public var termsOfServiceAcceptance: Stripe.Clearable<TermsOfServiceAcceptance>?

            public init(
                afterSubmit: Stripe.Clearable<AfterSubmit>? = nil,
                shippingAddress: Stripe.Clearable<ShippingAddress>? = nil,
                submit: Stripe.Clearable<Submit>? = nil,
                termsOfServiceAcceptance: Stripe.Clearable<TermsOfServiceAcceptance>? = nil
            ) {
                self.afterSubmit = afterSubmit
                self.shippingAddress = shippingAddress
                self.submit = submit
                self.termsOfServiceAcceptance = termsOfServiceAcceptance
            }

            public struct AfterSubmit: Codable, Hashable, Sendable {
                /// Text can be up to 1200 characters in length.
                public var message: String

                public init(
                    message: String
                ) {
                    self.message = message
                }
            }

            public struct ShippingAddress: Codable, Hashable, Sendable {
                /// Text can be up to 1200 characters in length.
                public var message: String

                public init(
                    message: String
                ) {
                    self.message = message
                }
            }

            public struct Submit: Codable, Hashable, Sendable {
                /// Text can be up to 1200 characters in length.
                public var message: String

                public init(
                    message: String
                ) {
                    self.message = message
                }
            }

            public struct TermsOfServiceAcceptance: Codable, Hashable, Sendable {
                /// Text can be up to 1200 characters in length.
                public var message: String

                public init(
                    message: String
                ) {
                    self.message = message
                }
            }
        }

        /// Generate a post-purchase Invoice for one-time payments.
        public struct InvoiceCreation: Codable, Hashable, Sendable {
            /// Whether the feature is enabled.
            public var enabled: Bool
            /// Invoice PDF configuration.
            public var invoiceData: InvoiceData?

            public init(
                enabled: Bool,
                invoiceData: InvoiceData? = nil
            ) {
                self.enabled = enabled
                self.invoiceData = invoiceData
            }

            /// Invoice PDF configuration.
            public struct InvoiceData: Codable, Hashable, Sendable {
                /// The account tax IDs associated with the invoice.
                public var accountTaxIds: Stripe.Clearable<[String]>?
                /// Default custom fields to be displayed on invoices for this customer.
                public var customFields: Stripe.Clearable<[CustomFields]>?
                /// An arbitrary string attached to the object.
                public var description: String?
                /// Default footer to be displayed on invoices for this customer.
                public var footer: String?
                /// The connected account that issues the invoice.
                public var issuer: Issuer?
                /// Set of key-value pairs that you can attach to an object.
                public var metadata: Stripe.Clearable<[String: String]>?
                /// Default options for invoice PDF rendering for this customer.
                public var renderingOptions: Stripe.Clearable<RenderingOptions>?

                public init(
                    accountTaxIds: Stripe.Clearable<[String]>? = nil,
                    customFields: Stripe.Clearable<[CustomFields]>? = nil,
                    description: String? = nil,
                    footer: String? = nil,
                    issuer: Issuer? = nil,
                    metadata: Stripe.Clearable<[String: String]>? = nil,
                    renderingOptions: Stripe.Clearable<RenderingOptions>? = nil
                ) {
                    self.accountTaxIds = accountTaxIds
                    self.customFields = customFields
                    self.description = description
                    self.footer = footer
                    self.issuer = issuer
                    self.metadata = metadata
                    self.renderingOptions = renderingOptions
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

                public struct RenderingOptions: Codable, Hashable, Sendable {
                    /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
                    public var amountTaxDisplay: AmountTaxDisplay?
                    /// ID of the invoice rendering template to use for this invoice.
                    public var template: String?

                    public init(
                        amountTaxDisplay: AmountTaxDisplay? = nil,
                        template: String? = nil
                    ) {
                        self.amountTaxDisplay = amountTaxDisplay
                        self.template = template
                    }

                    public enum AmountTaxDisplay: String, Codable, Hashable, Sendable {
                        case value = ""
                        case excludeTax = "exclude_tax"
                        case includeInclusiveTax = "include_inclusive_tax"
                    }
                }
            }
        }

        public struct LineItems: Codable, Hashable, Sendable {
            /// When set, provides configuration for this item’s quantity to be adjusted by the customer during checkout.
            public var adjustableQuantity: AdjustableQuantity?
            /// The ID of an existing line item on the payment link.
            public var id: String
            /// The quantity of the line item being purchased.
            public var quantity: Int?

            public init(
                adjustableQuantity: AdjustableQuantity? = nil,
                id: String,
                quantity: Int? = nil
            ) {
                self.adjustableQuantity = adjustableQuantity
                self.id = id
                self.quantity = quantity
            }

            /// When set, provides configuration for this item’s quantity to be adjusted by the customer during checkout.
            public struct AdjustableQuantity: Codable, Hashable, Sendable {
                /// Set to true if the quantity can be adjusted to any non-negative Integer.
                public var enabled: Bool
                /// The maximum quantity the customer can purchase.
                public var maximum: Int?
                /// The minimum quantity the customer can purchase.
                public var minimum: Int?

                public init(
                    enabled: Bool,
                    maximum: Int? = nil,
                    minimum: Int? = nil
                ) {
                    self.enabled = enabled
                    self.maximum = maximum
                    self.minimum = minimum
                }
            }
        }

        public struct NameCollection: Codable, Hashable, Sendable {
            /// Controls settings applied for collecting the customer's business name.
            public var business: Business?
            /// Controls settings applied for collecting the customer's individual name.
            public var individual: Individual?

            public init(
                business: Business? = nil,
                individual: Individual? = nil
            ) {
                self.business = business
                self.individual = individual
            }

            /// Controls settings applied for collecting the customer's business name.
            public struct Business: Codable, Hashable, Sendable {
                /// Enable business name collection on the payment link.
                public var enabled: Bool
                /// Whether the customer is required to provide their business name before checking out.
                public var optional: Bool?

                public init(
                    enabled: Bool,
                    optional: Bool? = nil
                ) {
                    self.enabled = enabled
                    self.optional = optional
                }
            }

            /// Controls settings applied for collecting the customer's individual name.
            public struct Individual: Codable, Hashable, Sendable {
                /// Enable individual name collection on the payment link.
                public var enabled: Bool
                /// Whether the customer is required to provide their full name before checking out.
                public var optional: Bool?

                public init(
                    enabled: Bool,
                    optional: Bool? = nil
                ) {
                    self.enabled = enabled
                    self.optional = optional
                }
            }
        }

        public struct OptionalItems: Codable, Hashable, Sendable {
            /// When set, provides configuration for the customer to adjust the quantity of the line item created when a customer.
            public var adjustableQuantity: AdjustableQuantity?
            /// The ID of the Price or Plan object.
            public var price: String
            /// The initial quantity of the line item created when a customer chooses to add this optional item to their order.
            public var quantity: Int

            public init(
                adjustableQuantity: AdjustableQuantity? = nil,
                price: String,
                quantity: Int
            ) {
                self.adjustableQuantity = adjustableQuantity
                self.price = price
                self.quantity = quantity
            }

            /// When set, provides configuration for the customer to adjust the quantity of the line item created when a customer.
            public struct AdjustableQuantity: Codable, Hashable, Sendable {
                /// Set to true if the quantity can be adjusted to any non-negative integer.
                public var enabled: Bool
                /// The maximum quantity of this item the customer can purchase.
                public var maximum: Int?
                /// The minimum quantity of this item the customer must purchase, if they choose to purchase it.
                public var minimum: Int?

                public init(
                    enabled: Bool,
                    maximum: Int? = nil,
                    minimum: Int? = nil
                ) {
                    self.enabled = enabled
                    self.maximum = maximum
                    self.minimum = minimum
                }
            }
        }

        /// A subset of parameters to be passed to PaymentIntent creation for Checkout Sessions in `payment` mode.
        public struct PaymentIntentData: Codable, Hashable, Sendable {
            /// An arbitrary string attached to the object.
            public var description: String?
            /// Set of key-value pairs that will declaratively set metadata on Payment Intents generated from this payment link.
            public var metadata: Stripe.Clearable<[String: String]>?
            /// Indicates that you intend to make future payments with the payment method collected by this Checkout Session.
            public var setupFutureUsage: SetupFutureUsage?
            /// Text that appears on the customer's statement as the statement descriptor for a non-card charge.
            public var statementDescriptor: String?
            /// Provides information about a card charge.
            public var statementDescriptorSuffix: String?
            /// A string that identifies the resulting payment as part of a group.
            public var transferGroup: String?

            public init(
                description: String? = nil,
                metadata: Stripe.Clearable<[String: String]>? = nil,
                setupFutureUsage: SetupFutureUsage? = nil,
                statementDescriptor: String? = nil,
                statementDescriptorSuffix: String? = nil,
                transferGroup: String? = nil
            ) {
                self.description = description
                self.metadata = metadata
                self.setupFutureUsage = setupFutureUsage
                self.statementDescriptor = statementDescriptor
                self.statementDescriptorSuffix = statementDescriptorSuffix
                self.transferGroup = transferGroup
            }

            public enum SetupFutureUsage: String, Codable, Hashable, Sendable {
                case value = ""
                case offSession = "off_session"
                case onSession = "on_session"
            }
        }

        public struct PaymentMethodOptions: Codable, Hashable, Sendable {
            /// Configuration for `card` payment methods.
            public var card: Stripe.Clearable<Card>?

            public init(
                card: Stripe.Clearable<Card>? = nil
            ) {
                self.card = card
            }

            public struct Card: Codable, Hashable, Sendable {
                /// Restrictions to apply to the card payment method.
                public var restrictions: Stripe.Clearable<Restrictions>?

                public init(
                    restrictions: Stripe.Clearable<Restrictions>? = nil
                ) {
                    self.restrictions = restrictions
                }

                public struct Restrictions: Codable, Hashable, Sendable {
                    /// The card brands to block.
                    public var brandsBlocked: Stripe.Clearable<[BrandsBlocked]>?

                    public init(
                        brandsBlocked: Stripe.Clearable<[BrandsBlocked]>? = nil
                    ) {
                        self.brandsBlocked = brandsBlocked
                    }

                    public enum BrandsBlocked: String, Codable, Hashable, Sendable {
                        case americanExpress = "american_express"
                        case discoverGlobalNetwork = "discover_global_network"
                        case mastercard
                        case visa
                    }
                }
            }
        }

        /// Controls phone number collection settings during checkout.
        public struct PhoneNumberCollection: Codable, Hashable, Sendable {
            /// Set to `true` to enable phone number collection.
            public var enabled: Bool

            public init(
                enabled: Bool
            ) {
                self.enabled = enabled
            }
        }

        public struct Restrictions: Codable, Hashable, Sendable {
            /// Configuration for the `completed_sessions` restriction type.
            public var completedSessions: CompletedSessions

            public init(
                completedSessions: CompletedSessions
            ) {
                self.completedSessions = completedSessions
            }

            /// Configuration for the `completed_sessions` restriction type.
            public struct CompletedSessions: Codable, Hashable, Sendable {
                /// The maximum number of checkout sessions that can be completed for the `completed_sessions` restriction to be met.
                public var limit: Int

                public init(
                    limit: Int
                ) {
                    self.limit = limit
                }
            }
        }

        public struct ShippingAddressCollection: Codable, Hashable, Sendable {
            /// An array of two-letter ISO country codes representing which countries Checkout should provide as options for shipping.
            public var allowedCountries: [AllowedCountries]

            public init(
                allowedCountries: [AllowedCountries]
            ) {
                self.allowedCountries = allowedCountries
            }

            public enum AllowedCountries: String, Codable, Hashable, Sendable {
                case AC
                case AD
                case AE
                case AF
                case AG
                case AI
                case AL
                case AM
                case AO
                case AQ
                case AR
                case AT
                case AU
                case AW
                case AX
                case AZ
                case BA
                case BB
                case BD
                case BE
                case BF
                case BG
                case BH
                case BI
                case BJ
                case BL
                case BM
                case BN
                case BO
                case BQ
                case BR
                case BS
                case BT
                case BV
                case BW
                case BY
                case BZ
                case CA
                case CD
                case CF
                case CG
                case CH
                case CI
                case CK
                case CL
                case CM
                case CN
                case CO
                case CR
                case CV
                case CW
                case CY
                case CZ
                case DE
                case DJ
                case DK
                case DM
                case DO
                case DZ
                case EC
                case EE
                case EG
                case EH
                case ER
                case ES
                case ET
                case FI
                case FJ
                case FK
                case FO
                case FR
                case GA
                case GB
                case GD
                case GE
                case GF
                case GG
                case GH
                case GI
                case GL
                case GM
                case GN
                case GP
                case GQ
                case GR
                case GS
                case GT
                case GU
                case GW
                case GY
                case HK
                case HN
                case HR
                case HT
                case HU
                case ID
                case IE
                case IL
                case IM
                case IN
                case IO
                case IQ
                case IS
                case IT
                case JE
                case JM
                case JO
                case JP
                case KE
                case KG
                case KH
                case KI
                case KM
                case KN
                case KR
                case KW
                case KY
                case KZ
                case LA
                case LB
                case LC
                case LI
                case LK
                case LR
                case LS
                case LT
                case LU
                case LV
                case LY
                case MA
                case MC
                case MD
                case ME
                case MF
                case MG
                case MK
                case ML
                case MM
                case MN
                case MO
                case MQ
                case MR
                case MS
                case MT
                case MU
                case MV
                case MW
                case MX
                case MY
                case MZ
                case NA
                case NC
                case NE
                case NG
                case NI
                case NL
                case NO
                case NP
                case NR
                case NU
                case NZ
                case OM
                case PA
                case PE
                case PF
                case PG
                case PH
                case PK
                case PL
                case PM
                case PN
                case PR
                case PS
                case PT
                case PY
                case QA
                case RE
                case RO
                case RS
                case RU
                case RW
                case SA
                case SB
                case SC
                case SD
                case SE
                case SG
                case SH
                case SI
                case SJ
                case SK
                case SL
                case SM
                case SN
                case SO
                case SR
                case SS
                case ST
                case SV
                case SX
                case SZ
                case TA
                case TC
                case TD
                case TF
                case TG
                case TH
                case TJ
                case TK
                case TL
                case TM
                case TN
                case TO
                case TR
                case TT
                case TV
                case TW
                case TZ
                case UA
                case UG
                case US
                case UY
                case UZ
                case VA
                case VC
                case VE
                case VG
                case VN
                case VU
                case WF
                case WS
                case XK
                case YE
                case YT
                case ZA
                case ZM
                case ZW
                case ZZ
            }
        }

        public struct ShippingOptions: Codable, Hashable, Sendable {
            /// The ID of the Shipping Rate to use for this shipping option.
            public var shippingRate: String?

            public init(
                shippingRate: String? = nil
            ) {
                self.shippingRate = shippingRate
            }
        }

        /// When creating a subscription, the specified configuration data will be used.
        public struct SubscriptionData: Codable, Hashable, Sendable {
            /// All invoices will be billed using the specified settings.
            public var invoiceSettings: InvoiceSettings?
            /// Set of key-value pairs that will declaratively set metadata on Subscriptions generated from this payment link.
            public var metadata: Stripe.Clearable<[String: String]>?
            /// Integer representing the number of trial period days before the customer is charged for the first time.
            public var trialPeriodDays: Stripe.Clearable<Int>?
            /// Settings related to subscription trials.
            public var trialSettings: Stripe.Clearable<TrialSettings>?

            public init(
                invoiceSettings: InvoiceSettings? = nil,
                metadata: Stripe.Clearable<[String: String]>? = nil,
                trialPeriodDays: Stripe.Clearable<Int>? = nil,
                trialSettings: Stripe.Clearable<TrialSettings>? = nil
            ) {
                self.invoiceSettings = invoiceSettings
                self.metadata = metadata
                self.trialPeriodDays = trialPeriodDays
                self.trialSettings = trialSettings
            }

            /// All invoices will be billed using the specified settings.
            public struct InvoiceSettings: Codable, Hashable, Sendable {
                /// The connected account that issues the invoice.
                public var issuer: Issuer?

                public init(
                    issuer: Issuer? = nil
                ) {
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

            public struct TrialSettings: Codable, Hashable, Sendable {
                /// Defines how the subscription should behave when the user's free trial ends.
                public var endBehavior: EndBehavior

                public init(
                    endBehavior: EndBehavior
                ) {
                    self.endBehavior = endBehavior
                }

                /// Defines how the subscription should behave when the user's free trial ends.
                public struct EndBehavior: Codable, Hashable, Sendable {
                    /// Indicates how the subscription should change when the trial ends if the user did not provide a payment method.
                    public var missingPaymentMethod: MissingPaymentMethod

                    public init(
                        missingPaymentMethod: MissingPaymentMethod
                    ) {
                        self.missingPaymentMethod = missingPaymentMethod
                    }

                    public enum MissingPaymentMethod: String, Codable, Hashable, Sendable {
                        case cancel
                        case createInvoice = "create_invoice"
                        case pause
                    }
                }
            }
        }

        /// Controls tax ID collection during checkout.
        public struct TaxIdCollection: Codable, Hashable, Sendable {
            /// Enable tax ID collection during checkout.
            public var enabled: Bool
            /// Describes whether a tax ID is required during checkout.
            public var required: Required?

            public init(
                enabled: Bool,
                required: Required? = nil
            ) {
                self.enabled = enabled
                self.required = required
            }

            public enum Required: String, Codable, Hashable, Sendable {
                case ifSupported = "if_supported"
                case never
            }
        }

        public struct TransferData: Codable, Hashable, Sendable {
            /// The amount that will be transferred automatically when a charge succeeds.
            public var amount: Stripe.Clearable<Int>?
            /// If specified, successful charges will be attributed to the destination account for tax reporting, and the funds from.
            public var destination: String

            public init(
                amount: Stripe.Clearable<Int>? = nil,
                destination: String
            ) {
                self.amount = amount
                self.destination = destination
            }
        }
    }

    public typealias Response = Stripe.PaymentLink
}
