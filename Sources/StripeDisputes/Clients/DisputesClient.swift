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
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Disputes.Dispute.
///
/// A protocol so tests can substitute a double; ``DisputesClient`` is the implementation that
/// talks to Stripe.
public protocol DisputesAPI: Sendable {
    func close(
        id: Stripe.Disputes.Dispute.ID,
        _ request: Stripe.Disputes.Dispute.Close.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Disputes.Dispute.Close.Response
    func list(_ request: Stripe.Disputes.Dispute.List.Request) async throws -> Stripe.Disputes.Dispute.List.Response
    func retrieve(
        id: Stripe.Disputes.Dispute.ID,
        _ request: Stripe.Disputes.Dispute.Retrieve.Request
    ) async throws -> Stripe.Disputes.Dispute.Retrieve.Response
    func update(
        id: Stripe.Disputes.Dispute.ID,
        _ request: Stripe.Disputes.Dispute.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Disputes.Dispute.Update.Response
}

public struct DisputesClient: DisputesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func close(
        id: Stripe.Disputes.Dispute.ID,
        _ request: Stripe.Disputes.Dispute.Close.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Disputes.Dispute.Close.Response {
        try await api.send(.POST, "v1/disputes/\(id)/close", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Disputes.Dispute.List.Request) async throws -> Stripe.Disputes.Dispute.List.Response {
        try await api.list("v1/disputes", parameters: request)
    }

    public func retrieve(
        id: Stripe.Disputes.Dispute.ID,
        _ request: Stripe.Disputes.Dispute.Retrieve.Request
    ) async throws -> Stripe.Disputes.Dispute.Retrieve.Response {
        try await api.list("v1/disputes/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Disputes.Dispute.ID,
        _ request: Stripe.Disputes.Dispute.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Disputes.Dispute.Update.Response {
        try await api.send(.POST, "v1/disputes/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension DisputesAPI {
    public func close(
        id: Stripe.Disputes.Dispute.ID,
        _ request: Stripe.Disputes.Dispute.Close.Request
    ) async throws -> Stripe.Disputes.Dispute.Close.Response {
        try await close(id: id, request, idempotencyKey: nil)
    }

    public func close(id: Stripe.Disputes.Dispute.ID, idempotencyKey: String? = nil) async throws -> Stripe.Disputes.Dispute.Close.Response {
        try await close(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> Stripe.Disputes.Dispute.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Disputes.Dispute.ID) async throws -> Stripe.Disputes.Dispute.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Disputes.Dispute.ID,
        _ request: Stripe.Disputes.Dispute.Update.Request
    ) async throws -> Stripe.Disputes.Dispute.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Disputes.Dispute.ID, idempotencyKey: String? = nil) async throws -> Stripe.Disputes.Dispute.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
