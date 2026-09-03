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

/// Operations on Stripe.Treasury.TransactionEntry.
///
/// A protocol so tests can substitute a double; ``TreasuryTransactionEntriesClient`` is the implementation that
/// talks to Stripe.
public protocol TreasuryTransactionEntriesAPI: Sendable {
    func list(_ request: Stripe.Treasury.TransactionEntry.List.Request) async throws -> Stripe.Treasury.TransactionEntry.List.Response
    func retrieve(
        id: Stripe.Treasury.TransactionEntry.ID,
        _ request: Stripe.Treasury.TransactionEntry.Retrieve.Request
    ) async throws -> Stripe.Treasury.TransactionEntry.Retrieve.Response
}

public struct TreasuryTransactionEntriesClient: TreasuryTransactionEntriesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Treasury.TransactionEntry.List.Request) async throws -> Stripe.Treasury.TransactionEntry.List.Response {
        try await api.list("v1/treasury/transaction_entries", parameters: request)
    }

    public func retrieve(
        id: Stripe.Treasury.TransactionEntry.ID,
        _ request: Stripe.Treasury.TransactionEntry.Retrieve.Request
    ) async throws -> Stripe.Treasury.TransactionEntry.Retrieve.Response {
        try await api.list("v1/treasury/transaction_entries/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TreasuryTransactionEntriesAPI {
    public func retrieve(id: Stripe.Treasury.TransactionEntry.ID) async throws -> Stripe.Treasury.TransactionEntry.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
