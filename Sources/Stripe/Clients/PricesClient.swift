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
    func create(_ request: Stripe.Products.Prices.Create.Request) async throws -> Stripe.Products.Price
    func retrieve(id: Stripe.Products.Price.ID) async throws -> Stripe.Products.Price
    func update(
        id: Stripe.Products.Price.ID,
        _ request: Stripe.Products.Prices.Update.Request
    ) async throws -> Stripe.Products.Price
    func list(
        _ request: Stripe.Products.Prices.List.Request
    ) async throws -> Stripe.Products.Prices.List.Response
}

public struct PricesClient: PricesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Products.Prices.Create.Request
    ) async throws -> Stripe.Products.Price {
        try await api.send(.POST, "v1/prices", body: request)
    }

    public func retrieve(id: Stripe.Products.Price.ID) async throws -> Stripe.Products.Price {
        try await api.send(.GET, "v1/prices/\(id)")
    }

    public func update(
        id: Stripe.Products.Price.ID,
        _ request: Stripe.Products.Prices.Update.Request
    ) async throws -> Stripe.Products.Price {
        try await api.send(.POST, "v1/prices/\(id)", body: request)
    }

    public func list(
        _ request: Stripe.Products.Prices.List.Request
    ) async throws -> Stripe.Products.Prices.List.Response {
        try await api.list("v1/prices", parameters: request)
    }
}
