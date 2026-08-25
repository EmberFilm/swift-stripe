//
//  PaymentMethod.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/15/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The PaymentMethod struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.PaymentMethods.PaymentMethod` that the generator spells differently.


// https://docs.stripe.com/api/paymentMethods/object.md

extension Stripe {
    public typealias PaymentMethod = Stripe.PaymentMethods.PaymentMethod
}


extension Stripe.PaymentMethods.PaymentMethod {
    public struct RadarOptions: Codable, Hashable, Sendable {
        /// A Radar Session is a snapshot of the browser metadata and device details that help Radar make more accurate predictions on your payments.
        public var session: String?

        public init(
            session: String? = nil
        ) {
            self.session = session
        }
    }
}
