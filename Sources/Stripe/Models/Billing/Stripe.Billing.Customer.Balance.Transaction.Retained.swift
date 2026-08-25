//
//  CustomerBalanceTransaction.swift
//
//
//  Created by Andrew Edwards on 11/28/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/customer_balance_transactions/object.md

/// The [Customer Balance Transaction Object](https://stripe.com/docs/api/customer_balance_transactions/object) .

// The Transaction struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.Customer.Balance.Transaction` that the generator spells differently.

extension Stripe.Billing.Customer.Balance.Transaction {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var data: [Stripe.Billing.Customer.Balance.Transaction]?
        public var hasMore: Bool?
        public var url: String?

        public init(
            object: String,
            data: [Stripe.Billing.Customer.Balance.Transaction]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
        }
    }
}
