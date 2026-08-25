#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.Credit.Balance {
    // https://docs.stripe.com/api/billing/credit-balance-transaction/list.md
    public enum List {}
}

extension Stripe.Billing.Credit.Balance.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return credit balance transactions for this customer.
        public let customer: Stripe.Customers.Customer.ID
        /// Only return credit balance transactions for this credit grant.
        public let creditGrant: String?
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public let endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public let limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public let startingAfter: String?

        public init(
            customer: Stripe.Customers.Customer.ID,
            creditGrant: String? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.customer = customer
            self.creditGrant = creditGrant
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }

        private enum CodingKeys: String, CodingKey {
            case customer
            case creditGrant
            case endingBefore
            case limit
            case startingAfter
        }
    }
}
