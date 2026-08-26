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

import AsyncHTTPClient

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// The entry point: one resource client per Stripe resource, all sharing one ``StripeAPI``.
///
/// The resource properties (`customers`, `checkoutSessions`, `billingPortalSessions`, …) are
/// generated from the OpenAPI spec into `Clients/Generated/`; each returns a value type over
/// the shared `api`, so holding them is free and every operation is reachable from here.
public struct StripeClient: Sendable {
    public let api: StripeAPI

    public init(configuration: StripeConfiguration, httpClient: HTTPClient = .shared) {
        self.api = StripeAPI(configuration: configuration, httpClient: httpClient)
    }

    @available(*, deprecated, renamed: "billingPortalSessions")
    public var portalSessions: BillingPortalSessionsClient { billingPortalSessions }
}
