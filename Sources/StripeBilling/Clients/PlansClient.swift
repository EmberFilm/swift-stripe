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
import StripeCheckout
import StripeCore
import StripeIssuing
import StripeModels
import StripeProducts

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Billing.Plan.
///
/// A protocol so tests can substitute a double; ``PlansClient`` is the implementation that
/// talks to Stripe.
public protocol PlansAPI: Sendable {
    func create(_ request: Stripe.Billing.Plan.Create.Request, idempotencyKey: String?) async throws -> Stripe.Billing.Plan.Create.Response
    func delete(id: Stripe.Billing.Plan.ID, idempotencyKey: String?) async throws -> Stripe.Billing.Plan.Delete.Response
    func list(_ request: Stripe.Billing.Plan.List.Request) async throws -> Stripe.Billing.Plan.List.Response
    func retrieve(id: Stripe.Billing.Plan.ID, _ request: Stripe.Billing.Plan.Retrieve.Request) async throws -> Stripe.Billing.Plan.Retrieve.Response
    func update(
        id: Stripe.Billing.Plan.ID,
        _ request: Stripe.Billing.Plan.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Plan.Update.Response
}

public struct PlansClient: PlansAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(_ request: Stripe.Billing.Plan.Create.Request, idempotencyKey: String?) async throws -> Stripe.Billing.Plan.Create.Response {
        try await api.send(.POST, "v1/plans", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(id: Stripe.Billing.Plan.ID, idempotencyKey: String?) async throws -> Stripe.Billing.Plan.Delete.Response {
        try await api.send(.DELETE, "v1/plans/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Billing.Plan.List.Request) async throws -> Stripe.Billing.Plan.List.Response {
        try await api.list("v1/plans", parameters: request)
    }

    public func retrieve(
        id: Stripe.Billing.Plan.ID,
        _ request: Stripe.Billing.Plan.Retrieve.Request
    ) async throws -> Stripe.Billing.Plan.Retrieve.Response {
        try await api.list("v1/plans/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Billing.Plan.ID,
        _ request: Stripe.Billing.Plan.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Plan.Update.Response {
        try await api.send(.POST, "v1/plans/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PlansAPI {
    public func create(_ request: Stripe.Billing.Plan.Create.Request) async throws -> Stripe.Billing.Plan.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func delete(id: Stripe.Billing.Plan.ID) async throws -> Stripe.Billing.Plan.Delete.Response {
        try await delete(id: id, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Billing.Plan.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Billing.Plan.ID) async throws -> Stripe.Billing.Plan.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(id: Stripe.Billing.Plan.ID, _ request: Stripe.Billing.Plan.Update.Request) async throws -> Stripe.Billing.Plan.Update.Response
    {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Billing.Plan.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Plan.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
