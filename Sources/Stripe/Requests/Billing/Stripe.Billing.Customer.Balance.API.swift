#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Customer.Balance {
    // https://docs.stripe.com/api/customer_balance_transactions/create.md
    public enum Create {}

    // https://docs.stripe.com/api/customer_balance_transactions/update.md
    public enum Update {}

    // https://docs.stripe.com/api/customer_balance_transactions/list.md
    public enum List {}
}

extension Stripe.Billing.Customer.Balance.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The amount to apply to the customer's credit balance. This is added to the customer's balance. Use a negative value to apply a credit, and use a positive value to apply a charge.
        public let amount: Int
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public let currency: Stripe.Currency
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public let description: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public let metadata: [String: String]?

        public init(
            amount: Int,
            currency: Stripe.Currency,
            description: String? = nil,
            metadata: [String: String]? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.description = description
            self.metadata = metadata
        }

        private enum CodingKeys: String, CodingKey {
            case amount
            case currency
            case description
            case metadata
        }
    }
}

extension Stripe.Billing.Customer.Balance.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public let description: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public let metadata: [String: String]?

        public init(
            description: String? = nil,
            metadata: [String: String]? = nil
        ) {
            self.description = description
            self.metadata = metadata
        }

        private enum CodingKeys: String, CodingKey {
            case description
            case metadata
        }
    }
}

extension Stripe.Billing.Customer.Balance.List {
    public struct Request: Codable, Equatable, Sendable {
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public let endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public let limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public let startingAfter: String?

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }

        private enum CodingKeys: String, CodingKey {
            case endingBefore
            case limit
            case startingAfter
        }
    }
}
