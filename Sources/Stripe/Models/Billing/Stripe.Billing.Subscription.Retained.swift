#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/subscriptions/object.md

/// The [Subscription Object](https://stripe.com/docs/api/subscriptions/object)

// The Subscription struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.Subscription` that the generator spells differently.

// MARK: - Subscription Types
extension Stripe.Billing.Subscription {

    // Using shared Stripe.Interval type
    public typealias Interval = Stripe.Interval

    public enum PaymentBehavior: String, Codable, Sendable {
        case allowIncomplete = "allow_incomplete"
        case errorIfIncomplete = "error_if_incomplete"
        case pendingIfIncomplete = "pending_if_incomplete"
        case defaultIncomplete = "default_incomplete"
    }

    public enum ProrationBehavior: String, Codable, Sendable {
        case createProrations = "create_prorations"
        case none
        case alwaysInvoice = "always_invoice"
    }
}

// MARK: - Automatic Tax
extension Stripe.Billing.Subscription {

    public struct TaxLiability: Codable, Hashable, Sendable {
        public var type: String?

        public init(type: String? = nil) {
            self.type = type
        }
    }
}

// MARK: - Billing
// MARK: - Cancellation
extension Stripe.Billing.Subscription {
    public enum Cancellation {}
}

extension Stripe.Billing.Subscription.Cancellation {
    public struct Details: Codable, Hashable, Sendable {
        /// Additional comments about cancellation
        public var comment: String?
        /// Customer submitted reason
        public var feedback: Feedback?
        /// Cancellation reason
        public var reason: String?

        public init(
            comment: String? = nil,
            feedback: Feedback? = nil,
            reason: String? = nil
        ) {
            self.comment = comment
            self.feedback = feedback
            self.reason = reason
        }
    }

    public enum Feedback: String, Codable, Sendable {
        case tooExpensive = "too_expensive"
        case missingFeatures = "missing_features"
        case switchService = "switch_service"
        case unused
        case customerService = "customer_service"
        case tooComplex = "too_complex"
        case lowQuality = "low_quality"
        case other
    }
}

// MARK: - Collection
extension Stripe.Billing.Subscription {
    public enum Collection {}
}

extension Stripe.Billing.Subscription.Collection {
    public enum Method: String, Codable, Sendable {
        case chargeAutomatically = "charge_automatically"
        case sendInvoice = "send_invoice"
    }
}

// MARK: - Payment
extension Stripe.Billing.Subscription {
    public enum Payment {}
}

extension Stripe.Billing.Subscription.Payment {
    public struct Settings: Codable, Hashable, Sendable {
        /// Payment method options configuration
        public var paymentMethodOptions: MethodOptions?
        /// Allowed payment method types
        public var paymentMethodTypes: [Stripe.PaymentMethods.PaymentMethod.`Type`]?
        /// Default payment method saving behavior
        public var saveDefaultPaymentMethod: SaveDefaultPaymentMethod?

        private enum CodingKeys: String, CodingKey {
            case paymentMethodOptions
            case paymentMethodTypes
            case saveDefaultPaymentMethod
        }

        public enum SaveDefaultPaymentMethod: String, Codable, Sendable {
            case off
            case onSubscription = "on_subscription"
        }

        public init(
            paymentMethodOptions: MethodOptions? = nil,
            paymentMethodTypes: [Stripe.PaymentMethods.PaymentMethod.`Type`]? = nil,
            saveDefaultPaymentMethod: SaveDefaultPaymentMethod? = nil
        ) {
            self.paymentMethodOptions = paymentMethodOptions
            self.paymentMethodTypes = paymentMethodTypes
            self.saveDefaultPaymentMethod = saveDefaultPaymentMethod
        }
    }

    public struct MethodOptions: Codable, Hashable, Sendable {
        // This is a placeholder for payment method options
        // The actual implementation should define specific payment method configurations

        public init() {}
    }
}

// MARK: - PendingInvoiceItemInterval
// MARK: - PauseCollection
// MARK: - Trial
extension Stripe.Billing.Subscription {
    public enum Trial {}
}

extension Stripe.Billing.Subscription.Trial {
    public struct Settings: Codable, Hashable, Sendable {
        /// End behavior configuration
        public var endBehavior: EndBehavior?

        public init(
            endBehavior: EndBehavior? = nil
        ) {
            self.endBehavior = endBehavior
        }
    }

    public struct EndBehavior: Codable, Hashable, Sendable {
        /// Behavior when payment method is missing
        public var missingPaymentMethod: MissingPaymentMethodBehavior?

        private enum CodingKeys: String, CodingKey {
            case missingPaymentMethod
        }

        public init(
            missingPaymentMethod: MissingPaymentMethodBehavior? = nil
        ) {
            self.missingPaymentMethod = missingPaymentMethod
        }
    }

    public enum MissingPaymentMethodBehavior: String, Codable, Sendable {
        case cancel
        case pause
        case createInvoice = "create_invoice"
    }
}

// MARK: - TransferData
// MARK: - Search and List Results
extension Stripe.Billing.Subscription {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Billing.Subscription]?
    }

    public struct SearchResult: Codable, Hashable, Sendable {
        public var object: String
        public var data: [Stripe.Billing.Subscription]?
        public var hasMore: Bool?
        public var url: String?
        public var nextPage: String?
        public var totalCount: Int?
    }
}

// MARK: - PendingUpdate
// MARK: - BillingMode
// MARK: - BillingCycleAnchorConfig
// MARK: - InvoiceSettings
// MARK: - Billing schedules
extension Stripe.Billing.Subscription {
    /// A schedule controlling how long a subscription bills for.
    public struct BillingSchedule: Codable, Hashable, Sendable {
        /// Which subscription items the schedule applies to. Nil means all of them.
        public var appliesTo: [AppliesTo]?
        /// When the schedule bills until.
        public var billUntil: BillUntil?
        /// Unique identifier for the billing schedule.
        public var key: String?

        public init(
            appliesTo: [AppliesTo]? = nil,
            billUntil: BillUntil? = nil,
            key: String? = nil
        ) {
            self.appliesTo = appliesTo
            self.billUntil = billUntil
            self.key = key
        }

        public struct AppliesTo: Codable, Hashable, Sendable {
            /// The subscription item with this price is the one the schedule applies to.
            @ExpandableOf<Stripe.Products.Price> public var price: Stripe.Products.Price.ID?
            public var type: `Type`?

            private enum CodingKeys: String, CodingKey {
                case price
                case type
            }

            public init(price: Stripe.Products.Price.ID? = nil, type: `Type`? = nil) {
                self._price = Expandable(id: price)
                self.type = type
            }

            public enum `Type`: String, Codable, Sendable {
                case price
            }
        }

        public struct BillUntil: Codable, Hashable, Sendable {
            /// The timestamp the billing schedule applies until.
            public var computedTimestamp: Date?
            /// The billing period, when expressed as a duration rather than a timestamp.
            public var duration: Duration?
            /// The timestamp the billing schedule applies until, when given explicitly.
            public var timestamp: Date?

            public init(
                computedTimestamp: Date? = nil,
                duration: Duration? = nil,
                timestamp: Date? = nil
            ) {
                self.computedTimestamp = computedTimestamp
                self.duration = duration
                self.timestamp = timestamp
            }

            public struct Duration: Codable, Hashable, Sendable {
                public var interval: Stripe.Interval?
                public var intervalCount: Int?

                private enum CodingKeys: String, CodingKey {
                    case interval
                    case intervalCount
                }

                public init(interval: Stripe.Interval? = nil, intervalCount: Int? = nil) {
                    self.interval = interval
                    self.intervalCount = intervalCount
                }
            }
        }
    }

    /// Managed Payments settings for a subscription.
    public struct ManagedPayments: Codable, Hashable, Sendable {
        public var enabled: Bool?

        public init(enabled: Bool? = nil) {
            self.enabled = enabled
        }
    }
}
