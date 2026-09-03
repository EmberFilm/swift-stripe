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
import StripeCheckout
import StripeCore
import StripeIssuing
import StripeModels
import StripePromotion
import StripeReporting

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on BankAccount.
///
/// A protocol so tests can substitute a double; ``BankAccountsClient`` is the implementation that
/// talks to Stripe.
public protocol BankAccountsAPI: Sendable {
    func verify(
        customer: String,
        id: String,
        _ request: BankAccount.Verify.Request,
        idempotencyKey: String?
    ) async throws -> BankAccount.Verify.Response
}

public struct BankAccountsClient: BankAccountsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func verify(
        customer: String,
        id: String,
        _ request: BankAccount.Verify.Request,
        idempotencyKey: String?
    ) async throws -> BankAccount.Verify.Response {
        try await api.send(.POST, "v1/customers/\(customer)/sources/\(id)/verify", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension BankAccountsAPI {
    public func verify(customer: String, id: String, _ request: BankAccount.Verify.Request) async throws -> BankAccount.Verify.Response {
        try await verify(customer: customer, id: id, request, idempotencyKey: nil)
    }

    public func verify(customer: String, id: String, idempotencyKey: String? = nil) async throws -> BankAccount.Verify.Response {
        try await verify(customer: customer, id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
