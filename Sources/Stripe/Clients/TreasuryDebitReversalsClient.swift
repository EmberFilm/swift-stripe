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

/// Operations on Stripe.Treasury.DebitReversal.
///
/// A protocol so tests can substitute a double; ``TreasuryDebitReversalsClient`` is the implementation that
/// talks to Stripe.
public protocol TreasuryDebitReversalsAPI: Sendable {
    func create(
        _ request: Stripe.Treasury.DebitReversal.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.DebitReversal.Create.Response
    func list(_ request: Stripe.Treasury.DebitReversal.List.Request) async throws -> Stripe.Treasury.DebitReversal.List.Response
    func retrieve(
        id: Stripe.Treasury.DebitReversal.ID,
        _ request: Stripe.Treasury.DebitReversal.Retrieve.Request
    ) async throws -> Stripe.Treasury.DebitReversal.Retrieve.Response
}

public struct TreasuryDebitReversalsClient: TreasuryDebitReversalsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Treasury.DebitReversal.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.DebitReversal.Create.Response {
        try await api.send(.POST, "v1/treasury/debit_reversals", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Treasury.DebitReversal.List.Request) async throws -> Stripe.Treasury.DebitReversal.List.Response {
        try await api.list("v1/treasury/debit_reversals", parameters: request)
    }

    public func retrieve(
        id: Stripe.Treasury.DebitReversal.ID,
        _ request: Stripe.Treasury.DebitReversal.Retrieve.Request
    ) async throws -> Stripe.Treasury.DebitReversal.Retrieve.Response {
        try await api.list("v1/treasury/debit_reversals/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TreasuryDebitReversalsAPI {
    public func create(_ request: Stripe.Treasury.DebitReversal.Create.Request) async throws -> Stripe.Treasury.DebitReversal.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func retrieve(id: Stripe.Treasury.DebitReversal.ID) async throws -> Stripe.Treasury.DebitReversal.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
