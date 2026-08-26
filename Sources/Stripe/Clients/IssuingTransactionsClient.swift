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

/// Operations on Transaction.
///
/// A protocol so tests can substitute a double; ``IssuingTransactionsClient`` is the implementation that
/// talks to Stripe.
public protocol IssuingTransactionsAPI: Sendable {
    func createForceCapture(
        _ request: Transaction.CreateForceCapture.Request,
        idempotencyKey: String?
    ) async throws -> Transaction.CreateForceCapture.Response
    func createUnlinkedRefund(
        _ request: Transaction.CreateUnlinkedRefund.Request,
        idempotencyKey: String?
    ) async throws -> Transaction.CreateUnlinkedRefund.Response
    func list(_ request: Transaction.List.Request) async throws -> Transaction.List.Response
    func refund(id: Transaction.ID, _ request: Transaction.Refund.Request, idempotencyKey: String?) async throws -> Transaction.Refund.Response
    func retrieve(id: Transaction.ID, _ request: Transaction.Retrieve.Request) async throws -> Transaction.Retrieve.Response
    func update(id: Transaction.ID, _ request: Transaction.Update.Request, idempotencyKey: String?) async throws -> Transaction.Update.Response
}

public struct IssuingTransactionsClient: IssuingTransactionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func createForceCapture(
        _ request: Transaction.CreateForceCapture.Request,
        idempotencyKey: String?
    ) async throws -> Transaction.CreateForceCapture.Response {
        try await api.send(.POST, "v1/test_helpers/issuing/transactions/create_force_capture", body: request, idempotencyKey: idempotencyKey)
    }

    public func createUnlinkedRefund(
        _ request: Transaction.CreateUnlinkedRefund.Request,
        idempotencyKey: String?
    ) async throws -> Transaction.CreateUnlinkedRefund.Response {
        try await api.send(.POST, "v1/test_helpers/issuing/transactions/create_unlinked_refund", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Transaction.List.Request) async throws -> Transaction.List.Response {
        try await api.list("v1/issuing/transactions", parameters: request)
    }

    public func refund(id: Transaction.ID, _ request: Transaction.Refund.Request, idempotencyKey: String?) async throws -> Transaction.Refund.Response
    {
        try await api.send(.POST, "v1/test_helpers/issuing/transactions/\(id)/refund", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(id: Transaction.ID, _ request: Transaction.Retrieve.Request) async throws -> Transaction.Retrieve.Response {
        try await api.list("v1/issuing/transactions/\(id)", parameters: request)
    }

    public func update(id: Transaction.ID, _ request: Transaction.Update.Request, idempotencyKey: String?) async throws -> Transaction.Update.Response
    {
        try await api.send(.POST, "v1/issuing/transactions/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension IssuingTransactionsAPI {
    public func createForceCapture(_ request: Transaction.CreateForceCapture.Request) async throws -> Transaction.CreateForceCapture.Response {
        try await createForceCapture(request, idempotencyKey: nil)
    }

    public func createUnlinkedRefund(_ request: Transaction.CreateUnlinkedRefund.Request) async throws -> Transaction.CreateUnlinkedRefund.Response {
        try await createUnlinkedRefund(request, idempotencyKey: nil)
    }

    public func list() async throws -> Transaction.List.Response {
        try await list(.init())
    }

    public func refund(id: Transaction.ID, _ request: Transaction.Refund.Request) async throws -> Transaction.Refund.Response {
        try await refund(id: id, request, idempotencyKey: nil)
    }

    public func refund(id: Transaction.ID, idempotencyKey: String? = nil) async throws -> Transaction.Refund.Response {
        try await refund(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func retrieve(id: Transaction.ID) async throws -> Transaction.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(id: Transaction.ID, _ request: Transaction.Update.Request) async throws -> Transaction.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Transaction.ID, idempotencyKey: String? = nil) async throws -> Transaction.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
