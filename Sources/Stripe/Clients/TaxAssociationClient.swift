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

/// Operations on Stripe.Tax.Association.
///
/// A protocol so tests can substitute a double; ``TaxAssociationClient`` is the implementation that
/// talks to Stripe.
public protocol TaxAssociationAPI: Sendable {
    func find(_ request: Stripe.Tax.Association.Find.Request) async throws -> Stripe.Tax.Association.Find.Response
}

public struct TaxAssociationClient: TaxAssociationAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func find(_ request: Stripe.Tax.Association.Find.Request) async throws -> Stripe.Tax.Association.Find.Response {
        try await api.list("v1/tax/associations/find", parameters: request)
    }
}
