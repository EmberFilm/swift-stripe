//
//  Quote.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/25/21.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/quotes/object.md

/// A Quote is a way to model prices that you'd like to provide to a customer. Once accepted, it will automatically create an invoice, subscription or subscription schedule.
extension Stripe.Billing {
    public struct Quote: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// This field is not included by default. To include it in the response, expand the `lineItems` field.
        public var lineItems: Stripe.Billing.Quote.LineItem.List?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Total before any discounts or taxes are applied.
        public var amountSubtotal: Int?
        /// Total after discounts and taxes are applied.
        public var amountTotal: Int?
        /// ID of the Connect Application that created the quote.
        public var application: String?
        /// The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner’s Stripe account. Only applicable if there are no line items with recurring prices on the quote.
        public var applicationFeeAmount: Int?
        /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account. Only applicable if there are line items with recurring prices on the quote.
        public var applicationFeePercent: String?
        /// Settings for automatic tax lookup for this quote and resulting invoices and subscriptions.
        public var automaticTax: Stripe.Billing.Quote.AutomaticTax?
        /// Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay invoices at the end of the subscription cycle or on finalization using the default payment method attached to the subscription or customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions. Defaults to `charge_automatically`.
        public var collectionMethod: Stripe.Billing.Quote.CollectionMethod?
        /// The definitive totals and line items for the quote, computed based on your inputted line items as well as other configuration such as trials. Used for rendering the quote to your customer.
        public var computed: Stripe.Billing.Quote.Computed?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// The customer which this quote belongs to. A customer is required before finalizing the quote. Once specified, it cannot be changed.
        @ExpandableOf<Stripe.Customers.Customer> public var customer: Stripe.Customers.Customer.ID?
        /// The tax rates applied to this quote.
        @ExpandableCollection<Stripe.Tax.Rate> public var defaultTaxRates: [String]?
        /// A description that will be displayed on the quote PDF.
        public var description: String?
        /// The discounts applied to this quote.
        @ExpandableCollection<Stripe.Products.Discount> public var discounts: [String]?
        /// The date on which the quote will be canceled if in `open` or `draft` status. Measured in seconds since the Unix epoch.
        public var expiresAt: Date?
        /// A footer that will be displayed on the quote PDF.
        public var footer: String?
        /// Details of the quote that was cloned. See the cloning documentation for more details.
        public var fromQuote: Stripe.Billing.Quote.FromQuote?
        /// A header that will be displayed on the quote PDF.
        public var header: String?
        /// The invoice that was created from this quote.
        @Expandable<Invoice, Invoice.ID> public var invoice
        /// All invoices will be billed using the specified settings.
        public var invoiceSettings: Stripe.Billing.Quote.InvoiceSettings?
        /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool
        /// A unique number that identifies this particular quote. This number is assigned once the quote is finalized.
        public var number: String?
        /// The account on behalf of which to charge. See the Connect documentation for details.
        @ExpandableOf<Stripe.Connect.Account> public var onBehalfOf: Stripe.Connect.Account.ID?
        /// The status of the quote.
        public var status: Stripe.Billing.Quote.Status?
        /// The timestamps of which the quote transitioned to a new status.
        public var statusTransitions: Stripe.Billing.Quote.StatusTransition?
        /// The subscription that was created or updated from this quote.
        @ExpandableOf<Stripe.Billing.Subscription> public var subscription:
            Stripe.Billing.Subscription.ID?
        /// When creating a subscription or subscription schedule, the specified configuration data will be used. There must be at least one line item with a recurring price for a subscription or subscription schedule to be created.
        public var subscriptionData: Stripe.Billing.Quote.SubscriptionData?
        /// The subscription schedule that was created or updated from this quote.
        @ExpandableOf<Stripe.Billing.Subscription.Schedule> public var subscriptionSchedule
        /// ID of the test clock this quote belongs to.
        @ExpandableOf<Stripe.Billing.TestClocks.TestClock> public var testClock:
            Stripe.Billing.TestClocks.TestClock.ID?
        /// Tax and discount details for the computed total amount.
        public var totalDetails: Stripe.Billing.Quote.TotalDetails?
        /// The account (if any) the payments will be attributed to for tax reporting, and where funds from each payment will be transferred to for each of the invoices.
        public var transferData: Stripe.Billing.Quote.TransferData?

        public init(
            id: ID,
            lineItems: Stripe.Billing.Quote.LineItem.List? = nil,
            metadata: [String: String]? = nil,
            object: String,
            amountSubtotal: Int? = nil,
            amountTotal: Int? = nil,
            application: String? = nil,
            applicationFeeAmount: Int? = nil,
            applicationFeePercent: String? = nil,
            automaticTax: Stripe.Billing.Quote.AutomaticTax? = nil,
            collectionMethod: Stripe.Billing.Quote.CollectionMethod? = nil,
            computed: Stripe.Billing.Quote.Computed? = nil,
            created: Date,
            currency: Stripe.Currency? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            defaultTaxRates: [String]? = nil,
            description: String? = nil,
            discounts: [String]? = nil,
            expiresAt: Date? = nil,
            footer: String? = nil,
            fromQuote: Stripe.Billing.Quote.FromQuote? = nil,
            header: String? = nil,
            invoice: Stripe.Billing.Invoice.ID? = nil,
            invoiceSettings: Stripe.Billing.Quote.InvoiceSettings? = nil,
            livemode: Bool,
            number: String? = nil,
            onBehalfOf: Stripe.Connect.Account.ID? = nil,
            status: Stripe.Billing.Quote.Status? = nil,
            statusTransitions: Stripe.Billing.Quote.StatusTransition? = nil,
            subscription: Stripe.Billing.Subscription.ID? = nil,
            subscriptionData: Stripe.Billing.Quote.SubscriptionData? = nil,
            subscriptionSchedule: Stripe.Billing.Subscription.Schedule.ID? = nil,
            testClock: Stripe.Billing.TestClocks.TestClock.ID? = nil,
            totalDetails: Stripe.Billing.Quote.TotalDetails? = nil,
            transferData: Stripe.Billing.Quote.TransferData? = nil
        ) {
            self.id = id
            self.lineItems = lineItems
            self.metadata = metadata
            self.object = object
            self.amountSubtotal = amountSubtotal
            self.amountTotal = amountTotal
            self.application = application
            self.applicationFeeAmount = applicationFeeAmount
            self.applicationFeePercent = applicationFeePercent
            self.automaticTax = automaticTax
            self.collectionMethod = collectionMethod
            self.computed = computed
            self.created = created
            self.currency = currency
            self._customer = Expandable(id: customer)
            self._defaultTaxRates = ExpandableCollection(ids: defaultTaxRates)
            self.description = description
            self._discounts = ExpandableCollection(ids: discounts)
            self.expiresAt = expiresAt
            self.footer = footer
            self.fromQuote = fromQuote
            self.header = header
            self._invoice = Expandable(id: invoice)
            self.invoiceSettings = invoiceSettings
            self.livemode = livemode
            self.number = number
            self._onBehalfOf = Expandable(id: onBehalfOf)
            self.status = status
            self.statusTransitions = statusTransitions
            self._subscription = Expandable(id: subscription)
            self.subscriptionData = subscriptionData
            self._subscriptionSchedule = Expandable(id: subscriptionSchedule)
            self._testClock = Expandable(id: testClock)
            self.totalDetails = totalDetails
            self.transferData = transferData
        }
    }
}

extension Stripe.Billing.Quote {
    public struct AutomaticTax: Codable, Hashable, Sendable {
        /// Automatically calculate taxes
        public var enabled: Bool
        /// The status of the most recent automated tax calculation for this quote.
        public var status: Stripe.Billing.Quote.AutomaticTax.Status?

        public init(
            enabled: Bool,
            status: Stripe.Billing.Quote.AutomaticTax.Status? = nil
        ) {
            self.enabled = enabled
            self.status = status
        }
    }
}

extension Stripe.Billing.Quote.AutomaticTax {
    public enum Status: String, Codable, Sendable {
        /// The location details supplied on the customer aren’t valid or don’t provide enough location information to accurately determine tax rates for the customer.
        case requiresLocationInputs = "requires_location_inputs"
        /// Stripe successfully calculated tax automatically on this quote.
        case complete
        /// The Stripe Tax service failed, please try again later.
        case failed
    }
}

extension Stripe.Billing.Quote {
    public enum CollectionMethod: String, Codable, Sendable {
        case chargeAutomatically = "charge_automatically"
        case sendInvoice = "send_invoice"
    }
}

extension Stripe.Billing.Quote {
    public struct Computed: Codable, Hashable, Sendable {
        /// The definitive totals and line items the customer will be charged on a recurring basis. Takes into account the line items with recurring prices and discounts with `duration=forever` coupons only. Defaults to null if no inputted line items with recurring prices.
        public var recurring: Stripe.Billing.Quote.Computed.Recurring?
        /// The definitive upfront totals and line items the customer will be charged on the first invoice.
        public var upfront: Stripe.Billing.Quote.Computed.Upfront?

        public init(
            recurring: Stripe.Billing.Quote.Computed.Recurring? = nil,
            upfront: Stripe.Billing.Quote.Computed.Upfront? = nil
        ) {
            self.recurring = recurring
            self.upfront = upfront
        }
    }
}

extension Stripe.Billing.Quote.Computed {
    public struct Recurring: Codable, Hashable, Sendable {
        /// Total before any discounts or taxes are applied.
        public var amountSubtotal: Int?
        /// Total after discounts and taxes are applied.
        public var amountTotal: Int?
        /// The frequency at which a subscription is billed. One of `day`, `week`, `month` or `year`.
        public var interval: Stripe.Billing.Plan.Interval?
        /// The number of intervals (specified in the `interval` attribute) between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months.
        public var intervalCount: Int?
        /// Tax and discount details for the computed total amount.
        public var totalDetails: Stripe.Billing.Quote.Computed.Recurring.TotalDetails?

        public init(
            amountSubtotal: Int? = nil,
            amountTotal: Int? = nil,
            interval: Stripe.Billing.Plan.Interval? = nil,
            intervalCount: Int? = nil,
            totalDetails: Stripe.Billing.Quote.Computed.Recurring.TotalDetails? = nil
        ) {
            self.amountSubtotal = amountSubtotal
            self.amountTotal = amountTotal
            self.interval = interval
            self.intervalCount = intervalCount
            self.totalDetails = totalDetails
        }
    }
}

extension Stripe.Billing.Quote.Computed.Recurring {
    public struct TotalDetails: Codable, Hashable, Sendable {
        /// This is the sum of all the line item discounts.
        public var amountDiscount: Int?
        /// This is the sum of all the line item shipping amounts.
        public var amountShipping: Int?
        /// This is the sum of all the line item tax amounts.
        public var amountTax: Int?
        /// Breakdown of individual tax and discount amounts that add up to the totals.
        ///
        /// This field is not included by default. To include it in the response, expand the `breakdown` field.
        public var breakdown: Stripe.Billing.Quote.Computed.Recurring.TotalDetails.Breakdown?

        public init(
            amountDiscount: Int? = nil,
            amountShipping: Int? = nil,
            amountTax: Int? = nil,
            breakdown: Stripe.Billing.Quote.Computed.Recurring.TotalDetails.Breakdown? = nil
        ) {
            self.amountDiscount = amountDiscount
            self.amountShipping = amountShipping
            self.amountTax = amountTax
            self.breakdown = breakdown
        }
    }
}

extension Stripe.Billing.Quote.Computed.Recurring.TotalDetails {
    public struct Breakdown: Codable, Hashable, Sendable {
        /// The aggregated line item discounts.
        public var discounts:
            [Stripe.Billing.Quote.Computed.Recurring.TotalDetails.Breakdown.Discount]?
        /// The aggregated line item tax amounts by rate.
        public var taxes: [Stripe.Billing.Quote.Computed.Recurring.TotalDetails.Breakdown.Tax]?

        public init(
            discounts: [Stripe.Billing.Quote.Computed.Recurring.TotalDetails.Breakdown.Discount]? =
                nil,
            taxes: [Stripe.Billing.Quote.Computed.Recurring.TotalDetails.Breakdown.Tax]? = nil
        ) {
            self.discounts = discounts
            self.taxes = taxes
        }
    }
}

extension Stripe.Billing.Quote.Computed.Recurring.TotalDetails.Breakdown {
    public struct Discount: Codable, Hashable, Sendable {
        /// The amount discounted.
        public var amount: Int?
        /// The discount applied.
        public var discount: Stripe.Products.Discount?

        public init(
            amount: Int? = nil,
            discount: Stripe.Products.Discount? = nil
        ) {
            self.amount = amount
            self.discount = discount
        }
    }
}

extension Stripe.Billing.Quote.Computed.Recurring.TotalDetails.Breakdown {
    public struct Tax: Codable, Hashable, Sendable {
        /// Amount of tax applied for this rate.
        public var amount: Int?
        /// The tax rate applied.
        public var rate: Stripe.Tax.Rate?
        /// The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
        public var taxabilityReason:
            Stripe.Billing.Quote.Computed.Recurring.TotalDetails.Breakdown.Tax.TaxabilityReason?

        public init(
            amount: Int? = nil,
            rate: Stripe.Tax.Rate? = nil,
            taxabilityReason: Stripe.Billing.Quote.Computed.Recurring.TotalDetails.Breakdown.Tax
                .TaxabilityReason? = nil
        ) {
            self.amount = amount
            self.rate = rate
            self.taxabilityReason = taxabilityReason
        }
    }
}

extension Stripe.Billing.Quote.Computed.Recurring.TotalDetails.Breakdown.Tax {
    public enum TaxabilityReason: String, Codable, Sendable {
        case vatExempt = "vat_exempt"
        case jurisdictionUnsupported = "jurisdiction_unsupported"
        case excludedTerritory = "excluded_territory"
        case standardRated = "standard_rated"
        case reducedRated = "reduced_rated"
        case zeroRated = "zero_rated"
        case reverseCharge = "reverse_charge"
        case customerExempt = "customer_exempt"
        case productExempt = "product_exempt"
        case productExemptHoliday = "product_exempt_holiday"
        case portionStandardRated = "portion_standard_rated"
        case portionReducedRated = "portion_reduced_rated"
        case portionProductExempt = "portion_product_exempt"
        case taxableBasisReduced = "taxable_basis_reduced"
        case notCollecting = "not_collecting"
        case notSubjectToTax = "not_subject_to_tax"
        case notSupported = "not_supported"
        case proportionallyRated = "proportionally_rated"
    }
}

extension Stripe.Billing.Quote.Computed {
    public struct Upfront: Codable, Hashable, Sendable {
        /// Total before any discounts or taxes are applied.
        public var amountSubtotal: Int?
        /// Total after discounts and taxes are applied.
        public var amountTotal: Int?
        /// The line items that will appear on the next invoice after this quote is accepted. This does not include pending invoice items that exist on the customer but may still be included in the next invoice.
        ///
        /// This field is not included by default. To include it in the response, expand the `lineItems` field.
        public var lineItems: Stripe.Billing.Quote.LineItem.List?
        /// Tax and discount details for the computed total amount.
        public var totalDetails: Stripe.Billing.Quote.Computed.Upfront.TotalDetails?

        public init(
            amountSubtotal: Int? = nil,
            amountTotal: Int? = nil,
            lineItems: Stripe.Billing.Quote.LineItem.List? = nil,
            totalDetails: Stripe.Billing.Quote.Computed.Upfront.TotalDetails? = nil
        ) {
            self.amountSubtotal = amountSubtotal
            self.amountTotal = amountTotal
            self.lineItems = lineItems
            self.totalDetails = totalDetails
        }
    }
}

extension Stripe.Billing.Quote.Computed.Upfront {
    public struct TotalDetails: Codable, Hashable, Sendable {
        /// This is the sum of all the line item discounts.
        public var amountDiscount: Int?
        /// This is the sum of all the line item shipping amounts.
        public var amountShipping: Int?
        /// This is the sum of all the line item tax amounts.
        public var amountTax: Int?
        /// Breakdown of individual tax and discount amounts that add up to the totals.
        ///
        /// This field is not included by default. To include it in the response, expand the `breakdown` field.
        public var breakdown: Stripe.Billing.Quote.Computed.Upfront.TotalDetails.Breakdown?

        public init(
            amountDiscount: Int? = nil,
            amountShipping: Int? = nil,
            amountTax: Int? = nil,
            breakdown: Stripe.Billing.Quote.Computed.Upfront.TotalDetails.Breakdown? = nil
        ) {
            self.amountDiscount = amountDiscount
            self.amountShipping = amountShipping
            self.amountTax = amountTax
            self.breakdown = breakdown
        }
    }
}

extension Stripe.Billing.Quote.Computed.Upfront.TotalDetails {
    public struct Breakdown: Codable, Hashable, Sendable {
        /// The aggregated line item discounts.
        public var discounts:
            [Stripe.Billing.Quote.Computed.Upfront.TotalDetails.Breakdown.Discount]?
        /// The aggregated line item tax amounts by rate.
        public var taxes: [Stripe.Billing.Quote.Computed.Upfront.TotalDetails.Breakdown.Tax]?

        public init(
            discounts: [Stripe.Billing.Quote.Computed.Upfront.TotalDetails.Breakdown.Discount]? =
                nil,
            taxes: [Stripe.Billing.Quote.Computed.Upfront.TotalDetails.Breakdown.Tax]? = nil
        ) {
            self.discounts = discounts
            self.taxes = taxes
        }
    }
}

extension Stripe.Billing.Quote.Computed.Upfront.TotalDetails.Breakdown {
    public struct Discount: Codable, Hashable, Sendable {
        /// The amount discounted.
        public var amount: Int?
        /// The discount applied.
        public var discount: Stripe.Products.Discount?

        public init(
            amount: Int? = nil,
            discount: Stripe.Products.Discount? = nil
        ) {
            self.amount = amount
            self.discount = discount
        }
    }
}

extension Stripe.Billing.Quote.Computed.Upfront.TotalDetails.Breakdown {
    public struct Tax: Codable, Hashable, Sendable {
        /// Amount of tax applied for this rate.
        public var amount: Int?
        /// The tax rate applied.
        public var rate: Stripe.Tax.Rate?
        /// The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
        public var taxabilityReason:
            Stripe.Billing.Quote.Computed.Upfront.TotalDetails.Breakdown.Tax.TaxabilityReason?

        public init(
            amount: Int? = nil,
            rate: Stripe.Tax.Rate? = nil,
            taxabilityReason: Stripe.Billing.Quote.Computed.Upfront.TotalDetails.Breakdown.Tax
                .TaxabilityReason? = nil
        ) {
            self.amount = amount
            self.rate = rate
            self.taxabilityReason = taxabilityReason
        }
    }
}

extension Stripe.Billing.Quote.Computed.Upfront.TotalDetails.Breakdown.Tax {
    public enum TaxabilityReason: String, Codable, Sendable {
        case vatExempt = "vat_exempt"
        case jurisdictionUnsupported = "jurisdiction_unsupported"
        case excludedTerritory = "excluded_territory"
        case standardRated = "standard_rated"
        case reducedRated = "reduced_rated"
        case zeroRated = "zero_rated"
        case reverseCharge = "reverse_charge"
        case customerExempt = "customer_exempt"
        case productExempt = "product_exempt"
        case productExemptHoliday = "product_exempt_holiday"
        case portionStandardRated = "portion_standard_rated"
        case portionReducedRated = "portion_reduced_rated"
        case portionProductExempt = "portion_product_exempt"
        case taxableBasisReduced = "taxable_basis_reduced"
        case notCollecting = "not_collecting"
        case notSubjectToTax = "not_subject_to_tax"
        case notSupported = "not_supported"
        case proportionallyRated = "proportionally_rated"
    }
}

extension Stripe.Billing.Quote {
    public struct FromQuote: Codable, Hashable, Sendable {
        /// Whether this quote is a revision of a different quote.
        public var isRevision: Bool?
        /// The quote that was cloned.
        @ExpandableOf<Stripe.Billing.Quote> public var quote: Stripe.Billing.Quote.ID?

        public init(
            isRevision: Bool? = nil,
            quote: Stripe.Billing.Quote.ID? = nil
        ) {
            self.isRevision = isRevision
            self._quote = Expandable(id: quote)
        }
    }
}

extension Stripe.Billing.Quote {
    public struct InvoiceSettings: Codable, Hashable, Sendable {
        /// Number of days within which a customer must pay invoices generated by this quote. This value will be null for quotes where `collection_method=charge_automatically`.
        public var daysUntilDue: Int?

        public init(
            daysUntilDue: Int? = nil
        ) {
            self.daysUntilDue = daysUntilDue
        }
    }
}

extension Stripe.Billing.Quote {
    public enum Status: String, Codable, Sendable {
        /// The quote can be edited while in this status and has not been sent to the customer.
        case draft
        /// The quote has been finalized and is awaiting action from the customer.
        case open
        /// The customer has accepted the quote and invoice, subscription or subscription schedule has been created.
        case accepted
        /// The quote has been canceled and is no longer valid.
        case canceled
    }
}

extension Stripe.Billing.Quote {
    public struct StatusTransition: Codable, Hashable, Sendable {
        /// The time that the quote was accepted. Measured in seconds since Unix epoch.
        public var acceptedAt: Date?
        /// The time that the quote was canceled. Measured in seconds since Unix epoch.
        public var canceledAt: Date?
        /// The time that the quote was finalized. Measured in seconds since Unix epoch.
        public var finalizedAt: Date?

        public init(
            acceptedAt: Date? = nil,
            canceledAt: Date? = nil,
            finalizedAt: Date? = nil
        ) {
            self.acceptedAt = acceptedAt
            self.canceledAt = canceledAt
            self.finalizedAt = finalizedAt
        }
    }
}

extension Stripe.Billing.Quote {
    public struct SubscriptionData: Codable, Hashable, Sendable {
        /// The subscription’s description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription.
        public var description: String?
        /// When creating a new subscription, the date of which the subscription schedule will start after the quote is accepted. This date is ignored if it is in the past when the quote is accepted. Measured in seconds since the Unix epoch.
        public var effectiveDate: Date?
        /// Integer representing the number of trial period days before the customer is charged for the first time.
        public var trialPeriodDays: Int?

        public init(
            description: String? = nil,
            effectiveDate: Date? = nil,
            trialPeriodDays: Int? = nil
        ) {
            self.description = description
            self.effectiveDate = effectiveDate
            self.trialPeriodDays = trialPeriodDays
        }
    }
}

extension Stripe.Billing.Quote {
    public struct TotalDetails: Codable, Hashable, Sendable {
        /// This is the sum of all the line item discounts.
        public var amountDiscount: Int?
        /// This is the sum of all the line item shipping amounts.
        public var amountShipping: Int?
        /// This is the sum of all the line item tax amounts.
        public var amountTax: Int?
        /// Breakdown of individual tax and discount amounts that add up to the totals.
        ///
        /// This field is not included by default. To include it in the response, expand the `breakdown` field.
        public var breakdown: Stripe.Billing.Quote.TotalDetails.Breakdown?

        public init(
            amountDiscount: Int? = nil,
            amountShipping: Int? = nil,
            amountTax: Int? = nil,
            breakdown: Stripe.Billing.Quote.TotalDetails.Breakdown? = nil
        ) {
            self.amountDiscount = amountDiscount
            self.amountShipping = amountShipping
            self.amountTax = amountTax
            self.breakdown = breakdown
        }
    }
}

extension Stripe.Billing.Quote.TotalDetails {
    public struct Breakdown: Codable, Hashable, Sendable {
        /// The aggregated line item discounts.
        public var discounts: [Stripe.Billing.Quote.TotalDetails.Breakdown.Discount]?
        /// The aggregated line item tax amounts by rate.
        public var taxes: [Stripe.Billing.Quote.TotalDetails.Breakdown.Tax]?

        public init(
            discounts: [Stripe.Billing.Quote.TotalDetails.Breakdown.Discount]? = nil,
            taxes: [Stripe.Billing.Quote.TotalDetails.Breakdown.Tax]? = nil
        ) {
            self.discounts = discounts
            self.taxes = taxes
        }
    }
}

extension Stripe.Billing.Quote.TotalDetails.Breakdown {
    public struct Discount: Codable, Hashable, Sendable {
        /// The amount discounted.
        public var amount: Int?
        /// The discount applied.
        public var discount: Stripe.Products.Discount?

        public init(
            amount: Int? = nil,
            discount: Stripe.Products.Discount? = nil
        ) {
            self.amount = amount
            self.discount = discount
        }
    }
}

extension Stripe.Billing.Quote.TotalDetails.Breakdown {
    public struct Tax: Codable, Hashable, Sendable {
        /// Amount of tax applied for this rate.
        public var amount: Int?
        /// The tax rate applied.
        public var rate: Stripe.Tax.Rate?
        /// The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
        public var taxabilityReason:
            Stripe.Billing.Quote.TotalDetails.Breakdown.Tax.TaxabilityReason?

        public init(
            amount: Int? = nil,
            rate: Stripe.Tax.Rate? = nil,
            taxabilityReason: Stripe.Billing.Quote.TotalDetails.Breakdown.Tax.TaxabilityReason? =
                nil
        ) {
            self.amount = amount
            self.rate = rate
            self.taxabilityReason = taxabilityReason
        }
    }
}

extension Stripe.Billing.Quote.TotalDetails.Breakdown.Tax {
    public enum TaxabilityReason: String, Codable, Sendable {
        case vatExempt = "vat_exempt"
        case jurisdictionUnsupported = "jurisdiction_unsupported"
        case excludedTerritory = "excluded_territory"
        case standardRated = "standard_rated"
        case reducedRated = "reduced_rated"
        case zeroRated = "zero_rated"
        case reverseCharge = "reverse_charge"
        case customerExempt = "customer_exempt"
        case productExempt = "product_exempt"
        case productExemptHoliday = "product_exempt_holiday"
        case portionStandardRated = "portion_standard_rated"
        case portionReducedRated = "portion_reduced_rated"
        case portionProductExempt = "portion_product_exempt"
        case taxableBasisReduced = "taxable_basis_reduced"
        case notCollecting = "not_collecting"
        case notSubjectToTax = "not_subject_to_tax"
        case notSupported = "not_supported"
        case proportionallyRated = "proportionally_rated"
    }
}

extension Stripe.Billing.Quote {
    public struct TransferData: Codable, Hashable, Sendable {
        /// The amount in cents that will be transferred to the destination account when the invoice is paid. By default, the entire amount is transferred to the destination.
        public var amount: Int?
        /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the destination account. By default, the entire amount will be transferred to the destination.
        public var amountPercent: String?
        /// The account where funds from the payment will be transferred to upon payment success.
        @ExpandableOf<Stripe.Connect.Account> public var destination: Stripe.Connect.Account.ID?

        public init(
            amount: Int? = nil,
            amountPercent: String? = nil,
            destination: Stripe.Connect.Account.ID? = nil
        ) {
            self.amount = amount
            self.amountPercent = amountPercent
            self._destination = Expandable(id: destination)
        }
    }
}

extension Stripe.Billing.Quote {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Billing.Quote.LineItem]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Billing.Quote.LineItem]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
