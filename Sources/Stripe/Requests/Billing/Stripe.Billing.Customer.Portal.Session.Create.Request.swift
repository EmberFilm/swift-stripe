#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The Session model already exists in Stripe Types Models
// We only need to add the Create request type here

// MARK: - Create
extension Stripe.Billing.Customer.Portal.Session {
    public enum Create {}
}

extension Stripe.Billing.Customer.Portal.Session.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The ID of an existing customer.
        public let customer: Stripe.Customers.Customer.ID

        /// The ID of an existing configuration to use for this session.
        public let configuration: String?

        /// Information about a specific flow for the customer to go through.
        public let flowData: FlowData?

        /// The IETF language tag of the locale Customer Portal is displayed in.
        public let locale: String?

        /// The account for which the session was created on behalf of.
        public let onBehalfOf: String?

        /// The URL to redirect customers to when they click on the portal link.
        public let returnUrl: String?

        public struct FlowData: Codable, Equatable, Sendable {
            /// Behavior after the flow is completed.
            public let afterCompletion: AfterCompletion?

            /// Type of flow that the customer will go through.
            public let type: FlowType

            /// Additional parameters for subscription update flow.
            public let subscriptionUpdate: SubscriptionUpdate?

            /// Additional parameters for subscription update confirm flow.
            public let subscriptionUpdateConfirm: SubscriptionUpdateConfirm?

            /// Additional parameters for subscription cancel flow.
            public let subscriptionCancel: SubscriptionCancel?

            public enum FlowType: String, Codable, Equatable, Sendable {
                case paymentMethodUpdate = "payment_method_update"
                case subscriptionCancel = "subscription_cancel"
                case subscriptionUpdate = "subscription_update"
                case subscriptionUpdateConfirm = "subscription_update_confirm"
            }

            public struct AfterCompletion: Codable, Equatable, Sendable {
                /// Configuration when type is hosted_confirmation.
                public let hostedConfirmation: HostedConfirmation?

                /// Configuration when type is redirect.
                public let redirect: Redirect?

                /// The specified type of behavior after the flow is completed.
                public let type: AfterCompletionType

                public enum AfterCompletionType: String, Codable, Equatable, Sendable {
                    case hostedConfirmation = "hosted_confirmation"
                    case portalHomepage = "portal_homepage"
                    case redirect
                }

                public struct HostedConfirmation: Codable, Equatable, Sendable {
                    /// A custom message to display to the customer after the flow is completed.
                    public let customMessage: String?

                    private enum CodingKeys: String, CodingKey {
                        case customMessage
                    }
                }

                public struct Redirect: Codable, Equatable, Sendable {
                    /// The URL to redirect customers to after the flow is completed.
                    public let returnUrl: String

                    private enum CodingKeys: String, CodingKey {
                        case returnUrl
                    }
                }

                private enum CodingKeys: String, CodingKey {
                    case hostedConfirmation
                    case redirect
                    case type
                }
            }

            public struct SubscriptionUpdate: Codable, Equatable, Sendable {
                /// The ID of the subscription to be updated.
                public let subscription: Stripe.Billing.Subscription.ID
            }

            public struct SubscriptionUpdateConfirm: Codable, Equatable, Sendable {
                /// The ID of the subscription item to be updated.
                public let items: [Item]

                /// The ID of the subscription to be updated.
                public let subscription: Stripe.Billing.Subscription.ID

                public struct Item: Codable, Equatable, Sendable {
                    /// The ID of the subscription item to be updated.
                    public let id: Stripe.Billing.Subscription.Item.ID

                    /// The quantity to update to.
                    public let quantity: Int?

                    /// The ID of the price to update to.
                    public let price: Stripe.Products.Price.ID?
                }
            }

            public struct SubscriptionCancel: Codable, Equatable, Sendable {
                /// The ID of the subscription to be canceled.
                public let subscription: Stripe.Billing.Subscription.ID
            }

            private enum CodingKeys: String, CodingKey {
                case afterCompletion
                case type
                case subscriptionUpdate
                case subscriptionUpdateConfirm
                case subscriptionCancel
            }
        }

        public init(
            customer: Stripe.Customers.Customer.ID,
            configuration: String? = nil,
            flowData: FlowData? = nil,
            locale: String? = nil,
            onBehalfOf: String? = nil,
            returnUrl: String? = nil
        ) {
            self.customer = customer
            self.configuration = configuration
            self.flowData = flowData
            self.locale = locale
            self.onBehalfOf = onBehalfOf
            self.returnUrl = returnUrl
        }

        private enum CodingKeys: String, CodingKey {
            case customer
            case configuration
            case flowData
            case locale
            case onBehalfOf
            case returnUrl
        }
    }
}
