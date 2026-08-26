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

/// Operations on Stripe.Connect.Capability.
///
/// A protocol so tests can substitute a double; ``CapabilitiesClient`` is the implementation that
/// talks to Stripe.
public protocol CapabilitiesAPI: Sendable {
    func list(account: String, _ request: Stripe.Connect.Capability.List.Request) async throws -> Stripe.Connect.Capability.List.Response
    func retrieve(
        account: String,
        capability: Stripe.Connect.Capability.ID,
        _ request: Stripe.Connect.Capability.Retrieve.Request
    ) async throws -> Stripe.Connect.Capability.Retrieve.Response
    func update(
        account: String,
        capability: Stripe.Connect.Capability.ID,
        _ request: Stripe.Connect.Capability.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Capability.Update.Response
}

public struct CapabilitiesClient: CapabilitiesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(account: String, _ request: Stripe.Connect.Capability.List.Request) async throws -> Stripe.Connect.Capability.List.Response {
        try await api.list("v1/accounts/\(account)/capabilities", parameters: request)
    }

    public func retrieve(
        account: String,
        capability: Stripe.Connect.Capability.ID,
        _ request: Stripe.Connect.Capability.Retrieve.Request
    ) async throws -> Stripe.Connect.Capability.Retrieve.Response {
        try await api.list("v1/accounts/\(account)/capabilities/\(capability)", parameters: request)
    }

    public func update(
        account: String,
        capability: Stripe.Connect.Capability.ID,
        _ request: Stripe.Connect.Capability.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Connect.Capability.Update.Response {
        try await api.send(.POST, "v1/accounts/\(account)/capabilities/\(capability)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension CapabilitiesAPI {
    public func list(account: String) async throws -> Stripe.Connect.Capability.List.Response {
        try await list(account: account, .init())
    }

    public func retrieve(account: String, capability: Stripe.Connect.Capability.ID) async throws -> Stripe.Connect.Capability.Retrieve.Response {
        try await retrieve(account: account, capability: capability, .init())
    }

    public func update(
        account: String,
        capability: Stripe.Connect.Capability.ID,
        _ request: Stripe.Connect.Capability.Update.Request
    ) async throws -> Stripe.Connect.Capability.Update.Response {
        try await update(account: account, capability: capability, request, idempotencyKey: nil)
    }

    public func update(
        account: String,
        capability: Stripe.Connect.Capability.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Connect.Capability.Update.Response {
        try await update(account: account, capability: capability, .init(), idempotencyKey: idempotencyKey)
    }
}
