#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/billing/credit-grant/object.md

extension Stripe.Billing.Credit {
    public struct Grant: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String

        /// Unique identifier for the object.
        public let id: ID

        /// String representing the object's type.
        public let object: String

        /// Amount of the credit grant.
        public let amount: Amount?

        /// Configuration specifying what this credit grant applies to.
        public let applicabilityConfig: ApplicabilityConfig

        /// The category of this credit grant.
        public let category: Category

        /// Time at which the object was created.
        public let created: Date

        /// ID of the customer to whom the credit grant applies.
        public let customer: Stripe.Customers.Customer.ID

        /// The time when the credit becomes effective.
        public let effectiveAt: Date?

        /// The time when the credit will expire.
        public let expiresAt: Date?

        /// Has the value true if the object exists in live mode.
        public let livemode: Bool

        /// Set of key-value pairs.
        public let metadata: [String: String]

        /// A descriptive name shown in dashboard.
        public let name: String?

        /// Priority for determining which credit to use.
        public let priority: Int?

        /// ID of the test clock this credit grant belongs to.
        public let testClock: String?

        /// Time at which the object was last updated.
        public let updated: Date

        /// The time when this credit grant was voided.
        public let voidedAt: Date?

        public struct Amount: Codable, Hashable, Sendable {
            /// The monetary amount.
            public let monetary: Monetary?

            /// The type of this amount.
            public let type: AmountType

            public struct Monetary: Codable, Hashable, Sendable {
                /// Three-letter ISO currency code.
                public let currency: Stripe.Currency

                /// A positive integer.
                public let value: Int
            }

            public enum AmountType: String, Codable, Hashable, Sendable {
                case monetary
            }
        }

        public struct ApplicabilityConfig: Codable, Hashable, Sendable {
            /// Scope of what this credit grant applies to.
            public let scope: Scope

            public struct Scope: Codable, Hashable, Sendable {
                /// The price type to which credit applies.
                public let priceType: PriceType?

                /// The specific prices to which credit applies.
                public let prices: [Price]?

                public enum PriceType: String, Codable, Hashable, Sendable {
                    case metered
                }

                public struct Price: Codable, Hashable, Sendable {
                    /// The price ID.
                    public let id: String?
                }

                private enum CodingKeys: String, CodingKey {
                    case priceType
                    case prices
                }
            }
        }

        public enum Category: String, Codable, Hashable, Sendable {
            case paid
            case promotional
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case amount
            case applicabilityConfig
            case category
            case created
            case customer
            case effectiveAt
            case expiresAt
            case livemode
            case metadata
            case name
            case priority
            case testClock
            case updated
            case voidedAt
        }
    }
}
