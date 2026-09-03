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

/// Operations on Stripe.Products.Shipping.Rate.
///
/// A protocol so tests can substitute a double; ``ShippingRatesClient`` is the implementation that
/// talks to Stripe.
public protocol ShippingRatesAPI: Sendable {
    func create(
        _ request: Stripe.Products.Shipping.Rate.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Shipping.Rate.Create.Response
    func list(_ request: Stripe.Products.Shipping.Rate.List.Request) async throws -> Stripe.Products.Shipping.Rate.List.Response
    func retrieve(
        id: Stripe.Products.Shipping.Rate.ID,
        _ request: Stripe.Products.Shipping.Rate.Retrieve.Request
    ) async throws -> Stripe.Products.Shipping.Rate.Retrieve.Response
    func update(
        id: Stripe.Products.Shipping.Rate.ID,
        _ request: Stripe.Products.Shipping.Rate.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Shipping.Rate.Update.Response
}

public struct ShippingRatesClient: ShippingRatesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Products.Shipping.Rate.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Shipping.Rate.Create.Response {
        try await api.send(.POST, "v1/shipping_rates", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Products.Shipping.Rate.List.Request) async throws -> Stripe.Products.Shipping.Rate.List.Response {
        try await api.list("v1/shipping_rates", parameters: request)
    }

    public func retrieve(
        id: Stripe.Products.Shipping.Rate.ID,
        _ request: Stripe.Products.Shipping.Rate.Retrieve.Request
    ) async throws -> Stripe.Products.Shipping.Rate.Retrieve.Response {
        try await api.list("v1/shipping_rates/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Products.Shipping.Rate.ID,
        _ request: Stripe.Products.Shipping.Rate.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Products.Shipping.Rate.Update.Response {
        try await api.send(.POST, "v1/shipping_rates/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ShippingRatesAPI {
    public func create(_ request: Stripe.Products.Shipping.Rate.Create.Request) async throws -> Stripe.Products.Shipping.Rate.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Products.Shipping.Rate.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Products.Shipping.Rate.ID) async throws -> Stripe.Products.Shipping.Rate.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Products.Shipping.Rate.ID,
        _ request: Stripe.Products.Shipping.Rate.Update.Request
    ) async throws -> Stripe.Products.Shipping.Rate.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.Products.Shipping.Rate.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Products.Shipping.Rate.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
