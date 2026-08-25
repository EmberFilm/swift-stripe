//
//  ProductsClient.swift
//  swift-stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import NIOHTTP1

/// Operations on the `/v1/products` resource.
public protocol ProductsAPI: Sendable {
    func create(
        _ request: Stripe.Products.Products.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Product
    func retrieve(id: Stripe.Products.Product.ID) async throws -> Stripe.Products.Product
    func update(
        id: Stripe.Products.Product.ID,
        _ request: Stripe.Products.Products.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Product
    func delete(
        id: Stripe.Products.Product.ID,
        idempotencyKey: String?
    ) async throws -> DeletedObject<Stripe.Products.Product>
    func list(
        _ request: Stripe.Products.Products.List.Request
    ) async throws -> Stripe.Products.Products.List.Response
}

public struct ProductsClient: ProductsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Products.Products.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Product {
        try await api.send(.POST, "v1/products", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(id: Stripe.Products.Product.ID) async throws -> Stripe.Products.Product {
        try await api.send(.GET, "v1/products/\(id)")
    }

    public func update(
        id: Stripe.Products.Product.ID,
        _ request: Stripe.Products.Products.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Product {
        try await api.send(
            .POST,
            "v1/products/\(id)",
            body: request,
            idempotencyKey: idempotencyKey
        )
    }

    public func delete(
        id: Stripe.Products.Product.ID,
        idempotencyKey: String?
    ) async throws -> DeletedObject<Stripe.Products.Product> {
        try await api.send(.DELETE, "v1/products/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(
        _ request: Stripe.Products.Products.List.Request
    ) async throws -> Stripe.Products.Products.List.Response {
        try await api.list("v1/products", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header, and
// no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ProductsAPI {
    public func create(
        _ request: Stripe.Products.Products.Create.Request
    ) async throws -> Stripe.Products.Product {
        try await create(request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.Products.Product.ID,
        _ request: Stripe.Products.Products.Update.Request
    ) async throws -> Stripe.Products.Product {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func delete(
        id: Stripe.Products.Product.ID
    ) async throws -> DeletedObject<Stripe.Products.Product> {
        try await delete(id: id, idempotencyKey: nil)
    }
}
