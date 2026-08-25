#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.CreditBalanceSummary {
    // https://docs.stripe.com/api/billing/credit-balance-summary/retrieve.md
    public enum Retrieve {}
}

extension Stripe.Billing.CreditBalanceSummary.Retrieve {
    public struct Request: Codable, Equatable, Sendable {
        /// The customer to retrieve credit balance summary for.
        public let customer: Stripe.Customers.Customer.ID
        /// Filter for the credit balance summary.
        public let filter: Stripe.Billing.Credit.Balance.Summary.Filter

        public init(
            customer: Stripe.Customers.Customer.ID,
            filter: Stripe.Billing.Credit.Balance.Summary.Filter
        ) {
            self.customer = customer
            self.filter = filter
        }

        private enum CodingKeys: String, CodingKey {
            case customer
            case filter
        }
    }
}
