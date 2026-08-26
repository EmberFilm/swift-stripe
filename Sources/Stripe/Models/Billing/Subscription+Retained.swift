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

    /// Managed Payments settings for a subscription.
    public struct ManagedPayments: Codable, Hashable, Sendable {
        public var enabled: Bool?

        public init(enabled: Bool? = nil) {
            self.enabled = enabled
        }
    }
}
