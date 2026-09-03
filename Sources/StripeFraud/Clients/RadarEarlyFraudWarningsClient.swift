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

/// Operations on Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.
///
/// A protocol so tests can substitute a double; ``RadarEarlyFraudWarningsClient`` is the implementation that
/// talks to Stripe.
public protocol RadarEarlyFraudWarningsAPI: Sendable {
    func list(
        _ request: Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.List.Request
    ) async throws -> Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.List.Response
    func retrieve(
        id: Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.ID,
        _ request: Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.Retrieve.Request
    ) async throws -> Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.Retrieve.Response
}

public struct RadarEarlyFraudWarningsClient: RadarEarlyFraudWarningsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(
        _ request: Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.List.Request
    ) async throws -> Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.List.Response {
        try await api.list("v1/radar/early_fraud_warnings", parameters: request)
    }

    public func retrieve(
        id: Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.ID,
        _ request: Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.Retrieve.Request
    ) async throws -> Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.Retrieve.Response {
        try await api.list("v1/radar/early_fraud_warnings/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension RadarEarlyFraudWarningsAPI {
    public func list() async throws -> Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.List.Response {
        try await list(.init())
    }

    public func retrieve(
        id: Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.ID
    ) async throws -> Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
