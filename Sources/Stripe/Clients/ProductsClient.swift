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
        _ request: Stripe.Products.Products.Create.Request
    ) async throws -> Stripe.Products.Product
    func retrieve(id: Stripe.Products.Product.ID) async throws -> Stripe.Products.Product
    func update(
        id: Stripe.Products.Product.ID,
        _ request: Stripe.Products.Products.Update.Request
    ) async throws -> Stripe.Products.Product
    func delete(
        id: Stripe.Products.Product.ID
    ) async throws -> DeletedObject<Stripe.Products.Product>
    func list(
        _ request: Stripe.Products.Products.List.Request
    ) async throws -> Stripe.Products.Products.List.Response
}

public struct ProductsClient: ProductsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Products.Products.Create.Request
    ) async throws -> Stripe.Products.Product {
        try await api.send(.POST, "v1/products", body: request)
    }

    public func retrieve(id: Stripe.Products.Product.ID) async throws -> Stripe.Products.Product {
        try await api.send(.GET, "v1/products/\(id)")
    }

    public func update(
        id: Stripe.Products.Product.ID,
        _ request: Stripe.Products.Products.Update.Request
    ) async throws -> Stripe.Products.Product {
        try await api.send(.POST, "v1/products/\(id)", body: request)
    }

    public func delete(
        id: Stripe.Products.Product.ID
    ) async throws -> DeletedObject<Stripe.Products.Product> {
        try await api.send(.DELETE, "v1/products/\(id)")
    }

    public func list(
        _ request: Stripe.Products.Products.List.Request
    ) async throws -> Stripe.Products.Products.List.Response {
        try await api.list("v1/products", parameters: request)
    }
}
