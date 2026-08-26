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

/// Operations on Stripe.Connect.Transfer.
///
/// A protocol so tests can substitute a double; ``TransfersClient`` is the implementation that
/// talks to Stripe.
public protocol TransfersAPI: Sendable {
    func create(_ request: Stripe.Connect.Transfer.Create.Request, idempotencyKey: String?) async throws -> Stripe.Connect.Transfer.Create.Response
    func list(_ request: Stripe.Connect.Transfer.List.Request) async throws -> Stripe.Connect.Transfer.List.Response
    func retrieve(
        id: Stripe.Connect.Transfer.ID,
        _ request: Stripe.Connect.Transfer.Retrieve.Request
    ) async throws -> Stripe.Connect.Transfer.Retrieve.Response
    func update(
        id: Stripe.Connect.Transfer.ID,
        _ request: Stripe.Connect.Transfer.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Transfer.Update.Response
}

public struct TransfersClient: TransfersAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Connect.Transfer.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Transfer.Create.Response {
        try await api.send(.POST, "v1/transfers", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Connect.Transfer.List.Request) async throws -> Stripe.Connect.Transfer.List.Response {
        try await api.list("v1/transfers", parameters: request)
    }

    public func retrieve(
        id: Stripe.Connect.Transfer.ID,
        _ request: Stripe.Connect.Transfer.Retrieve.Request
    ) async throws -> Stripe.Connect.Transfer.Retrieve.Response {
        try await api.list("v1/transfers/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Connect.Transfer.ID,
        _ request: Stripe.Connect.Transfer.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Transfer.Update.Response {
        try await api.send(.POST, "v1/transfers/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TransfersAPI {
    public func create(_ request: Stripe.Connect.Transfer.Create.Request) async throws -> Stripe.Connect.Transfer.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Connect.Transfer.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Connect.Transfer.ID) async throws -> Stripe.Connect.Transfer.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Connect.Transfer.ID,
        _ request: Stripe.Connect.Transfer.Update.Request
    ) async throws -> Stripe.Connect.Transfer.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Connect.Transfer.ID, idempotencyKey: String? = nil) async throws -> Stripe.Connect.Transfer.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
