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

import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Connection and behaviour settings for a ``StripeClient``.
public struct StripeConfiguration: Sendable {
    /// Secret API key (`sk_live_…` / `sk_test_…`).
    public var secretKey: String

    /// Base URL of the Stripe REST API.
    public var baseURL: URL

    /// Pinned Stripe API version, sent as `Stripe-Version`.
    ///
    /// Leaving this `nil` uses whichever version the account defaults to, which
    /// means Stripe can change response shapes under you. Pin it in production.
    public var apiVersion: String?
    /// Where uploads and downloads go: `files.stripe.com` rather than `api.stripe.com`.
    public var filesBaseURL: URL

    /// Connected account to act on behalf of, sent as `Stripe-Account`.
    public var connectedAccount: String?

    /// How many times to retry a request that failed with a retryable status.
    public var maxRetries: Int

    /// Per-request timeout.
    public var timeout: Duration

    public init(
        secretKey: String,
        baseURL: URL = URL(string: "https://api.stripe.com")!,
        apiVersion: String? = Stripe.generatedAPIVersion,
        filesBaseURL: URL = URL(string: "https://files.stripe.com")!,
        connectedAccount: String? = nil,
        maxRetries: Int = 2,
        timeout: Duration = .seconds(60)
    ) {
        self.secretKey = secretKey
        self.baseURL = baseURL
        self.apiVersion = apiVersion
        self.filesBaseURL = filesBaseURL
        self.connectedAccount = connectedAccount
        self.maxRetries = maxRetries
        self.timeout = timeout
    }
}
