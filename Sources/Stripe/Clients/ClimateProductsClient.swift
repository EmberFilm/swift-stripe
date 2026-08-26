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

/// Operations on Stripe.Climate.Product.
///
/// A protocol so tests can substitute a double; ``ClimateProductsClient`` is the implementation that
/// talks to Stripe.
public protocol ClimateProductsAPI: Sendable {
    func list(_ request: Stripe.Climate.Product.List.Request) async throws -> Stripe.Climate.Product.List.Response
    func retrieve(
        id: Stripe.Climate.Product.ID,
        _ request: Stripe.Climate.Product.Retrieve.Request
    ) async throws -> Stripe.Climate.Product.Retrieve.Response
}

public struct ClimateProductsClient: ClimateProductsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Climate.Product.List.Request) async throws -> Stripe.Climate.Product.List.Response {
        try await api.list("v1/climate/products", parameters: request)
    }

    public func retrieve(
        id: Stripe.Climate.Product.ID,
        _ request: Stripe.Climate.Product.Retrieve.Request
    ) async throws -> Stripe.Climate.Product.Retrieve.Response {
        try await api.list("v1/climate/products/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ClimateProductsAPI {
    public func list() async throws -> Stripe.Climate.Product.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Climate.Product.ID) async throws -> Stripe.Climate.Product.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
