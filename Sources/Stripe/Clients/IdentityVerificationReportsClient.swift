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

/// Operations on VerificationReport.
///
/// A protocol so tests can substitute a double; ``IdentityVerificationReportsClient`` is the implementation that
/// talks to Stripe.
public protocol IdentityVerificationReportsAPI: Sendable {
    func list(_ request: VerificationReport.List.Request) async throws -> VerificationReport.List.Response
    func retrieve(id: VerificationReport.ID, _ request: VerificationReport.Retrieve.Request) async throws -> VerificationReport.Retrieve.Response
}

public struct IdentityVerificationReportsClient: IdentityVerificationReportsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: VerificationReport.List.Request) async throws -> VerificationReport.List.Response {
        try await api.list("v1/identity/verification_reports", parameters: request)
    }

    public func retrieve(
        id: VerificationReport.ID,
        _ request: VerificationReport.Retrieve.Request
    ) async throws -> VerificationReport.Retrieve.Response {
        try await api.list("v1/identity/verification_reports/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension IdentityVerificationReportsAPI {
    public func list() async throws -> VerificationReport.List.Response {
        try await list(.init())
    }

    public func retrieve(id: VerificationReport.ID) async throws -> VerificationReport.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
