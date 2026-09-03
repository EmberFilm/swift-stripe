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

/// Operations on TerminalConfiguration.
///
/// A protocol so tests can substitute a double; ``TerminalConfigurationsClient`` is the implementation that
/// talks to Stripe.
public protocol TerminalConfigurationsAPI: Sendable {
    func create(_ request: TerminalConfiguration.Create.Request, idempotencyKey: String?) async throws -> TerminalConfiguration.Create.Response
    func delete(id: TerminalConfiguration.ID, idempotencyKey: String?) async throws -> TerminalConfiguration.Delete.Response
    func list(_ request: TerminalConfiguration.List.Request) async throws -> TerminalConfiguration.List.Response
    func retrieve(
        id: TerminalConfiguration.ID,
        _ request: TerminalConfiguration.Retrieve.Request
    ) async throws -> TerminalConfiguration.Retrieve.Response
    func update(
        id: TerminalConfiguration.ID,
        _ request: TerminalConfiguration.Update.Request,
        idempotencyKey: String?
    ) async throws -> TerminalConfiguration.Update.Response
}

public struct TerminalConfigurationsClient: TerminalConfigurationsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(_ request: TerminalConfiguration.Create.Request, idempotencyKey: String?) async throws -> TerminalConfiguration.Create.Response
    {
        try await api.send(.POST, "v1/terminal/configurations", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(id: TerminalConfiguration.ID, idempotencyKey: String?) async throws -> TerminalConfiguration.Delete.Response {
        try await api.send(.DELETE, "v1/terminal/configurations/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(_ request: TerminalConfiguration.List.Request) async throws -> TerminalConfiguration.List.Response {
        try await api.list("v1/terminal/configurations", parameters: request)
    }

    public func retrieve(
        id: TerminalConfiguration.ID,
        _ request: TerminalConfiguration.Retrieve.Request
    ) async throws -> TerminalConfiguration.Retrieve.Response {
        try await api.list("v1/terminal/configurations/\(id)", parameters: request)
    }

    public func update(
        id: TerminalConfiguration.ID,
        _ request: TerminalConfiguration.Update.Request,
        idempotencyKey: String?
    ) async throws -> TerminalConfiguration.Update.Response {
        try await api.send(.POST, "v1/terminal/configurations/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TerminalConfigurationsAPI {
    public func create(_ request: TerminalConfiguration.Create.Request) async throws -> TerminalConfiguration.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> TerminalConfiguration.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func delete(id: TerminalConfiguration.ID) async throws -> TerminalConfiguration.Delete.Response {
        try await delete(id: id, idempotencyKey: nil)
    }

    public func list() async throws -> TerminalConfiguration.List.Response {
        try await list(.init())
    }

    public func retrieve(id: TerminalConfiguration.ID) async throws -> TerminalConfiguration.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: TerminalConfiguration.ID,
        _ request: TerminalConfiguration.Update.Request
    ) async throws -> TerminalConfiguration.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: TerminalConfiguration.ID, idempotencyKey: String? = nil) async throws -> TerminalConfiguration.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
