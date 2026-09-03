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

/// Operations on Stripe.Checkout.Session.
///
/// A protocol so tests can substitute a double; ``CheckoutSessionsClient`` is the implementation that
/// talks to Stripe.
public protocol CheckoutSessionsAPI: Sendable {
    func create(_ request: Stripe.Checkout.Session.Create.Request, idempotencyKey: String?) async throws -> Stripe.Checkout.Session.Create.Response
    func expire(
        id: Stripe.Checkout.Session.ID,
        _ request: Stripe.Checkout.Session.Expire.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Checkout.Session.Expire.Response
    func list(_ request: Stripe.Checkout.Session.List.Request) async throws -> Stripe.Checkout.Session.List.Response
    func listLineItems(
        id: Stripe.Checkout.Session.ID,
        _ request: Stripe.Checkout.Session.ListLineItems.Request
    ) async throws -> Stripe.Checkout.Session.ListLineItems.Response
    func retrieve(
        id: Stripe.Checkout.Session.ID,
        _ request: Stripe.Checkout.Session.Retrieve.Request
    ) async throws -> Stripe.Checkout.Session.Retrieve.Response
    func update(
        id: Stripe.Checkout.Session.ID,
        _ request: Stripe.Checkout.Session.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Checkout.Session.Update.Response
}

public struct CheckoutSessionsClient: CheckoutSessionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Checkout.Session.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Checkout.Session.Create.Response {
        try await api.send(.POST, "v1/checkout/sessions", body: request, idempotencyKey: idempotencyKey)
    }

    public func expire(
        id: Stripe.Checkout.Session.ID,
        _ request: Stripe.Checkout.Session.Expire.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Checkout.Session.Expire.Response {
        try await api.send(.POST, "v1/checkout/sessions/\(id)/expire", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Checkout.Session.List.Request) async throws -> Stripe.Checkout.Session.List.Response {
        try await api.list("v1/checkout/sessions", parameters: request)
    }

    public func listLineItems(
        id: Stripe.Checkout.Session.ID,
        _ request: Stripe.Checkout.Session.ListLineItems.Request
    ) async throws -> Stripe.Checkout.Session.ListLineItems.Response {
        try await api.list("v1/checkout/sessions/\(id)/line_items", parameters: request)
    }

    public func retrieve(
        id: Stripe.Checkout.Session.ID,
        _ request: Stripe.Checkout.Session.Retrieve.Request
    ) async throws -> Stripe.Checkout.Session.Retrieve.Response {
        try await api.list("v1/checkout/sessions/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Checkout.Session.ID,
        _ request: Stripe.Checkout.Session.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Checkout.Session.Update.Response {
        try await api.send(.POST, "v1/checkout/sessions/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension CheckoutSessionsAPI {
    public func create(_ request: Stripe.Checkout.Session.Create.Request) async throws -> Stripe.Checkout.Session.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.Checkout.Session.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func expire(
        id: Stripe.Checkout.Session.ID,
        _ request: Stripe.Checkout.Session.Expire.Request
    ) async throws -> Stripe.Checkout.Session.Expire.Response {
        try await expire(id: id, request, idempotencyKey: nil)
    }

    public func expire(id: Stripe.Checkout.Session.ID, idempotencyKey: String? = nil) async throws -> Stripe.Checkout.Session.Expire.Response {
        try await expire(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> Stripe.Checkout.Session.List.Response {
        try await list(.init())
    }

    public func listLineItems(id: Stripe.Checkout.Session.ID) async throws -> Stripe.Checkout.Session.ListLineItems.Response {
        try await listLineItems(id: id, .init())
    }

    public func retrieve(id: Stripe.Checkout.Session.ID) async throws -> Stripe.Checkout.Session.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Checkout.Session.ID,
        _ request: Stripe.Checkout.Session.Update.Request
    ) async throws -> Stripe.Checkout.Session.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Checkout.Session.ID, idempotencyKey: String? = nil) async throws -> Stripe.Checkout.Session.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
