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

/// Operations on ReportRun.
///
/// A protocol so tests can substitute a double; ``ReportingReportRunsClient`` is the implementation that
/// talks to Stripe.
public protocol ReportingReportRunsAPI: Sendable {
    func create(_ request: ReportRun.Create.Request, idempotencyKey: String?) async throws -> ReportRun.Create.Response
    func list(_ request: ReportRun.List.Request) async throws -> ReportRun.List.Response
    func retrieve(id: ReportRun.ID, _ request: ReportRun.Retrieve.Request) async throws -> ReportRun.Retrieve.Response
}

public struct ReportingReportRunsClient: ReportingReportRunsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(_ request: ReportRun.Create.Request, idempotencyKey: String?) async throws -> ReportRun.Create.Response {
        try await api.send(.POST, "v1/reporting/report_runs", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: ReportRun.List.Request) async throws -> ReportRun.List.Response {
        try await api.list("v1/reporting/report_runs", parameters: request)
    }

    public func retrieve(id: ReportRun.ID, _ request: ReportRun.Retrieve.Request) async throws -> ReportRun.Retrieve.Response {
        try await api.list("v1/reporting/report_runs/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ReportingReportRunsAPI {
    public func create(_ request: ReportRun.Create.Request) async throws -> ReportRun.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> ReportRun.List.Response {
        try await list(.init())
    }

    public func retrieve(id: ReportRun.ID) async throws -> ReportRun.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
