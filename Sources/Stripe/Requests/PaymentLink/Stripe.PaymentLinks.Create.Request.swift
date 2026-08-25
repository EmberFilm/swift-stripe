#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/payment-link/create.md
extension Stripe.PaymentLinks.Create {
    public struct Request: Codable, Equatable, Sendable {
        public let lineItems: [LineItem]
        public let metadata: [String: String]?
        public let afterCompletion: Stripe.PaymentLink.After.Completion?
        public let allowPromotionCodes: Bool?
        public let applicationFeeAmount: Int?
        public let applicationFeePercent: Decimal?
        public let automaticTax: Stripe.PaymentLink.AutomaticTax?
        public let billingAddressCollection: Stripe.PaymentLink.Billing.Address.Collection?
        public let consentCollection: Stripe.PaymentLink.Consent.Collection?
        public let currency: Stripe.Currency?
        public let customFields: [Stripe.PaymentLink.CustomField]?
        public let customText: Stripe.PaymentLink.Custom.Text?
        public let customerCreation: Stripe.PaymentLink.Customer.Creation?
        public let inactiveMessage: String?
        public let invoiceCreation: Stripe.PaymentLink.Invoice.Creation?
        public let onBehalfOf: String?
        public let paymentIntentData: Stripe.PaymentLink.PaymentIntent.Data?
        public let paymentMethodCollection: Stripe.PaymentLink.PaymentMethod.Collection?
        public let paymentMethodTypes: [String]?
        public let phoneNumberCollection: Bool?
        public let restrictions: Stripe.PaymentLink.Restrictions?
        public let shippingAddressCollection: Stripe.PaymentLink.Shipping.Address.Collection?
        public let shippingOptions: [Stripe.PaymentLink.Shipping.Option]?
        public let submitType: Stripe.PaymentLink.Submit.`Type`?
        public let subscriptionData: Stripe.PaymentLink.Subscription.Data?
        public let taxIdCollection: Stripe.PaymentLink.TaxId.Collection?
        public let transferData: Stripe.PaymentLink.Transfer.Data?

        private enum CodingKeys: String, CodingKey {
            case lineItems
            case metadata
            case afterCompletion
            case allowPromotionCodes
            case applicationFeeAmount
            case applicationFeePercent
            case automaticTax
            case billingAddressCollection
            case consentCollection
            case currency
            case customFields
            case customText
            case customerCreation
            case inactiveMessage
            case invoiceCreation
            case onBehalfOf
            case paymentIntentData
            case paymentMethodCollection
            case paymentMethodTypes
            case phoneNumberCollection
            case restrictions
            case shippingAddressCollection
            case shippingOptions
            case submitType
            case subscriptionData
            case taxIdCollection
            case transferData
        }

        public init(
            lineItems: [LineItem],
            metadata: [String: String]? = nil,
            afterCompletion: Stripe.PaymentLink.After.Completion? = nil,
            allowPromotionCodes: Bool? = nil,
            applicationFeeAmount: Int? = nil,
            applicationFeePercent: Decimal? = nil,
            automaticTax: Stripe.PaymentLink.AutomaticTax? = nil,
            billingAddressCollection: Stripe.PaymentLink.Billing.Address.Collection? = nil,
            consentCollection: Stripe.PaymentLink.Consent.Collection? = nil,
            currency: Stripe.Currency? = nil,
            customFields: [Stripe.PaymentLink.CustomField]? = nil,
            customText: Stripe.PaymentLink.Custom.Text? = nil,
            customerCreation: Stripe.PaymentLink.Customer.Creation? = nil,
            inactiveMessage: String? = nil,
            invoiceCreation: Stripe.PaymentLink.Invoice.Creation? = nil,
            onBehalfOf: String? = nil,
            paymentIntentData: Stripe.PaymentLink.PaymentIntent.Data? = nil,
            paymentMethodCollection: Stripe.PaymentLink.PaymentMethod.Collection? = nil,
            paymentMethodTypes: [String]? = nil,
            phoneNumberCollection: Bool? = nil,
            restrictions: Stripe.PaymentLink.Restrictions? = nil,
            shippingAddressCollection: Stripe.PaymentLink.Shipping.Address.Collection? = nil,
            shippingOptions: [Stripe.PaymentLink.Shipping.Option]? = nil,
            submitType: Stripe.PaymentLink.Submit.`Type`? = nil,
            subscriptionData: Stripe.PaymentLink.Subscription.Data? = nil,
            taxIdCollection: Stripe.PaymentLink.TaxId.Collection? = nil,
            transferData: Stripe.PaymentLink.Transfer.Data? = nil
        ) {
            self.lineItems = lineItems
            self.metadata = metadata
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
            self.inactiveMessage = inactiveMessage
            self.invoiceCreation = invoiceCreation
            self.onBehalfOf = onBehalfOf
            self.paymentIntentData = paymentIntentData
            self.paymentMethodCollection = paymentMethodCollection
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
    }
}

extension Stripe.PaymentLinks.Create {
    public struct LineItem: Codable, Equatable, Sendable {
        public let price: Stripe.Products.Price.ID?
        public let priceData: Stripe.LineItemPriceData?
        public let quantity: Int
        public let adjustableQuantity: Stripe.AdjustableQuantity?

        private enum CodingKeys: String, CodingKey {
            case price
            case priceData
            case quantity
            case adjustableQuantity
        }

        public init(
            price: Stripe.Products.Price.ID? = nil,
            priceData: Stripe.LineItemPriceData? = nil,
            quantity: Int,
            adjustableQuantity: Stripe.AdjustableQuantity? = nil
        ) {
            self.price = price
            self.priceData = priceData
            self.quantity = quantity
            self.adjustableQuantity = adjustableQuantity
        }
    }
}

public struct AfterCompletion: Codable, Equatable, Sendable {
    public let type: CompletionType
    public let hostedConfirmation: HostedConfirmation?
    public let redirect: Redirect?

    private enum CodingKeys: String, CodingKey {
        case type
        case hostedConfirmation
        case redirect
    }

    public init(
        type: CompletionType,
        hostedConfirmation: HostedConfirmation? = nil,
        redirect: Redirect? = nil
    ) {
        self.type = type
        self.hostedConfirmation = hostedConfirmation
        self.redirect = redirect
    }

    public enum CompletionType: String, Codable, Sendable {
        case hostedConfirmation = "hosted_confirmation"
        case redirect
    }
}

public struct HostedConfirmation: Codable, Equatable, Sendable {
    public let customMessage: String?

    private enum CodingKeys: String, CodingKey {
        case customMessage
    }

    public init(customMessage: String? = nil) {
        self.customMessage = customMessage
    }
}

public struct Redirect: Codable, Equatable, Sendable {
    public let url: String

    public init(url: String) {
        self.url = url
    }
}

public struct AutomaticTax: Codable, Equatable, Sendable {
    public let enabled: Bool
    public let liability: Liability?

    public init(
        enabled: Bool,
        liability: Liability? = nil
    ) {
        self.enabled = enabled
        self.liability = liability
    }

    public struct Liability: Codable, Equatable, Sendable {
        public let type: LiabilityType
        public let account: String?

        public init(
            type: LiabilityType,
            account: String? = nil
        ) {
            self.type = type
            self.account = account
        }

        public enum LiabilityType: String, Codable, Sendable {
            case account
            case `self`
        }
    }
}

public struct ConsentCollection: Codable, Equatable, Sendable {
    public let paymentMethodReuseAgreement: PaymentMethodReuseAgreement?
    public let promotions: Promotions?
    public let termsOfService: TermsOfService?

    private enum CodingKeys: String, CodingKey {
        case paymentMethodReuseAgreement
        case promotions
        case termsOfService
    }

    public init(
        paymentMethodReuseAgreement: PaymentMethodReuseAgreement? = nil,
        promotions: Promotions? = nil,
        termsOfService: TermsOfService? = nil
    ) {
        self.paymentMethodReuseAgreement = paymentMethodReuseAgreement
        self.promotions = promotions
        self.termsOfService = termsOfService
    }

    public struct PaymentMethodReuseAgreement: Codable, Equatable, Sendable {
        public let position: Position

        public enum Position: String, Codable, Sendable {
            case auto
            case hidden
        }

        public init(position: Position) {
            self.position = position
        }
    }

    public enum Promotions: String, Codable, Sendable {
        case auto
        case none
    }

    public enum TermsOfService: String, Codable, Sendable {
        case none
        case required
    }
}

public struct CustomField: Codable, Equatable, Sendable {
    public let key: String
    public let label: Label
    public let type: FieldType
    public let dropdown: Dropdown?
    public let numeric: Numeric?
    public let text: Text?
    public let optional: Bool?

    private enum CodingKeys: String, CodingKey {
        case key
        case label
        case type
        case dropdown
        case numeric
        case text
        case optional
    }

    public init(
        key: String,
        label: Label,
        type: FieldType,
        dropdown: Dropdown? = nil,
        numeric: Numeric? = nil,
        text: Text? = nil,
        optional: Bool? = nil
    ) {
        self.key = key
        self.label = label
        self.type = type
        self.dropdown = dropdown
        self.numeric = numeric
        self.text = text
        self.optional = optional
    }

    public struct Label: Codable, Equatable, Sendable {
        public let custom: String
        public let type: String

        public init(custom: String, type: String = "custom") {
            self.custom = custom
            self.type = type
        }
    }

    public enum FieldType: String, Codable, Sendable {
        case dropdown
        case numeric
        case text
    }

    public struct Dropdown: Codable, Equatable, Sendable {
        public let options: [Option]

        public init(options: [Option]) {
            self.options = options
        }

        public struct Option: Codable, Equatable, Sendable {
            public let label: String
            public let value: String

            public init(label: String, value: String) {
                self.label = label
                self.value = value
            }
        }
    }

    public struct Numeric: Codable, Equatable, Sendable {
        public let maximumLength: Int?
        public let minimumLength: Int?

        private enum CodingKeys: String, CodingKey {
            case maximumLength
            case minimumLength
        }

        public init(maximumLength: Int? = nil, minimumLength: Int? = nil) {
            self.maximumLength = maximumLength
            self.minimumLength = minimumLength
        }
    }

    public struct Text: Codable, Equatable, Sendable {
        public let maximumLength: Int?
        public let minimumLength: Int?

        private enum CodingKeys: String, CodingKey {
            case maximumLength
            case minimumLength
        }

        public init(maximumLength: Int? = nil, minimumLength: Int? = nil) {
            self.maximumLength = maximumLength
            self.minimumLength = minimumLength
        }
    }
}
