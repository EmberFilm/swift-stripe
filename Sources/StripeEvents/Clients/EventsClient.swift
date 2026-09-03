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

/// Operations on Stripe.Events.Event.
///
/// A protocol so tests can substitute a double; ``EventsClient`` is the implementation that
/// talks to Stripe.
public protocol EventsAPI: Sendable {
    func list(_ request: Stripe.Events.Event.List.Request) async throws -> Stripe.Events.Event.List.Response
    func retrieve(id: String, _ request: Stripe.Events.Event.Retrieve.Request) async throws -> Stripe.Events.Event.Retrieve.Response
}

public struct EventsClient: EventsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Events.Event.List.Request) async throws -> Stripe.Events.Event.List.Response {
        try await api.list("v1/events", parameters: request)
    }

    public func retrieve(id: String, _ request: Stripe.Events.Event.Retrieve.Request) async throws -> Stripe.Events.Event.Retrieve.Response {
        try await api.list("v1/events/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension EventsAPI {
    public func list() async throws -> Stripe.Events.Event.List.Response {
        try await list(.init())
    }

    public func retrieve(id: String) async throws -> Stripe.Events.Event.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
