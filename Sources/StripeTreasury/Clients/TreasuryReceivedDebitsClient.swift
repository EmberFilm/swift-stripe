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

/// Operations on Stripe.Treasury.ReceivedDebit.
///
/// A protocol so tests can substitute a double; ``TreasuryReceivedDebitsClient`` is the implementation that
/// talks to Stripe.
public protocol TreasuryReceivedDebitsAPI: Sendable {
    func create(
        _ request: Stripe.Treasury.ReceivedDebit.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.ReceivedDebit.Create.Response
    func list(_ request: Stripe.Treasury.ReceivedDebit.List.Request) async throws -> Stripe.Treasury.ReceivedDebit.List.Response
    func retrieve(
        id: Stripe.Treasury.ReceivedDebit.ID,
        _ request: Stripe.Treasury.ReceivedDebit.Retrieve.Request
    ) async throws -> Stripe.Treasury.ReceivedDebit.Retrieve.Response
}

public struct TreasuryReceivedDebitsClient: TreasuryReceivedDebitsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Treasury.ReceivedDebit.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.ReceivedDebit.Create.Response {
        try await api.send(.POST, "v1/test_helpers/treasury/received_debits", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Treasury.ReceivedDebit.List.Request) async throws -> Stripe.Treasury.ReceivedDebit.List.Response {
        try await api.list("v1/treasury/received_debits", parameters: request)
    }

    public func retrieve(
        id: Stripe.Treasury.ReceivedDebit.ID,
        _ request: Stripe.Treasury.ReceivedDebit.Retrieve.Request
    ) async throws -> Stripe.Treasury.ReceivedDebit.Retrieve.Response {
        try await api.list("v1/treasury/received_debits/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TreasuryReceivedDebitsAPI {
    public func create(_ request: Stripe.Treasury.ReceivedDebit.Create.Request) async throws -> Stripe.Treasury.ReceivedDebit.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func retrieve(id: Stripe.Treasury.ReceivedDebit.ID) async throws -> Stripe.Treasury.ReceivedDebit.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
