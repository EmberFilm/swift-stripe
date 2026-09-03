import StripeCore
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.PaymentIntents.PaymentIntent.Capture {
    public enum Method: String, Codable, Sendable {
        /// (Default) Stripe automatically captures funds when the customer authorizes the payment.
        case automatic
        case automaticAsync = "automatic_async"
        /// Place a hold on the funds when the customer authorizes the payment, but don’t capture the funds until later.
        ///
        /// (Not all payment methods support this.).
        case manual
    }
}
