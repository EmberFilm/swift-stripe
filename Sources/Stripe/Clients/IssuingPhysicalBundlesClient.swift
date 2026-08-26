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

/// Operations on Stripe.Issuing.PhysicalBundle.
///
/// A protocol so tests can substitute a double; ``IssuingPhysicalBundlesClient`` is the implementation that
/// talks to Stripe.
public protocol IssuingPhysicalBundlesAPI: Sendable {
    func list(_ request: Stripe.Issuing.PhysicalBundle.List.Request) async throws -> Stripe.Issuing.PhysicalBundle.List.Response
    func retrieve(
        id: Stripe.Issuing.PhysicalBundle.ID,
        _ request: Stripe.Issuing.PhysicalBundle.Retrieve.Request
    ) async throws -> Stripe.Issuing.PhysicalBundle.Retrieve.Response
}

public struct IssuingPhysicalBundlesClient: IssuingPhysicalBundlesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Issuing.PhysicalBundle.List.Request) async throws -> Stripe.Issuing.PhysicalBundle.List.Response {
        try await api.list("v1/issuing/physical_bundles", parameters: request)
    }

    public func retrieve(
        id: Stripe.Issuing.PhysicalBundle.ID,
        _ request: Stripe.Issuing.PhysicalBundle.Retrieve.Request
    ) async throws -> Stripe.Issuing.PhysicalBundle.Retrieve.Response {
        try await api.list("v1/issuing/physical_bundles/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension IssuingPhysicalBundlesAPI {
    public func list() async throws -> Stripe.Issuing.PhysicalBundle.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Issuing.PhysicalBundle.ID) async throws -> Stripe.Issuing.PhysicalBundle.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
