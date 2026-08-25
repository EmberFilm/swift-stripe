//
//  StripeClient.swift
//  swift-stripe
//

import AsyncHTTPClient
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Entry point to the Stripe API.
///
/// ```swift
/// let config = ConfigReader(provider: EnvironmentVariablesProvider())
/// let stripe = StripeClient(
///     configuration: try StripeConfiguration(config: config.scoped(to: "stripe"))
/// )
///
/// let customer = try await stripe.customers.create(
///     .init(email: "customer@example.com", name: "Ada Lovelace")
/// )
/// ```
///
/// The client does not own or shut down its `HTTPClient`. It defaults to
/// `HTTPClient.shared`, which lives for the process; pass your own to share a
/// pool with the rest of an application, and shut that one down yourself.
public struct StripeClient: Sendable {
    /// The low-level request engine, for endpoints without a typed wrapper yet.
    public let api: StripeAPI

    public let customers: any CustomersAPI
    public let paymentIntents: any PaymentIntentsAPI
    public let checkoutSessions: any CheckoutSessionsAPI
    public let products: any ProductsAPI
    public let prices: any PricesAPI
    public let subscriptions: any SubscriptionsAPI

    public init(configuration: StripeConfiguration, httpClient: HTTPClient = .shared) {
        let api = StripeAPI(configuration: configuration, httpClient: httpClient)
        self.api = api
        self.customers = CustomersClient(api: api)
        self.paymentIntents = PaymentIntentsClient(api: api)
        self.checkoutSessions = CheckoutSessionsClient(api: api)
        self.products = ProductsClient(api: api)
        self.prices = PricesClient(api: api)
        self.subscriptions = SubscriptionsClient(api: api)
    }
}
