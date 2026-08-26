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

/// Operations on Stripe.PaymentAttemptRecord.
///
/// A protocol so tests can substitute a double; ``PaymentAttemptRecordsClient`` is the implementation that
/// talks to Stripe.
public protocol PaymentAttemptRecordsAPI: Sendable {
    func list(_ request: Stripe.PaymentAttemptRecord.List.Request) async throws -> Stripe.PaymentAttemptRecord.List.Response
    func retrieve(
        id: Stripe.PaymentAttemptRecord.ID,
        _ request: Stripe.PaymentAttemptRecord.Retrieve.Request
    ) async throws -> Stripe.PaymentAttemptRecord.Retrieve.Response
}

public struct PaymentAttemptRecordsClient: PaymentAttemptRecordsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.PaymentAttemptRecord.List.Request) async throws -> Stripe.PaymentAttemptRecord.List.Response {
        try await api.list("v1/payment_attempt_records", parameters: request)
    }

    public func retrieve(
        id: Stripe.PaymentAttemptRecord.ID,
        _ request: Stripe.PaymentAttemptRecord.Retrieve.Request
    ) async throws -> Stripe.PaymentAttemptRecord.Retrieve.Response {
        try await api.list("v1/payment_attempt_records/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PaymentAttemptRecordsAPI {
    public func retrieve(id: Stripe.PaymentAttemptRecord.ID) async throws -> Stripe.PaymentAttemptRecord.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
