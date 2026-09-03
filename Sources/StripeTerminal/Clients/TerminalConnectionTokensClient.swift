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

/// Operations on TerminalConnectionToken.
///
/// A protocol so tests can substitute a double; ``TerminalConnectionTokensClient`` is the implementation that
/// talks to Stripe.
public protocol TerminalConnectionTokensAPI: Sendable {
    func create(_ request: TerminalConnectionToken.Create.Request, idempotencyKey: String?) async throws -> TerminalConnectionToken.Create.Response
}

public struct TerminalConnectionTokensClient: TerminalConnectionTokensAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: TerminalConnectionToken.Create.Request,
        idempotencyKey: String?
    ) async throws -> TerminalConnectionToken.Create.Response {
        try await api.send(.POST, "v1/terminal/connection_tokens", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TerminalConnectionTokensAPI {
    public func create(_ request: TerminalConnectionToken.Create.Request) async throws -> TerminalConnectionToken.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> TerminalConnectionToken.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }
}
