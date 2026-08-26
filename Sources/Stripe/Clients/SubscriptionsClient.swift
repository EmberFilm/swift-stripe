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
        _ request: Stripe.Billing.Subscription.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription
    func retrieve(id: Stripe.Billing.Subscription.ID) async throws -> Stripe.Billing.Subscription
    func update(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription
    func cancel(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription
    func list(
        _ request: Stripe.Billing.Subscription.List.Request
    ) async throws -> Stripe.Billing.Subscription.List.Response
}

public struct SubscriptionsClient: SubscriptionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    private static let path = "v1/subscriptions"

    public func create(
        _ request: Stripe.Billing.Subscription.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription {
        try await api.send(.POST, Self.path, body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: Stripe.Billing.Subscription.ID
    ) async throws -> Stripe.Billing.Subscription {
        try await api.send(.GET, "\(Self.path)/\(id)")
    }

    public func update(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription {
        try await api.send(
            .POST,
            "\(Self.path)/\(id)",
            body: request,
            idempotencyKey: idempotencyKey
        )
    }

    public func cancel(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription {
        try await api.send(
            .DELETE,
            "\(Self.path)/\(id)",
            body: request,
            idempotencyKey: idempotencyKey
        )
    }

    public func list(
        _ request: Stripe.Billing.Subscription.List.Request
    ) async throws -> Stripe.Billing.Subscription.List.Response {
        try await api.list(Self.path, parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header, and
// no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension SubscriptionsAPI {
    public func create(
        _ request: Stripe.Billing.Subscription.Create.Request
    ) async throws -> Stripe.Billing.Subscription {
        try await create(request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Update.Request
    ) async throws -> Stripe.Billing.Subscription {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func cancel(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Cancel.Request
    ) async throws -> Stripe.Billing.Subscription {
        try await cancel(id: id, request, idempotencyKey: nil)
    }
}
