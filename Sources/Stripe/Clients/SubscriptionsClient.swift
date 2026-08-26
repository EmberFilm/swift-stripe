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

/// Operations on Stripe.Billing.Subscription.
///
/// A protocol so tests can substitute a double; ``SubscriptionsClient`` is the implementation that
/// talks to Stripe.
public protocol SubscriptionsAPI: Sendable {
    func cancel(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.Cancel.Response
    func create(
        _ request: Stripe.Billing.Subscription.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.Create.Response
    func deleteDiscount(
        id: Stripe.Billing.Subscription.ID,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.DeleteDiscount.Response
    func list(_ request: Stripe.Billing.Subscription.List.Request) async throws -> Stripe.Billing.Subscription.List.Response
    func migrate(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Migrate.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.Migrate.Response
    func resume(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Resume.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.Resume.Response
    func retrieve(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Retrieve.Request
    ) async throws -> Stripe.Billing.Subscription.Retrieve.Response
    func search(_ request: Stripe.Billing.Subscription.Search.Request) async throws -> Stripe.Billing.Subscription.Search.Response
    func update(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.Update.Response
}

public struct SubscriptionsClient: SubscriptionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func cancel(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.Cancel.Response {
        try await api.send(.DELETE, "v1/subscriptions/\(id)", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(
        _ request: Stripe.Billing.Subscription.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.Create.Response {
        try await api.send(.POST, "v1/subscriptions", body: request, idempotencyKey: idempotencyKey)
    }

    public func deleteDiscount(
        id: Stripe.Billing.Subscription.ID,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.DeleteDiscount.Response {
        try await api.send(.DELETE, "v1/subscriptions/\(id)/discount", idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Billing.Subscription.List.Request) async throws -> Stripe.Billing.Subscription.List.Response {
        try await api.list("v1/subscriptions", parameters: request)
    }

    public func migrate(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Migrate.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.Migrate.Response {
        try await api.send(.POST, "v1/subscriptions/\(id)/migrate", body: request, idempotencyKey: idempotencyKey)
    }

    public func resume(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Resume.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.Resume.Response {
        try await api.send(.POST, "v1/subscriptions/\(id)/resume", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Retrieve.Request
    ) async throws -> Stripe.Billing.Subscription.Retrieve.Response {
        try await api.list("v1/subscriptions/\(id)", parameters: request)
    }

    public func search(_ request: Stripe.Billing.Subscription.Search.Request) async throws -> Stripe.Billing.Subscription.Search.Response {
        try await api.list("v1/subscriptions/search", parameters: request)
    }

    public func update(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Subscription.Update.Response {
        try await api.send(.POST, "v1/subscriptions/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension SubscriptionsAPI {
    public func cancel(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Cancel.Request
    ) async throws -> Stripe.Billing.Subscription.Cancel.Response {
        try await cancel(id: id, request, idempotencyKey: nil)
    }

    public func cancel(id: Stripe.Billing.Subscription.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Subscription.Cancel.Response
    {
        try await cancel(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func create(_ request: Stripe.Billing.Subscription.Create.Request) async throws -> Stripe.Billing.Subscription.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.Billing.Subscription.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func deleteDiscount(id: Stripe.Billing.Subscription.ID) async throws -> Stripe.Billing.Subscription.DeleteDiscount.Response {
        try await deleteDiscount(id: id, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Billing.Subscription.List.Response {
        try await list(.init())
    }

    public func migrate(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Migrate.Request
    ) async throws -> Stripe.Billing.Subscription.Migrate.Response {
        try await migrate(id: id, request, idempotencyKey: nil)
    }

    public func resume(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Resume.Request
    ) async throws -> Stripe.Billing.Subscription.Resume.Response {
        try await resume(id: id, request, idempotencyKey: nil)
    }

    public func resume(id: Stripe.Billing.Subscription.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Subscription.Resume.Response
    {
        try await resume(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func retrieve(id: Stripe.Billing.Subscription.ID) async throws -> Stripe.Billing.Subscription.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Billing.Subscription.ID,
        _ request: Stripe.Billing.Subscription.Update.Request
    ) async throws -> Stripe.Billing.Subscription.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Billing.Subscription.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Subscription.Update.Response
    {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
