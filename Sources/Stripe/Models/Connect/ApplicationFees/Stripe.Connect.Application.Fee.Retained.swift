//
//  ApplicationFee.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/16/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/application_fees/object.md

// The Fee struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.Application.Fee` that the generator spells differently.

extension Stripe.Connect.Application.Fee {
    public struct Source: Codable, Hashable, Sendable {
        public var feeType: String?
        public var resource: Stripe.Connect.Application.Fee.Source.Resource?

        public init(
            feeType: String? = nil,
            resource: Stripe.Connect.Application.Fee.Source.Resource? = nil
        ) {
            self.feeType = feeType
            self.resource = resource
        }
    }
}

extension Stripe.Connect.Application.Fee.Source {
    public struct Resource: Codable, Hashable, Sendable {
        public var charge: Stripe.Charges.Charge.ID?
        public var payout: Stripe.Payouts.Payout.ID?
        public var type: String?

        public init(
            charge: Stripe.Charges.Charge.ID? = nil,
            payout: Stripe.Payouts.Payout.ID? = nil,
            type: String? = nil
        ) {
            self.charge = charge
            self.payout = payout
            self.type = type
        }
    }
}

