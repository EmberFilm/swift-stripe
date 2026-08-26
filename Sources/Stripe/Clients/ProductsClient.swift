//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-stripe open source project
//
// Copyright (c) 2026 the swift-stripe project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
// See NOTICE for attribution of derived work
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import NIOHTTP1

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Products.Product.
///
/// A protocol so tests can substitute a double; ``ProductsClient`` is the implementation that
/// talks to Stripe.
public protocol ProductsAPI: Sendable {
    func create(_ request: Stripe.Products.Product.Create.Request, idempotencyKey: String?) async throws -> Stripe.Products.Product.Create.Response
    func delete(id: Stripe.Products.Product.ID, idempotencyKey: String?) async throws -> Stripe.Products.Product.Delete.Response
    func list(_ request: Stripe.Products.Product.List.Request) async throws -> Stripe.Products.Product.List.Response
    func retrieve(
        id: Stripe.Products.Product.ID,
        _ request: Stripe.Products.Product.Retrieve.Request
    ) async throws -> Stripe.Products.Product.Retrieve.Response
    func search(_ request: Stripe.Products.Product.Search.Request) async throws -> Stripe.Products.Product.Search.Response
    func update(
        id: Stripe.Products.Product.ID,
        _ request: Stripe.Products.Product.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Product.Update.Response
}

public struct ProductsClient: ProductsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Products.Product.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Product.Create.Response {
        try await api.send(.POST, "v1/products", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(id: Stripe.Products.Product.ID, idempotencyKey: String?) async throws -> Stripe.Products.Product.Delete.Response {
        try await api.send(.DELETE, "v1/products/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Products.Product.List.Request) async throws -> Stripe.Products.Product.List.Response {
        try await api.list("v1/products", parameters: request)
    }

    public func retrieve(
        id: Stripe.Products.Product.ID,
        _ request: Stripe.Products.Product.Retrieve.Request
    ) async throws -> Stripe.Products.Product.Retrieve.Response {
        try await api.list("v1/products/\(id)", parameters: request)
    }

    public func search(_ request: Stripe.Products.Product.Search.Request) async throws -> Stripe.Products.Product.Search.Response {
        try await api.list("v1/products/search", parameters: request)
    }

    public func update(
        id: Stripe.Products.Product.ID,
        _ request: Stripe.Products.Product.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Product.Update.Response {
        try await api.send(.POST, "v1/products/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ProductsAPI {
    public func create(_ request: Stripe.Products.Product.Create.Request) async throws -> Stripe.Products.Product.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func delete(id: Stripe.Products.Product.ID) async throws -> Stripe.Products.Product.Delete.Response {
        try await delete(id: id, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Products.Product.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Products.Product.ID) async throws -> Stripe.Products.Product.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Products.Product.ID,
        _ request: Stripe.Products.Product.Update.Request
    ) async throws -> Stripe.Products.Product.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Products.Product.ID, idempotencyKey: String? = nil) async throws -> Stripe.Products.Product.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
