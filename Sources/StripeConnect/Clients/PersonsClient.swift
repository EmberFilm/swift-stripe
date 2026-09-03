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

/// Operations on Stripe.Connect.Person.
///
/// A protocol so tests can substitute a double; ``PersonsClient`` is the implementation that
/// talks to Stripe.
public protocol PersonsAPI: Sendable {
    func create(
        account: String,
        _ request: Stripe.Connect.Person.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Person.Create.Response
    func delete(account: String, person: Stripe.Connect.Person.ID, idempotencyKey: String?) async throws -> Stripe.Connect.Person.Delete.Response
    func list(account: String, _ request: Stripe.Connect.Person.List.Request) async throws -> Stripe.Connect.Person.List.Response
    func retrieve(
        account: String,
        person: Stripe.Connect.Person.ID,
        _ request: Stripe.Connect.Person.Retrieve.Request
    ) async throws -> Stripe.Connect.Person.Retrieve.Response
    func update(
        account: String,
        person: Stripe.Connect.Person.ID,
        _ request: Stripe.Connect.Person.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Person.Update.Response
}

public struct PersonsClient: PersonsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        account: String,
        _ request: Stripe.Connect.Person.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Person.Create.Response {
        try await api.send(.POST, "v1/accounts/\(account)/persons", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(
        account: String,
        person: Stripe.Connect.Person.ID,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Person.Delete.Response {
        try await api.send(.DELETE, "v1/accounts/\(account)/persons/\(person)", idempotencyKey: idempotencyKey)
    }

    public func list(account: String, _ request: Stripe.Connect.Person.List.Request) async throws -> Stripe.Connect.Person.List.Response {
        try await api.list("v1/accounts/\(account)/persons", parameters: request)
    }

    public func retrieve(
        account: String,
        person: Stripe.Connect.Person.ID,
        _ request: Stripe.Connect.Person.Retrieve.Request
    ) async throws -> Stripe.Connect.Person.Retrieve.Response {
        try await api.list("v1/accounts/\(account)/persons/\(person)", parameters: request)
    }

    public func update(
        account: String,
        person: Stripe.Connect.Person.ID,
        _ request: Stripe.Connect.Person.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Person.Update.Response {
        try await api.send(.POST, "v1/accounts/\(account)/persons/\(person)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PersonsAPI {
    public func create(account: String, _ request: Stripe.Connect.Person.Create.Request) async throws -> Stripe.Connect.Person.Create.Response {
        try await create(account: account, request, idempotencyKey: nil)
    }

    public func create(account: String, idempotencyKey: String? = nil) async throws -> Stripe.Connect.Person.Create.Response {
        try await create(account: account, .init(), idempotencyKey: idempotencyKey)
    }

    public func delete(account: String, person: Stripe.Connect.Person.ID) async throws -> Stripe.Connect.Person.Delete.Response {
        try await delete(account: account, person: person, idempotencyKey: nil)
    }

    public func list(account: String) async throws -> Stripe.Connect.Person.List.Response {
        try await list(account: account, .init())
    }

    public func retrieve(account: String, person: Stripe.Connect.Person.ID) async throws -> Stripe.Connect.Person.Retrieve.Response {
        try await retrieve(account: account, person: person, .init())
    }

    public func update(
        account: String,
        person: Stripe.Connect.Person.ID,
        _ request: Stripe.Connect.Person.Update.Request
    ) async throws -> Stripe.Connect.Person.Update.Response {
        try await update(account: account, person: person, request, idempotencyKey: nil)
    }

    public func update(
        account: String,
        person: Stripe.Connect.Person.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Connect.Person.Update.Response {
        try await update(account: account, person: person, .init(), idempotencyKey: idempotencyKey)
    }
}
