//
//  Customer.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/19/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The Customer struct is generated (Models/Generated). These are the nested types the request
// layer still names under `Stripe.Customers.Customer` that the generator spells differently.

// The CustomerCashBalance struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Customers.CustomerCashBalance` that the generator spells differently.

extension Stripe.Customers.Customer {
    public enum Sessions: Sendable {}
}





extension Stripe.Customers {
    public enum CustomerTaxExempt: String, Codable, Sendable {
        case none
        case exempt
        case reverse
    }
}



// MARK: - Tax
