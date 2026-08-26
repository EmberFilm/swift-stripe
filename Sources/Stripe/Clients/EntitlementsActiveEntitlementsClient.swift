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

/// Operations on Stripe.Entitlements.ActiveEntitlement.
///
/// A protocol so tests can substitute a double; ``EntitlementsActiveEntitlementsClient`` is the implementation that
/// talks to Stripe.
public protocol EntitlementsActiveEntitlementsAPI: Sendable {
    func list(_ request: Stripe.Entitlements.ActiveEntitlement.List.Request) async throws -> Stripe.Entitlements.ActiveEntitlement.List.Response
    func retrieve(
        id: Stripe.Entitlements.ActiveEntitlement.ID,
        _ request: Stripe.Entitlements.ActiveEntitlement.Retrieve.Request
    ) async throws -> Stripe.Entitlements.ActiveEntitlement.Retrieve.Response
}

public struct EntitlementsActiveEntitlementsClient: EntitlementsActiveEntitlementsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(
        _ request: Stripe.Entitlements.ActiveEntitlement.List.Request
    ) async throws -> Stripe.Entitlements.ActiveEntitlement.List.Response {
        try await api.list("v1/entitlements/active_entitlements", parameters: request)
    }

    public func retrieve(
        id: Stripe.Entitlements.ActiveEntitlement.ID,
        _ request: Stripe.Entitlements.ActiveEntitlement.Retrieve.Request
    ) async throws -> Stripe.Entitlements.ActiveEntitlement.Retrieve.Response {
        try await api.list("v1/entitlements/active_entitlements/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension EntitlementsActiveEntitlementsAPI {
    public func retrieve(id: Stripe.Entitlements.ActiveEntitlement.ID) async throws -> Stripe.Entitlements.ActiveEntitlement.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
