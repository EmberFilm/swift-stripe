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

/// Operations on VerificationSession.
///
/// A protocol so tests can substitute a double; ``IdentityVerificationSessionsClient`` is the implementation that
/// talks to Stripe.
public protocol IdentityVerificationSessionsAPI: Sendable {
    func cancel(
        id: VerificationSession.ID,
        _ request: VerificationSession.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> VerificationSession.Cancel.Response
    func create(_ request: VerificationSession.Create.Request, idempotencyKey: String?) async throws -> VerificationSession.Create.Response
    func list(_ request: VerificationSession.List.Request) async throws -> VerificationSession.List.Response
    func redact(
        id: VerificationSession.ID,
        _ request: VerificationSession.Redact.Request,
        idempotencyKey: String?
    ) async throws -> VerificationSession.Redact.Response
    func retrieve(id: VerificationSession.ID, _ request: VerificationSession.Retrieve.Request) async throws -> VerificationSession.Retrieve.Response
    func update(
        id: VerificationSession.ID,
        _ request: VerificationSession.Update.Request,
        idempotencyKey: String?
    ) async throws -> VerificationSession.Update.Response
}

public struct IdentityVerificationSessionsClient: IdentityVerificationSessionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func cancel(
        id: VerificationSession.ID,
        _ request: VerificationSession.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> VerificationSession.Cancel.Response {
        try await api.send(.POST, "v1/identity/verification_sessions/\(id)/cancel", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(_ request: VerificationSession.Create.Request, idempotencyKey: String?) async throws -> VerificationSession.Create.Response {
        try await api.send(.POST, "v1/identity/verification_sessions", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: VerificationSession.List.Request) async throws -> VerificationSession.List.Response {
        try await api.list("v1/identity/verification_sessions", parameters: request)
    }

    public func redact(
        id: VerificationSession.ID,
        _ request: VerificationSession.Redact.Request,
        idempotencyKey: String?
    ) async throws -> VerificationSession.Redact.Response {
        try await api.send(.POST, "v1/identity/verification_sessions/\(id)/redact", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: VerificationSession.ID,
        _ request: VerificationSession.Retrieve.Request
    ) async throws -> VerificationSession.Retrieve.Response {
        try await api.list("v1/identity/verification_sessions/\(id)", parameters: request)
    }

    public func update(
        id: VerificationSession.ID,
        _ request: VerificationSession.Update.Request,
        idempotencyKey: String?
    ) async throws -> VerificationSession.Update.Response {
        try await api.send(.POST, "v1/identity/verification_sessions/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension IdentityVerificationSessionsAPI {
    public func cancel(id: VerificationSession.ID, _ request: VerificationSession.Cancel.Request) async throws -> VerificationSession.Cancel.Response
    {
        try await cancel(id: id, request, idempotencyKey: nil)
    }

    public func cancel(id: VerificationSession.ID, idempotencyKey: String? = nil) async throws -> VerificationSession.Cancel.Response {
        try await cancel(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func create(_ request: VerificationSession.Create.Request) async throws -> VerificationSession.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> VerificationSession.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> VerificationSession.List.Response {
        try await list(.init())
    }

    public func redact(id: VerificationSession.ID, _ request: VerificationSession.Redact.Request) async throws -> VerificationSession.Redact.Response
    {
        try await redact(id: id, request, idempotencyKey: nil)
    }

    public func redact(id: VerificationSession.ID, idempotencyKey: String? = nil) async throws -> VerificationSession.Redact.Response {
        try await redact(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func retrieve(id: VerificationSession.ID) async throws -> VerificationSession.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(id: VerificationSession.ID, _ request: VerificationSession.Update.Request) async throws -> VerificationSession.Update.Response
    {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: VerificationSession.ID, idempotencyKey: String? = nil) async throws -> VerificationSession.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
