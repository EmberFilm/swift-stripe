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

/// Operations on Stripe.Connect.Account.Session.
///
/// A protocol so tests can substitute a double; ``AccountSessionsClient`` is the implementation that
/// talks to Stripe.
public protocol AccountSessionsAPI: Sendable {
    func create(
        _ request: Stripe.Connect.Account.Session.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Account.Session.Create.Response
}

public struct AccountSessionsClient: AccountSessionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Connect.Account.Session.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Account.Session.Create.Response {
        try await api.send(.POST, "v1/account_sessions", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension AccountSessionsAPI {
    public func create(_ request: Stripe.Connect.Account.Session.Create.Request) async throws -> Stripe.Connect.Account.Session.Create.Response {
        try await create(request, idempotencyKey: nil)
    }
}
