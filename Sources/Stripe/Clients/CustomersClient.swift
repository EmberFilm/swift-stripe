//
//  CustomersClient.swift
//  swift-stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import NIOHTTP1

/// Operations on the `/v1/customers` resource.
///
/// A protocol so tests can substitute a double; ``CustomersClient`` is the
/// implementation that talks to Stripe.
public protocol CustomersAPI: Sendable {
    func create(
        _ request: Stripe.Customers.Customer.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer
    func retrieve(id: Stripe.Customers.Customer.ID) async throws -> Stripe.Customers.Customer
    func update(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer
    func delete(
        id: Stripe.Customers.Customer.ID,
        idempotencyKey: String?
    ) async throws -> DeletedObject<Stripe.Customers.Customer>
    func list(_ request: Stripe.Customers.Customer.List.Request) async throws -> Stripe.Customers.Customer.List.Response
    func search(
        _ request: Stripe.Customers.Customer.Search.Request
    ) async throws -> Stripe.Customers.Customer.Search.Response
}

public struct CustomersClient: CustomersAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Customers.Customer.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer {
        try await api.send(.POST, "v1/customers", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: Stripe.Customers.Customer.ID
    ) async throws -> Stripe.Customers.Customer {
        try await api.send(.GET, "v1/customers/\(id)")
    }

    public func update(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer {
        try await api.send(
            .POST,
            "v1/customers/\(id)",
            body: request,
            idempotencyKey: idempotencyKey
        )
    }

    public func delete(
        id: Stripe.Customers.Customer.ID,
        idempotencyKey: String?
    ) async throws -> DeletedObject<Stripe.Customers.Customer> {
        try await api.send(.DELETE, "v1/customers/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(
        _ request: Stripe.Customers.Customer.List.Request
    ) async throws -> Stripe.Customers.Customer.List.Response {
        try await api.list("v1/customers", parameters: request)
    }

    public func search(
        _ request: Stripe.Customers.Customer.Search.Request
    ) async throws -> Stripe.Customers.Customer.Search.Response {
        try await api.list("v1/customers/search", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header, and
// no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension CustomersAPI {
    public func create(
        _ request: Stripe.Customers.Customer.Create.Request
    ) async throws -> Stripe.Customers.Customer {
        try await create(request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.Update.Request
    ) async throws -> Stripe.Customers.Customer {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func delete(
        id: Stripe.Customers.Customer.ID
    ) async throws -> DeletedObject<Stripe.Customers.Customer> {
        try await delete(id: id, idempotencyKey: nil)
    }
}
