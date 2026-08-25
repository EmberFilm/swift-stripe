//
//  SubscriptionsClient.swift
//  swift-stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import NIOHTTP1

/// Operations on the `/v1/subscriptions` resource.
public protocol SubscriptionsAPI: Sendable {
    func create(
        _ request: Stripe.Billing.Subscriptions.Create.Request
    ) async throws -> Stripe.Billing.Subscription
    func retrieve(id: Stripe.Billing.Subscription.ID) async throws -> Stripe.Billing.Subscription
    func update(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscriptions.Update.Request
    ) async throws -> Stripe.Billing.Subscription
    func cancel(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscriptions.Cancel.Request
    ) async throws -> Stripe.Billing.Subscription
    func list(
        _ request: Stripe.Billing.Subscriptions.List.Request
    ) async throws -> Stripe.Billing.Subscriptions.List.Response
}

public struct SubscriptionsClient: SubscriptionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    private static let path = "v1/subscriptions"

    public func create(
        _ request: Stripe.Billing.Subscriptions.Create.Request
    ) async throws -> Stripe.Billing.Subscription {
        try await api.send(.POST, Self.path, body: request)
    }

    public func retrieve(
        id: Stripe.Billing.Subscription.ID
    ) async throws -> Stripe.Billing.Subscription {
        try await api.send(.GET, "\(Self.path)/\(id)")
    }

    public func update(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscriptions.Update.Request
    ) async throws -> Stripe.Billing.Subscription {
        try await api.send(.POST, "\(Self.path)/\(id)", body: request)
    }

    public func cancel(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscriptions.Cancel.Request
    ) async throws -> Stripe.Billing.Subscription {
        try await api.send(.DELETE, "\(Self.path)/\(id)", body: request)
    }

    public func list(
        _ request: Stripe.Billing.Subscriptions.List.Request
    ) async throws -> Stripe.Billing.Subscriptions.List.Response {
        try await api.list(Self.path, parameters: request)
    }
}
