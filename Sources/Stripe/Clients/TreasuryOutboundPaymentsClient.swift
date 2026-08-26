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

/// Operations on Stripe.Treasury.OutboundPayment.
///
/// A protocol so tests can substitute a double; ``TreasuryOutboundPaymentsClient`` is the implementation that
/// talks to Stripe.
public protocol TreasuryOutboundPaymentsAPI: Sendable {
    func cancel(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.Cancel.Response
    func create(
        _ request: Stripe.Treasury.OutboundPayment.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.Create.Response
    func fail(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Fail.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.Fail.Response
    func list(_ request: Stripe.Treasury.OutboundPayment.List.Request) async throws -> Stripe.Treasury.OutboundPayment.List.Response
    func post(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Post.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.Post.Response
    func retrieve(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Retrieve.Request
    ) async throws -> Stripe.Treasury.OutboundPayment.Retrieve.Response
    func returnOutboundPayment(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.ReturnOutboundPayment.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.ReturnOutboundPayment.Response
    func update(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.Update.Response
}

public struct TreasuryOutboundPaymentsClient: TreasuryOutboundPaymentsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func cancel(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.Cancel.Response {
        try await api.send(.POST, "v1/treasury/outbound_payments/\(id)/cancel", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(
        _ request: Stripe.Treasury.OutboundPayment.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.Create.Response {
        try await api.send(.POST, "v1/treasury/outbound_payments", body: request, idempotencyKey: idempotencyKey)
    }

    public func fail(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Fail.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.Fail.Response {
        try await api.send(.POST, "v1/test_helpers/treasury/outbound_payments/\(id)/fail", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Treasury.OutboundPayment.List.Request) async throws -> Stripe.Treasury.OutboundPayment.List.Response {
        try await api.list("v1/treasury/outbound_payments", parameters: request)
    }

    public func post(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Post.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.Post.Response {
        try await api.send(.POST, "v1/test_helpers/treasury/outbound_payments/\(id)/post", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Retrieve.Request
    ) async throws -> Stripe.Treasury.OutboundPayment.Retrieve.Response {
        try await api.list("v1/treasury/outbound_payments/\(id)", parameters: request)
    }

    public func returnOutboundPayment(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.ReturnOutboundPayment.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.ReturnOutboundPayment.Response {
        try await api.send(.POST, "v1/test_helpers/treasury/outbound_payments/\(id)/return", body: request, idempotencyKey: idempotencyKey)
    }

    public func update(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundPayment.Update.Response {
        try await api.send(.POST, "v1/test_helpers/treasury/outbound_payments/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TreasuryOutboundPaymentsAPI {
    public func cancel(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Cancel.Request
    ) async throws -> Stripe.Treasury.OutboundPayment.Cancel.Response {
        try await cancel(id: id, request, idempotencyKey: nil)
    }

    public func cancel(
        id: Stripe.Treasury.OutboundPayment.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Treasury.OutboundPayment.Cancel.Response {
        try await cancel(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func create(_ request: Stripe.Treasury.OutboundPayment.Create.Request) async throws -> Stripe.Treasury.OutboundPayment.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func fail(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Fail.Request
    ) async throws -> Stripe.Treasury.OutboundPayment.Fail.Response {
        try await fail(id: id, request, idempotencyKey: nil)
    }

    public func fail(
        id: Stripe.Treasury.OutboundPayment.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Treasury.OutboundPayment.Fail.Response {
        try await fail(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func post(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Post.Request
    ) async throws -> Stripe.Treasury.OutboundPayment.Post.Response {
        try await post(id: id, request, idempotencyKey: nil)
    }

    public func post(
        id: Stripe.Treasury.OutboundPayment.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Treasury.OutboundPayment.Post.Response {
        try await post(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func retrieve(id: Stripe.Treasury.OutboundPayment.ID) async throws -> Stripe.Treasury.OutboundPayment.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func returnOutboundPayment(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.ReturnOutboundPayment.Request
    ) async throws -> Stripe.Treasury.OutboundPayment.ReturnOutboundPayment.Response {
        try await returnOutboundPayment(id: id, request, idempotencyKey: nil)
    }

    public func returnOutboundPayment(
        id: Stripe.Treasury.OutboundPayment.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Treasury.OutboundPayment.ReturnOutboundPayment.Response {
        try await returnOutboundPayment(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func update(
        id: Stripe.Treasury.OutboundPayment.ID,
        _ request: Stripe.Treasury.OutboundPayment.Update.Request
    ) async throws -> Stripe.Treasury.OutboundPayment.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }
}
