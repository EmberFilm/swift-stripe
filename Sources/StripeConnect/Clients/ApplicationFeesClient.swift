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

/// Operations on Stripe.Connect.Application.Fee.
///
/// A protocol so tests can substitute a double; ``ApplicationFeesClient`` is the implementation that
/// talks to Stripe.
public protocol ApplicationFeesAPI: Sendable {
    func list(_ request: Stripe.Connect.Application.Fee.List.Request) async throws -> Stripe.Connect.Application.Fee.List.Response
    func retrieve(
        id: Stripe.Connect.Application.Fee.ID,
        _ request: Stripe.Connect.Application.Fee.Retrieve.Request
    ) async throws -> Stripe.Connect.Application.Fee.Retrieve.Response
}

public struct ApplicationFeesClient: ApplicationFeesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Connect.Application.Fee.List.Request) async throws -> Stripe.Connect.Application.Fee.List.Response {
        try await api.list("v1/application_fees", parameters: request)
    }

    public func retrieve(
        id: Stripe.Connect.Application.Fee.ID,
        _ request: Stripe.Connect.Application.Fee.Retrieve.Request
    ) async throws -> Stripe.Connect.Application.Fee.Retrieve.Response {
        try await api.list("v1/application_fees/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ApplicationFeesAPI {
    public func list() async throws -> Stripe.Connect.Application.Fee.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Connect.Application.Fee.ID) async throws -> Stripe.Connect.Application.Fee.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
