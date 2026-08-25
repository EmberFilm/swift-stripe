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
    func create(_ request: Stripe.Customers.Create.Request) async throws -> Stripe.Customers.Customer
    func retrieve(id: Stripe.Customers.Customer.ID) async throws -> Stripe.Customers.Customer
    func update(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Update.Request
    ) async throws -> Stripe.Customers.Customer
    func delete(
        id: Stripe.Customers.Customer.ID
    ) async throws -> DeletedObject<Stripe.Customers.Customer>
    func list(_ request: Stripe.Customers.List.Request) async throws -> Stripe.Customers.List.Response
    func search(
        _ request: Stripe.Customers.Search.Request
    ) async throws -> Stripe.Customers.Search.Response
}

public struct CustomersClient: CustomersAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Customers.Create.Request
    ) async throws -> Stripe.Customers.Customer {
        try await api.send(.POST, "v1/customers", body: request)
    }

    public func retrieve(
        id: Stripe.Customers.Customer.ID
    ) async throws -> Stripe.Customers.Customer {
        try await api.send(.GET, "v1/customers/\(id)")
    }

    public func update(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Update.Request
    ) async throws -> Stripe.Customers.Customer {
        try await api.send(.POST, "v1/customers/\(id)", body: request)
    }

    public func delete(
        id: Stripe.Customers.Customer.ID
    ) async throws -> DeletedObject<Stripe.Customers.Customer> {
        try await api.send(.DELETE, "v1/customers/\(id)")
    }

    public func list(
        _ request: Stripe.Customers.List.Request
    ) async throws -> Stripe.Customers.List.Response {
        try await api.list("v1/customers", parameters: request)
    }

    public func search(
        _ request: Stripe.Customers.Search.Request
    ) async throws -> Stripe.Customers.Search.Response {
        try await api.list("v1/customers/search", parameters: request)
    }
}
