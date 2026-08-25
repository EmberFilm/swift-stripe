#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/subscriptions/object.md

/// The [Subscription Object](https://stripe.com/docs/api/subscriptions/object)
extension Stripe.Billing {
    public struct Subscription: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String

        /// Unique identifier for the object.
        public var id: ID
        /// If the subscription has been canceled with the `at_period_end` flag set to `true`, `cancel_at_period_end` on the subscription will be `true`.
        public var cancelAtPeriodEnd: Bool?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// End of the current period that the subscription has been invoiced for.
        public var currentPeriodEnd: Date?
        /// Start of the current period that the subscription has been invoiced for.
        public var currentPeriodStart: Date?
        /// ID of the customer who owns the subscription.
        @ExpandableOf<Stripe.Customers.Customer> public var customer: Stripe.Customers.Customer.ID?
        /// ID of the default payment method for the subscription.
        @ExpandableOf<Stripe.PaymentMethods.PaymentMethod> public var defaultPaymentMethod:
            Stripe.PaymentMethods.PaymentMethod.ID?
        /// The subscription's description, meant to be displayable to the customer.
        public var description: String?
        /// List of subscription items, each with an attached plan.
        public var items: Item.List?
        /// The most recent invoice this subscription has generated.
        @Expandable<Invoice, Invoice.ID> public var latestInvoice
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// You can use this SetupIntent to collect user authentication.
        @ExpandableOf<Stripe.Setup.Intent> public var pendingSetupIntent
        /// If specified, pending updates that will be applied to the subscription.
        public var pendingUpdate: PendingUpdate?
        /// Subscription status
        public var status: Status?
        /// String representing the object's type.
        public var object: String
        /// ID of the Connect Application that created the subscription.
        public var application: String?
        /// Application fee percentage
        public var applicationFeePercent: Decimal?
        /// Automatic tax settings for this subscription.
        public var automaticTax: AutomaticTax?
        /// Billing cycle anchor
        public var billingCycleAnchor: Date?
        /// Billing cycle anchor configuration
        public var billingCycleAnchorConfig: BillingCycleAnchorConfig?
        /// Billing thresholds
        public var billingThresholds: BillingThresholds?
        /// Cancellation date
        public var cancelAt: Date?
        /// Cancellation timestamp
        public var canceledAt: Date?
        /// Cancellation details
        public var cancellationDetails: Cancellation.Details?
        /// Collection method
        public var collectionMethod: Collection.Method?
        /// Creation timestamp
        public var created: Date
        /// Payment due days
        public var daysUntilDue: Int?
        /// Default payment source
        @DynamicExpandable<BankAccount, Card> public var defaultSource: String?
        /// Default tax rates
        public var defaultTaxRates: [Stripe.Tax.Rate]?
        /// Active discount
        public var discount: Stripe.Products.Discount?
        /// End date if ended
        public var endedAt: Date?
        /// Live mode flag
        public var livemode: Bool?
        /// Next pending invoice timestamp
        public var nextPendingInvoiceItemInvoice: Date?
        /// Connected account
        @ExpandableOf<Stripe.Connect.Account> public var onBehalfOf: Stripe.Connect.Account.ID?
        /// Payment pause settings
        public var pauseCollection: PauseCollection?
        /// Payment settings
        public var paymentSettings: Payment.Settings?
        /// Pending invoice interval
        public var pendingInvoiceItemInterval: PendingInvoiceItemInterval?
        /// Associated schedule
        @ExpandableOf<Schedule> public var schedule
        /// Start date
        public var startDate: Date?
        /// Test clock ID
        public var testClock: String?
        /// Transfer data
        public var transferData: TransferData?
        /// Trial end date
        public var trialEnd: Date?
        /// Trial settings
        public var trialSettings: Trial.Settings?
        /// Trial start date
        public var trialStart: Date?
        /// Billing mode configuration
        public var billingMode: BillingMode?
        /// Array of discounts applied to the subscription
        public var discounts: [Stripe.Products.Discount]?
        /// Invoice settings for the subscription
        public var invoiceSettings: InvoiceSettings?
        /// Legacy plan object (deprecated, use price instead)
        public var plan: Plan?
        /// Quantity of the subscription (for single-item subscriptions)
        public var quantity: Int?
        /// ID of the account representing the customer who owns the subscription.
        public var customerAccount: String?
        /// Billing schedules for this subscription.
        public var billingSchedules: [BillingSchedule]?
        /// Settings for Managed Payments for this subscription.
        public var managedPayments: ManagedPayments?
        /// The currency the subscription is presented in.
        public var presentmentDetails: PresentmentDetails?

        private enum CodingKeys: String, CodingKey {
            case id
            case cancelAtPeriodEnd
            case currency
            case currentPeriodEnd
            case currentPeriodStart
            case customer
            case defaultPaymentMethod
            case description
            case items
            case latestInvoice
            case metadata
            case pendingSetupIntent
            case pendingUpdate
            case status
            case object
            case application
            case applicationFeePercent
            case automaticTax
            case billingCycleAnchor
            case billingCycleAnchorConfig
            case billingThresholds
            case cancelAt
            case canceledAt
            case cancellationDetails
            case collectionMethod
            case created
            case daysUntilDue
            case defaultSource
            case defaultTaxRates
            case discount
            case endedAt
            case livemode
            case nextPendingInvoiceItemInvoice
            case onBehalfOf
            case pauseCollection
            case paymentSettings
            case pendingInvoiceItemInterval
            case schedule
            case startDate
            case testClock
            case transferData
            case trialEnd
            case trialSettings
            case trialStart
            case billingMode
            case discounts
            case invoiceSettings
            case plan
            case quantity
        }

        public init(
            id: ID,
            cancelAtPeriodEnd: Bool? = nil,
            currency: Stripe.Currency? = nil,
            currentPeriodEnd: Date? = nil,
            currentPeriodStart: Date? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            defaultPaymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            description: String? = nil,
            items: Item.List? = nil,
            latestInvoice: Stripe.Billing.Invoice.ID? = nil,
            metadata: [String: String]? = nil,
            pendingSetupIntent: Stripe.Setup.Intent.ID? = nil,
            pendingUpdate: PendingUpdate? = nil,
            status: Status? = nil,
            object: String,
            application: String? = nil,
            applicationFeePercent: Decimal? = nil,
            automaticTax: AutomaticTax? = nil,
            billingCycleAnchor: Date? = nil,
            billingCycleAnchorConfig: BillingCycleAnchorConfig? = nil,
            billingThresholds: BillingThresholds? = nil,
            cancelAt: Date? = nil,
            canceledAt: Date? = nil,
            cancellationDetails: Cancellation.Details? = nil,
            collectionMethod: Collection.Method? = nil,
            created: Date,
            daysUntilDue: Int? = nil,
            defaultSource: String? = nil,
            defaultTaxRates: [Stripe.Tax.Rate]? = nil,
            discount: Stripe.Products.Discount? = nil,
            endedAt: Date? = nil,
            livemode: Bool? = nil,
            nextPendingInvoiceItemInvoice: Date? = nil,
            onBehalfOf: Stripe.Connect.Account.ID? = nil,
            pauseCollection: PauseCollection? = nil,
            paymentSettings: Payment.Settings? = nil,
            pendingInvoiceItemInterval: PendingInvoiceItemInterval? = nil,
            schedule: Schedule.ID? = nil,
            startDate: Date? = nil,
            testClock: String? = nil,
            transferData: TransferData? = nil,
            trialEnd: Date? = nil,
            trialSettings: Trial.Settings? = nil,
            trialStart: Date? = nil,
            billingMode: BillingMode? = nil,
            discounts: [Stripe.Products.Discount]? = nil,
            invoiceSettings: InvoiceSettings? = nil,
            plan: Plan? = nil,
            quantity: Int? = nil,
            customerAccount: String? = nil,
            billingSchedules: [BillingSchedule]? = nil,
            managedPayments: ManagedPayments? = nil,
            presentmentDetails: PresentmentDetails? = nil
        ) {
            self.id = id
            self.cancelAtPeriodEnd = cancelAtPeriodEnd
            self.currency = currency
            self.currentPeriodEnd = currentPeriodEnd
            self.currentPeriodStart = currentPeriodStart
            self._customer = Expandable(id: customer)
            self._defaultPaymentMethod = Expandable(id: defaultPaymentMethod)
            self.description = description
            self.items = items
            self._latestInvoice = Expandable(id: latestInvoice)
            self.metadata = metadata
            self._pendingSetupIntent = Expandable(id: pendingSetupIntent)
            self.pendingUpdate = pendingUpdate
            self.status = status
            self.object = object
            self.application = application
            self.applicationFeePercent = applicationFeePercent
            self.automaticTax = automaticTax
            self.billingCycleAnchor = billingCycleAnchor
            self.billingCycleAnchorConfig = billingCycleAnchorConfig
            self.billingThresholds = billingThresholds
            self.cancelAt = cancelAt
            self.canceledAt = canceledAt
            self.cancellationDetails = cancellationDetails
            self.collectionMethod = collectionMethod
            self.created = created
            self.daysUntilDue = daysUntilDue
            self._defaultSource = DynamicExpandable(id: defaultSource)
            self.defaultTaxRates = defaultTaxRates
            self.discount = discount
            self.endedAt = endedAt
            self.livemode = livemode
            self.nextPendingInvoiceItemInvoice = nextPendingInvoiceItemInvoice
            self._onBehalfOf = Expandable(id: onBehalfOf)
            self.pauseCollection = pauseCollection
            self.paymentSettings = paymentSettings
            self.pendingInvoiceItemInterval = pendingInvoiceItemInterval
            self._schedule = Expandable(id: schedule)
            self.startDate = startDate
            self.testClock = testClock
            self.transferData = transferData
            self.trialEnd = trialEnd
            self.trialSettings = trialSettings
            self.trialStart = trialStart
            self.billingMode = billingMode
            self.discounts = discounts
            self.invoiceSettings = invoiceSettings
            self.plan = plan
            self.quantity = quantity
            self.customerAccount = customerAccount
            self.billingSchedules = billingSchedules
            self.managedPayments = managedPayments
            self.presentmentDetails = presentmentDetails
        }
    }
}

// MARK: - Subscription Types
extension Stripe.Billing.Subscription {
    public enum Status: String, Codable, Sendable {
        case active
        case pastDue = "past_due"
        case unpaid
        case canceled
        case incomplete
        case incompleteExpired = "incomplete_expired"
        case trialing
        case paused
    }

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
    public struct AutomaticTax: Codable, Hashable, Sendable {
        /// Whether Stripe automatically computes tax on this subscription.
        public var enabled: Bool?
        /// The reason why automatic tax is disabled, if applicable.
        public var disabledReason: String?
        /// The location where tax is liable to be collected.
        public var liability: TaxLiability?

        private enum CodingKeys: String, CodingKey {
            case enabled
            case disabledReason
            case liability
        }

        public init(
            enabled: Bool? = nil,
            disabledReason: String? = nil,
            liability: TaxLiability? = nil
        ) {
            self.enabled = enabled
            self.disabledReason = disabledReason
            self.liability = liability
        }
    }

    public struct TaxLiability: Codable, Hashable, Sendable {
        public var type: String?

        public init(type: String? = nil) {
            self.type = type
        }
    }
}

// MARK: - Billing
extension Stripe.Billing.Subscription {
    public struct BillingThresholds: Codable, Hashable, Sendable {
        /// Monetary threshold that triggers the subscription to create an invoice
        public var amountGte: Int?
        /// Reset billing cycle anchor flag
        public var resetBillingCycleAnchor: Bool?

        private enum CodingKeys: String, CodingKey {
            case amountGte
            case resetBillingCycleAnchor
        }

        public init(
            amountGte: Int? = nil,
            resetBillingCycleAnchor: Bool? = nil
        ) {
            self.amountGte = amountGte
            self.resetBillingCycleAnchor = resetBillingCycleAnchor
        }
    }
}

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
extension Stripe.Billing.Subscription {
    public struct PendingInvoiceItemInterval: Codable, Hashable, Sendable {
        /// Billing interval
        public var interval: Stripe.Interval?
        /// Number of intervals between invoices
        public var intervalCount: Int?

        private enum CodingKeys: String, CodingKey {
            case interval
            case intervalCount
        }

        public init(
            interval: Stripe.Interval? = nil,
            intervalCount: Int? = nil
        ) {
            self.interval = interval
            self.intervalCount = intervalCount
        }
    }
}

// MARK: - PauseCollection
extension Stripe.Billing.Subscription {
    public struct PauseCollection: Codable, Hashable, Sendable {
        /// Collection behavior while paused
        public var behavior: Behavior?
        /// Resume date
        public var resumesAt: Date?

        private enum CodingKeys: String, CodingKey {
            case behavior
            case resumesAt
        }

        public init(
            behavior: Behavior? = nil,
            resumesAt: Date? = nil
        ) {
            self.behavior = behavior
            self.resumesAt = resumesAt
        }

        public enum Behavior: String, Codable, Sendable {
            case keepAsDraft = "keep_as_draft"
            case markUncollectible = "mark_uncollectible"
            case void
        }
    }
}

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
extension Stripe.Billing.Subscription {
    public struct TransferData: Codable, Hashable, Sendable {
        /// Transfer percentage
        public var amountPercent: Int?
        /// Destination account
        @ExpandableOf<Stripe.Connect.Account> public var destination: Stripe.Connect.Account.ID?

        private enum CodingKeys: String, CodingKey {
            case amountPercent
            case destination
        }

        public init(
            amountPercent: Int? = nil,
            destination: Stripe.Connect.Account.ID? = nil
        ) {
            self.amountPercent = amountPercent
            self._destination = Expandable(id: destination)
        }
    }
}

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
extension Stripe.Billing.Subscription {
    public struct PendingUpdate: Codable, Hashable, Sendable {
        public var billingCycleAnchor: Date?
        public var expiresAt: Date?
        public var subscriptionItems: [Item]?
        public var trialEnd: Date?
        public var trialFromPlan: Bool?

        private enum CodingKeys: String, CodingKey {
            case billingCycleAnchor
            case expiresAt
            case subscriptionItems
            case trialEnd
            case trialFromPlan
        }

        public init(
            billingCycleAnchor: Date? = nil,
            expiresAt: Date? = nil,
            subscriptionItems: [Item]? = nil,
            trialEnd: Date? = nil,
            trialFromPlan: Bool? = nil
        ) {
            self.billingCycleAnchor = billingCycleAnchor
            self.expiresAt = expiresAt
            self.subscriptionItems = subscriptionItems
            self.trialEnd = trialEnd
            self.trialFromPlan = trialFromPlan
        }
    }
}

// MARK: - BillingMode
extension Stripe.Billing.Subscription {
    public struct BillingMode: Codable, Hashable, Sendable {
        public var type: String?

        public init(type: String? = nil) {
            self.type = type
        }
    }
}

// MARK: - BillingCycleAnchorConfig
extension Stripe.Billing.Subscription {
    public struct BillingCycleAnchorConfig: Codable, Hashable, Sendable {
        public var dayOfMonth: Int?
        public var hour: Int?
        public var minute: Int?
        public var month: Int?
        public var second: Int?

        private enum CodingKeys: String, CodingKey {
            case dayOfMonth
            case hour
            case minute
            case month
            case second
        }

        public init(
            dayOfMonth: Int? = nil,
            hour: Int? = nil,
            minute: Int? = nil,
            month: Int? = nil,
            second: Int? = nil
        ) {
            self.dayOfMonth = dayOfMonth
            self.hour = hour
            self.minute = minute
            self.month = month
            self.second = second
        }
    }
}

// MARK: - InvoiceSettings
extension Stripe.Billing.Subscription {
    public struct InvoiceSettings: Codable, Hashable, Sendable {
        public var accountTaxIds: [String]?
        public var issuer: Issuer?

        private enum CodingKeys: String, CodingKey {
            case accountTaxIds
            case issuer
        }

        public init(
            accountTaxIds: [String]? = nil,
            issuer: Issuer? = nil
        ) {
            self.accountTaxIds = accountTaxIds
            self.issuer = issuer
        }

        public struct Issuer: Codable, Hashable, Sendable {
            public var type: String?

            public init(type: String? = nil) {
                self.type = type
            }
        }
    }
}

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

    /// The currency a subscription is presented in.
    public struct PresentmentDetails: Codable, Hashable, Sendable {
        public var presentmentCurrency: String?

        private enum CodingKeys: String, CodingKey {
            case presentmentCurrency
        }

        public init(presentmentCurrency: String? = nil) {
            self.presentmentCurrency = presentmentCurrency
        }
    }
}
