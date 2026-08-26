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

/// Operations on FinancialConnections.Transaction.
///
/// A protocol so tests can substitute a double; ``FinancialConnectionsTransactionsClient`` is the implementation that
/// talks to Stripe.
public protocol FinancialConnectionsTransactionsAPI: Sendable {
    func list(_ request: FinancialConnections.Transaction.List.Request) async throws -> FinancialConnections.Transaction.List.Response
    func retrieve(
        id: FinancialConnections.Transaction.ID,
        _ request: FinancialConnections.Transaction.Retrieve.Request
    ) async throws -> FinancialConnections.Transaction.Retrieve.Response
}

public struct FinancialConnectionsTransactionsClient: FinancialConnectionsTransactionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: FinancialConnections.Transaction.List.Request) async throws -> FinancialConnections.Transaction.List.Response {
        try await api.list("v1/financial_connections/transactions", parameters: request)
    }

    public func retrieve(
        id: FinancialConnections.Transaction.ID,
        _ request: FinancialConnections.Transaction.Retrieve.Request
    ) async throws -> FinancialConnections.Transaction.Retrieve.Response {
        try await api.list("v1/financial_connections/transactions/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension FinancialConnectionsTransactionsAPI {
    public func retrieve(id: FinancialConnections.Transaction.ID) async throws -> FinancialConnections.Transaction.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
