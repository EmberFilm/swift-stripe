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

/// Operations on ReportType.
///
/// A protocol so tests can substitute a double; ``ReportingReportTypesClient`` is the implementation that
/// talks to Stripe.
public protocol ReportingReportTypesAPI: Sendable {
    func list(_ request: ReportType.List.Request) async throws -> ReportType.List.Response
    func retrieve(id: ReportType.ID, _ request: ReportType.Retrieve.Request) async throws -> ReportType.Retrieve.Response
}

public struct ReportingReportTypesClient: ReportingReportTypesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: ReportType.List.Request) async throws -> ReportType.List.Response {
        try await api.list("v1/reporting/report_types", parameters: request)
    }

    public func retrieve(id: ReportType.ID, _ request: ReportType.Retrieve.Request) async throws -> ReportType.Retrieve.Response {
        try await api.list("v1/reporting/report_types/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ReportingReportTypesAPI {
    public func list() async throws -> ReportType.List.Response {
        try await list(.init())
    }

    public func retrieve(id: ReportType.ID) async throws -> ReportType.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
