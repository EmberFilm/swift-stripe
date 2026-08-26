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

/// Operations on Stripe.Fraud.PaymentEvaluation.
///
/// A protocol so tests can substitute a double; ``RadarPaymentEvaluationsClient`` is the implementation that
/// talks to Stripe.
public protocol RadarPaymentEvaluationsAPI: Sendable {
    func create(
        _ request: Stripe.Fraud.PaymentEvaluation.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Fraud.PaymentEvaluation.Create.Response
}

public struct RadarPaymentEvaluationsClient: RadarPaymentEvaluationsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Fraud.PaymentEvaluation.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Fraud.PaymentEvaluation.Create.Response {
        try await api.send(.POST, "v1/radar/payment_evaluations", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension RadarPaymentEvaluationsAPI {
    public func create(_ request: Stripe.Fraud.PaymentEvaluation.Create.Request) async throws -> Stripe.Fraud.PaymentEvaluation.Create.Response {
        try await create(request, idempotencyKey: nil)
    }
}
