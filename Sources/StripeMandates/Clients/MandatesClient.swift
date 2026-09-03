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

/// Operations on Stripe.Mandates.Mandate.
///
/// A protocol so tests can substitute a double; ``MandatesClient`` is the implementation that
/// talks to Stripe.
public protocol MandatesAPI: Sendable {
    func retrieve(
        id: Stripe.Mandates.Mandate.ID,
        _ request: Stripe.Mandates.Mandate.Retrieve.Request
    ) async throws -> Stripe.Mandates.Mandate.Retrieve.Response
}

public struct MandatesClient: MandatesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func retrieve(
        id: Stripe.Mandates.Mandate.ID,
        _ request: Stripe.Mandates.Mandate.Retrieve.Request
    ) async throws -> Stripe.Mandates.Mandate.Retrieve.Response {
        try await api.list("v1/mandates/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension MandatesAPI {
    public func retrieve(id: Stripe.Mandates.Mandate.ID) async throws -> Stripe.Mandates.Mandate.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
