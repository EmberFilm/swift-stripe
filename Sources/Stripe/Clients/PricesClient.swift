//
//  PricesClient.swift
//  swift-stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import NIOHTTP1

/// Operations on the `/v1/prices` resource.
public protocol PricesAPI: Sendable {
    func create(
        _ request: Stripe.Products.Prices.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Price
    func retrieve(id: Stripe.Products.Price.ID) async throws -> Stripe.Products.Price
    func update(
        id: Stripe.Products.Price.ID,
        _ request: Stripe.Products.Prices.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Price
    func list(
        _ request: Stripe.Products.Prices.List.Request
    ) async throws -> Stripe.Products.Prices.List.Response
}

public struct PricesClient: PricesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Products.Prices.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Price {
        try await api.send(.POST, "v1/prices", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(id: Stripe.Products.Price.ID) async throws -> Stripe.Products.Price {
        try await api.send(.GET, "v1/prices/\(id)")
    }

    public func update(
        id: Stripe.Products.Price.ID,
        _ request: Stripe.Products.Prices.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Price {
        try await api.send(
            .POST,
            "v1/prices/\(id)",
            body: request,
            idempotencyKey: idempotencyKey
        )
    }

    public func list(
        _ request: Stripe.Products.Prices.List.Request
    ) async throws -> Stripe.Products.Prices.List.Response {
        try await api.list("v1/prices", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header, and
// no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PricesAPI {
    public func create(
        _ request: Stripe.Products.Prices.Create.Request
    ) async throws -> Stripe.Products.Price {
        try await create(request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.Products.Price.ID,
        _ request: Stripe.Products.Prices.Update.Request
    ) async throws -> Stripe.Products.Price {
        try await update(id: id, request, idempotencyKey: nil)
    }
}
