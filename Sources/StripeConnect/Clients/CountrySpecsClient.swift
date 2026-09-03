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

/// Operations on Stripe.Connect.CountrySpec.
///
/// A protocol so tests can substitute a double; ``CountrySpecsClient`` is the implementation that
/// talks to Stripe.
public protocol CountrySpecsAPI: Sendable {
    func list(_ request: Stripe.Connect.CountrySpec.List.Request) async throws -> Stripe.Connect.CountrySpec.List.Response
    func retrieve(
        id: Stripe.Connect.CountrySpec.ID,
        _ request: Stripe.Connect.CountrySpec.Retrieve.Request
    ) async throws -> Stripe.Connect.CountrySpec.Retrieve.Response
}

public struct CountrySpecsClient: CountrySpecsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Connect.CountrySpec.List.Request) async throws -> Stripe.Connect.CountrySpec.List.Response {
        try await api.list("v1/country_specs", parameters: request)
    }

    public func retrieve(
        id: Stripe.Connect.CountrySpec.ID,
        _ request: Stripe.Connect.CountrySpec.Retrieve.Request
    ) async throws -> Stripe.Connect.CountrySpec.Retrieve.Response {
        try await api.list("v1/country_specs/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension CountrySpecsAPI {
    public func list() async throws -> Stripe.Connect.CountrySpec.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Connect.CountrySpec.ID) async throws -> Stripe.Connect.CountrySpec.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
