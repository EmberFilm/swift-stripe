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

/// Operations on Stripe.Payouts.Payout.
///
/// A protocol so tests can substitute a double; ``PayoutsClient`` is the implementation that
/// talks to Stripe.
public protocol PayoutsAPI: Sendable {
    func cancel(
        id: Stripe.Payouts.Payout.ID,
        _ request: Stripe.Payouts.Payout.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Payouts.Payout.Cancel.Response
    func create(_ request: Stripe.Payouts.Payout.Create.Request, idempotencyKey: String?) async throws -> Stripe.Payouts.Payout.Create.Response
    func list(_ request: Stripe.Payouts.Payout.List.Request) async throws -> Stripe.Payouts.Payout.List.Response
    func retrieve(
        id: Stripe.Payouts.Payout.ID,
        _ request: Stripe.Payouts.Payout.Retrieve.Request
    ) async throws -> Stripe.Payouts.Payout.Retrieve.Response
    func reverse(
        id: Stripe.Payouts.Payout.ID,
        _ request: Stripe.Payouts.Payout.Reverse.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Payouts.Payout.Reverse.Response
    func update(
        id: Stripe.Payouts.Payout.ID,
        _ request: Stripe.Payouts.Payout.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Payouts.Payout.Update.Response
}

public struct PayoutsClient: PayoutsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func cancel(
        id: Stripe.Payouts.Payout.ID,
        _ request: Stripe.Payouts.Payout.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Payouts.Payout.Cancel.Response {
        try await api.send(.POST, "v1/payouts/\(id)/cancel", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(_ request: Stripe.Payouts.Payout.Create.Request, idempotencyKey: String?) async throws -> Stripe.Payouts.Payout.Create.Response
    {
        try await api.send(.POST, "v1/payouts", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Payouts.Payout.List.Request) async throws -> Stripe.Payouts.Payout.List.Response {
        try await api.list("v1/payouts", parameters: request)
    }

    public func retrieve(
        id: Stripe.Payouts.Payout.ID,
        _ request: Stripe.Payouts.Payout.Retrieve.Request
    ) async throws -> Stripe.Payouts.Payout.Retrieve.Response {
        try await api.list("v1/payouts/\(id)", parameters: request)
    }

    public func reverse(
        id: Stripe.Payouts.Payout.ID,
        _ request: Stripe.Payouts.Payout.Reverse.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Payouts.Payout.Reverse.Response {
        try await api.send(.POST, "v1/payouts/\(id)/reverse", body: request, idempotencyKey: idempotencyKey)
    }

    public func update(
        id: Stripe.Payouts.Payout.ID,
        _ request: Stripe.Payouts.Payout.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Payouts.Payout.Update.Response {
        try await api.send(.POST, "v1/payouts/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PayoutsAPI {
    public func cancel(
        id: Stripe.Payouts.Payout.ID,
        _ request: Stripe.Payouts.Payout.Cancel.Request
    ) async throws -> Stripe.Payouts.Payout.Cancel.Response {
        try await cancel(id: id, request, idempotencyKey: nil)
    }

    public func cancel(id: Stripe.Payouts.Payout.ID, idempotencyKey: String? = nil) async throws -> Stripe.Payouts.Payout.Cancel.Response {
        try await cancel(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func create(_ request: Stripe.Payouts.Payout.Create.Request) async throws -> Stripe.Payouts.Payout.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Payouts.Payout.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Payouts.Payout.ID) async throws -> Stripe.Payouts.Payout.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func reverse(
        id: Stripe.Payouts.Payout.ID,
        _ request: Stripe.Payouts.Payout.Reverse.Request
    ) async throws -> Stripe.Payouts.Payout.Reverse.Response {
        try await reverse(id: id, request, idempotencyKey: nil)
    }

    public func reverse(id: Stripe.Payouts.Payout.ID, idempotencyKey: String? = nil) async throws -> Stripe.Payouts.Payout.Reverse.Response {
        try await reverse(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func update(
        id: Stripe.Payouts.Payout.ID,
        _ request: Stripe.Payouts.Payout.Update.Request
    ) async throws -> Stripe.Payouts.Payout.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Payouts.Payout.ID, idempotencyKey: String? = nil) async throws -> Stripe.Payouts.Payout.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
