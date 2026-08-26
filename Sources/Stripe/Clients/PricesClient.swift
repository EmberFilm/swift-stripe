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

/// Operations on Stripe.Products.Price.
///
/// A protocol so tests can substitute a double; ``PricesClient`` is the implementation that
/// talks to Stripe.
public protocol PricesAPI: Sendable {
    func create(_ request: Stripe.Products.Price.Create.Request, idempotencyKey: String?) async throws -> Stripe.Products.Price.Create.Response
    func list(_ request: Stripe.Products.Price.List.Request) async throws -> Stripe.Products.Price.List.Response
    func retrieve(
        id: Stripe.Products.Price.ID,
        _ request: Stripe.Products.Price.Retrieve.Request
    ) async throws -> Stripe.Products.Price.Retrieve.Response
    func search(_ request: Stripe.Products.Price.Search.Request) async throws -> Stripe.Products.Price.Search.Response
    func update(
        id: Stripe.Products.Price.ID,
        _ request: Stripe.Products.Price.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Price.Update.Response
}

public struct PricesClient: PricesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(_ request: Stripe.Products.Price.Create.Request, idempotencyKey: String?) async throws -> Stripe.Products.Price.Create.Response
    {
        try await api.send(.POST, "v1/prices", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Products.Price.List.Request) async throws -> Stripe.Products.Price.List.Response {
        try await api.list("v1/prices", parameters: request)
    }

    public func retrieve(
        id: Stripe.Products.Price.ID,
        _ request: Stripe.Products.Price.Retrieve.Request
    ) async throws -> Stripe.Products.Price.Retrieve.Response {
        try await api.list("v1/prices/\(id)", parameters: request)
    }

    public func search(_ request: Stripe.Products.Price.Search.Request) async throws -> Stripe.Products.Price.Search.Response {
        try await api.list("v1/prices/search", parameters: request)
    }

    public func update(
        id: Stripe.Products.Price.ID,
        _ request: Stripe.Products.Price.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Price.Update.Response {
        try await api.send(.POST, "v1/prices/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PricesAPI {
    public func create(_ request: Stripe.Products.Price.Create.Request) async throws -> Stripe.Products.Price.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Products.Price.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Products.Price.ID) async throws -> Stripe.Products.Price.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Products.Price.ID,
        _ request: Stripe.Products.Price.Update.Request
    ) async throws -> Stripe.Products.Price.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Products.Price.ID, idempotencyKey: String? = nil) async throws -> Stripe.Products.Price.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
