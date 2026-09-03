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
import StripeIssuing
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Balance.
///
/// A protocol so tests can substitute a double; ``BalanceClient`` is the implementation that
/// talks to Stripe.
public protocol BalanceAPI: Sendable {
    func retrieve(_ request: Stripe.Balance.Retrieve.Request) async throws -> Stripe.Balance.Retrieve.Response
}

public struct BalanceClient: BalanceAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func retrieve(_ request: Stripe.Balance.Retrieve.Request) async throws -> Stripe.Balance.Retrieve.Response {
        try await api.list("v1/balance", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension BalanceAPI {
    public func retrieve() async throws -> Stripe.Balance.Retrieve.Response {
        try await retrieve(.init())
    }
}
