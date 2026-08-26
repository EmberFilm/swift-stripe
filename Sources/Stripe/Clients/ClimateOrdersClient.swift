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

/// Operations on Stripe.Climate.Order.
///
/// A protocol so tests can substitute a double; ``ClimateOrdersClient`` is the implementation that
/// talks to Stripe.
public protocol ClimateOrdersAPI: Sendable {
    func cancel(
        id: Stripe.Climate.Order.ID,
        _ request: Stripe.Climate.Order.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Climate.Order.Cancel.Response
    func create(_ request: Stripe.Climate.Order.Create.Request, idempotencyKey: String?) async throws -> Stripe.Climate.Order.Create.Response
    func list(_ request: Stripe.Climate.Order.List.Request) async throws -> Stripe.Climate.Order.List.Response
    func retrieve(
        id: Stripe.Climate.Order.ID,
        _ request: Stripe.Climate.Order.Retrieve.Request
    ) async throws -> Stripe.Climate.Order.Retrieve.Response
    func update(
        id: Stripe.Climate.Order.ID,
        _ request: Stripe.Climate.Order.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Climate.Order.Update.Response
}

public struct ClimateOrdersClient: ClimateOrdersAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func cancel(
        id: Stripe.Climate.Order.ID,
        _ request: Stripe.Climate.Order.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Climate.Order.Cancel.Response {
        try await api.send(.POST, "v1/climate/orders/\(id)/cancel", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(_ request: Stripe.Climate.Order.Create.Request, idempotencyKey: String?) async throws -> Stripe.Climate.Order.Create.Response {
        try await api.send(.POST, "v1/climate/orders", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Climate.Order.List.Request) async throws -> Stripe.Climate.Order.List.Response {
        try await api.list("v1/climate/orders", parameters: request)
    }

    public func retrieve(
        id: Stripe.Climate.Order.ID,
        _ request: Stripe.Climate.Order.Retrieve.Request
    ) async throws -> Stripe.Climate.Order.Retrieve.Response {
        try await api.list("v1/climate/orders/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Climate.Order.ID,
        _ request: Stripe.Climate.Order.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Climate.Order.Update.Response {
        try await api.send(.POST, "v1/climate/orders/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ClimateOrdersAPI {
    public func cancel(
        id: Stripe.Climate.Order.ID,
        _ request: Stripe.Climate.Order.Cancel.Request
    ) async throws -> Stripe.Climate.Order.Cancel.Response {
        try await cancel(id: id, request, idempotencyKey: nil)
    }

    public func cancel(id: Stripe.Climate.Order.ID, idempotencyKey: String? = nil) async throws -> Stripe.Climate.Order.Cancel.Response {
        try await cancel(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func create(_ request: Stripe.Climate.Order.Create.Request) async throws -> Stripe.Climate.Order.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Climate.Order.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Climate.Order.ID) async throws -> Stripe.Climate.Order.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Climate.Order.ID,
        _ request: Stripe.Climate.Order.Update.Request
    ) async throws -> Stripe.Climate.Order.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Climate.Order.ID, idempotencyKey: String? = nil) async throws -> Stripe.Climate.Order.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
