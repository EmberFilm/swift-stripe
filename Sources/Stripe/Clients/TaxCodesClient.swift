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

/// Operations on Stripe.Tax.Code.
///
/// A protocol so tests can substitute a double; ``TaxCodesClient`` is the implementation that
/// talks to Stripe.
public protocol TaxCodesAPI: Sendable {
    func list(_ request: Stripe.Tax.Code.List.Request) async throws -> Stripe.Tax.Code.List.Response
    func retrieve(id: Stripe.Tax.Code.ID, _ request: Stripe.Tax.Code.Retrieve.Request) async throws -> Stripe.Tax.Code.Retrieve.Response
}

public struct TaxCodesClient: TaxCodesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Tax.Code.List.Request) async throws -> Stripe.Tax.Code.List.Response {
        try await api.list("v1/tax_codes", parameters: request)
    }

    public func retrieve(id: Stripe.Tax.Code.ID, _ request: Stripe.Tax.Code.Retrieve.Request) async throws -> Stripe.Tax.Code.Retrieve.Response {
        try await api.list("v1/tax_codes/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TaxCodesAPI {
    public func list() async throws -> Stripe.Tax.Code.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Tax.Code.ID) async throws -> Stripe.Tax.Code.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
