#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The Configuration model already exists in Stripe Types Models
// We only need to add the Create, Update, List request/response types here

// MARK: - Create
extension Stripe.Billing.Customer.Portal.Configuration {
    public enum Create {}
}

extension Stripe.Billing.Customer.Portal.Configuration.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The business information shown to customers in the portal.
        public let businessProfile: BusinessProfile?

        /// The default URL to redirect customers to when they click on the portal's link to return to your website.
        public let defaultReturnUrl: String?

        /// Information about the features available in the portal.
        public let features: Features

        /// The hosted login page for this configuration.
        public let loginPage: LoginPage?

        /// Set of key-value pairs that you can attach to an object.
        public let metadata: [String: String]?

        public init(
            businessProfile: BusinessProfile? = nil,
            defaultReturnUrl: String? = nil,
            features: Request.Features,
            loginPage: Request.LoginPage? = nil,
            metadata: [String: String]? = nil
        ) {
            self.businessProfile = businessProfile
            self.defaultReturnUrl = defaultReturnUrl
            self.features = features
            self.loginPage = loginPage
            self.metadata = metadata
        }

        public struct BusinessProfile: Codable, Equatable, Sendable {
            /// The messaging shown to customers in the portal.
            public let headline: String?

            /// A link to the business's publicly available privacy policy.
            public let privacyPolicyUrl: String?

            /// A link to the business's publicly available terms of service.
            public let termsOfServiceUrl: String?

            public init(
                headline: String? = nil,
                privacyPolicyUrl: String? = nil,
                termsOfServiceUrl: String?
            ) {
                self.headline = headline
                self.privacyPolicyUrl = privacyPolicyUrl
                self.termsOfServiceUrl = termsOfServiceUrl
            }

            private enum CodingKeys: String, CodingKey {
                case headline
                case privacyPolicyUrl
                case termsOfServiceUrl
            }
        }

        public struct Features: Codable, Equatable, Sendable {
            /// Information about updating customer details in the portal.
            public let customerUpdate: CustomerUpdate?

            /// Information about showing invoice history in the portal.
            public let invoiceHistory: InvoiceHistory?

            /// Information about updating payment methods in the portal.
            public let paymentMethodUpdate: PaymentMethodUpdate?

            /// Information about canceling subscriptions in the portal.
            public let subscriptionCancel: SubscriptionCancel?

            /// Information about pausing subscriptions in the portal.
            public let subscriptionPause: SubscriptionPause?

            /// Information about updating subscriptions in the portal.
            public let subscriptionUpdate: SubscriptionUpdate?

            public init(
                customerUpdate: CustomerUpdate? = nil,
                invoiceHistory: InvoiceHistory? = nil,
                paymentMethodUpdate: PaymentMethodUpdate? = nil,
                subscriptionCancel: SubscriptionCancel? = nil,
                subscriptionPause: SubscriptionPause? = nil,
                subscriptionUpdate: SubscriptionUpdate? = nil
            ) {
                self.customerUpdate = customerUpdate
                self.invoiceHistory = invoiceHistory
                self.paymentMethodUpdate = paymentMethodUpdate
                self.subscriptionCancel = subscriptionCancel
                self.subscriptionPause = subscriptionPause
                self.subscriptionUpdate = subscriptionUpdate
            }

            public struct CustomerUpdate: Codable, Equatable, Sendable {
                /// The types of customer updates that are supported.
                public let allowedUpdates: [String]?

                /// Whether the feature is enabled.
                public let enabled: Bool

                public init(
                    allowedUpdates: [String]? = nil,
                    enabled: Bool
                ) {
                    self.allowedUpdates = allowedUpdates
                    self.enabled = enabled
                }

                private enum CodingKeys: String, CodingKey {
                    case allowedUpdates
                    case enabled
                }
            }

            public struct InvoiceHistory: Codable, Equatable, Sendable {
                /// Whether the feature is enabled.
                public let enabled: Bool

                public init(
                    enabled: Bool
                ) {
                    self.enabled = enabled
                }
            }

            public struct PaymentMethodUpdate: Codable, Equatable, Sendable {
                /// Whether the feature is enabled.
                public let enabled: Bool

                public init(
                    enabled: Bool
                ) {
                    self.enabled = enabled
                }
            }

            public struct SubscriptionCancel: Codable, Equatable, Sendable {
                /// Whether the cancellation reasons will be collected in the portal.
                public let cancellationReason: CancellationReason?

                /// Whether the feature is enabled.
                public let enabled: Bool

                /// Whether to cancel subscriptions immediately or at the end of the billing period.
                public let mode: String?

                /// Whether to create prorations when canceling subscriptions.
                public let prorationBehavior: String?

                public init(
                    cancellationReason: CancellationReason? = nil,
                    enabled: Bool,
                    mode: String? = nil,
                    prorationBehavior: String? = nil
                ) {
                    self.cancellationReason = cancellationReason
                    self.enabled = enabled
                    self.mode = mode
                    self.prorationBehavior = prorationBehavior
                }

                public struct CancellationReason: Codable, Equatable, Sendable {
                    /// Whether the feature is enabled.
                    public let enabled: Bool

                    /// Which cancellation reasons will be given as options to the customer.
                    public let options: [String]?
                }

                private enum CodingKeys: String, CodingKey {
                    case cancellationReason
                    case enabled
                    case mode
                    case prorationBehavior
                }
            }

            public struct SubscriptionPause: Codable, Equatable, Sendable {
                /// Whether the feature is enabled.
                public let enabled: Bool?

                public init(
                    enabled: Bool
                ) {
                    self.enabled = enabled
                }
            }

            public struct SubscriptionUpdate: Codable, Equatable, Sendable {
                /// The types of subscription updates that are supported.
                public let defaultAllowedUpdates: [String]?

                /// Whether the feature is enabled.
                public let enabled: Bool

                /// The list of products that support subscription updates.
                public let products: [Product]?

                /// Determines how to handle prorations resulting from subscription updates.
                public let prorationBehavior: String?

                public init(
                    defaultAllowedUpdates: [String]? = nil,
                    enabled: Bool,
                    products: [Product]? = nil,
                    prorationBehavior: String? = nil
                ) {
                    self.defaultAllowedUpdates = defaultAllowedUpdates
                    self.enabled = enabled
                    self.products = products
                    self.prorationBehavior = prorationBehavior
                }

                public struct Product: Codable, Equatable, Sendable {
                    /// The list of price IDs.
                    public let prices: [String]

                    /// The product ID.
                    public let product: Stripe.Products.Product.ID

                    public init(prices: [String], product: Stripe.Products.Product.ID) {
                        self.prices = prices
                        self.product = product
                    }
                }

                private enum CodingKeys: String, CodingKey {
                    case defaultAllowedUpdates
                    case enabled
                    case products
                    case prorationBehavior
                }
            }

            private enum CodingKeys: String, CodingKey {
                case customerUpdate
                case invoiceHistory
                case paymentMethodUpdate
                case subscriptionCancel
                case subscriptionPause
                case subscriptionUpdate
            }
        }

        public struct LoginPage: Codable, Equatable, Sendable {
            /// If true, a shareable url will be generated.
            public let enabled: Bool

            public init(enabled: Bool) {
                self.enabled = enabled
            }
        }

        private enum CodingKeys: String, CodingKey {
            case businessProfile
            case defaultReturnUrl
            case features
            case loginPage
            case metadata
        }
    }
}

// MARK: - Update
extension Stripe.Billing.Customer.Portal.Configuration {
    public enum Update {}
}

extension Stripe.Billing.Customer.Portal.Configuration.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Whether the configuration is active.
        public let active: Bool?

        /// The business information shown to customers in the portal.
        public let businessProfile:
            Stripe.Billing.Customer.Portal.Configuration.Create.Request.BusinessProfile?

        /// The default URL to redirect customers to.
        public let defaultReturnUrl: String?

        /// Information about the features available in the portal.
        public let features: Stripe.Billing.Customer.Portal.Configuration.Create.Request.Features?

        /// The hosted login page for this configuration.
        public let loginPage: Stripe.Billing.Customer.Portal.Configuration.Create.Request.LoginPage?

        /// Set of key-value pairs that you can attach to an object.
        public let metadata: [String: String]?

        public init(
            active: Bool? = nil,
            businessProfile: Stripe.Billing.Customer.Portal.Configuration.Create.Request
                .BusinessProfile? = nil,
            defaultReturnUrl: String? = nil,
            features: Stripe.Billing.Customer.Portal.Configuration.Create.Request.Features? = nil,
            loginPage: Stripe.Billing.Customer.Portal.Configuration.Create.Request.LoginPage? = nil,
            metadata: [String: String]? = nil
        ) {
            self.active = active
            self.businessProfile = businessProfile
            self.defaultReturnUrl = defaultReturnUrl
            self.features = features
            self.loginPage = loginPage
            self.metadata = metadata
        }

        private enum CodingKeys: String, CodingKey {
            case active
            case businessProfile
            case defaultReturnUrl
            case features
            case loginPage
            case metadata
        }
    }
}

// MARK: - List
extension Stripe.Billing.Customer.Portal.Configuration {
    public enum List {}
}

extension Stripe.Billing.Customer.Portal.Configuration.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return configurations that are active or inactive.
        public let active: Bool?

        /// Only return the default configuration.
        public let isDefault: Bool?

        /// A cursor for use in pagination.
        public let endingBefore: String?

        /// A cursor for use in pagination.
        public let startingAfter: String?

        /// A limit on the number of objects to be returned.
        public let limit: Int?

        public init(
            active: Bool? = nil,
            isDefault: Bool? = nil,
            endingBefore: String? = nil,
            startingAfter: String? = nil,
            limit: Int? = nil
        ) {
            self.active = active
            self.isDefault = isDefault
            self.endingBefore = endingBefore
            self.startingAfter = startingAfter
            self.limit = limit
        }

        private enum CodingKeys: String, CodingKey {
            case active
            case isDefault
            case endingBefore
            case startingAfter
            case limit
        }
    }

    public struct Response: Codable, Sendable {
        /// String representing the object's type.
        public let object: String

        /// The URL where this list can be accessed.
        public let url: String

        /// True if this list has another page of items after this one.
        public let hasMore: Bool

        /// An array of configurations.
        public let data: [Stripe.Billing.Customer.Portal.Configuration]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}
