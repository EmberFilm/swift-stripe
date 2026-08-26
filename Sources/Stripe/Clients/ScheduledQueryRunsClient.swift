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

/// Operations on ScheduledQueryRun.
///
/// A protocol so tests can substitute a double; ``ScheduledQueryRunsClient`` is the implementation that
/// talks to Stripe.
public protocol ScheduledQueryRunsAPI: Sendable {
    func list(_ request: ScheduledQueryRun.List.Request) async throws -> ScheduledQueryRun.List.Response
    func retrieve(id: ScheduledQueryRun.ID, _ request: ScheduledQueryRun.Retrieve.Request) async throws -> ScheduledQueryRun.Retrieve.Response
}

public struct ScheduledQueryRunsClient: ScheduledQueryRunsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: ScheduledQueryRun.List.Request) async throws -> ScheduledQueryRun.List.Response {
        try await api.list("v1/sigma/scheduled_query_runs", parameters: request)
    }

    public func retrieve(id: ScheduledQueryRun.ID, _ request: ScheduledQueryRun.Retrieve.Request) async throws -> ScheduledQueryRun.Retrieve.Response
    {
        try await api.list("v1/sigma/scheduled_query_runs/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ScheduledQueryRunsAPI {
    public func list() async throws -> ScheduledQueryRun.List.Response {
        try await list(.init())
    }

    public func retrieve(id: ScheduledQueryRun.ID) async throws -> ScheduledQueryRun.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
