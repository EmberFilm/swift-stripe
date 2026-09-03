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

extension Stripe.Billing.Quote {
    public enum Accept {}
    public enum Cancel {}
    public enum Create {}
    public enum FinalizeQuote {}
    public enum List {}
    public enum ListComputedUpfrontLineItems {}
    public enum ListLineItems {}
    public enum Pdf {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/quotes/{quote}/accept
extension Stripe.Billing.Quote.Accept {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Quote
}

// POST /v1/quotes/{quote}/cancel
extension Stripe.Billing.Quote.Cancel {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Quote
}

// POST /v1/quotes
extension Stripe.Billing.Quote.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the.
        public var applicationFeeAmount: Stripe.Clearable<Int>?
        /// A non-negative decimal between 0 and 100, with at most two decimal places.
        public var applicationFeePercent: Stripe.Clearable<Decimal>?
        /// Settings for automatic tax lookup for this quote and resulting invoices and subscriptions.
        public var automaticTax: AutomaticTax?
        /// Either `charge_automatically`, or `send_invoice`.
        public var collectionMethod: CollectionMethod?
        /// The customer for which this quote belongs to.
        public var customer: String?
        /// The account for which this quote belongs to.
        public var customerAccount: String?
        /// The tax rates that will apply to any line item that does not have `tax_rates` set.
        public var defaultTaxRates: Stripe.Clearable<[String]>?
        /// A description that will be displayed on the quote PDF.
        public var description: String?
        /// The discounts applied to the quote.
        public var discounts: Stripe.Clearable<[Discounts]>?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A future timestamp on which the quote will be canceled if in `open` or `draft` status.
        public var expiresAt: Date?
        /// A footer that will be displayed on the quote PDF.
        public var footer: String?
        /// Clone an existing quote.
        public var fromQuote: FromQuote?
        /// A header that will be displayed on the quote PDF.
        public var header: String?
        /// All invoices will be billed using the specified settings.
        public var invoiceSettings: InvoiceSettings?
        /// A list of line items the customer is being quoted for.
        public var lineItems: [LineItems]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The account on behalf of which to charge.
        public var onBehalfOf: String?
        /// When creating a subscription or subscription schedule, the specified configuration data will be used.
        public var subscriptionData: SubscriptionData?
        /// ID of the test clock to attach to the quote.
        public var testClock: String?
        /// The data with which to automatically create a Transfer for each of the invoices.
        public var transferData: Stripe.Clearable<TransferData>?

        public init(
            applicationFeeAmount: Stripe.Clearable<Int>? = nil,
            applicationFeePercent: Stripe.Clearable<Decimal>? = nil,
            automaticTax: AutomaticTax? = nil,
            collectionMethod: CollectionMethod? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            defaultTaxRates: Stripe.Clearable<[String]>? = nil,
            description: String? = nil,
            discounts: Stripe.Clearable<[Discounts]>? = nil,
            expand: [String]? = nil,
            expiresAt: Date? = nil,
            footer: String? = nil,
            fromQuote: FromQuote? = nil,
            header: String? = nil,
            invoiceSettings: InvoiceSettings? = nil,
            lineItems: [LineItems]? = nil,
            metadata: [String: String]? = nil,
            onBehalfOf: String? = nil,
            subscriptionData: SubscriptionData? = nil,
            testClock: String? = nil,
            transferData: Stripe.Clearable<TransferData>? = nil
        ) {
            self.applicationFeeAmount = applicationFeeAmount
            self.applicationFeePercent = applicationFeePercent
            self.automaticTax = automaticTax
            self.collectionMethod = collectionMethod
            self.customer = customer
            self.customerAccount = customerAccount
            self.defaultTaxRates = defaultTaxRates
            self.description = description
            self.discounts = discounts
            self.expand = expand
            self.expiresAt = expiresAt
            self.footer = footer
            self.fromQuote = fromQuote
            self.header = header
            self.invoiceSettings = invoiceSettings
            self.lineItems = lineItems
            self.metadata = metadata
            self.onBehalfOf = onBehalfOf
            self.subscriptionData = subscriptionData
            self.testClock = testClock
            self.transferData = transferData
        }

        public enum CollectionMethod: String, Codable, Hashable, Sendable {
            case chargeAutomatically = "charge_automatically"
            case sendInvoice = "send_invoice"
        }

        /// Settings for automatic tax lookup for this quote and resulting invoices and subscriptions.
        public struct AutomaticTax: Codable, Hashable, Sendable {
            /// Controls whether Stripe will automatically compute tax on the resulting invoices or subscriptions as well as the.
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

        /// Clone an existing quote.
        public struct FromQuote: Codable, Hashable, Sendable {
            /// Whether this quote is a revision of the previous quote.
            public var isRevision: Bool?
            /// The `id` of the quote that will be cloned.
            public var quote: String

            public init(
                isRevision: Bool? = nil,
                quote: String
            ) {
                self.isRevision = isRevision
                self.quote = quote
            }
        }

        /// All invoices will be billed using the specified settings.
        public struct InvoiceSettings: Codable, Hashable, Sendable {
            /// A list of up to 4 custom fields to be displayed on the invoice.
            public var customFields: Stripe.Clearable<[CustomFields]>?
            /// Number of days within which a customer must pay the invoice generated by this quote.
            public var daysUntilDue: Int?
            /// An arbitrary string attached to the object.
            public var description: String?
            /// Footer to be displayed on the invoice.
            public var footer: String?
            /// The connected account that issues the invoice.
            public var issuer: Issuer?

            public init(
                customFields: Stripe.Clearable<[CustomFields]>? = nil,
                daysUntilDue: Int? = nil,
                description: String? = nil,
                footer: String? = nil,
                issuer: Issuer? = nil
            ) {
                self.customFields = customFields
                self.daysUntilDue = daysUntilDue
                self.description = description
                self.footer = footer
                self.issuer = issuer
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
        }

        public struct LineItems: Codable, Hashable, Sendable {
            /// The discounts applied to this line item.
            public var discounts: Stripe.Clearable<[Discounts]>?
            /// The ID of the price object.
            public var price: String?
            /// Data used to generate a new Price object inline.
            public var priceData: PriceData?
            /// The quantity of the line item.
            public var quantity: Int?
            /// The tax rates which apply to the line item.
            public var taxRates: Stripe.Clearable<[String]>?

            public init(
                discounts: Stripe.Clearable<[Discounts]>? = nil,
                price: String? = nil,
                priceData: PriceData? = nil,
                quantity: Int? = nil,
                taxRates: Stripe.Clearable<[String]>? = nil
            ) {
                self.discounts = discounts
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

            /// Data used to generate a new Price object inline.
            public struct PriceData: Codable, Hashable, Sendable {
                /// Three-letter ISO currency code, in lowercase.
                public var currency: Stripe.Currency
                /// The ID of the Product that this Price will belong to.
                public var product: String
                /// The recurring components of a price such as `interval` and `interval_count`.
                public var recurring: Recurring?
                /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
                public var taxBehavior: TaxBehavior?
                /// A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
                public var unitAmount: Int?
                /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
                public var unitAmountDecimal: String?

                public init(
                    currency: Stripe.Currency,
                    product: String,
                    recurring: Recurring? = nil,
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

        /// When creating a subscription or subscription schedule, the specified configuration data will be used.
        public struct SubscriptionData: Codable, Hashable, Sendable {
            /// Controls how prorations and invoices for subscriptions are calculated and orchestrated.
            public var billingMode: BillingMode?
            /// The subscription's description, meant to be displayable to the customer.
            public var description: String?
            /// When creating a new subscription, the date of which the subscription schedule will start after the quote is accepted.
            public var effectiveDate: EffectiveDate?
            /// Set of key-value pairs that will set metadata on the subscription or subscription schedule when the quote is accepted.
            public var metadata: [String: String]?
            /// Integer representing the number of trial period days before the customer is charged for the first time.
            public var trialPeriodDays: Stripe.Clearable<Int>?

            public init(
                billingMode: BillingMode? = nil,
                description: String? = nil,
                effectiveDate: EffectiveDate? = nil,
                metadata: [String: String]? = nil,
                trialPeriodDays: Stripe.Clearable<Int>? = nil
            ) {
                self.billingMode = billingMode
                self.description = description
                self.effectiveDate = effectiveDate
                self.metadata = metadata
                self.trialPeriodDays = trialPeriodDays
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

            /// When creating a new subscription, the date of which the subscription schedule will start after the quote is accepted.
            public enum EffectiveDate: Codable, Hashable, Sendable {
                case value(Date)
                case currentPeriodEnd
                /// Unsets the field.
                case clear

                public init(from decoder: any Decoder) throws {
                    let container = try decoder.singleValueContainer()
                    if let value = try? container.decode(Date.self) {
                        self = .value(value)
                        return
                    }
                    switch try container.decode(String.self) {
                    case "current_period_end": self = .currentPeriodEnd
                    case "": self = .clear
                    case let other: throw DecodingError.dataCorruptedError(in: container, debugDescription: "unknown keyword \(other)")
                    }
                }

                public func encode(to encoder: any Encoder) throws {
                    var container = encoder.singleValueContainer()
                    switch self {
                    case .value(let value): try container.encode(value)
                    case .currentPeriodEnd: try container.encode("current_period_end")
                    case .clear: try container.encode("")
                    }
                }
            }
        }

        public struct TransferData: Codable, Hashable, Sendable {
            /// The amount that will be transferred automatically when the invoice is paid.
            public var amount: Int?
            /// A non-negative decimal between 0 and 100, with at most two decimal places.
            public var amountPercent: Decimal?
            /// ID of an existing, connected Stripe account.
            public var destination: String

            public init(
                amount: Int? = nil,
                amountPercent: Decimal? = nil,
                destination: String
            ) {
                self.amount = amount
                self.amountPercent = amountPercent
                self.destination = destination
            }
        }
    }

    public typealias Response = Stripe.Billing.Quote
}

// POST /v1/quotes/{quote}/finalize
extension Stripe.Billing.Quote.FinalizeQuote {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A future timestamp on which the quote will be canceled if in `open` or `draft` status.
        public var expiresAt: Date?

        public init(
            expand: [String]? = nil,
            expiresAt: Date? = nil
        ) {
            self.expand = expand
            self.expiresAt = expiresAt
        }
    }

    public typealias Response = Stripe.Billing.Quote
}

// GET /v1/quotes
extension Stripe.Billing.Quote.List {
    public struct Request: Codable, Hashable, Sendable {
        /// The ID of the customer whose quotes you're retrieving.
        public var customer: String?
        /// The ID of the account representing the customer whose quotes you're retrieving.
        public var customerAccount: String?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// The status of the quote.
        public var status: Status?
        /// Provides a list of quotes that are associated with the specified test clock.
        public var testClock: String?

        public init(
            customer: String? = nil,
            customerAccount: String? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            status: Status? = nil,
            testClock: String? = nil
        ) {
            self.customer = customer
            self.customerAccount = customerAccount
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
            self.status = status
            self.testClock = testClock
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case accepted
            case canceled
            case draft
            case open
        }
    }

    public typealias Response = Stripe.Page<Stripe.Billing.Quote>
}

// GET /v1/quotes/{quote}/computed_upfront_line_items
extension Stripe.Billing.Quote.ListComputedUpfrontLineItems {
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

// GET /v1/quotes/{quote}/line_items
extension Stripe.Billing.Quote.ListLineItems {
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

// GET /v1/quotes/{quote}/pdf
extension Stripe.Billing.Quote.Pdf {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Data
}

// GET /v1/quotes/{quote}
extension Stripe.Billing.Quote.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.Quote
}

// POST /v1/quotes/{quote}
extension Stripe.Billing.Quote.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the.
        public var applicationFeeAmount: Stripe.Clearable<Int>?
        /// A non-negative decimal between 0 and 100, with at most two decimal places.
        public var applicationFeePercent: Stripe.Clearable<Decimal>?
        /// Settings for automatic tax lookup for this quote and resulting invoices and subscriptions.
        public var automaticTax: AutomaticTax?
        /// Either `charge_automatically`, or `send_invoice`.
        public var collectionMethod: CollectionMethod?
        /// The customer for which this quote belongs to.
        public var customer: String?
        /// The account for which this quote belongs to.
        public var customerAccount: String?
        /// The tax rates that will apply to any line item that does not have `tax_rates` set.
        public var defaultTaxRates: Stripe.Clearable<[String]>?
        /// A description that will be displayed on the quote PDF.
        public var description: String?
        /// The discounts applied to the quote.
        public var discounts: Stripe.Clearable<[Discounts]>?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A future timestamp on which the quote will be canceled if in `open` or `draft` status.
        public var expiresAt: Date?
        /// A footer that will be displayed on the quote PDF.
        public var footer: String?
        /// A header that will be displayed on the quote PDF.
        public var header: String?
        /// All invoices will be billed using the specified settings.
        public var invoiceSettings: InvoiceSettings?
        /// A list of line items the customer is being quoted for.
        public var lineItems: [LineItems]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The account on behalf of which to charge.
        public var onBehalfOf: String?
        /// When creating a subscription or subscription schedule, the specified configuration data will be used.
        public var subscriptionData: SubscriptionData?
        /// The data with which to automatically create a Transfer for each of the invoices.
        public var transferData: Stripe.Clearable<TransferData>?

        public init(
            applicationFeeAmount: Stripe.Clearable<Int>? = nil,
            applicationFeePercent: Stripe.Clearable<Decimal>? = nil,
            automaticTax: AutomaticTax? = nil,
            collectionMethod: CollectionMethod? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            defaultTaxRates: Stripe.Clearable<[String]>? = nil,
            description: String? = nil,
            discounts: Stripe.Clearable<[Discounts]>? = nil,
            expand: [String]? = nil,
            expiresAt: Date? = nil,
            footer: String? = nil,
            header: String? = nil,
            invoiceSettings: InvoiceSettings? = nil,
            lineItems: [LineItems]? = nil,
            metadata: [String: String]? = nil,
            onBehalfOf: String? = nil,
            subscriptionData: SubscriptionData? = nil,
            transferData: Stripe.Clearable<TransferData>? = nil
        ) {
            self.applicationFeeAmount = applicationFeeAmount
            self.applicationFeePercent = applicationFeePercent
            self.automaticTax = automaticTax
            self.collectionMethod = collectionMethod
            self.customer = customer
            self.customerAccount = customerAccount
            self.defaultTaxRates = defaultTaxRates
            self.description = description
            self.discounts = discounts
            self.expand = expand
            self.expiresAt = expiresAt
            self.footer = footer
            self.header = header
            self.invoiceSettings = invoiceSettings
            self.lineItems = lineItems
            self.metadata = metadata
            self.onBehalfOf = onBehalfOf
            self.subscriptionData = subscriptionData
            self.transferData = transferData
        }

        public enum CollectionMethod: String, Codable, Hashable, Sendable {
            case chargeAutomatically = "charge_automatically"
            case sendInvoice = "send_invoice"
        }

        /// Settings for automatic tax lookup for this quote and resulting invoices and subscriptions.
        public struct AutomaticTax: Codable, Hashable, Sendable {
            /// Controls whether Stripe will automatically compute tax on the resulting invoices or subscriptions as well as the.
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

        /// All invoices will be billed using the specified settings.
        public struct InvoiceSettings: Codable, Hashable, Sendable {
            /// A list of up to 4 custom fields to be displayed on the invoice.
            public var customFields: Stripe.Clearable<[CustomFields]>?
            /// Number of days within which a customer must pay the invoice generated by this quote.
            public var daysUntilDue: Int?
            /// An arbitrary string attached to the object.
            public var description: String?
            /// Footer to be displayed on the invoice.
            public var footer: String?
            /// The connected account that issues the invoice.
            public var issuer: Issuer?

            public init(
                customFields: Stripe.Clearable<[CustomFields]>? = nil,
                daysUntilDue: Int? = nil,
                description: String? = nil,
                footer: String? = nil,
                issuer: Issuer? = nil
            ) {
                self.customFields = customFields
                self.daysUntilDue = daysUntilDue
                self.description = description
                self.footer = footer
                self.issuer = issuer
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
        }

        public struct LineItems: Codable, Hashable, Sendable {
            /// The discounts applied to this line item.
            public var discounts: Stripe.Clearable<[Discounts]>?
            /// The ID of an existing line item on the quote.
            public var id: String?
            /// The ID of the price object.
            public var price: String?
            /// Data used to generate a new Price object inline.
            public var priceData: PriceData?
            /// The quantity of the line item.
            public var quantity: Int?
            /// The tax rates which apply to the line item.
            public var taxRates: Stripe.Clearable<[String]>?

            public init(
                discounts: Stripe.Clearable<[Discounts]>? = nil,
                id: String? = nil,
                price: String? = nil,
                priceData: PriceData? = nil,
                quantity: Int? = nil,
                taxRates: Stripe.Clearable<[String]>? = nil
            ) {
                self.discounts = discounts
                self.id = id
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

            /// Data used to generate a new Price object inline.
            public struct PriceData: Codable, Hashable, Sendable {
                /// Three-letter ISO currency code, in lowercase.
                public var currency: Stripe.Currency
                /// The ID of the Product that this Price will belong to.
                public var product: String
                /// The recurring components of a price such as `interval` and `interval_count`.
                public var recurring: Recurring?
                /// Only required if a default tax behavior) was not provided in the Stripe Tax settings.
                public var taxBehavior: TaxBehavior?
                /// A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
                public var unitAmount: Int?
                /// Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places.
                public var unitAmountDecimal: String?

                public init(
                    currency: Stripe.Currency,
                    product: String,
                    recurring: Recurring? = nil,
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

        /// When creating a subscription or subscription schedule, the specified configuration data will be used.
        public struct SubscriptionData: Codable, Hashable, Sendable {
            /// The subscription's description, meant to be displayable to the customer.
            public var description: String?
            /// When creating a new subscription, the date of which the subscription schedule will start after the quote is accepted.
            public var effectiveDate: EffectiveDate?
            /// Set of key-value pairs that will set metadata on the subscription or subscription schedule when the quote is accepted.
            public var metadata: [String: String]?
            /// Integer representing the number of trial period days before the customer is charged for the first time.
            public var trialPeriodDays: Stripe.Clearable<Int>?

            public init(
                description: String? = nil,
                effectiveDate: EffectiveDate? = nil,
                metadata: [String: String]? = nil,
                trialPeriodDays: Stripe.Clearable<Int>? = nil
            ) {
                self.description = description
                self.effectiveDate = effectiveDate
                self.metadata = metadata
                self.trialPeriodDays = trialPeriodDays
            }

            /// When creating a new subscription, the date of which the subscription schedule will start after the quote is accepted.
            public enum EffectiveDate: Codable, Hashable, Sendable {
                case value(Date)
                case currentPeriodEnd
                /// Unsets the field.
                case clear

                public init(from decoder: any Decoder) throws {
                    let container = try decoder.singleValueContainer()
                    if let value = try? container.decode(Date.self) {
                        self = .value(value)
                        return
                    }
                    switch try container.decode(String.self) {
                    case "current_period_end": self = .currentPeriodEnd
                    case "": self = .clear
                    case let other: throw DecodingError.dataCorruptedError(in: container, debugDescription: "unknown keyword \(other)")
                    }
                }

                public func encode(to encoder: any Encoder) throws {
                    var container = encoder.singleValueContainer()
                    switch self {
                    case .value(let value): try container.encode(value)
                    case .currentPeriodEnd: try container.encode("current_period_end")
                    case .clear: try container.encode("")
                    }
                }
            }
        }

        public struct TransferData: Codable, Hashable, Sendable {
            /// The amount that will be transferred automatically when the invoice is paid.
            public var amount: Int?
            /// A non-negative decimal between 0 and 100, with at most two decimal places.
            public var amountPercent: Decimal?
            /// ID of an existing, connected Stripe account.
            public var destination: String

            public init(
                amount: Int? = nil,
                amountPercent: Decimal? = nil,
                destination: String
            ) {
                self.amount = amount
                self.amountPercent = amountPercent
                self.destination = destination
            }
        }
    }

    public typealias Response = Stripe.Billing.Quote
}
