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

/// Operations on Stripe.Climate.Supplier.
///
/// A protocol so tests can substitute a double; ``ClimateSuppliersClient`` is the implementation that
/// talks to Stripe.
public protocol ClimateSuppliersAPI: Sendable {
    func list(_ request: Stripe.Climate.Supplier.List.Request) async throws -> Stripe.Climate.Supplier.List.Response
    func retrieve(
        id: Stripe.Climate.Supplier.ID,
        _ request: Stripe.Climate.Supplier.Retrieve.Request
    ) async throws -> Stripe.Climate.Supplier.Retrieve.Response
}

public struct ClimateSuppliersClient: ClimateSuppliersAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Climate.Supplier.List.Request) async throws -> Stripe.Climate.Supplier.List.Response {
        try await api.list("v1/climate/suppliers", parameters: request)
    }

    public func retrieve(
        id: Stripe.Climate.Supplier.ID,
        _ request: Stripe.Climate.Supplier.Retrieve.Request
    ) async throws -> Stripe.Climate.Supplier.Retrieve.Response {
        try await api.list("v1/climate/suppliers/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ClimateSuppliersAPI {
    public func list() async throws -> Stripe.Climate.Supplier.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Climate.Supplier.ID) async throws -> Stripe.Climate.Supplier.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
