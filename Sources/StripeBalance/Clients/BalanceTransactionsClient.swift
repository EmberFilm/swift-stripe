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
import StripeIssuing
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Balance.Transaction.
///
/// A protocol so tests can substitute a double; ``BalanceTransactionsClient`` is the implementation that
/// talks to Stripe.
public protocol BalanceTransactionsAPI: Sendable {
    func list(_ request: Stripe.Balance.Transaction.List.Request) async throws -> Stripe.Balance.Transaction.List.Response
    func retrieve(
        id: Stripe.Balance.Transaction.ID,
        _ request: Stripe.Balance.Transaction.Retrieve.Request
    ) async throws -> Stripe.Balance.Transaction.Retrieve.Response
}

public struct BalanceTransactionsClient: BalanceTransactionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Balance.Transaction.List.Request) async throws -> Stripe.Balance.Transaction.List.Response {
        try await api.list("v1/balance_transactions", parameters: request)
    }

    public func retrieve(
        id: Stripe.Balance.Transaction.ID,
        _ request: Stripe.Balance.Transaction.Retrieve.Request
    ) async throws -> Stripe.Balance.Transaction.Retrieve.Response {
        try await api.list("v1/balance_transactions/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension BalanceTransactionsAPI {
    public func list() async throws -> Stripe.Balance.Transaction.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Balance.Transaction.ID) async throws -> Stripe.Balance.Transaction.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
