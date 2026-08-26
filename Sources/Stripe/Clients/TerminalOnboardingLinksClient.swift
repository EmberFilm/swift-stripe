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

/// Operations on Stripe.Terminal.OnboardingLink.
///
/// A protocol so tests can substitute a double; ``TerminalOnboardingLinksClient`` is the implementation that
/// talks to Stripe.
public protocol TerminalOnboardingLinksAPI: Sendable {
    func create(
        _ request: Stripe.Terminal.OnboardingLink.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.OnboardingLink.Create.Response
}

public struct TerminalOnboardingLinksClient: TerminalOnboardingLinksAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Terminal.OnboardingLink.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.OnboardingLink.Create.Response {
        try await api.send(.POST, "v1/terminal/onboarding_links", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TerminalOnboardingLinksAPI {
    public func create(_ request: Stripe.Terminal.OnboardingLink.Create.Request) async throws -> Stripe.Terminal.OnboardingLink.Create.Response {
        try await create(request, idempotencyKey: nil)
    }
}
