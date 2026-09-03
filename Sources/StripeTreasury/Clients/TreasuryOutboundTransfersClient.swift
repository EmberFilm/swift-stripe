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

/// Operations on Stripe.Treasury.OutboundTransfer.
///
/// A protocol so tests can substitute a double; ``TreasuryOutboundTransfersClient`` is the implementation that
/// talks to Stripe.
public protocol TreasuryOutboundTransfersAPI: Sendable {
    func cancel(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.Cancel.Response
    func create(
        _ request: Stripe.Treasury.OutboundTransfer.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.Create.Response
    func fail(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Fail.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.Fail.Response
    func list(_ request: Stripe.Treasury.OutboundTransfer.List.Request) async throws -> Stripe.Treasury.OutboundTransfer.List.Response
    func post(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Post.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.Post.Response
    func retrieve(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Retrieve.Request
    ) async throws -> Stripe.Treasury.OutboundTransfer.Retrieve.Response
    func returnOutboundTransfer(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.ReturnOutboundTransfer.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.ReturnOutboundTransfer.Response
    func update(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.Update.Response
}

public struct TreasuryOutboundTransfersClient: TreasuryOutboundTransfersAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func cancel(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.Cancel.Response {
        try await api.send(.POST, "v1/treasury/outbound_transfers/\(id)/cancel", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(
        _ request: Stripe.Treasury.OutboundTransfer.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.Create.Response {
        try await api.send(.POST, "v1/treasury/outbound_transfers", body: request, idempotencyKey: idempotencyKey)
    }

    public func fail(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Fail.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.Fail.Response {
        try await api.send(.POST, "v1/test_helpers/treasury/outbound_transfers/\(id)/fail", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Treasury.OutboundTransfer.List.Request) async throws -> Stripe.Treasury.OutboundTransfer.List.Response {
        try await api.list("v1/treasury/outbound_transfers", parameters: request)
    }

    public func post(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Post.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.Post.Response {
        try await api.send(.POST, "v1/test_helpers/treasury/outbound_transfers/\(id)/post", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Retrieve.Request
    ) async throws -> Stripe.Treasury.OutboundTransfer.Retrieve.Response {
        try await api.list("v1/treasury/outbound_transfers/\(id)", parameters: request)
    }

    public func returnOutboundTransfer(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.ReturnOutboundTransfer.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.ReturnOutboundTransfer.Response {
        try await api.send(.POST, "v1/test_helpers/treasury/outbound_transfers/\(id)/return", body: request, idempotencyKey: idempotencyKey)
    }

    public func update(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Treasury.OutboundTransfer.Update.Response {
        try await api.send(.POST, "v1/test_helpers/treasury/outbound_transfers/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TreasuryOutboundTransfersAPI {
    public func cancel(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Cancel.Request
    ) async throws -> Stripe.Treasury.OutboundTransfer.Cancel.Response {
        try await cancel(id: id, request, idempotencyKey: nil)
    }

    public func cancel(
        id: Stripe.Treasury.OutboundTransfer.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Treasury.OutboundTransfer.Cancel.Response {
        try await cancel(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func create(_ request: Stripe.Treasury.OutboundTransfer.Create.Request) async throws -> Stripe.Treasury.OutboundTransfer.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func fail(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Fail.Request
    ) async throws -> Stripe.Treasury.OutboundTransfer.Fail.Response {
        try await fail(id: id, request, idempotencyKey: nil)
    }

    public func fail(
        id: Stripe.Treasury.OutboundTransfer.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Treasury.OutboundTransfer.Fail.Response {
        try await fail(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func post(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Post.Request
    ) async throws -> Stripe.Treasury.OutboundTransfer.Post.Response {
        try await post(id: id, request, idempotencyKey: nil)
    }

    public func post(
        id: Stripe.Treasury.OutboundTransfer.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Treasury.OutboundTransfer.Post.Response {
        try await post(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func retrieve(id: Stripe.Treasury.OutboundTransfer.ID) async throws -> Stripe.Treasury.OutboundTransfer.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func returnOutboundTransfer(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.ReturnOutboundTransfer.Request
    ) async throws -> Stripe.Treasury.OutboundTransfer.ReturnOutboundTransfer.Response {
        try await returnOutboundTransfer(id: id, request, idempotencyKey: nil)
    }

    public func returnOutboundTransfer(
        id: Stripe.Treasury.OutboundTransfer.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Treasury.OutboundTransfer.ReturnOutboundTransfer.Response {
        try await returnOutboundTransfer(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func update(
        id: Stripe.Treasury.OutboundTransfer.ID,
        _ request: Stripe.Treasury.OutboundTransfer.Update.Request
    ) async throws -> Stripe.Treasury.OutboundTransfer.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }
}
