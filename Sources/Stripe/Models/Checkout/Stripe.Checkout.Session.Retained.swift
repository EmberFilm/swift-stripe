//
//  Sessions.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/checkout/sessions/object.md

// The Session struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Checkout.Session` that the generator spells differently.

// The LineItem struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Checkout.Session.LineItem` that the generator spells differently.

extension Stripe.Checkout.Session {
    public enum Custom {}
}

extension Stripe.Checkout.Session {
    public enum PaymentMethod {}
}

extension Stripe.Checkout.Session.Custom {
    public struct Field: Codable, Hashable, Sendable {
        /// Configuration for `type=dropdown` fields.
        public var dropdown: Stripe.Checkout.Session.Custom.Field.Dropdown?
        /// String of your choice that your integration can use to reconcile this field. Must be unique to this field, alphanumeric, and up to 200 characters.
        public var key: String?
        /// The label for the field, displayed to the customer.
        public var label: Stripe.Checkout.Session.Custom.Field.Label?
        /// Configuration for `type=numeric` fields.
        public var numeric: Stripe.Checkout.Session.Custom.Field.Numeric?
        /// Whether the customer is required to complete the field before completing the Checkout Session. Defaults to `false`.
        public var optional: Bool?
        /// Configuration for `type=text` fields.
        public var text: Stripe.Checkout.Session.Custom.Field.Text?
        /// The type of the field.
        public var type: Stripe.Checkout.Session.Custom.Field.`Type`?

        public init(
            dropdown: Stripe.Checkout.Session.Custom.Field.Dropdown? = nil,
            key: String? = nil,
            label: Stripe.Checkout.Session.Custom.Field.Label? = nil,
            numeric: Stripe.Checkout.Session.Custom.Field.Numeric? = nil,
            optional: Bool? = nil,
            text: Stripe.Checkout.Session.Custom.Field.Text? = nil,
            type: Stripe.Checkout.Session.Custom.Field.`Type`? = nil
        ) {
            self.dropdown = dropdown
            self.key = key
            self.label = label
            self.numeric = numeric
            self.optional = optional
            self.text = text
            self.type = type
        }
    }
}

extension Stripe.Checkout.Session.Custom.Field {
    public struct Dropdown: Codable, Hashable, Sendable {
        /// The options available for the customer to select. Up to 200 options allowed
        public var options: [Stripe.Checkout.Session.Custom.Field.Dropdown.Option]?
        /// The option selected by the customer. This will be the `value` for the option.
        public var value: String?

        public init(
            options: [Stripe.Checkout.Session.Custom.Field.Dropdown.Option]? = nil,
            value: String? = nil
        ) {
            self.options = options
            self.value = value
        }
    }
}
extension Stripe.Checkout.Session.Custom.Field.Dropdown {
    public struct Option: Codable, Hashable, Sendable {
        /// The label for the option, displayed to the customer. Up to 100 characters.
        public var label: String?
        /// The value for this option, not displayed to the customer, used by your integration to reconcile the option selected by the customer. Must be unique to this option, alphanumeric, and up to 100 characters.
        public var value: String?

        public init(
            label: String? = nil,
            value: String? = nil
        ) {
            self.label = label
            self.value = value
        }
    }
}

extension Stripe.Checkout.Session.Custom.Field {
    public struct Label: Codable, Hashable, Sendable {
        /// Custom text for the label, displayed to the customer. Up to 50 characters.
        public var custom: String?
        /// The type of the label.
        public var type: Stripe.Checkout.Session.Custom.Field.Label.`Type`?

        public init(
            custom: String? = nil,
            type: Stripe.Checkout.Session.Custom.Field.Label.`Type`? = nil
        ) {
            self.custom = custom
            self.type = type
        }
    }
}

extension Stripe.Checkout.Session.Custom.Field.Label {
    public enum `Type`: String, Codable, Sendable {
        /// Set a custom label for the field.
        case custom
    }
}

extension Stripe.Checkout.Session.Custom.Field {
    public struct Numeric: Codable, Hashable, Sendable {
        /// The maximum character length constraint for the customer’s input.
        public var maximumLength: Int?
        /// The minimum character length requirement for the customer’s input.
        public var minimumLength: Int?
        /// The value entered by the customer, containing only digits.
        public var value: String?

        private enum CodingKeys: String, CodingKey {
            case maximumLength
            case minimumLength
            case value
        }

        public init(
            maximumLength: Int? = nil,
            minimumLength: Int? = nil,
            value: String? = nil
        ) {
            self.maximumLength = maximumLength
            self.minimumLength = minimumLength
            self.value = value
        }
    }
}

extension Stripe.Checkout.Session.Custom.Field {
    public struct Text: Codable, Hashable, Sendable {
        /// The maximum character length constraint for the customer’s input.
        public var maximumLength: Int?
        /// The minimum character length requirement for the customer’s input.
        public var minimumLength: Int?
        /// The value entered by the customer.
        public var value: String?

        private enum CodingKeys: String, CodingKey {
            case maximumLength
            case minimumLength
            case value
        }

        public init(
            maximumLength: Int? = nil,
            minimumLength: Int? = nil,
            value: String? = nil
        ) {
            self.maximumLength = maximumLength
            self.minimumLength = minimumLength
            self.value = value
        }
    }
}

extension Stripe.Checkout.Session.Custom.Field {
    public enum `Type`: String, Codable, Sendable {
        /// Collect a string field from your customer.
        case text
        /// Collect a numbers-only field from your customer.
        case numeric
        /// Provide a list of options for your customer to select.
        case dropdown
    }
}

extension Stripe.Checkout.Session.Custom {
    public struct Text: Codable, Hashable, Sendable {
        /// Custom text that should be displayed alongside shipping address collection.
        public var shippingAddress: Stripe.Checkout.Session.Custom.Text.Shipping.Address?
        /// Custom text that should be displayed alongside the payment confirmation button.
        public var submit: Stripe.Checkout.Session.CustomTextSubmit?

        private enum CodingKeys: String, CodingKey {
            case shippingAddress
            case submit
        }

        public init(
            shippingAddress: Stripe.Checkout.Session.Custom.Text.Shipping.Address? = nil,
            submit: Stripe.Checkout.Session.CustomTextSubmit? = nil
        ) {
            self.shippingAddress = shippingAddress
            self.submit = submit
        }
    }
}

extension Stripe.Checkout.Session.Custom.Text {
    public enum Shipping {}
}

extension Stripe.Checkout.Session.Custom.Text.Shipping {
    public struct Address: Codable, Hashable, Sendable {
        /// Text may be up to 1000 characters in length.
        public var message: String?

        public init(
            message: String? = nil
        ) {
            self.message = message
        }
    }
}

extension Stripe.Checkout.Session {
    public struct CustomTextSubmit: Codable, Hashable, Sendable {
        /// Text may be up to 1000 characters in length.
        public var message: String?

        public init(
            message: String? = nil
        ) {
            self.message = message
        }
    }
}

extension Stripe.Checkout.Session {
    public enum Customer {}
}

extension Stripe.Checkout.Session.Customer {
    public enum Creation: String, Codable, Sendable {
        /// The Checkout Session will only create a Customer if it is required for Session confirmation. Currently, only `subscription` mode Sessions require a Customer.
        case ifRequired = "if_required"
        /// The Checkout Session will always create a Customer when a Session confirmation is attempted.
        case always
    }
}

extension Stripe.Checkout.Session.Invoice {
    public struct Creation: Codable, Hashable, Sendable {
        /// Indicates whether invoice creation is enabled for the Checkout Session.
        public var enabled: Bool?
        /// Parameters passed when creating invoices for payment-mode Checkout Sessions.
        public var invoiceData: Stripe.Checkout.Session.Invoice.Creation.Invoice.Data?

        public init(
            enabled: Bool? = nil,
            invoiceData: Stripe.Checkout.Session.Invoice.Creation.Invoice.Data? = nil
        ) {
            self.enabled = enabled
            self.invoiceData = invoiceData
        }
    }
}

extension Stripe.Checkout.Session {
    public enum Invoice {}
}

extension Stripe.Checkout.Session.Invoice.Creation {
    public enum Invoice {}
}

extension Stripe.Checkout.Session.Invoice.Creation.Invoice {
    public struct Data: Codable, Hashable, Sendable {
        /// The account tax IDs associated with the invoice
        @ExpandableCollection<Stripe.Tax.ID> public var accountTaxIds: [String]?
        /// Custom fields displayed on the invoice.
        public var customFields:
            [Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Custom.Fields]?
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public var description: String?
        /// Footer displayed on the invoice.
        public var footer: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// Options for invoice PDF rendering.
        public var renderingOptions:
            Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Rendering.Options?

        public init(
            accountTaxIds: [String]? = nil,
            customFields: [Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Custom.Fields]? =
                nil,
            description: String? = nil,
            footer: String? = nil,
            metadata: [String: String]? = nil,
            renderingOptions: Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Rendering
                .Options? =
                nil
        ) {
            self._accountTaxIds = ExpandableCollection(ids: accountTaxIds)
            self.customFields = customFields
            self.description = description
            self.footer = footer
            self.metadata = metadata
            self.renderingOptions = renderingOptions
        }
    }
}

extension Stripe.Checkout.Session.Invoice.Creation.Invoice.Data {
    public enum Custom {}
}

extension Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Custom {
    public struct Fields: Codable, Hashable, Sendable {
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
extension Stripe.Checkout.Session.Invoice.Creation.Invoice.Data {
    public enum Rendering {}
}

extension Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Rendering {
    public struct Options: Codable, Hashable, Sendable {
        /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
        public var amountTaxDisplay: String?

        public init(
            amountTaxDisplay: String? = nil
        ) {
            self.amountTaxDisplay = amountTaxDisplay
        }
    }
}

extension Stripe.Checkout.Session {
    public enum Billing {}
}

extension Stripe.Checkout.Session.Billing {
    public enum Address {}
}

extension Stripe.Checkout.Session.Billing.Address {
    public enum Collection: String, Codable, Sendable {
        /// Checkout will only collect the billing address when necessary. When using `automatic_tax`, Checkout will collect the minimum number of fields required for tax calculation.
        case auto
        /// Checkout will always collect the customer’s billing address.
        case required
    }
}

extension Stripe.Checkout.Session {
    public typealias Currency = Stripe.Currency
}


extension Stripe.Checkout.Session.Customer {
    public struct Details: Codable, Hashable, Sendable {
        /// The customer’s address after a completed Checkout Session. Note: This property is populated only for sessions on or after March 30, 2022.
        public var address: Address?
        /// The customer’s email at time of checkout.
        public var email: String?
        /// The customer’s name after a completed Checkout Session. Note: This property is populated only for sessions on or after March 30, 2022.
        public var name: String?
        /// The customer’s phone number at the time of checkout
        public var phone: String?
        /// The customer’s tax exempt status at time of checkout.
        public var taxExempt: String?
        /// The customer’s tax IDs at time of checkout.
        public var taxIds: [Stripe.Checkout.Session.Customer.Details.TaxId]?

        public init(
            address: Address? = nil,
            email: String? = nil,
            name: String? = nil,
            phone: String? = nil,
            taxExempt: String? = nil,
            taxIds: [Stripe.Checkout.Session.Customer.Details.TaxId]? = nil
        ) {
            self.address = address
            self.email = email
            self.name = name
            self.phone = phone
            self.taxExempt = taxExempt
            self.taxIds = taxIds
        }
    }
}

extension Stripe.Checkout.Session.Customer.Details {
    public struct TaxId: Codable, Hashable, Sendable {
        /// The type of the tax ID.
        public var type: Stripe.Tax.ID.`Type`
        /// The value of the tax ID.
        public var value: String?

        public init(
            type: Stripe.Tax.ID.`Type`,
            value: String? = nil
        ) {
            self.type = type
            self.value = value
        }
    }
}

extension Stripe.Checkout.Session.LineItem {
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

extension Stripe.Checkout.Session.LineItem {
    public struct Tax: Codable, Hashable, Sendable {
        /// Amount of tax applied for this rate.
        public var amount: Int?
        /// The tax rate applied.
        public var rate: Stripe.Tax.Rate?

        public init(
            amount: Int? = nil,
            rate: Stripe.Tax.Rate? = nil
        ) {
            self.amount = amount
            self.rate = rate
        }
    }
}

extension Stripe.Checkout.Session.LineItem {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Checkout.Session.LineItem]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Checkout.Session.LineItem]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}

extension Stripe.Checkout.Session.PaymentMethod {
    public enum Collection: String, Codable, Sendable {
        /// The Checkout Session will always collect a PaymentMethod.
        case always
        /// The Checkout Session will only collect a PaymentMethod if there is an amount due.
        case ifRequired = "if_required"
    }
}

extension Stripe.Checkout.Session {
    public enum Shipping {}
}

extension Stripe.Checkout.Session.Shipping {
    public enum Address {}
}

extension Stripe.Checkout.Session.Shipping.Address {
    public struct Collection: Codable, Hashable, Sendable {
        /// An array of two-letter ISO country codes representing which countries Checkout should provide as options for shipping locations. Unsupported country codes: `AS, CX, CC, CU, HM, IR, KP, MH, FM, NF, MP, PW, SD, SY, UM, VI`.
        public var allowedCountries: [String]?

        public init(
            allowedCountries: [String]? = nil
        ) {
            self.allowedCountries = allowedCountries
        }
    }
}

extension Stripe.Checkout.Session.Shipping {
    public struct Cost: Codable, Hashable, Sendable {
        /// Total shipping cost before any discounts or taxes are applied.
        public var amountSubtotal: Int?
        /// Total tax amount applied due to shipping costs. If no tax was applied, defaults to 0.
        public var amountTax: Int?
        /// Total shipping cost after discounts and taxes are applied.
        public var amountTotal: Int?
        /// The ID of the Shipping.Rate for this order.
        @ExpandableOf<Stripe.Products.Shipping.Rate> public var shippingRate
        /// The taxes applied to the shipping rate. This field is not included by default. To include it in the response, expand the `taxes` field.
        public var taxes: [Stripe.Checkout.Session.Shipping.Cost.Taxes]?

        public init(
            amountSubtotal: Int? = nil,
            amountTax: Int? = nil,
            amountTotal: Int? = nil,
            shippingRate: Stripe.Products.Shipping.Rate.ID? = nil,
            taxes: [Stripe.Checkout.Session.Shipping.Cost.Taxes]? = nil
        ) {
            self.amountSubtotal = amountSubtotal
            self.amountTax = amountTax
            self.amountTotal = amountTotal
            self._shippingRate = Expandable(id: shippingRate)
            self.taxes = taxes
        }
    }
}

extension Stripe.Checkout.Session.Shipping.Cost {
    public struct Taxes: Codable, Hashable, Sendable {
        /// Amount of tax applied for this rate.
        public var amount: Int?
        /// The tax rate applied.
        public var rate: Stripe.Tax.Rate?

        public init(
            amount: Int? = nil,
            rate: Stripe.Tax.Rate? = nil
        ) {
            self.amount = amount
            self.rate = rate
        }
    }
}

extension Stripe.Checkout.Session.Shipping {
    public struct Option: Codable, Hashable, Sendable {
        /// A non-negative integer in cents representing how much to charge.
        public var shippingAmount: Int?
        /// The shipping rate.
        @Expandable<Stripe.Products.Shipping.Rate, Stripe.Products.Shipping.Rate.ID> public
            var shippingRate

        public init(
            shippingAmount: Int? = nil,
            shippingRate: Stripe.Products.Shipping.Rate.ID? = nil
        ) {
            self.shippingAmount = shippingAmount
            self._shippingRate = Expandable(id: shippingRate)
        }
    }
}

extension Stripe.Checkout.Session {
    public enum Submit {}
}

extension Stripe.Checkout.Session.Submit {
    public enum `Type`: String, Codable, Sendable {
        case auto
        case book
        case donate
        case pay
    }
}

extension Stripe.Checkout.Session {
    public enum Total {}
}

extension Stripe.Checkout.Session.Total {
    public struct Details: Codable, Hashable, Sendable {
        /// This is the sum of all the line item discounts.
        public var amountDiscount: Int?
        /// This is the sum of all the line item shipping amounts.
        public var amountShipping: Int?
        /// This is the sum of all the line item tax amounts.
        public var amountTax: Int?
        /// Breakdown of individual tax and discount amounts that add up to the totals. This field is not included by default. To include it in the response, expand the breakdown field.
        public var breakdown: Stripe.Checkout.Session.Total.Details.Breakdown?

        public init(
            amountDiscount: Int? = nil,
            amountShipping: Int? = nil,
            amountTax: Int? = nil,
            breakdown: Stripe.Checkout.Session.Total.Details.Breakdown? = nil
        ) {
            self.amountDiscount = amountDiscount
            self.amountShipping = amountShipping
            self.amountTax = amountTax
            self.breakdown = breakdown
        }
    }
}

extension Stripe.Checkout.Session.Total.Details {
    public struct Breakdown: Codable, Hashable, Sendable {
        /// The aggregated discounts.
        public var discounts: [Stripe.Checkout.Session.Total.Details.Breakdown.Discount]?
        /// The aggregated tax amounts by rate.
        public var taxes: [Stripe.Checkout.Session.Total.Details.Breakdown.Tax]?
    }
}

extension Stripe.Checkout.Session.Total.Details.Breakdown {
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

extension Stripe.Checkout.Session.Total.Details.Breakdown {
    public struct Tax: Codable, Hashable, Sendable {
        /// Amount of tax applied for this rate.
        public var amount: Int?
        /// The tax rate applied.
        public var rate: Stripe.Tax.Rate?

        public init(
            amount: Int? = nil,
            rate: Stripe.Tax.Rate? = nil
        ) {
            self.amount = amount
            self.rate = rate
        }
    }
}

extension Stripe.Checkout.Session {
    public enum Payment {}
}

extension Stripe.Checkout.Session.Payment {
    public enum Status: String, Codable, Sendable {
        /// The payment funds are available in your account.
        case paid
        /// The payment funds are not yet available in your account.
        case unpaid
        /// The Checkout Session is in setup mode and doesn’t require a payment at this time.
        case noPaymentRequired = "no_payment_required"
    }
}

extension Stripe.Checkout.Session {
    public enum TaxId {}
}

extension Stripe.Checkout.Session.TaxId {
    public struct Collection: Codable, Hashable, Sendable {
        /// Indicates whether tax ID collection is enabled for the session
        public var enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }
}


// MARK: - Fields added through API version 2026-07-29.dahlia
extension Stripe.Checkout.Session {

    /// A discount applied to a session, as a coupon or a promotion code.
    public struct Discount: Codable, Hashable, Sendable {
        @ExpandableOf<Stripe.Products.Coupon> public var coupon: Stripe.Products.Coupon.ID?
        @ExpandableOf<Promotion.Code> public var promotionCode: Promotion.Code.ID?

        private enum CodingKeys: String, CodingKey {
            case coupon
            case promotionCode
        }

        public init(
            coupon: Stripe.Products.Coupon.ID? = nil,
            promotionCode: Promotion.Code.ID? = nil
        ) {
            self._coupon = Expandable(id: coupon)
            self._promotionCode = Expandable(id: promotionCode)
        }
    }

    /// The payment method configuration that produced the available payment methods.
    public struct PaymentMethodConfigurationDetails: Codable, Hashable, Sendable {
        public var id: String?
        /// The parent configuration this one inherits from, for connected accounts.
        public var parent: String?

        public init(id: String? = nil, parent: String? = nil) {
            self.id = id
            self.parent = parent
        }
    }
}
