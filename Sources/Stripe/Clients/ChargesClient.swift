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

/// Operations on Stripe.Charges.Charge.
///
/// A protocol so tests can substitute a double; ``ChargesClient`` is the implementation that
/// talks to Stripe.
public protocol ChargesAPI: Sendable {
    func capture(
        id: Stripe.Charges.Charge.ID,
        _ request: Stripe.Charges.Charge.Capture.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Charges.Charge.Capture.Response
    func create(_ request: Stripe.Charges.Charge.Create.Request, idempotencyKey: String?) async throws -> Stripe.Charges.Charge.Create.Response
    func list(_ request: Stripe.Charges.Charge.List.Request) async throws -> Stripe.Charges.Charge.List.Response
    func retrieve(
        id: Stripe.Charges.Charge.ID,
        _ request: Stripe.Charges.Charge.Retrieve.Request
    ) async throws -> Stripe.Charges.Charge.Retrieve.Response
    func search(_ request: Stripe.Charges.Charge.Search.Request) async throws -> Stripe.Charges.Charge.Search.Response
    func update(
        id: Stripe.Charges.Charge.ID,
        _ request: Stripe.Charges.Charge.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Charges.Charge.Update.Response
}

public struct ChargesClient: ChargesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func capture(
        id: Stripe.Charges.Charge.ID,
        _ request: Stripe.Charges.Charge.Capture.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Charges.Charge.Capture.Response {
        try await api.send(.POST, "v1/charges/\(id)/capture", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(_ request: Stripe.Charges.Charge.Create.Request, idempotencyKey: String?) async throws -> Stripe.Charges.Charge.Create.Response
    {
        try await api.send(.POST, "v1/charges", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Charges.Charge.List.Request) async throws -> Stripe.Charges.Charge.List.Response {
        try await api.list("v1/charges", parameters: request)
    }

    public func retrieve(
        id: Stripe.Charges.Charge.ID,
        _ request: Stripe.Charges.Charge.Retrieve.Request
    ) async throws -> Stripe.Charges.Charge.Retrieve.Response {
        try await api.list("v1/charges/\(id)", parameters: request)
    }

    public func search(_ request: Stripe.Charges.Charge.Search.Request) async throws -> Stripe.Charges.Charge.Search.Response {
        try await api.list("v1/charges/search", parameters: request)
    }

    public func update(
        id: Stripe.Charges.Charge.ID,
        _ request: Stripe.Charges.Charge.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Charges.Charge.Update.Response {
        try await api.send(.POST, "v1/charges/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ChargesAPI {
    public func capture(
        id: Stripe.Charges.Charge.ID,
        _ request: Stripe.Charges.Charge.Capture.Request
    ) async throws -> Stripe.Charges.Charge.Capture.Response {
        try await capture(id: id, request, idempotencyKey: nil)
    }

    public func capture(id: Stripe.Charges.Charge.ID, idempotencyKey: String? = nil) async throws -> Stripe.Charges.Charge.Capture.Response {
        try await capture(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func create(_ request: Stripe.Charges.Charge.Create.Request) async throws -> Stripe.Charges.Charge.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.Charges.Charge.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> Stripe.Charges.Charge.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Charges.Charge.ID) async throws -> Stripe.Charges.Charge.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Charges.Charge.ID,
        _ request: Stripe.Charges.Charge.Update.Request
    ) async throws -> Stripe.Charges.Charge.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Charges.Charge.ID, idempotencyKey: String? = nil) async throws -> Stripe.Charges.Charge.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
