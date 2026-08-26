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

/// Operations on FinancialConnections.Account.
///
/// A protocol so tests can substitute a double; ``FinancialConnectionsAccountsClient`` is the implementation that
/// talks to Stripe.
public protocol FinancialConnectionsAccountsAPI: Sendable {
    func disconnect(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Disconnect.Request,
        idempotencyKey: String?
    ) async throws -> FinancialConnections.Account.Disconnect.Response
    func list(_ request: FinancialConnections.Account.List.Request) async throws -> FinancialConnections.Account.List.Response
    func listOwners(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.ListOwners.Request
    ) async throws -> FinancialConnections.Account.ListOwners.Response
    func refresh(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Refresh.Request,
        idempotencyKey: String?
    ) async throws -> FinancialConnections.Account.Refresh.Response
    func retrieve(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Retrieve.Request
    ) async throws -> FinancialConnections.Account.Retrieve.Response
    func subscribe(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Subscribe.Request,
        idempotencyKey: String?
    ) async throws -> FinancialConnections.Account.Subscribe.Response
    func unsubscribe(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Unsubscribe.Request,
        idempotencyKey: String?
    ) async throws -> FinancialConnections.Account.Unsubscribe.Response
}

public struct FinancialConnectionsAccountsClient: FinancialConnectionsAccountsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func disconnect(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Disconnect.Request,
        idempotencyKey: String?
    ) async throws -> FinancialConnections.Account.Disconnect.Response {
        try await api.send(.POST, "v1/financial_connections/accounts/\(id)/disconnect", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: FinancialConnections.Account.List.Request) async throws -> FinancialConnections.Account.List.Response {
        try await api.list("v1/financial_connections/accounts", parameters: request)
    }

    public func listOwners(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.ListOwners.Request
    ) async throws -> FinancialConnections.Account.ListOwners.Response {
        try await api.list("v1/financial_connections/accounts/\(id)/owners", parameters: request)
    }

    public func refresh(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Refresh.Request,
        idempotencyKey: String?
    ) async throws -> FinancialConnections.Account.Refresh.Response {
        try await api.send(.POST, "v1/financial_connections/accounts/\(id)/refresh", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Retrieve.Request
    ) async throws -> FinancialConnections.Account.Retrieve.Response {
        try await api.list("v1/financial_connections/accounts/\(id)", parameters: request)
    }

    public func subscribe(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Subscribe.Request,
        idempotencyKey: String?
    ) async throws -> FinancialConnections.Account.Subscribe.Response {
        try await api.send(.POST, "v1/financial_connections/accounts/\(id)/subscribe", body: request, idempotencyKey: idempotencyKey)
    }

    public func unsubscribe(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Unsubscribe.Request,
        idempotencyKey: String?
    ) async throws -> FinancialConnections.Account.Unsubscribe.Response {
        try await api.send(.POST, "v1/financial_connections/accounts/\(id)/unsubscribe", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension FinancialConnectionsAccountsAPI {
    public func disconnect(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Disconnect.Request
    ) async throws -> FinancialConnections.Account.Disconnect.Response {
        try await disconnect(id: id, request, idempotencyKey: nil)
    }

    public func disconnect(
        id: FinancialConnections.Account.ID,
        idempotencyKey: String? = nil
    ) async throws -> FinancialConnections.Account.Disconnect.Response {
        try await disconnect(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> FinancialConnections.Account.List.Response {
        try await list(.init())
    }

    public func refresh(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Refresh.Request
    ) async throws -> FinancialConnections.Account.Refresh.Response {
        try await refresh(id: id, request, idempotencyKey: nil)
    }

    public func retrieve(id: FinancialConnections.Account.ID) async throws -> FinancialConnections.Account.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func subscribe(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Subscribe.Request
    ) async throws -> FinancialConnections.Account.Subscribe.Response {
        try await subscribe(id: id, request, idempotencyKey: nil)
    }

    public func unsubscribe(
        id: FinancialConnections.Account.ID,
        _ request: FinancialConnections.Account.Unsubscribe.Request
    ) async throws -> FinancialConnections.Account.Unsubscribe.Response {
        try await unsubscribe(id: id, request, idempotencyKey: nil)
    }
}
