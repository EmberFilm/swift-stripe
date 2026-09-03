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
import StripeCheckout
import StripeCore
import StripeIssuing
import StripeModels
import StripeProducts

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Billing.TestClocks.TestClock.
///
/// A protocol so tests can substitute a double; ``TestHelpersTestClocksClient`` is the implementation that
/// talks to Stripe.
public protocol TestHelpersTestClocksAPI: Sendable {
    func advance(
        id: Stripe.Billing.TestClocks.TestClock.ID,
        _ request: Stripe.Billing.TestClocks.TestClock.Advance.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.TestClocks.TestClock.Advance.Response
    func create(
        _ request: Stripe.Billing.TestClocks.TestClock.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.TestClocks.TestClock.Create.Response
    func delete(
        id: Stripe.Billing.TestClocks.TestClock.ID,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.TestClocks.TestClock.Delete.Response
    func list(_ request: Stripe.Billing.TestClocks.TestClock.List.Request) async throws -> Stripe.Billing.TestClocks.TestClock.List.Response
    func retrieve(
        id: Stripe.Billing.TestClocks.TestClock.ID,
        _ request: Stripe.Billing.TestClocks.TestClock.Retrieve.Request
    ) async throws -> Stripe.Billing.TestClocks.TestClock.Retrieve.Response
}

public struct TestHelpersTestClocksClient: TestHelpersTestClocksAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func advance(
        id: Stripe.Billing.TestClocks.TestClock.ID,
        _ request: Stripe.Billing.TestClocks.TestClock.Advance.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.TestClocks.TestClock.Advance.Response {
        try await api.send(.POST, "v1/test_helpers/test_clocks/\(id)/advance", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(
        _ request: Stripe.Billing.TestClocks.TestClock.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.TestClocks.TestClock.Create.Response {
        try await api.send(.POST, "v1/test_helpers/test_clocks", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(
        id: Stripe.Billing.TestClocks.TestClock.ID,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.TestClocks.TestClock.Delete.Response {
        try await api.send(.DELETE, "v1/test_helpers/test_clocks/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Billing.TestClocks.TestClock.List.Request) async throws -> Stripe.Billing.TestClocks.TestClock.List.Response {
        try await api.list("v1/test_helpers/test_clocks", parameters: request)
    }

    public func retrieve(
        id: Stripe.Billing.TestClocks.TestClock.ID,
        _ request: Stripe.Billing.TestClocks.TestClock.Retrieve.Request
    ) async throws -> Stripe.Billing.TestClocks.TestClock.Retrieve.Response {
        try await api.list("v1/test_helpers/test_clocks/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TestHelpersTestClocksAPI {
    public func advance(
        id: Stripe.Billing.TestClocks.TestClock.ID,
        _ request: Stripe.Billing.TestClocks.TestClock.Advance.Request
    ) async throws -> Stripe.Billing.TestClocks.TestClock.Advance.Response {
        try await advance(id: id, request, idempotencyKey: nil)
    }

    public func create(
        _ request: Stripe.Billing.TestClocks.TestClock.Create.Request
    ) async throws -> Stripe.Billing.TestClocks.TestClock.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func delete(id: Stripe.Billing.TestClocks.TestClock.ID) async throws -> Stripe.Billing.TestClocks.TestClock.Delete.Response {
        try await delete(id: id, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Billing.TestClocks.TestClock.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Billing.TestClocks.TestClock.ID) async throws -> Stripe.Billing.TestClocks.TestClock.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
