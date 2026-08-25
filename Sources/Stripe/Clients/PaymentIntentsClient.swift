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
        _ request: Stripe.PaymentIntents.Create.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent
    func retrieve(
        id: Stripe.PaymentIntents.PaymentIntent.ID
    ) async throws -> Stripe.PaymentIntents.PaymentIntent
    func update(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Update.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent
    func confirm(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Confirm.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent
    func capture(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Capture.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent
    func cancel(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Cancel.Request
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
        _ request: Stripe.PaymentIntents.Create.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(.POST, Self.path, body: request)
    }

    public func retrieve(
        id: Stripe.PaymentIntents.PaymentIntent.ID
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(.GET, "\(Self.path)/\(id)")
    }

    public func update(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Update.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(.POST, "\(Self.path)/\(id)", body: request)
    }

    public func confirm(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Confirm.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(.POST, "\(Self.path)/\(id)/confirm", body: request)
    }

    public func capture(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Capture.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(.POST, "\(Self.path)/\(id)/capture", body: request)
    }

    public func cancel(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.Cancel.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent {
        try await api.send(.POST, "\(Self.path)/\(id)/cancel", body: request)
    }

    public func list(
        _ request: Stripe.PaymentIntents.List.Request
    ) async throws -> Stripe.PaymentIntents.List.Response {
        try await api.list(Self.path, parameters: request)
    }
}
