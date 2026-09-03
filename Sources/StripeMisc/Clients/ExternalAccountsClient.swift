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
import StripeCheckout
import StripeCore
import StripeIssuing
import StripeModels
import StripePromotion
import StripeReporting

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.ExternalAccount.
///
/// A protocol so tests can substitute a double; ``ExternalAccountsClient`` is the implementation that
/// talks to Stripe.
public protocol ExternalAccountsAPI: Sendable {
    func create(
        account: String,
        _ request: Stripe.ExternalAccount.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.ExternalAccount.Create.Response
    func delete(account: String, id: String, idempotencyKey: String?) async throws -> Stripe.ExternalAccount.Delete.Response
    func list(account: String, _ request: Stripe.ExternalAccount.List.Request) async throws -> Stripe.ExternalAccount.List.Response
    func retrieve(
        account: String,
        id: String,
        _ request: Stripe.ExternalAccount.Retrieve.Request
    ) async throws -> Stripe.ExternalAccount.Retrieve.Response
    func update(
        account: String,
        id: String,
        _ request: Stripe.ExternalAccount.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.ExternalAccount.Update.Response
}

public struct ExternalAccountsClient: ExternalAccountsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        account: String,
        _ request: Stripe.ExternalAccount.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.ExternalAccount.Create.Response {
        try await api.send(.POST, "v1/accounts/\(account)/external_accounts", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(account: String, id: String, idempotencyKey: String?) async throws -> Stripe.ExternalAccount.Delete.Response {
        try await api.send(.DELETE, "v1/accounts/\(account)/external_accounts/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(account: String, _ request: Stripe.ExternalAccount.List.Request) async throws -> Stripe.ExternalAccount.List.Response {
        try await api.list("v1/accounts/\(account)/external_accounts", parameters: request)
    }

    public func retrieve(
        account: String,
        id: String,
        _ request: Stripe.ExternalAccount.Retrieve.Request
    ) async throws -> Stripe.ExternalAccount.Retrieve.Response {
        try await api.list("v1/accounts/\(account)/external_accounts/\(id)", parameters: request)
    }

    public func update(
        account: String,
        id: String,
        _ request: Stripe.ExternalAccount.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.ExternalAccount.Update.Response {
        try await api.send(.POST, "v1/accounts/\(account)/external_accounts/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ExternalAccountsAPI {
    public func create(account: String, _ request: Stripe.ExternalAccount.Create.Request) async throws -> Stripe.ExternalAccount.Create.Response {
        try await create(account: account, request, idempotencyKey: nil)
    }

    public func delete(account: String, id: String) async throws -> Stripe.ExternalAccount.Delete.Response {
        try await delete(account: account, id: id, idempotencyKey: nil)
    }

    public func list(account: String) async throws -> Stripe.ExternalAccount.List.Response {
        try await list(account: account, .init())
    }

    public func retrieve(account: String, id: String) async throws -> Stripe.ExternalAccount.Retrieve.Response {
        try await retrieve(account: account, id: id, .init())
    }

    public func update(
        account: String,
        id: String,
        _ request: Stripe.ExternalAccount.Update.Request
    ) async throws -> Stripe.ExternalAccount.Update.Response {
        try await update(account: account, id: id, request, idempotencyKey: nil)
    }

    public func update(account: String, id: String, idempotencyKey: String? = nil) async throws -> Stripe.ExternalAccount.Update.Response {
        try await update(account: account, id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
