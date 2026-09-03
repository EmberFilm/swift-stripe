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

/// Operations on Stripe.Connect.Account.LoginLink.
///
/// A protocol so tests can substitute a double; ``LoginLinksClient`` is the implementation that
/// talks to Stripe.
public protocol LoginLinksAPI: Sendable {
    func create(
        account: String,
        _ request: Stripe.Connect.Account.LoginLink.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Account.LoginLink.Create.Response
}

public struct LoginLinksClient: LoginLinksAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        account: String,
        _ request: Stripe.Connect.Account.LoginLink.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Account.LoginLink.Create.Response {
        try await api.send(.POST, "v1/accounts/\(account)/login_links", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension LoginLinksAPI {
    public func create(
        account: String,
        _ request: Stripe.Connect.Account.LoginLink.Create.Request
    ) async throws -> Stripe.Connect.Account.LoginLink.Create.Response {
        try await create(account: account, request, idempotencyKey: nil)
    }

    public func create(account: String, idempotencyKey: String? = nil) async throws -> Stripe.Connect.Account.LoginLink.Create.Response {
        try await create(account: account, .init(), idempotencyKey: idempotencyKey)
    }
}
