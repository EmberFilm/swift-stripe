//
//  StripeConfiguration.swift
//  swift-stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Connection and behaviour settings for a ``StripeClient``.
public struct StripeConfiguration: Sendable {
    /// Secret API key (`sk_live_…` / `sk_test_…`).
    public var secretKey: String

    /// Base URL of the Stripe REST API.
    public var baseURL: URL

    /// Pinned Stripe API version, sent as `Stripe-Version`.
    ///
    /// Leaving this `nil` uses whichever version the account defaults to, which
    /// means Stripe can change response shapes under you. Pin it in production.
    public var apiVersion: String?

    /// Connected account to act on behalf of, sent as `Stripe-Account`.
    public var connectedAccount: String?

    /// How many times to retry a request that failed with a retryable status.
    public var maxRetries: Int

    /// Per-request timeout.
    public var timeout: Duration

    public init(
        secretKey: String,
        baseURL: URL = URL(string: "https://api.stripe.com")!,
        apiVersion: String? = nil,
        connectedAccount: String? = nil,
        maxRetries: Int = 2,
        timeout: Duration = .seconds(60)
    ) {
        self.secretKey = secretKey
        self.baseURL = baseURL
        self.apiVersion = apiVersion
        self.connectedAccount = connectedAccount
        self.maxRetries = maxRetries
        self.timeout = timeout
    }
}
