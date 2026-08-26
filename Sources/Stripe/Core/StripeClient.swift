//
//  StripeClient.swift
//  swift-stripe
//

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
