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
import StripeIssuing
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Tax.Settings.
///
/// A protocol so tests can substitute a double; ``TaxSettingsClient`` is the implementation that
/// talks to Stripe.
public protocol TaxSettingsAPI: Sendable {
    func retrieve(_ request: Stripe.Tax.Settings.Retrieve.Request) async throws -> Stripe.Tax.Settings.Retrieve.Response
    func update(_ request: Stripe.Tax.Settings.Update.Request, idempotencyKey: String?) async throws -> Stripe.Tax.Settings.Update.Response
}

public struct TaxSettingsClient: TaxSettingsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func retrieve(_ request: Stripe.Tax.Settings.Retrieve.Request) async throws -> Stripe.Tax.Settings.Retrieve.Response {
        try await api.list("v1/tax/settings", parameters: request)
    }

    public func update(_ request: Stripe.Tax.Settings.Update.Request, idempotencyKey: String?) async throws -> Stripe.Tax.Settings.Update.Response {
        try await api.send(.POST, "v1/tax/settings", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TaxSettingsAPI {
    public func retrieve() async throws -> Stripe.Tax.Settings.Retrieve.Response {
        try await retrieve(.init())
    }

    public func update(_ request: Stripe.Tax.Settings.Update.Request) async throws -> Stripe.Tax.Settings.Update.Response {
        try await update(request, idempotencyKey: nil)
    }

    public func update(idempotencyKey: String? = nil) async throws -> Stripe.Tax.Settings.Update.Response {
        try await update(.init(), idempotencyKey: idempotencyKey)
    }
}
