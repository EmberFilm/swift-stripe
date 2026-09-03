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

/// Operations on Stripe.Connect.Application.Fee.Refund.
///
/// A protocol so tests can substitute a double; ``FeeRefundsClient`` is the implementation that
/// talks to Stripe.
public protocol FeeRefundsAPI: Sendable {
    func create(
        id: Stripe.Connect.Application.Fee.Refund.ID,
        _ request: Stripe.Connect.Application.Fee.Refund.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Application.Fee.Refund.Create.Response
    func list(
        id: Stripe.Connect.Application.Fee.Refund.ID,
        _ request: Stripe.Connect.Application.Fee.Refund.List.Request
    ) async throws -> Stripe.Connect.Application.Fee.Refund.List.Response
    func retrieve(
        fee: String,
        id: String,
        _ request: Stripe.Connect.Application.Fee.Refund.Retrieve.Request
    ) async throws -> Stripe.Connect.Application.Fee.Refund.Retrieve.Response
    func update(
        fee: String,
        id: String,
        _ request: Stripe.Connect.Application.Fee.Refund.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Application.Fee.Refund.Update.Response
}

public struct FeeRefundsClient: FeeRefundsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        id: Stripe.Connect.Application.Fee.Refund.ID,
        _ request: Stripe.Connect.Application.Fee.Refund.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Application.Fee.Refund.Create.Response {
        try await api.send(.POST, "v1/application_fees/\(id)/refunds", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(
        id: Stripe.Connect.Application.Fee.Refund.ID,
        _ request: Stripe.Connect.Application.Fee.Refund.List.Request
    ) async throws -> Stripe.Connect.Application.Fee.Refund.List.Response {
        try await api.list("v1/application_fees/\(id)/refunds", parameters: request)
    }

    public func retrieve(
        fee: String,
        id: String,
        _ request: Stripe.Connect.Application.Fee.Refund.Retrieve.Request
    ) async throws -> Stripe.Connect.Application.Fee.Refund.Retrieve.Response {
        try await api.list("v1/application_fees/\(fee)/refunds/\(id)", parameters: request)
    }

    public func update(
        fee: String,
        id: String,
        _ request: Stripe.Connect.Application.Fee.Refund.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Application.Fee.Refund.Update.Response {
        try await api.send(.POST, "v1/application_fees/\(fee)/refunds/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension FeeRefundsAPI {
    public func create(
        id: Stripe.Connect.Application.Fee.Refund.ID,
        _ request: Stripe.Connect.Application.Fee.Refund.Create.Request
    ) async throws -> Stripe.Connect.Application.Fee.Refund.Create.Response {
        try await create(id: id, request, idempotencyKey: nil)
    }

    public func create(
        id: Stripe.Connect.Application.Fee.Refund.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Connect.Application.Fee.Refund.Create.Response {
        try await create(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func list(id: Stripe.Connect.Application.Fee.Refund.ID) async throws -> Stripe.Connect.Application.Fee.Refund.List.Response {
        try await list(id: id, .init())
    }

    public func retrieve(fee: String, id: String) async throws -> Stripe.Connect.Application.Fee.Refund.Retrieve.Response {
        try await retrieve(fee: fee, id: id, .init())
    }

    public func update(
        fee: String,
        id: String,
        _ request: Stripe.Connect.Application.Fee.Refund.Update.Request
    ) async throws -> Stripe.Connect.Application.Fee.Refund.Update.Response {
        try await update(fee: fee, id: id, request, idempotencyKey: nil)
    }

    public func update(fee: String, id: String, idempotencyKey: String? = nil) async throws -> Stripe.Connect.Application.Fee.Refund.Update.Response {
        try await update(fee: fee, id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
