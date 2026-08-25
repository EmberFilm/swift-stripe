//
//  Invoice.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/4/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/invoices/object.md

/// The [Invoice Object](https://stripe.com/docs/api/invoices/object) .

// The Invoice struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.Invoice` that the generator spells differently.

extension Stripe.Billing.Subscription {
    public struct Details: Codable, Hashable, Sendable {
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?

        public init(
            metadata: [String: String]? = nil
        ) {
            self.metadata = metadata
        }
    }
}

extension Stripe.Billing.Invoice {
    public enum AutomaticTaxStatus: String, Codable, Sendable {
        /// The location details supplied on the customer aren’t valid or don’t provide enough location information to accurately determine tax rates for the customer.
        case requiresLocationInputs = "requires_location_inputs"
        /// Stripe successfully calculated tax automatically on this invoice.
        case complete
        /// The Stripe Tax service failed, please try again later.
        case failed
    }
}

extension Stripe.Billing.Invoice {
    public enum Reason: String, Codable, Sendable {
        case subscriptionCycle = "subscription_cycle"
        case subscriptionCreate = "subscription_create"
        case subscriptionUpdate = "subscription_update"
        case subscription
        case manual
        case upcoming
        case subscriptionThreshold = "subscription_threshold"
    }
}

extension Stripe.Billing.Invoice {
    public struct CustomField: Codable, Hashable, Sendable {
        /// The name of the custom field.
        public var name: String?
        /// The value of the custom field.
        public var value: String?

        public init(
            name: String? = nil,
            value: String? = nil
        ) {
            self.name = name
            self.value = value
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct CustomerTaxId: Codable, Hashable, Sendable {
        /// The type of the tax ID
        public var type: Stripe.Tax.ID.`Type`?
        /// The value of the tax ID.
        public var value: String?

        public init(
            type: Stripe.Tax.ID.`Type`? = nil,
            value: String? = nil
        ) {
            self.type = type
            self.value = value
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct LastFinalizationError: Codable, Hashable, Sendable {
        /// The type of error returned. One of `api_connection_error`, `api_error`, `authentication_error`, `card_error`, `idempotency_error`, `invalid_request_error`, or `rate_limit_error`.
        public var type: StripeError.Variant?
        /// For some errors that could be handled programmatically, a short string indicating the error code reported.
        public var code: StripeErrorCode?
        /// A URL to more information about the error code reported.
        public var docUrl: String?
        /// A human-readable message providing more details about the error. For card errors, these messages can be shown to your users.
        public var message: String?
        /// If the error is parameter-specific, the parameter related to the error. For example, you can use this to display a message near the correct form field.
        public var param: String?
        /// If the error is specific to the type of payment method, the payment method type that had a problem. This field is only populated for invoice-related errors.
        public var paymentMethodType: Stripe.PaymentMethods.PaymentMethod.`Type`?

        public init(
            type: StripeError.Variant? = nil,
            code: StripeErrorCode? = nil,
            docUrl: String? = nil,
            message: String? = nil,
            param: String? = nil,
            paymentMethodType: Stripe.PaymentMethods.PaymentMethod.`Type`? = nil
        ) {
            self.type = type
            self.code = code
            self.docUrl = docUrl
            self.message = message
            self.param = param
            self.paymentMethodType = paymentMethodType
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct RenderingOptions: Codable, Hashable, Sendable {
        /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
        public var amountTaxDisplay: String?

        public init(
            amountTaxDisplay: String? = nil
        ) {
            self.amountTaxDisplay = amountTaxDisplay
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct TotalTaxAmount: Codable, Hashable, Sendable {
        /// The amount, in cents, of the tax.
        public var amount: Int?
        /// Whether this tax amount is inclusive or exclusive.
        public var inclusive: Bool?
        /// The tax rate that was applied to get this tax amount.
        @ExpandableOf<Stripe.Tax.Rate> public var taxRate
        /// The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
        public var taxabilityReason: Stripe.Billing.Invoice.TotalTaxAmount.TaxabilityReason?
        /// The amount on which tax is calculated, in cents.
        public var taxableAmount: Int?

        public init(
            amount: Int? = nil,
            inclusive: Bool? = nil,
            taxRate: Stripe.Tax.Rate.ID? = nil,
            taxabilityReason: Stripe.Billing.Invoice.TotalTaxAmount.TaxabilityReason? = nil,
            taxableAmount: Int? = nil
        ) {
            self.amount = amount
            self.inclusive = inclusive
            self._taxRate = Expandable(id: taxRate)
            self.taxabilityReason = taxabilityReason
            self.taxableAmount = taxableAmount
        }
    }
}

extension Stripe.Billing.Invoice.TotalTaxAmount {
    public enum TaxabilityReason: String, Codable, Sendable {
        /// Taxed at the standard rate.
        case standardRated = "standard_rated"
        /// Taxed at a reduced rate.
        case reducedRated = "reduced_rated"
        /// The transaction is taxed at a special rate of 0% or the transaction is exempt (but these exempt transactions still let you deduct the “input VAT” paid on your business purchases).
        case zeroRated = "zero_rated"
        /// No tax is applied as it is the responsibility of the buyer to account for tax in this case.
        case reverseCharge = "reverse_charge"
        /// No tax is applied as the customer is exempt from tax.
        case customerExempt = "customer_exempt"
        /// The product or service is nontaxable or exempt from tax.
        case productExempt = "product_exempt"
        /// The product or service is not taxed due to a sales tax holiday.
        case productExemptHoliday = "product_exempt_holiday"
        /// A portion of the price is taxed at the standard rate.
        case portionStandardRated = "portion_standard_rated"
        /// A portion of the price is taxed at a reduced rate.
        case portionReducedRated = "portion_reduced_rated"
        /// A portion of the price is exempt from tax.
        case portionProductExempt = "portion_product_exempt"
        /// A reduced amount of the price is subject to tax.
        case taxableBasisReduced = "taxable_basis_reduced"
        /// No tax is collected either because you are not registered to collect tax in this jurisdiction, or because the non-taxable product tax code (txcd_00000000) was used.
        case notCollecting = "not_collecting"
        /// No tax is imposed on this transaction.
        case notSubjectToTax = "not_subject_to_tax"
        /// No tax is applied as Stripe Tax does not support this jurisdiction or territory.
        case notSupported = "not_supported"
        /// The shipping cost tax rate is calculated as a weighted average of the other line items’ rates, weighted by their amounts.
        case proportionallyRated = "proportionally_rated"
    }
}

extension Stripe.Billing.Invoice {
    public struct TotalDiscountAmount: Codable, Hashable, Sendable {
        /// The amount, in cents, of the discount.
        public var amount: Int?
        /// The discount that was applied to get this discount amount.
        @ExpandableOf<Stripe.Products.Discount> public var discount

        public init(
            amount: Int? = nil,
            discount: Stripe.Products.Discount.ID? = nil
        ) {
            self.amount = amount
            self._discount = Expandable(id: discount)
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct TransferData: Codable, Hashable, Sendable {
        /// The amount in cents that will be transferred to the destination account when the invoice is paid. By default, the entire amount is transferred to the destination.
        public var amount: Int?
        /// The account where funds from the payment will be transferred to upon payment success.
        @ExpandableOf<Stripe.Connect.Account> public var destination

        public init(
            amount: Int? = nil,
            destination: Stripe.Connect.Account.ID? = nil
        ) {
            self.amount = amount
            self._destination = Expandable(id: destination)
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Billing.Invoice]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Billing.Invoice]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}

// MARK: - Parent
extension Stripe.Billing.Invoice {

    /// Details about the subscription that created an invoice.
    public struct SubscriptionDetails: Codable, Hashable, Sendable {
        /// The subscription that generated this invoice.
        @ExpandableOf<Stripe.Billing.Subscription> public var subscription:
            Stripe.Billing.Subscription.ID?
        /// An immutable snapshot of the subscription's metadata as of invoice finalization.
        /// Populated only for invoices created on or after 2023-06-29.
        public var metadata: [String: String]?
        /// Only set on upcoming invoices that preview prorations: the time used to calculate them.
        public var subscriptionProrationDate: Date?

        private enum CodingKeys: String, CodingKey {
            case subscription
            case metadata
            case subscriptionProrationDate
        }

        public init(
            subscription: Stripe.Billing.Subscription.ID? = nil,
            metadata: [String: String]? = nil,
            subscriptionProrationDate: Date? = nil
        ) {
            self._subscription = Expandable(id: subscription)
            self.metadata = metadata
            self.subscriptionProrationDate = subscriptionProrationDate
        }
    }

    /// Details about the quote that created an invoice.
    public struct QuoteDetails: Codable, Hashable, Sendable {
        /// The quote that generated this invoice.
        public var quote: Stripe.Billing.Quote.ID?

        public init(quote: Stripe.Billing.Quote.ID? = nil) {
            self.quote = quote
        }
    }
}

// MARK: - Fields added through API version 2026-07-29.dahlia
extension Stripe.Billing.Invoice {

    /// A credit applied to an invoice before tax.
    public struct PretaxCreditAmount: Codable, Hashable, Sendable {
        public var amount: Int?
        @ExpandableOf<Stripe.Billing.Credit.Balance.Transaction> public var creditBalanceTransaction:
            Stripe.Billing.Credit.Balance.Transaction.ID?
        @ExpandableOf<Stripe.Products.Discount> public var discount: Stripe.Products.Discount.ID?
        public var type: `Type`?

        private enum CodingKeys: String, CodingKey {
            case amount
            case creditBalanceTransaction
            case discount
            case type
        }

        public init(
            amount: Int? = nil,
            creditBalanceTransaction: Stripe.Billing.Credit.Balance.Transaction.ID? = nil,
            discount: Stripe.Products.Discount.ID? = nil,
            type: `Type`? = nil
        ) {
            self.amount = amount
            self._creditBalanceTransaction = Expandable(id: creditBalanceTransaction)
            self._discount = Expandable(id: discount)
            self.type = type
        }

        public enum `Type`: String, Codable, Sendable {
            case creditBalanceTransaction = "credit_balance_transaction"
            case discount
        }
    }

    /// A tax applied to an invoice, by rate.
    public struct TotalTax: Codable, Hashable, Sendable {
        public var amount: Int?
        public var taxBehavior: TaxBehavior?
        public var taxRateDetails: TaxRateDetails?
        public var taxabilityReason: TaxabilityReason?
        public var taxableAmount: Int?
        public var type: `Type`?

        private enum CodingKeys: String, CodingKey {
            case amount
            case taxBehavior
            case taxRateDetails
            case taxabilityReason
            case taxableAmount
            case type
        }

        public init(
            amount: Int? = nil,
            taxBehavior: TaxBehavior? = nil,
            taxRateDetails: TaxRateDetails? = nil,
            taxabilityReason: TaxabilityReason? = nil,
            taxableAmount: Int? = nil,
            type: `Type`? = nil
        ) {
            self.amount = amount
            self.taxBehavior = taxBehavior
            self.taxRateDetails = taxRateDetails
            self.taxabilityReason = taxabilityReason
            self.taxableAmount = taxableAmount
            self.type = type
        }

        public enum TaxBehavior: String, Codable, Sendable {
            case exclusive
            case inclusive
        }

        public enum `Type`: String, Codable, Sendable {
            case taxRateDetails = "tax_rate_details"
        }

        public enum TaxabilityReason: String, Codable, Sendable {
            case customerExempt = "customer_exempt"
            case notAvailable = "not_available"
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

        public struct TaxRateDetails: Codable, Hashable, Sendable {
            @ExpandableOf<Stripe.Tax.Rate> public var taxRate: Stripe.Tax.Rate.ID?

            private enum CodingKeys: String, CodingKey {
                case taxRate
            }

            public init(taxRate: Stripe.Tax.Rate.ID? = nil) {
                self._taxRate = Expandable(id: taxRate)
            }
        }
    }
}
