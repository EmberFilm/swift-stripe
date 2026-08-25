//
//  StripeAPITests.swift
//  swift-stripe
//
//  Request construction and response handling, tested as pure functions —
//  no network, no transport abstraction.
//

import AsyncHTTPClient
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import NIOHTTP1
import Testing

@testable import Stripe

@Suite("StripeAPI request building")
struct RequestBuildingTests {

    static func api(
        secretKey: String = "sk_test_123",
        apiVersion: String? = "2024-06-20",
        connectedAccount: String? = nil
    ) -> StripeAPI {
        StripeAPI(
            configuration: StripeConfiguration(
                secretKey: secretKey,
                apiVersion: apiVersion,
                connectedAccount: connectedAccount
            ),
            httpClient: .shared
        )
    }

    @Test("paths are appended to the base URL")
    func path() throws {
        let request = try Self.api().makeRequest(.GET, "v1/customers/cus_42")
        #expect(request.url == "https://api.stripe.com/v1/customers/cus_42")
        #expect(request.method == .GET)
    }

    @Test("the secret key is sent as a bearer token")
    func authorization() throws {
        let request = try Self.api().makeRequest(.GET, "v1/customers")
        #expect(request.headers.first(name: "Authorization") == "Bearer sk_test_123")
        #expect(request.headers.first(name: "Accept") == "application/json")
    }

    @Test("a pinned API version is sent")
    func apiVersion() throws {
        let request = try Self.api().makeRequest(.GET, "v1/customers")
        #expect(request.headers.first(name: "Stripe-Version") == "2024-06-20")
    }

    @Test("no version header when the configuration pins none")
    func noAPIVersion() throws {
        let request = try Self.api(apiVersion: nil).makeRequest(.GET, "v1/customers")
        #expect(request.headers.first(name: "Stripe-Version") == nil)
    }

    @Test("connected accounts are sent as Stripe-Account")
    func connectedAccount() throws {
        let request = try Self.api(connectedAccount: "acct_123")
            .makeRequest(.GET, "v1/customers")
        #expect(request.headers.first(name: "Stripe-Account") == "acct_123")
    }

    @Test("a body sets the form content type")
    func contentType() throws {
        let request = try Self.api().makeRequest(.POST, "v1/customers", body: Data("a=b".utf8))
        #expect(
            request.headers.first(name: "Content-Type") == "application/x-www-form-urlencoded"
        )
    }

    @Test("requests without a body carry no content type")
    func noContentType() throws {
        let request = try Self.api().makeRequest(.GET, "v1/customers")
        #expect(request.headers.first(name: "Content-Type") == nil)
    }

    @Test("query parameters are percent-encoded into the URL")
    func query() throws {
        let request = try Self.api().makeRequest(
            .GET,
            "v1/customers",
            query: [(key: "email", value: "ada@example.com"), (key: "limit", value: "5")]
        )
        #expect(request.url.contains("email=ada%40example.com"))
        #expect(request.url.contains("limit=5"))
    }
}

@Suite("StripeAPI response handling")
struct ResponseHandlingTests {

    @Test("a 2xx body decodes")
    func success() throws {
        let customer: Stripe.Customers.Customer = try StripeAPI.decode(
            status: 200,
            requestID: "req_1",
            body: Data(#"{"id":"cus_1","object":"customer","created":1,"livemode":false}"#.utf8)
        )
        #expect(customer.id == "cus_1")
    }

    @Test("a Stripe error payload becomes a typed error carrying the request id")
    func apiError() throws {
        let body = Data(#"""
        {"error":{"type":"card_error","code":"card_declined",
                  "message":"Your card was declined.","param":"payment_method"}}
        """#.utf8)

        do {
            let _: Stripe.Customers.Customer = try StripeAPI.decode(
                status: 402, requestID: "req_test_123", body: body
            )
            Issue.record("expected an error")
        } catch let error as StripeClientError {
            guard case .api(let status, let stripeError, let requestID) = error else {
                Issue.record("expected .api, got \(error)")
                return
            }
            #expect(status == 402)
            #expect(stripeError.message == "Your card was declined.")
            #expect(stripeError.param == "payment_method")
            #expect(requestID == "req_test_123")
        }
    }

    @Test("a non-Stripe error body falls back to unexpectedStatus")
    func unexpectedStatus() throws {
        do {
            let _: Stripe.Customers.Customer = try StripeAPI.decode(
                status: 502, requestID: nil, body: Data("<html>bad gateway</html>".utf8)
            )
            Issue.record("expected an error")
        } catch let error as StripeClientError {
            guard case .unexpectedStatus(let status, let body, _) = error else {
                Issue.record("expected .unexpectedStatus, got \(error)")
                return
            }
            #expect(status == 502)
            #expect(body.contains("bad gateway"))
        }
    }

    @Test("a malformed 2xx body surfaces as a decoding error")
    func decodingFailure() throws {
        do {
            let _: Stripe.Customers.Customer = try StripeAPI.decode(
                status: 200, requestID: nil, body: Data(#"{"unexpected":true}"#.utf8)
            )
            Issue.record("expected an error")
        } catch let error as StripeClientError {
            guard case .decoding = error else {
                Issue.record("expected .decoding, got \(error)")
                return
            }
        }
    }

    @Test("retry policy: 429 and 5xx retry, 4xx does not", arguments: [
        (429, true), (500, true), (503, true), (501, false),
        (400, false), (402, false), (404, false),
    ])
    func retryPolicy(status: Int, retryable: Bool) {
        let error = StripeClientError.unexpectedStatus(status: status, body: "", requestID: nil)
        #expect(error.isRetryable == retryable)
    }
}
