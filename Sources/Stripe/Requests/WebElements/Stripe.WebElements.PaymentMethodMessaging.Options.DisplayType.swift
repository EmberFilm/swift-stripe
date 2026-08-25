#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.WebElements {
    /// Payment Method Messaging Element for displaying payment method messaging
    /// See: https://docs.stripe.com/elements/payment-method-messaging
    public struct PaymentMethodMessaging: Codable, Hashable, Sendable {
        public let options: Options?

        public init(options: Options? = nil) {
            self.options = options
        }

        public struct Options: Codable, Hashable, Sendable {
            public let amount: Int?
            public let currency: Stripe.Currency?
            public let paymentMethodTypes: [String]?
            public let countryCode: String?
            public let displayType: DisplayType?

            enum CodingKeys: String, CodingKey {
                case amount
                case currency
                case paymentMethodTypes
                case countryCode
                case displayType
            }

            public init(
                amount: Int? = nil,
                currency: Stripe.Currency? = nil,
                paymentMethodTypes: [String]? = nil,
                countryCode: String? = nil,
                displayType: DisplayType? = nil
            ) {
                self.amount = amount
                self.currency = currency
                self.paymentMethodTypes = paymentMethodTypes
                self.countryCode = countryCode
                self.displayType = displayType
            }
        }
    }
}

extension Stripe.WebElements.PaymentMethodMessaging.Options {
    public enum DisplayType: String, Codable, Sendable {
        case promotional
        case text
        case flex
    }
}
