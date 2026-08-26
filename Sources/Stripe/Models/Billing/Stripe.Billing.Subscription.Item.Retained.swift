//
//  Subscription.Item.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/subscriptionItems/object.md

// The Item struct is generated (Models/Generated). These are the nested types the request
// layer still names under `Stripe.Billing.Subscription.Item` that the generator spells differently.

extension Stripe.Billing.Subscription.Item {
    public enum PaymentBehavior: String, Codable, Sendable {
        /// Use `allow_incomplete` to transition the subscription to `status=past_due` if a payment is required but cannot be paid.
        case allowIncomplete = "allow_incomplete"
        /// Use `error_if_incomplete` if you want Stripe to return an HTTP 402 status code if a subscription’s first invoice cannot be paid.
        case errorIfIncomplete = "error_if_incomplete"
        /// Use `pending_if_incomplete` to update the subscription using pending updates. When you use `pending_if_incomplete` you can only pass the parameters supported by pending updates.
        case pendingIfIncomplete = "pending_if_incomplete"
        /// Use `default_incomplete` to transition the subscription to `status=past_due` when payment is required and await explicit confirmation of the invoice’s payment intent. This allows simpler management of scenarios where additional user actions are needed to pay a subscription’s invoice. Such as failed payments, SCA regulation, or collecting a mandate for a bank debit payment method.
        case defaultIncomplete = "default_incomplete"

    }
}

extension Stripe.Billing.Subscription.Item {
    public enum ProrationBehavior: String, Codable, Sendable {
        case createProrations = "create_prorations"
        case alwaysInvoice = "always_invoice"
        case none
    }
}

