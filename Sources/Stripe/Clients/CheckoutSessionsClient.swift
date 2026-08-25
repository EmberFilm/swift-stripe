//
//  CheckoutSessionsClient.swift
//  swift-stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import NIOHTTP1

/// Operations on the `/v1/checkout/sessions` resource.
public protocol CheckoutSessionsAPI: Sendable {
    func create(
        _ request: Stripe.Checkout.Sessions.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Checkout.Session
    func retrieve(id: Stripe.Checkout.Session.ID) async throws -> Stripe.Checkout.Session
    func expire(
        id: Stripe.Checkout.Session.ID,
        idempotencyKey: String?
    ) async throws -> Stripe.Checkout.Session
    func list(
        _ request: Stripe.Checkout.Sessions.List.Request
    ) async throws -> Stripe.Checkout.Sessions.List.Response
}

public struct CheckoutSessionsClient: CheckoutSessionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    private static let path = "v1/checkout/sessions"

    public func create(
        _ request: Stripe.Checkout.Sessions.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Checkout.Session {
        try await api.send(.POST, Self.path, body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(id: Stripe.Checkout.Session.ID) async throws -> Stripe.Checkout.Session {
        try await api.send(.GET, "\(Self.path)/\(id)")
    }

    public func expire(
        id: Stripe.Checkout.Session.ID,
        idempotencyKey: String?
    ) async throws -> Stripe.Checkout.Session {
        try await api.send(.POST, "\(Self.path)/\(id)/expire", idempotencyKey: idempotencyKey)
    }

    public func list(
        _ request: Stripe.Checkout.Sessions.List.Request
    ) async throws -> Stripe.Checkout.Sessions.List.Response {
        try await api.list(Self.path, parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header, and
// no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension CheckoutSessionsAPI {
    public func create(
        _ request: Stripe.Checkout.Sessions.Create.Request
    ) async throws -> Stripe.Checkout.Session {
        try await create(request, idempotencyKey: nil)
    }

    public func expire(id: Stripe.Checkout.Session.ID) async throws -> Stripe.Checkout.Session {
        try await expire(id: id, idempotencyKey: nil)
    }
}
