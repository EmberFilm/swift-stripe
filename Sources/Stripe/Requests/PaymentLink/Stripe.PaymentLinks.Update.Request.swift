#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/payment-link/update.md
extension Stripe.PaymentLinks.Update {
    public struct Request: Codable, Equatable, Sendable {
        public let active: Bool?
        public let afterCompletion: Stripe.PaymentLink.After.Completion?
        public let allowPromotionCodes: Bool?
        public let automaticTax: Stripe.PaymentLink.AutomaticTax?
        public let billingAddressCollection: Stripe.PaymentLink.Billing.Address.Collection?
        public let customFields: [Stripe.PaymentLink.CustomField]?
        public let customText: Stripe.PaymentLink.Custom.Text?
        public let customerCreation: Stripe.PaymentLink.Customer.Creation?
        public let inactiveMessage: String?
        public let invoiceCreation: InvoiceCreation?
        public let lineItems: [Stripe.PaymentLinks.Update.LineItem]?
        public let metadata: [String: String]?
        public let paymentMethodCollection: Stripe.PaymentLink.PaymentMethod.Collection?
        public let paymentMethodTypes: [String]?
        public let restrictions: Stripe.PaymentLink.Restrictions?
        public let shippingAddressCollection: Stripe.PaymentLink.Shipping.Address.Collection?
        public let submitType: Stripe.PaymentLink.Submit.`Type`?
        public let subscriptionData: Stripe.PaymentLink.Subscription.Data?
        public let taxIdCollection: Stripe.PaymentLink.TaxId.Collection?

        private enum CodingKeys: String, CodingKey {
            case active
            case afterCompletion
            case allowPromotionCodes
            case automaticTax
            case billingAddressCollection
            case customFields
            case customText
            case customerCreation
            case inactiveMessage
            case invoiceCreation
            case lineItems
            case metadata
            case paymentMethodCollection
            case paymentMethodTypes
            case restrictions
            case shippingAddressCollection
            case submitType
            case subscriptionData
            case taxIdCollection
        }

        public init(
            active: Bool? = nil,
            afterCompletion: Stripe.PaymentLink.After.Completion? = nil,
            allowPromotionCodes: Bool? = nil,
            automaticTax: Stripe.PaymentLink.AutomaticTax? = nil,
            billingAddressCollection: Stripe.PaymentLink.Billing.Address.Collection? = nil,
            customFields: [Stripe.PaymentLink.CustomField]? = nil,
            customText: Stripe.PaymentLink.Custom.Text? = nil,
            customerCreation: Stripe.PaymentLink.Customer.Creation? = nil,
            inactiveMessage: String? = nil,
            invoiceCreation: InvoiceCreation? = nil,
            lineItems: [Stripe.PaymentLinks.Update.LineItem]? = nil,
            metadata: [String: String]? = nil,
            paymentMethodCollection: Stripe.PaymentLink.PaymentMethod.Collection? = nil,
            paymentMethodTypes: [String]? = nil,
            restrictions: Stripe.PaymentLink.Restrictions? = nil,
            shippingAddressCollection: Stripe.PaymentLink.Shipping.Address.Collection? = nil,
            submitType: Stripe.PaymentLink.Submit.`Type`? = nil,
            subscriptionData: Stripe.PaymentLink.Subscription.Data? = nil,
            taxIdCollection: Stripe.PaymentLink.TaxId.Collection? = nil
        ) {
            self.active = active
            self.afterCompletion = afterCompletion
            self.allowPromotionCodes = allowPromotionCodes
            self.automaticTax = automaticTax
            self.billingAddressCollection = billingAddressCollection
            self.customFields = customFields
            self.customText = customText
            self.customerCreation = customerCreation
            self.inactiveMessage = inactiveMessage
            self.invoiceCreation = invoiceCreation
            self.lineItems = lineItems
            self.metadata = metadata
            self.paymentMethodCollection = paymentMethodCollection
            self.paymentMethodTypes = paymentMethodTypes
            self.restrictions = restrictions
            self.shippingAddressCollection = shippingAddressCollection
            self.submitType = submitType
            self.subscriptionData = subscriptionData
            self.taxIdCollection = taxIdCollection
        }
    }
}

extension Stripe.PaymentLinks.Update {
    public struct LineItem: Codable, Equatable, Sendable {
        public let id: String
        public let adjustableQuantity: Stripe.AdjustableQuantity?
        public let quantity: Int?

        private enum CodingKeys: String, CodingKey {
            case id
            case adjustableQuantity
            case quantity
        }

        public init(
            id: String,
            adjustableQuantity: Stripe.AdjustableQuantity? = nil,
            quantity: Int? = nil
        ) {
            self.id = id
            self.adjustableQuantity = adjustableQuantity
            self.quantity = quantity
        }
    }
}

extension Stripe.PaymentLinks.Update {
    public struct InvoiceCreation: Codable, Equatable, Sendable {
        public let enabled: Bool
        public let invoiceData: InvoiceData?

        private enum CodingKeys: String, CodingKey {
            case enabled
            case invoiceData
        }

        public init(
            enabled: Bool,
            invoiceData: InvoiceData? = nil
        ) {
            self.enabled = enabled
            self.invoiceData = invoiceData
        }

        public struct InvoiceData: Codable, Equatable, Sendable {
            public let accountTaxIds: [String]?
            public let customFields: [CustomField]?
            public let description: String?
            public let footer: String?
            public let metadata: [String: String]?
            public let renderingOptions: RenderingOptions?

            private enum CodingKeys: String, CodingKey {
                case accountTaxIds
                case customFields
                case description
                case footer
                case metadata
                case renderingOptions
            }

            public init(
                accountTaxIds: [String]? = nil,
                customFields: [CustomField]? = nil,
                description: String? = nil,
                footer: String? = nil,
                metadata: [String: String]? = nil,
                renderingOptions: RenderingOptions? = nil
            ) {
                self.accountTaxIds = accountTaxIds
                self.customFields = customFields
                self.description = description
                self.footer = footer
                self.metadata = metadata
                self.renderingOptions = renderingOptions
            }

            public struct CustomField: Codable, Equatable, Sendable {
                public let name: String
                public let value: String

                public init(
                    name: String,
                    value: String
                ) {
                    self.name = name
                    self.value = value
                }
            }

            public struct RenderingOptions: Codable, Equatable, Sendable {
                public let amountTaxDisplay: AmountTaxDisplay?

                private enum CodingKeys: String, CodingKey {
                    case amountTaxDisplay
                }

                public init(
                    amountTaxDisplay: AmountTaxDisplay? = nil
                ) {
                    self.amountTaxDisplay = amountTaxDisplay
                }

                public enum AmountTaxDisplay: String, Codable, Sendable {
                    case excludeTax = "exclude_tax"
                    case includeInclusiveTax = "include_inclusive_tax"
                }
            }
        }
    }
}
