//
//  Stripe.PresentmentDetails.swift
//  swift-stripe
//

extension Stripe {
    /// The amount and currency a payment was presented to the customer in, when that differs
    /// from the settlement currency. Shared by Charge and PaymentIntent, which the spec backs
    /// with one schema.
    public struct PresentmentDetails: Codable, Hashable, Sendable {
        public var presentmentAmount: Int?
        public var presentmentCurrency: String?

        private enum CodingKeys: String, CodingKey {
            case presentmentAmount
            case presentmentCurrency
        }

        public init(presentmentAmount: Int? = nil, presentmentCurrency: String? = nil) {
            self.presentmentAmount = presentmentAmount
            self.presentmentCurrency = presentmentCurrency
        }
    }
}
