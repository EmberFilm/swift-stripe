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
import StripePaymentMethods
import StripeProducts
import StripeTax

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Customers.Customer.
///
/// A protocol so tests can substitute a double; ``CustomersClient`` is the implementation that
/// talks to Stripe.
public protocol CustomersAPI: Sendable {
    func create(
        _ request: Stripe.Customers.Customer.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.Create.Response
    func createFundingInstructions(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.CreateFundingInstructions.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.CreateFundingInstructions.Response
    func createTaxId(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.CreateTaxId.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.CreateTaxId.Response
    func delete(id: Stripe.Customers.Customer.ID, idempotencyKey: String?) async throws -> Stripe.Customers.Customer.Delete.Response
    func deleteDiscount(id: Stripe.Customers.Customer.ID, idempotencyKey: String?) async throws -> Stripe.Customers.Customer.DeleteDiscount.Response
    func deleteTaxId(
        customer: Stripe.Customers.Customer.ID,
        id: String,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.DeleteTaxId.Response
    func fundCashBalance(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.FundCashBalance.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.FundCashBalance.Response
    func list(_ request: Stripe.Customers.Customer.List.Request) async throws -> Stripe.Customers.Customer.List.Response
    func listPaymentMethods(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.ListPaymentMethods.Request
    ) async throws -> Stripe.Customers.Customer.ListPaymentMethods.Response
    func listTaxIds(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.ListTaxIds.Request
    ) async throws -> Stripe.Customers.Customer.ListTaxIds.Response
    func retrieve(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.Retrieve.Request
    ) async throws -> Stripe.Customers.Customer.Retrieve.Response
    func retrievePaymentMethod(
        customer: Stripe.Customers.Customer.ID,
        paymentMethod: String,
        _ request: Stripe.Customers.Customer.RetrievePaymentMethod.Request
    ) async throws -> Stripe.Customers.Customer.RetrievePaymentMethod.Response
    func retrieveTaxId(
        customer: Stripe.Customers.Customer.ID,
        id: String,
        _ request: Stripe.Customers.Customer.RetrieveTaxId.Request
    ) async throws -> Stripe.Customers.Customer.RetrieveTaxId.Response
    func search(_ request: Stripe.Customers.Customer.Search.Request) async throws -> Stripe.Customers.Customer.Search.Response
    func update(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.Update.Response
}

public struct CustomersClient: CustomersAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Customers.Customer.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.Create.Response {
        try await api.send(.POST, "v1/customers", body: request, idempotencyKey: idempotencyKey)
    }

    public func createFundingInstructions(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.CreateFundingInstructions.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.CreateFundingInstructions.Response {
        try await api.send(.POST, "v1/customers/\(id)/funding_instructions", body: request, idempotencyKey: idempotencyKey)
    }

    public func createTaxId(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.CreateTaxId.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.CreateTaxId.Response {
        try await api.send(.POST, "v1/customers/\(id)/tax_ids", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(id: Stripe.Customers.Customer.ID, idempotencyKey: String?) async throws -> Stripe.Customers.Customer.Delete.Response {
        try await api.send(.DELETE, "v1/customers/\(id)", idempotencyKey: idempotencyKey)
    }

    public func deleteDiscount(
        id: Stripe.Customers.Customer.ID,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.DeleteDiscount.Response {
        try await api.send(.DELETE, "v1/customers/\(id)/discount", idempotencyKey: idempotencyKey)
    }

    public func deleteTaxId(
        customer: Stripe.Customers.Customer.ID,
        id: String,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.DeleteTaxId.Response {
        try await api.send(.DELETE, "v1/customers/\(customer)/tax_ids/\(id)", idempotencyKey: idempotencyKey)
    }

    public func fundCashBalance(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.FundCashBalance.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.FundCashBalance.Response {
        try await api.send(.POST, "v1/test_helpers/customers/\(id)/fund_cash_balance", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Customers.Customer.List.Request) async throws -> Stripe.Customers.Customer.List.Response {
        try await api.list("v1/customers", parameters: request)
    }

    public func listPaymentMethods(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.ListPaymentMethods.Request
    ) async throws -> Stripe.Customers.Customer.ListPaymentMethods.Response {
        try await api.list("v1/customers/\(id)/payment_methods", parameters: request)
    }

    public func listTaxIds(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.ListTaxIds.Request
    ) async throws -> Stripe.Customers.Customer.ListTaxIds.Response {
        try await api.list("v1/customers/\(id)/tax_ids", parameters: request)
    }

    public func retrieve(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.Retrieve.Request
    ) async throws -> Stripe.Customers.Customer.Retrieve.Response {
        try await api.list("v1/customers/\(id)", parameters: request)
    }

    public func retrievePaymentMethod(
        customer: Stripe.Customers.Customer.ID,
        paymentMethod: String,
        _ request: Stripe.Customers.Customer.RetrievePaymentMethod.Request
    ) async throws -> Stripe.Customers.Customer.RetrievePaymentMethod.Response {
        try await api.list("v1/customers/\(customer)/payment_methods/\(paymentMethod)", parameters: request)
    }

    public func retrieveTaxId(
        customer: Stripe.Customers.Customer.ID,
        id: String,
        _ request: Stripe.Customers.Customer.RetrieveTaxId.Request
    ) async throws -> Stripe.Customers.Customer.RetrieveTaxId.Response {
        try await api.list("v1/customers/\(customer)/tax_ids/\(id)", parameters: request)
    }

    public func search(_ request: Stripe.Customers.Customer.Search.Request) async throws -> Stripe.Customers.Customer.Search.Response {
        try await api.list("v1/customers/search", parameters: request)
    }

    public func update(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer.Update.Response {
        try await api.send(.POST, "v1/customers/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension CustomersAPI {
    public func create(_ request: Stripe.Customers.Customer.Create.Request) async throws -> Stripe.Customers.Customer.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.Customers.Customer.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func createFundingInstructions(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.CreateFundingInstructions.Request
    ) async throws -> Stripe.Customers.Customer.CreateFundingInstructions.Response {
        try await createFundingInstructions(id: id, request, idempotencyKey: nil)
    }

    public func createTaxId(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.CreateTaxId.Request
    ) async throws -> Stripe.Customers.Customer.CreateTaxId.Response {
        try await createTaxId(id: id, request, idempotencyKey: nil)
    }

    public func delete(id: Stripe.Customers.Customer.ID) async throws -> Stripe.Customers.Customer.Delete.Response {
        try await delete(id: id, idempotencyKey: nil)
    }

    public func deleteDiscount(id: Stripe.Customers.Customer.ID) async throws -> Stripe.Customers.Customer.DeleteDiscount.Response {
        try await deleteDiscount(id: id, idempotencyKey: nil)
    }

    public func deleteTaxId(customer: Stripe.Customers.Customer.ID, id: String) async throws -> Stripe.Customers.Customer.DeleteTaxId.Response {
        try await deleteTaxId(customer: customer, id: id, idempotencyKey: nil)
    }

    public func fundCashBalance(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.FundCashBalance.Request
    ) async throws -> Stripe.Customers.Customer.FundCashBalance.Response {
        try await fundCashBalance(id: id, request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Customers.Customer.List.Response {
        try await list(.init())
    }

    public func listPaymentMethods(id: Stripe.Customers.Customer.ID) async throws -> Stripe.Customers.Customer.ListPaymentMethods.Response {
        try await listPaymentMethods(id: id, .init())
    }

    public func listTaxIds(id: Stripe.Customers.Customer.ID) async throws -> Stripe.Customers.Customer.ListTaxIds.Response {
        try await listTaxIds(id: id, .init())
    }

    public func retrieve(id: Stripe.Customers.Customer.ID) async throws -> Stripe.Customers.Customer.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func retrievePaymentMethod(
        customer: Stripe.Customers.Customer.ID,
        paymentMethod: String
    ) async throws -> Stripe.Customers.Customer.RetrievePaymentMethod.Response {
        try await retrievePaymentMethod(customer: customer, paymentMethod: paymentMethod, .init())
    }

    public func retrieveTaxId(customer: Stripe.Customers.Customer.ID, id: String) async throws -> Stripe.Customers.Customer.RetrieveTaxId.Response {
        try await retrieveTaxId(customer: customer, id: id, .init())
    }

    public func update(
        id: Stripe.Customers.Customer.ID,
        _ request: Stripe.Customers.Customer.Update.Request
    ) async throws -> Stripe.Customers.Customer.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Customers.Customer.ID, idempotencyKey: String? = nil) async throws -> Stripe.Customers.Customer.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
