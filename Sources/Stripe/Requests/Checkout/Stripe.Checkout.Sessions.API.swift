#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Checkout.Sessions {
    public enum Create {}
    public enum Update {}
    public enum List {}
    public enum LineItems {}
    public enum PaymentIntent {}
}

extension Stripe.Checkout.Sessions.PaymentIntent {
    /// A subset of parameters to be passed to PaymentIntent creation for Checkout Sessions in payment mode
    public struct Data: Codable, Equatable, Sendable {
        /// The amount of the application fee (if any) that will be requested to be applied to the payment
        public let applicationFeeAmount: Int?
        /// Controls when the funds will be captured from the customer's account
        public let captureMethod: CaptureMethod?
        /// An arbitrary string attached to the object. Often useful for displaying to users
        public let description: String?
        /// Set of key-value pairs that you can attach to an object
        public let metadata: [String: String]?
        /// The Stripe account ID for which these funds are intended
        public let onBehalfOf: String?
        /// Email address that the receipt for the resulting payment will be sent to
        public let receiptEmail: String?
        /// Indicates that you intend to make future payments with the payment method collected
        public let setupFutureUsage: SetupFutureUsage?
        /// An arbitrary string to be displayed on your customer's credit card or bank statement
        public let statementDescriptor: String?
        /// Provides information about a card payment that customers see on their statements
        public let statementDescriptorSuffix: String?
        /// Shipping information for this PaymentIntent
        public let shipping: Shipping?
        /// The parameters used to automatically create a Transfer when the payment succeeds
        public let transferData: TransferData?
        /// A string that identifies the resulting payment as part of a group
        public let transferGroup: String?

        private enum CodingKeys: String, CodingKey {
            case applicationFeeAmount
            case captureMethod
            case description
            case metadata
            case onBehalfOf
            case receiptEmail
            case setupFutureUsage
            case statementDescriptor
            case statementDescriptorSuffix
            case shipping
            case transferData
            case transferGroup
        }

        public init(
            applicationFeeAmount: Int? = nil,
            captureMethod: CaptureMethod? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            onBehalfOf: String? = nil,
            receiptEmail: String? = nil,
            setupFutureUsage: SetupFutureUsage? = nil,
            statementDescriptor: String? = nil,
            statementDescriptorSuffix: String? = nil,
            shipping: Shipping? = nil,
            transferData: TransferData? = nil,
            transferGroup: String? = nil
        ) {
            self.applicationFeeAmount = applicationFeeAmount
            self.captureMethod = captureMethod
            self.description = description
            self.metadata = metadata
            self.onBehalfOf = onBehalfOf
            self.receiptEmail = receiptEmail
            self.setupFutureUsage = setupFutureUsage
            self.statementDescriptor = statementDescriptor
            self.statementDescriptorSuffix = statementDescriptorSuffix
            self.shipping = shipping
            self.transferData = transferData
            self.transferGroup = transferGroup
        }

        public enum CaptureMethod: String, Codable, Equatable, Sendable {
            case automatic
            case automaticAsync = "automatic_async"
            case manual
        }

        public enum SetupFutureUsage: String, Codable, Equatable, Sendable {
            case onSession = "on_session"
            case offSession = "off_session"
        }

        public struct Shipping: Codable, Equatable, Sendable {
            public let address: Address?
            public let carrier: String?
            public let name: String?
            public let phone: String?
            public let trackingNumber: String?

            private enum CodingKeys: String, CodingKey {
                case address
                case carrier
                case name
                case phone
                case trackingNumber
            }

            public init(
                address: Address? = nil,
                carrier: String? = nil,
                name: String? = nil,
                phone: String? = nil,
                trackingNumber: String? = nil
            ) {
                self.address = address
                self.carrier = carrier
                self.name = name
                self.phone = phone
                self.trackingNumber = trackingNumber
            }

            public struct Address: Codable, Equatable, Sendable {
                public let city: String?
                public let country: String?
                public let line1: String?
                public let line2: String?
                public let postalCode: String?
                public let state: String?

                private enum CodingKeys: String, CodingKey {
                    case city
                    case country
                    case line1
                    case line2
                    case postalCode
                    case state
                }

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

        public struct TransferData: Codable, Equatable, Sendable {
            public let amount: Int?
            public let destination: String

            public init(amount: Int? = nil, destination: String) {
                self.amount = amount
                self.destination = destination
            }
        }
    }
}

extension Stripe.Checkout.Sessions.Create {
    public struct Request: Codable, Equatable, Sendable {
        public let automaticTax: Stripe.Checkout.Session.AutomaticTax?
        public let successUrl: String
        public let cancelUrl: String?
        public let clientReferenceId: String?
        public let currency: Stripe.Currency?
        public let customer: Stripe.Customers.Customer.ID?
        public let customerEmail: String?
        public let lineItems: [Stripe.Checkout.Sessions.Create.LineItem]?
        public let metadata: [String: String]?
        public let mode: Stripe.Checkout.Session.Mode
        public let paymentMethodTypes: [String]?
        public let allowPromotionCodes: Bool?
        public let billingAddressCollection: Stripe.Checkout.Session.Billing.Address.Collection?
        public let consentCollection: Stripe.Checkout.Session.ConsentCollection?
        public let customerCreation: Stripe.Checkout.Session.Customer.Creation?
        public let expiresAt: Date?
        public let locale: Stripe.Checkout.Session.Locale?
        public let paymentIntentData: Stripe.Checkout.Sessions.PaymentIntent.Data?
        public let paymentMethodCollection: Stripe.Checkout.Session.PaymentMethod.Collection?
        public let paymentMethodOptions: Stripe.Checkout.Session.PaymentMethod.Options?
        public let phoneNumberCollection: Bool?
        public let shippingAddressCollection: Stripe.Checkout.Session.Shipping.Address.Collection?
        public let shippingRates: [String]?
        public let submitType: Stripe.Checkout.Session.Submit.`Type`?
        public let taxIdCollection: Stripe.Checkout.Session.TaxId.Collection?
        public let uiMode: Stripe.Checkout.Session.UIMode?
        /// Applies only in `subscription` mode. Metadata set here lands on the Subscription
        /// object rather than the Session, which is what later subscription webhooks carry.
        public let subscriptionData: Stripe.Checkout.Sessions.Create.SubscriptionData?

        private enum CodingKeys: String, CodingKey {
            case automaticTax
            case successUrl
            case cancelUrl
            case clientReferenceId
            case currency
            case customer
            case customerEmail
            case lineItems
            case metadata
            case mode
            case paymentMethodTypes
            case allowPromotionCodes
            case billingAddressCollection
            case consentCollection
            case customerCreation
            case expiresAt
            case locale
            case paymentIntentData
            case paymentMethodCollection
            case paymentMethodOptions
            case phoneNumberCollection
            case shippingAddressCollection
            case shippingRates
            case submitType
            case taxIdCollection
            case uiMode
            case subscriptionData
        }

        public init(
            automaticTax: Stripe.Checkout.Session.AutomaticTax? = nil,
            successUrl: String,
            cancelUrl: String? = nil,
            clientReferenceId: String? = nil,
            currency: Stripe.Currency? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            customerEmail: String? = nil,
            lineItems: [Stripe.Checkout.Sessions.Create.LineItem]? = nil,
            metadata: [String: String]? = nil,
            mode: Stripe.Checkout.Session.Mode,
            paymentMethodTypes: [String]? = nil,
            allowPromotionCodes: Bool? = nil,
            billingAddressCollection: Stripe.Checkout.Session.Billing.Address.Collection? = nil,
            consentCollection: Stripe.Checkout.Session.ConsentCollection? = nil,
            customerCreation: Stripe.Checkout.Session.Customer.Creation? = nil,
            expiresAt: Date? = nil,
            locale: Stripe.Checkout.Session.Locale? = nil,
            paymentIntentData: Stripe.Checkout.Sessions.PaymentIntent.Data? = nil,
            paymentMethodCollection: Stripe.Checkout.Session.PaymentMethod.Collection? = nil,
            paymentMethodOptions: Stripe.Checkout.Session.PaymentMethod.Options? = nil,
            phoneNumberCollection: Bool? = nil,
            shippingAddressCollection: Stripe.Checkout.Session.Shipping.Address.Collection? = nil,
            shippingRates: [String]? = nil,
            submitType: Stripe.Checkout.Session.Submit.`Type`? = nil,
            taxIdCollection: Stripe.Checkout.Session.TaxId.Collection? = nil,
            uiMode: Stripe.Checkout.Session.UIMode? = nil,
            subscriptionData: Stripe.Checkout.Sessions.Create.SubscriptionData? = nil
        ) {
            self.automaticTax = automaticTax
            self.successUrl = successUrl
            self.cancelUrl = cancelUrl
            self.clientReferenceId = clientReferenceId
            self.currency = currency
            self.customer = customer
            self.customerEmail = customerEmail
            self.lineItems = lineItems
            self.metadata = metadata
            self.mode = mode
            self.paymentMethodTypes = paymentMethodTypes
            self.allowPromotionCodes = allowPromotionCodes
            self.billingAddressCollection = billingAddressCollection
            self.consentCollection = consentCollection
            self.customerCreation = customerCreation
            self.expiresAt = expiresAt
            self.locale = locale
            self.paymentIntentData = paymentIntentData
            self.paymentMethodCollection = paymentMethodCollection
            self.paymentMethodOptions = paymentMethodOptions
            self.phoneNumberCollection = phoneNumberCollection
            self.shippingAddressCollection = shippingAddressCollection
            self.shippingRates = shippingRates
            self.submitType = submitType
            self.taxIdCollection = taxIdCollection
            self.uiMode = uiMode
            self.subscriptionData = subscriptionData
        }
    }
}

extension Stripe.Checkout.Sessions.Update {
    public struct Request: Codable, Hashable, Sendable {
        public let metadata: [String: String]?

        public init(metadata: [String: String]? = nil) {
            self.metadata = metadata
        }
    }
}

extension Stripe.Checkout.Sessions.List {
    public struct Request: Codable, Hashable, Sendable {
        public let paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID?
        public let subscription: Stripe.Billing.Subscription.ID?
        public let startingAfter: String?
        public let endingBefore: String?
        public let limit: Int?

        private enum CodingKeys: String, CodingKey {
            case paymentIntent
            case subscription
            case startingAfter
            case endingBefore
            case limit
        }

        public init(
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
            subscription: Stripe.Billing.Subscription.ID? = nil,
            startingAfter: String? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil
        ) {
            self.paymentIntent = paymentIntent
            self.subscription = subscription
            self.startingAfter = startingAfter
            self.endingBefore = endingBefore
            self.limit = limit
        }
    }
}

extension Stripe.Checkout.Sessions.LineItems {
    public struct Request: Codable, Hashable, Sendable {
        public let endingBefore: String?
        public let startingAfter: String?
        public let limit: Int?

        private enum CodingKeys: String, CodingKey {
            case endingBefore
            case startingAfter
            case limit
        }

        public init(
            endingBefore: String? = nil,
            startingAfter: String? = nil,
            limit: Int? = nil
        ) {
            self.endingBefore = endingBefore
            self.startingAfter = startingAfter
            self.limit = limit
        }
    }
}

extension Stripe.Checkout.Sessions.Create {
    public struct LineItem: Codable, Hashable, Sendable {
        public let adjustableQuantity: Stripe.AdjustableQuantity?
        public let price: Stripe.Products.Price.ID?
        public let priceData: Stripe.LineItemPriceData?
        public let quantity: Int?
        public let dynamicTaxRates: [String]?
        public let taxRates: [String]?

        private enum CodingKeys: String, CodingKey {
            case adjustableQuantity
            case price
            case priceData
            case quantity
            case dynamicTaxRates
            case taxRates
        }

        public init(
            adjustableQuantity: Stripe.AdjustableQuantity? = nil,
            price: Stripe.Products.Price.ID? = nil,
            priceData: Stripe.LineItemPriceData? = nil,
            quantity: Int? = nil,
            dynamicTaxRates: [String]? = nil,
            taxRates: [String]? = nil
        ) {
            self.adjustableQuantity = adjustableQuantity
            self.price = price
            self.priceData = priceData
            self.quantity = quantity
            self.dynamicTaxRates = dynamicTaxRates
            self.taxRates = taxRates
        }
    }
}

extension Stripe.Checkout.Sessions.Create {
    /// `subscription_data` on checkout-session create.
    ///
    /// Only honoured when the session's `mode` is `.subscription`; Stripe rejects it on a
    /// one-time `payment` session. This is the only way to reach the Subscription object the
    /// session will create — notably its `metadata`, which is what `customer.subscription.*`
    /// webhooks later carry, and the trial, which cannot be set after the fact.
    public struct SubscriptionData: Codable, Hashable, Sendable {
        /// A non-negative decimal between 0 and 100, with at most two decimal places. Requires
        /// the request to be made on behalf of another account.
        public let applicationFeePercent: Double?
        /// A future timestamp to anchor the subscription's billing cycle.
        public let billingCycleAnchor: Date?
        /// Tax rates applied to every subscription item that does not set its own.
        public let defaultTaxRates: [String]?
        /// Displayed to the customer, including in the customer portal. Max 500 characters.
        public let description: String?
        /// Set on the created Subscription, not on the Session.
        public let metadata: [String: String]?
        /// The account on behalf of which to charge each of the subscription's invoices.
        public let onBehalfOf: String?
        /// How to handle prorations resulting from ``billingCycleAnchor``.
        public let prorationBehavior: ProrationBehavior?
        /// Transfers each invoice's funds to a connected account.
        public let transferData: TransferData?
        /// Unix timestamp ending the trial. At least 48 hours out. Exclusive with
        /// ``trialPeriodDays``.
        public let trialEnd: Date?
        /// Trial length in days, at least 1. Exclusive with ``trialEnd``.
        public let trialPeriodDays: Int?
        /// What happens when a trial ends with no payment method on file.
        public let trialSettings: TrialSettings?

        // Not modelled: `billing_cycle_anchor_config`, `billing_mode`, `invoice_settings` and
        // `pending_invoice_item_interval`.

        private enum CodingKeys: String, CodingKey {
            case applicationFeePercent
            case billingCycleAnchor
            case defaultTaxRates
            case description
            case metadata
            case onBehalfOf
            case prorationBehavior
            case transferData
            case trialEnd
            case trialPeriodDays
            case trialSettings
        }

        public init(
            applicationFeePercent: Double? = nil,
            billingCycleAnchor: Date? = nil,
            defaultTaxRates: [String]? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            onBehalfOf: String? = nil,
            prorationBehavior: ProrationBehavior? = nil,
            transferData: TransferData? = nil,
            trialEnd: Date? = nil,
            trialPeriodDays: Int? = nil,
            trialSettings: TrialSettings? = nil
        ) {
            self.applicationFeePercent = applicationFeePercent
            self.billingCycleAnchor = billingCycleAnchor
            self.defaultTaxRates = defaultTaxRates
            self.description = description
            self.metadata = metadata
            self.onBehalfOf = onBehalfOf
            self.prorationBehavior = prorationBehavior
            self.transferData = transferData
            self.trialEnd = trialEnd
            self.trialPeriodDays = trialPeriodDays
            self.trialSettings = trialSettings
        }

        /// Checkout accepts only these two, unlike `Subscription.ProrationBehavior`, which also
        /// has `always_invoice`.
        public enum ProrationBehavior: String, Codable, Sendable {
            case createProrations = "create_prorations"
            case none
        }

        /// Request-side transfer data: `destination` is required and is a plain id, never an
        /// expanded account.
        public struct TransferData: Codable, Hashable, Sendable {
            public let destination: Stripe.Connect.Account.ID
            /// A non-negative decimal between 0 and 100, with at most two decimal places.
            public let amountPercent: Double?

            private enum CodingKeys: String, CodingKey {
                case destination
                case amountPercent
            }

            public init(
                destination: Stripe.Connect.Account.ID,
                amountPercent: Double? = nil
            ) {
                self.destination = destination
                self.amountPercent = amountPercent
            }
        }

        /// Request-side trial settings. Stripe requires both levels, so unlike the response
        /// model's all-optional shape these are non-optional and cannot be sent half-built.
        public struct TrialSettings: Codable, Hashable, Sendable {
            public let endBehavior: EndBehavior

            public init(endBehavior: EndBehavior) {
                self.endBehavior = endBehavior
            }

            public struct EndBehavior: Codable, Hashable, Sendable {
                public let missingPaymentMethod: MissingPaymentMethod

                private enum CodingKeys: String, CodingKey {
                    case missingPaymentMethod
                }

                public init(missingPaymentMethod: MissingPaymentMethod) {
                    self.missingPaymentMethod = missingPaymentMethod
                }
            }

            public enum MissingPaymentMethod: String, Codable, Sendable {
                case cancel
                case createInvoice = "create_invoice"
                case pause
            }
        }
    }
}

// PriceData and its nested types moved to Stripe.LineItemPriceData in Shared Models

extension Stripe.Checkout.Sessions.Create.Request {
    public struct AutomaticTax: Codable, Hashable, Sendable {
        public let enabled: Bool

        public init(enabled: Bool) {
            self.enabled = enabled
        }
    }
}

extension Stripe.Checkout.Sessions.Create.Request {
    public enum PaymentIntent {}
}

extension Stripe.Checkout.Sessions.Create.Request.PaymentIntent {
    public struct Data: Codable, Hashable, Sendable {
        public let applicationFeeAmount: Int?
        public let captureMethod: CaptureMethod?
        public let description: String?
        public let metadata: [String: String]?
        public let onBehalfOf: String?
        public let receiptEmail: String?
        public let setupFutureUsage: SetupFutureUsage?
        public let shipping: Shipping?
        public let statementDescriptor: Stripe.StatementDescriptor?
        public let statementDescriptorSuffix: String?
        public let transferData: TransferData?
        public let transferGroup: String?

        private enum CodingKeys: String, CodingKey {
            case applicationFeeAmount
            case captureMethod
            case description
            case metadata
            case onBehalfOf
            case receiptEmail
            case setupFutureUsage
            case shipping
            case statementDescriptor
            case statementDescriptorSuffix
            case transferData
            case transferGroup
        }

        public init(
            applicationFeeAmount: Int? = nil,
            captureMethod: CaptureMethod? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            onBehalfOf: String? = nil,
            receiptEmail: String? = nil,
            setupFutureUsage: SetupFutureUsage? = nil,
            shipping: Shipping? = nil,
            statementDescriptor: Stripe.StatementDescriptor? = nil,
            statementDescriptorSuffix: String? = nil,
            transferData: TransferData? = nil,
            transferGroup: String? = nil
        ) {
            self.applicationFeeAmount = applicationFeeAmount
            self.captureMethod = captureMethod
            self.description = description
            self.metadata = metadata
            self.onBehalfOf = onBehalfOf
            self.receiptEmail = receiptEmail
            self.setupFutureUsage = setupFutureUsage
            self.shipping = shipping
            self.statementDescriptor = statementDescriptor
            self.statementDescriptorSuffix = statementDescriptorSuffix
            self.transferData = transferData
            self.transferGroup = transferGroup
        }
    }
}

extension Stripe.Checkout.Sessions.Create.Request.PaymentIntent.Data {
    public enum CaptureMethod: String, Codable, Sendable {
        case automatic
        case automaticAsync = "automatic_async"
        case manual
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case onSession = "on_session"
        case offSession = "off_session"
    }

    public struct Shipping: Codable, Hashable, Sendable {
        public let address: Address
        public let name: String
        public let carrier: String?
        public let phone: String?
        public let trackingNumber: String?

        private enum CodingKeys: String, CodingKey {
            case address
            case name
            case carrier
            case phone
            case trackingNumber
        }

        public init(
            address: Address,
            name: String,
            carrier: String? = nil,
            phone: String? = nil,
            trackingNumber: String? = nil
        ) {
            self.address = address
            self.name = name
            self.carrier = carrier
            self.phone = phone
            self.trackingNumber = trackingNumber
        }
    }

    public struct TransferData: Codable, Hashable, Sendable {
        public let destination: String
        public let amount: Int?

        public init(
            destination: String,
            amount: Int? = nil
        ) {
            self.destination = destination
            self.amount = amount
        }
    }
}

extension Stripe.Checkout.Sessions.List {
    public struct Response: Codable, Hashable, Sendable {
        public let object: String?
        public let url: String?
        public let hasMore: Bool?
        public let data: [Stripe.Checkout.Session]?

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}

extension Stripe.Checkout.Sessions.LineItems {
    public struct Response: Codable, Hashable, Sendable {
        public let object: String?
        public let url: String?
        public let hasMore: Bool?
        public let data: [Stripe.Checkout.Session.LineItem]?

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}
