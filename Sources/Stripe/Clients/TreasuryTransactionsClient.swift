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

/// Operations on Stripe.Treasury.Transaction.
///
/// A protocol so tests can substitute a double; ``TreasuryTransactionsClient`` is the implementation that
/// talks to Stripe.
public protocol TreasuryTransactionsAPI: Sendable {
    func list(_ request: Stripe.Treasury.Transaction.List.Request) async throws -> Stripe.Treasury.Transaction.List.Response
    func retrieve(
        id: Stripe.Treasury.Transaction.ID,
        _ request: Stripe.Treasury.Transaction.Retrieve.Request
    ) async throws -> Stripe.Treasury.Transaction.Retrieve.Response
}

public struct TreasuryTransactionsClient: TreasuryTransactionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Treasury.Transaction.List.Request) async throws -> Stripe.Treasury.Transaction.List.Response {
        try await api.list("v1/treasury/transactions", parameters: request)
    }

    public func retrieve(
        id: Stripe.Treasury.Transaction.ID,
        _ request: Stripe.Treasury.Transaction.Retrieve.Request
    ) async throws -> Stripe.Treasury.Transaction.Retrieve.Response {
        try await api.list("v1/treasury/transactions/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TreasuryTransactionsAPI {
    public func retrieve(id: Stripe.Treasury.Transaction.ID) async throws -> Stripe.Treasury.Transaction.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
