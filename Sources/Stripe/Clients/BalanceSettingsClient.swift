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

/// Operations on Stripe.BalanceSettings.
///
/// A protocol so tests can substitute a double; ``BalanceSettingsClient`` is the implementation that
/// talks to Stripe.
public protocol BalanceSettingsAPI: Sendable {
    func retrieve(_ request: Stripe.BalanceSettings.Retrieve.Request) async throws -> Stripe.BalanceSettings.Retrieve.Response
    func update(_ request: Stripe.BalanceSettings.Update.Request, idempotencyKey: String?) async throws -> Stripe.BalanceSettings.Update.Response
}

public struct BalanceSettingsClient: BalanceSettingsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func retrieve(_ request: Stripe.BalanceSettings.Retrieve.Request) async throws -> Stripe.BalanceSettings.Retrieve.Response {
        try await api.list("v1/balance_settings", parameters: request)
    }

    public func update(
        _ request: Stripe.BalanceSettings.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.BalanceSettings.Update.Response {
        try await api.send(.POST, "v1/balance_settings", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension BalanceSettingsAPI {
    public func retrieve() async throws -> Stripe.BalanceSettings.Retrieve.Response {
        try await retrieve(.init())
    }

    public func update(_ request: Stripe.BalanceSettings.Update.Request) async throws -> Stripe.BalanceSettings.Update.Response {
        try await update(request, idempotencyKey: nil)
    }

    public func update(idempotencyKey: String? = nil) async throws -> Stripe.BalanceSettings.Update.Response {
        try await update(.init(), idempotencyKey: idempotencyKey)
    }
}
