//
//  PaymentIntentsClient.swift
//  swift-stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import NIOHTTP1

/// Operations on the `/v1/payment_intents` resource.
public protocol PaymentIntentsAPI: Sendable {
    func create(
        _ request: Stripe.PaymentIntents.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent
    func retrieve(
        id: Stripe.PaymentIntents.PaymentIntent.ID
    ) async throws -> Stripe.PaymentIntents.PaymentIntent
    func update(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent
    func confirm(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Confirm.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent
    func capture(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Capture.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent
    func cancel(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent
    func list(
        _ request: Stripe.PaymentIntents.List.Request
    ) async throws -> Stripe.PaymentIntents.List.Response
}

public struct PaymentIntentsClient: PaymentIntentsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    private static let path = "v1/payment_intents"

    public func create(
        _ request: Stripe.PaymentIntents.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(.POST, Self.path, body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: Stripe.PaymentIntents.PaymentIntent.ID
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(.GET, "\(Self.path)/\(id)")
    }

    public func update(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(
            .POST,
            "\(Self.path)/\(id)",
            body: request,
            idempotencyKey: idempotencyKey
        )
    }

    public func confirm(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Confirm.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(
            .POST,
            "\(Self.path)/\(id)/confirm",
            body: request,
            idempotencyKey: idempotencyKey
        )
    }

    public func capture(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Capture.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(
            .POST,
            "\(Self.path)/\(id)/capture",
            body: request,
            idempotencyKey: idempotencyKey
        )
    }

    public func cancel(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(
            .POST,
            "\(Self.path)/\(id)/cancel",
            body: request,
            idempotencyKey: idempotencyKey
        )
    }

    public func list(
        _ request: Stripe.PaymentIntents.List.Request
    ) async throws -> Stripe.PaymentIntents.List.Response {
        try await api.list(Self.path, parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header, and
// no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PaymentIntentsAPI {
    public func create(
        _ request: Stripe.PaymentIntents.Create.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await create(request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Update.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func confirm(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Confirm.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await confirm(id: id, request, idempotencyKey: nil)
    }

    public func capture(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Capture.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await capture(id: id, request, idempotencyKey: nil)
    }

    public func cancel(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Cancel.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await cancel(id: id, request, idempotencyKey: nil)
    }
}
