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

/// Operations on Stripe.Billing.FeedbackOption.
///
/// A protocol so tests can substitute a double; ``BillingFeedbackOptionsClient`` is the implementation that
/// talks to Stripe.
public protocol BillingFeedbackOptionsAPI: Sendable {
    func create(
        _ request: Stripe.Billing.FeedbackOption.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.FeedbackOption.Create.Response
    func deactivate(
        id: Stripe.Billing.FeedbackOption.ID,
        _ request: Stripe.Billing.FeedbackOption.Deactivate.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.FeedbackOption.Deactivate.Response
    func list(_ request: Stripe.Billing.FeedbackOption.List.Request) async throws -> Stripe.Billing.FeedbackOption.List.Response
    func retrieve(
        id: Stripe.Billing.FeedbackOption.ID,
        _ request: Stripe.Billing.FeedbackOption.Retrieve.Request
    ) async throws -> Stripe.Billing.FeedbackOption.Retrieve.Response
    func update(
        id: Stripe.Billing.FeedbackOption.ID,
        _ request: Stripe.Billing.FeedbackOption.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.FeedbackOption.Update.Response
}

public struct BillingFeedbackOptionsClient: BillingFeedbackOptionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Billing.FeedbackOption.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.FeedbackOption.Create.Response {
        try await api.send(.POST, "v1/billing/feedback_options", body: request, idempotencyKey: idempotencyKey)
    }

    public func deactivate(
        id: Stripe.Billing.FeedbackOption.ID,
        _ request: Stripe.Billing.FeedbackOption.Deactivate.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.FeedbackOption.Deactivate.Response {
        try await api.send(.POST, "v1/billing/feedback_options/\(id)/deactivate", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Billing.FeedbackOption.List.Request) async throws -> Stripe.Billing.FeedbackOption.List.Response {
        try await api.list("v1/billing/feedback_options", parameters: request)
    }

    public func retrieve(
        id: Stripe.Billing.FeedbackOption.ID,
        _ request: Stripe.Billing.FeedbackOption.Retrieve.Request
    ) async throws -> Stripe.Billing.FeedbackOption.Retrieve.Response {
        try await api.list("v1/billing/feedback_options/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Billing.FeedbackOption.ID,
        _ request: Stripe.Billing.FeedbackOption.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.FeedbackOption.Update.Response {
        try await api.send(.POST, "v1/billing/feedback_options/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension BillingFeedbackOptionsAPI {
    public func create(_ request: Stripe.Billing.FeedbackOption.Create.Request) async throws -> Stripe.Billing.FeedbackOption.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func deactivate(
        id: Stripe.Billing.FeedbackOption.ID,
        _ request: Stripe.Billing.FeedbackOption.Deactivate.Request
    ) async throws -> Stripe.Billing.FeedbackOption.Deactivate.Response {
        try await deactivate(id: id, request, idempotencyKey: nil)
    }

    public func deactivate(
        id: Stripe.Billing.FeedbackOption.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Billing.FeedbackOption.Deactivate.Response {
        try await deactivate(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> Stripe.Billing.FeedbackOption.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Billing.FeedbackOption.ID) async throws -> Stripe.Billing.FeedbackOption.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Billing.FeedbackOption.ID,
        _ request: Stripe.Billing.FeedbackOption.Update.Request
    ) async throws -> Stripe.Billing.FeedbackOption.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.Billing.FeedbackOption.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Billing.FeedbackOption.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
