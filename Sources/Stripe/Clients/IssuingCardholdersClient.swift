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

/// Operations on Cardholder.
///
/// A protocol so tests can substitute a double; ``IssuingCardholdersClient`` is the implementation that
/// talks to Stripe.
public protocol IssuingCardholdersAPI: Sendable {
    func create(_ request: Cardholder.Create.Request, idempotencyKey: String?) async throws -> Cardholder.Create.Response
    func list(_ request: Cardholder.List.Request) async throws -> Cardholder.List.Response
    func retrieve(id: Cardholder.ID, _ request: Cardholder.Retrieve.Request) async throws -> Cardholder.Retrieve.Response
    func update(id: Cardholder.ID, _ request: Cardholder.Update.Request, idempotencyKey: String?) async throws -> Cardholder.Update.Response
}

public struct IssuingCardholdersClient: IssuingCardholdersAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(_ request: Cardholder.Create.Request, idempotencyKey: String?) async throws -> Cardholder.Create.Response {
        try await api.send(.POST, "v1/issuing/cardholders", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Cardholder.List.Request) async throws -> Cardholder.List.Response {
        try await api.list("v1/issuing/cardholders", parameters: request)
    }

    public func retrieve(id: Cardholder.ID, _ request: Cardholder.Retrieve.Request) async throws -> Cardholder.Retrieve.Response {
        try await api.list("v1/issuing/cardholders/\(id)", parameters: request)
    }

    public func update(id: Cardholder.ID, _ request: Cardholder.Update.Request, idempotencyKey: String?) async throws -> Cardholder.Update.Response {
        try await api.send(.POST, "v1/issuing/cardholders/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension IssuingCardholdersAPI {
    public func create(_ request: Cardholder.Create.Request) async throws -> Cardholder.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Cardholder.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Cardholder.ID) async throws -> Cardholder.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(id: Cardholder.ID, _ request: Cardholder.Update.Request) async throws -> Cardholder.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Cardholder.ID, idempotencyKey: String? = nil) async throws -> Cardholder.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
