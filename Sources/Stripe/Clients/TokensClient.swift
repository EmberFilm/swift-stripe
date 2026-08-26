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

/// Operations on Stripe.Tokens.Token.
///
/// A protocol so tests can substitute a double; ``TokensClient`` is the implementation that
/// talks to Stripe.
public protocol TokensAPI: Sendable {
    func create(_ request: Stripe.Tokens.Token.Create.Request, idempotencyKey: String?) async throws -> Stripe.Tokens.Token.Create.Response
    func retrieve(id: Stripe.Tokens.Token.ID, _ request: Stripe.Tokens.Token.Retrieve.Request) async throws -> Stripe.Tokens.Token.Retrieve.Response
}

public struct TokensClient: TokensAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(_ request: Stripe.Tokens.Token.Create.Request, idempotencyKey: String?) async throws -> Stripe.Tokens.Token.Create.Response {
        try await api.send(.POST, "v1/tokens", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: Stripe.Tokens.Token.ID,
        _ request: Stripe.Tokens.Token.Retrieve.Request
    ) async throws -> Stripe.Tokens.Token.Retrieve.Response {
        try await api.list("v1/tokens/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TokensAPI {
    public func create(_ request: Stripe.Tokens.Token.Create.Request) async throws -> Stripe.Tokens.Token.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.Tokens.Token.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func retrieve(id: Stripe.Tokens.Token.ID) async throws -> Stripe.Tokens.Token.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
