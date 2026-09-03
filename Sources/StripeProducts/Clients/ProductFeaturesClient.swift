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
import StripeCore
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Products.ProductFeature.
///
/// A protocol so tests can substitute a double; ``ProductFeaturesClient`` is the implementation that
/// talks to Stripe.
public protocol ProductFeaturesAPI: Sendable {
    func create(
        product: String,
        _ request: Stripe.Products.ProductFeature.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.ProductFeature.Create.Response
    func delete(product: String, id: String, idempotencyKey: String?) async throws -> Stripe.Products.ProductFeature.Delete.Response
    func list(product: String, _ request: Stripe.Products.ProductFeature.List.Request) async throws -> Stripe.Products.ProductFeature.List.Response
    func retrieve(
        product: String,
        id: String,
        _ request: Stripe.Products.ProductFeature.Retrieve.Request
    ) async throws -> Stripe.Products.ProductFeature.Retrieve.Response
}

public struct ProductFeaturesClient: ProductFeaturesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        product: String,
        _ request: Stripe.Products.ProductFeature.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.ProductFeature.Create.Response {
        try await api.send(.POST, "v1/products/\(product)/features", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(product: String, id: String, idempotencyKey: String?) async throws -> Stripe.Products.ProductFeature.Delete.Response {
        try await api.send(.DELETE, "v1/products/\(product)/features/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(
        product: String,
        _ request: Stripe.Products.ProductFeature.List.Request
    ) async throws -> Stripe.Products.ProductFeature.List.Response {
        try await api.list("v1/products/\(product)/features", parameters: request)
    }

    public func retrieve(
        product: String,
        id: String,
        _ request: Stripe.Products.ProductFeature.Retrieve.Request
    ) async throws -> Stripe.Products.ProductFeature.Retrieve.Response {
        try await api.list("v1/products/\(product)/features/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ProductFeaturesAPI {
    public func create(
        product: String,
        _ request: Stripe.Products.ProductFeature.Create.Request
    ) async throws -> Stripe.Products.ProductFeature.Create.Response {
        try await create(product: product, request, idempotencyKey: nil)
    }

    public func delete(product: String, id: String) async throws -> Stripe.Products.ProductFeature.Delete.Response {
        try await delete(product: product, id: id, idempotencyKey: nil)
    }

    public func list(product: String) async throws -> Stripe.Products.ProductFeature.List.Response {
        try await list(product: product, .init())
    }

    public func retrieve(product: String, id: String) async throws -> Stripe.Products.ProductFeature.Retrieve.Response {
        try await retrieve(product: product, id: id, .init())
    }
}
