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

/// Operations on Stripe.Setup.Attempt.
///
/// A protocol so tests can substitute a double; ``SetupAttemptsClient`` is the implementation that
/// talks to Stripe.
public protocol SetupAttemptsAPI: Sendable {
    func list(_ request: Stripe.Setup.Attempt.List.Request) async throws -> Stripe.Setup.Attempt.List.Response
}

public struct SetupAttemptsClient: SetupAttemptsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Setup.Attempt.List.Request) async throws -> Stripe.Setup.Attempt.List.Response {
        try await api.list("v1/setup_attempts", parameters: request)
    }
}
