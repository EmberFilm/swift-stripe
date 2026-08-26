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

/// Operations on Stripe.Connect.Account.
///
/// A protocol so tests can substitute a double; ``AccountsClient`` is the implementation that
/// talks to Stripe.
public protocol AccountsAPI: Sendable {
    func create(_ request: Stripe.Connect.Account.Create.Request, idempotencyKey: String?) async throws -> Stripe.Connect.Account.Create.Response
    func delete(id: Stripe.Connect.Account.ID, idempotencyKey: String?) async throws -> Stripe.Connect.Account.Delete.Response
    func list(_ request: Stripe.Connect.Account.List.Request) async throws -> Stripe.Connect.Account.List.Response
    func reject(
        id: Stripe.Connect.Account.ID,
        _ request: Stripe.Connect.Account.Reject.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Account.Reject.Response
    func retrieve(
        id: Stripe.Connect.Account.ID,
        _ request: Stripe.Connect.Account.Retrieve.Request
    ) async throws -> Stripe.Connect.Account.Retrieve.Response
    func retrieveCurrent(_ request: Stripe.Connect.Account.RetrieveCurrent.Request) async throws -> Stripe.Connect.Account.RetrieveCurrent.Response
    func unreject(
        id: Stripe.Connect.Account.ID,
        _ request: Stripe.Connect.Account.Unreject.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Account.Unreject.Response
    func update(
        id: Stripe.Connect.Account.ID,
        _ request: Stripe.Connect.Account.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Account.Update.Response
}

public struct AccountsClient: AccountsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Connect.Account.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Account.Create.Response {
        try await api.send(.POST, "v1/accounts", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(id: Stripe.Connect.Account.ID, idempotencyKey: String?) async throws -> Stripe.Connect.Account.Delete.Response {
        try await api.send(.DELETE, "v1/accounts/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Connect.Account.List.Request) async throws -> Stripe.Connect.Account.List.Response {
        try await api.list("v1/accounts", parameters: request)
    }

    public func reject(
        id: Stripe.Connect.Account.ID,
        _ request: Stripe.Connect.Account.Reject.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Account.Reject.Response {
        try await api.send(.POST, "v1/accounts/\(id)/reject", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: Stripe.Connect.Account.ID,
        _ request: Stripe.Connect.Account.Retrieve.Request
    ) async throws -> Stripe.Connect.Account.Retrieve.Response {
        try await api.list("v1/accounts/\(id)", parameters: request)
    }

    public func retrieveCurrent(
        _ request: Stripe.Connect.Account.RetrieveCurrent.Request
    ) async throws -> Stripe.Connect.Account.RetrieveCurrent.Response {
        try await api.list("v1/account", parameters: request)
    }

    public func unreject(
        id: Stripe.Connect.Account.ID,
        _ request: Stripe.Connect.Account.Unreject.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Account.Unreject.Response {
        try await api.send(.POST, "v1/accounts/\(id)/unreject", body: request, idempotencyKey: idempotencyKey)
    }

    public func update(
        id: Stripe.Connect.Account.ID,
        _ request: Stripe.Connect.Account.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Account.Update.Response {
        try await api.send(.POST, "v1/accounts/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension AccountsAPI {
    public func create(_ request: Stripe.Connect.Account.Create.Request) async throws -> Stripe.Connect.Account.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.Connect.Account.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func delete(id: Stripe.Connect.Account.ID) async throws -> Stripe.Connect.Account.Delete.Response {
        try await delete(id: id, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Connect.Account.List.Response {
        try await list(.init())
    }

    public func reject(
        id: Stripe.Connect.Account.ID,
        _ request: Stripe.Connect.Account.Reject.Request
    ) async throws -> Stripe.Connect.Account.Reject.Response {
        try await reject(id: id, request, idempotencyKey: nil)
    }

    public func retrieve(id: Stripe.Connect.Account.ID) async throws -> Stripe.Connect.Account.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func retrieveCurrent() async throws -> Stripe.Connect.Account.RetrieveCurrent.Response {
        try await retrieveCurrent(.init())
    }

    public func unreject(
        id: Stripe.Connect.Account.ID,
        _ request: Stripe.Connect.Account.Unreject.Request
    ) async throws -> Stripe.Connect.Account.Unreject.Response {
        try await unreject(id: id, request, idempotencyKey: nil)
    }

    public func unreject(id: Stripe.Connect.Account.ID, idempotencyKey: String? = nil) async throws -> Stripe.Connect.Account.Unreject.Response {
        try await unreject(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func update(
        id: Stripe.Connect.Account.ID,
        _ request: Stripe.Connect.Account.Update.Request
    ) async throws -> Stripe.Connect.Account.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Connect.Account.ID, idempotencyKey: String? = nil) async throws -> Stripe.Connect.Account.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
