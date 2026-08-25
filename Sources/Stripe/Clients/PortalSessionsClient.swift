//
//  PortalSessionsClient.swift
//  swift-stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import NIOHTTP1

/// Operations on the `/v1/billing_portal/sessions` resource.
///
/// Sessions are create-only: Stripe issues a short-lived URL and does not expose
/// the session for retrieval or listing afterwards.
public protocol PortalSessionsAPI: Sendable {
    func create(
        _ request: Stripe.Billing.Customer.Portal.Session.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Portal.Session
}

public struct PortalSessionsClient: PortalSessionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    private static let path = "v1/billing_portal/sessions"

    public func create(
        _ request: Stripe.Billing.Customer.Portal.Session.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Portal.Session {
        try await api.send(.POST, Self.path, body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header, and
// no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PortalSessionsAPI {
    public func create(
        _ request: Stripe.Billing.Customer.Portal.Session.Create.Request
    ) async throws -> Stripe.Billing.Customer.Portal.Session {
        try await create(request, idempotencyKey: nil)
    }
}
