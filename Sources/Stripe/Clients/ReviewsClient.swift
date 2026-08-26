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

/// Operations on Stripe.Fraud.Reviews.Review.
///
/// A protocol so tests can substitute a double; ``ReviewsClient`` is the implementation that
/// talks to Stripe.
public protocol ReviewsAPI: Sendable {
    func approve(
        id: Stripe.Fraud.Reviews.Review.ID,
        _ request: Stripe.Fraud.Reviews.Review.Approve.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Fraud.Reviews.Review.Approve.Response
    func list(_ request: Stripe.Fraud.Reviews.Review.List.Request) async throws -> Stripe.Fraud.Reviews.Review.List.Response
    func retrieve(
        id: Stripe.Fraud.Reviews.Review.ID,
        _ request: Stripe.Fraud.Reviews.Review.Retrieve.Request
    ) async throws -> Stripe.Fraud.Reviews.Review.Retrieve.Response
}

public struct ReviewsClient: ReviewsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func approve(
        id: Stripe.Fraud.Reviews.Review.ID,
        _ request: Stripe.Fraud.Reviews.Review.Approve.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Fraud.Reviews.Review.Approve.Response {
        try await api.send(.POST, "v1/reviews/\(id)/approve", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Fraud.Reviews.Review.List.Request) async throws -> Stripe.Fraud.Reviews.Review.List.Response {
        try await api.list("v1/reviews", parameters: request)
    }

    public func retrieve(
        id: Stripe.Fraud.Reviews.Review.ID,
        _ request: Stripe.Fraud.Reviews.Review.Retrieve.Request
    ) async throws -> Stripe.Fraud.Reviews.Review.Retrieve.Response {
        try await api.list("v1/reviews/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ReviewsAPI {
    public func approve(
        id: Stripe.Fraud.Reviews.Review.ID,
        _ request: Stripe.Fraud.Reviews.Review.Approve.Request
    ) async throws -> Stripe.Fraud.Reviews.Review.Approve.Response {
        try await approve(id: id, request, idempotencyKey: nil)
    }

    public func approve(
        id: Stripe.Fraud.Reviews.Review.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Fraud.Reviews.Review.Approve.Response {
        try await approve(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> Stripe.Fraud.Reviews.Review.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Fraud.Reviews.Review.ID) async throws -> Stripe.Fraud.Reviews.Review.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
