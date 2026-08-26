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
import NIOCore
import NIOHTTP1

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Executes Stripe API requests: builds them, signs them, retries them, and.
/// decodes the result.
///
/// Resource clients are thin wrappers over this type.
public struct StripeAPI: Sendable {
    public let configuration: StripeConfiguration

    /// The `AsyncHTTPClient` used for every request.
    ///
    /// Not owned by this type: connection pooling and shutdown are the caller's.
    public let httpClient: HTTPClient

    private let formEncoder = StripeFormEncoder()

    public init(configuration: StripeConfiguration, httpClient: HTTPClient = .shared) {
        self.configuration = configuration
        self.httpClient = httpClient
    }

    /// Decoder matching Stripe's wire format.
    ///
    /// `.convertFromSnakeCase` is required: the model types declare plain
    /// camelCase properties. (The upstream package used `.useDefaultKeys` on the
    /// assumption that every model carried explicit `CodingKeys`; roughly half
    /// did not, so fields such as `invoice_prefix` and `has_more` silently
    /// decoded to `nil`.)
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

    // MARK: - Requests

    /// Sends a request with no body.
    ///
    /// - Parameters:
    ///   - method: The HTTP method.
    ///   - path: The path under the API host, such as `v1/customers`.
    ///   - as: The type to decode the response into; inferred from the call site.
    ///   - idempotencyKey: Sent as `Idempotency-Key`. Stripe replays the first response for a
    ///     repeated key, which is also what makes the request safe to retry.
    public func send<Response: Decodable>(
        _ method: HTTPMethod,
        _ path: String,
        as: Response.Type = Response.self,
        idempotencyKey: String? = nil
    ) async throws -> Response {
        try await perform(makeRequest(method, path, idempotencyKey: idempotencyKey))
    }

    /// Sends a request whose parameters are form-encoded into the body.
    ///
    /// - Parameters:
    ///   - method: The HTTP method.
    ///   - path: The path under the API host, such as `v1/customers`.
    ///   - body: The request, form-encoded by ``StripeFormEncoder``.
    ///   - as: The type to decode the response into; inferred from the call site.
    ///   - idempotencyKey: Sent as `Idempotency-Key`. Stripe replays the first response for a
    ///     repeated key, which is also what makes the request safe to retry.
    public func send<Body: Encodable, Response: Decodable>(
        _ method: HTTPMethod,
        _ path: String,
        body: Body,
        as: Response.Type = Response.self,
        idempotencyKey: String? = nil
    ) async throws -> Response {
        let encoded = try formEncoder.encode(body)
        return try await perform(
            makeRequest(method, path, body: Data(encoded.utf8), idempotencyKey: idempotencyKey)
        )
    }

    /// Sends a `GET` whose parameters are form-encoded into the query string.
    ///
    /// Stripe takes list filters as query parameters using the same bracket
    /// notation it accepts in bodies.
    public func list<Parameters: Encodable, Response: Decodable>(
        _ path: String,
        parameters: Parameters,
        as: Response.Type = Response.self
    ) async throws -> Response {
        let query = try formEncoder.pairs(of: parameters)
        return try await perform(makeRequest(.GET, path, query: query))
    }

    /// Uploads a file: the request fields and the file as `multipart/form-data`, to the files host.
    public func upload<Fields: Encodable, Response: Decodable>(
        _ path: String,
        fields: Fields,
        file: Stripe.Upload,
        as: Response.Type = Response.self,
        idempotencyKey: String? = nil
    ) async throws -> Response {
        let boundary = "swift-stripe-" + UUID().uuidString
        var body = Data()
        func part(_ header: String, _ bytes: Data) {
            body.append(Data("--\(boundary)\r\n\(header)\r\n\r\n".utf8))
            body.append(bytes)
            body.append(Data("\r\n".utf8))
        }
        for (key, value) in try formEncoder.pairs(of: fields) {
            part("Content-Disposition: form-data; name=\"\(key)\"", Data(value.utf8))
        }
        part(
            "Content-Disposition: form-data; name=\"file\"; filename=\"\(file.filename)\"\r\nContent-Type: \(file.contentType)",
            file.data
        )
        body.append(Data("--\(boundary)--\r\n".utf8))
        return try await perform(
            makeRequest(
                .POST,
                path,
                body: body,
                idempotencyKey: idempotencyKey,
                baseURL: configuration.filesBaseURL,
                contentType: "multipart/form-data; boundary=\(boundary)"
            )
        )
    }

    /// Fetches a binary document (a quote PDF) from the files host.
    public func download<Parameters: Encodable>(_ path: String, parameters: Parameters) async throws -> Data {
        let query = try formEncoder.pairs(of: parameters)
        return try await performRaw(makeRequest(.GET, path, query: query, baseURL: configuration.filesBaseURL))
    }

    public func download(_ path: String) async throws -> Data {
        try await performRaw(makeRequest(.GET, path, baseURL: configuration.filesBaseURL))
    }

    // MARK: - Building

    /// Builds the `HTTPClientRequest` for a Stripe call.
    ///
    /// Kept separate from ``perform(_:)`` so its output — URL, method, headers —
    /// can be asserted on directly in tests without issuing a request.
    func makeRequest(
        _ method: HTTPMethod,
        _ path: String,
        query: [(key: String, value: String)] = [],
        body: Data? = nil,
        idempotencyKey: String? = nil,
        baseURL: URL? = nil,
        contentType: String = "application/x-www-form-urlencoded"
    ) throws -> HTTPClientRequest {
        guard
            var components = URLComponents(
                url: (baseURL ?? configuration.baseURL).appendingPathComponent(path),
                resolvingAgainstBaseURL: false
            )
        else {
            throw StripeClientError.invalidURL(path)
        }
        if !query.isEmpty {
            components.percentEncodedQuery =
                query
                .map { "\(StripeFormEncoder.escape($0.key))=\(StripeFormEncoder.escape($0.value))" }
                .joined(separator: "&")
        }
        guard let url = components.url else {
            throw StripeClientError.invalidURL(path)
        }

        var request = HTTPClientRequest(url: url.absoluteString)
        request.method = method
        request.headers.add(name: "Authorization", value: "Bearer \(configuration.secretKey)")
        request.headers.add(name: "Accept", value: "application/json")
        if let version = configuration.apiVersion {
            request.headers.add(name: "Stripe-Version", value: version)
        }
        if let account = configuration.connectedAccount {
            request.headers.add(name: "Stripe-Account", value: account)
        }
        if let idempotencyKey {
            request.headers.add(name: Self.idempotencyKeyHeader, value: idempotencyKey)
        }
        if let body {
            request.headers.add(name: "Content-Type", value: contentType)
            request.body = .bytes(ByteBuffer(bytes: body))
        }
        return request
    }

    // MARK: - Execution

    /// The header Stripe deduplicates writes on.
    static let idempotencyKeyHeader = "Idempotency-Key"

    /// Whether a failed attempt at this request may be repeated.
    ///
    /// Reads always may. A write may only when it carries an idempotency key —
    /// without one, replaying a `429`/`5xx` risks a second charge, customer, or
    /// subscription, and losing the error is worse than surfacing it.
    static func isSafeToRetry(_ request: HTTPClientRequest) -> Bool {
        request.method == .GET
            || request.method == .HEAD
            || request.headers.contains(name: idempotencyKeyHeader)
    }

    private func perform<Response: Decodable>(
        _ request: HTTPClientRequest
    ) async throws -> Response {
        try await execute(request) { status, requestID, body in
            try Self.decode(status: status, requestID: requestID, body: body)
        }
    }

    private func performRaw(_ request: HTTPClientRequest) async throws -> Data {
        try await execute(request) { status, requestID, body in
            guard (200..<300).contains(status) else {
                // the files host answers errors with the same JSON envelope
                let _: Data = try Self.decode(status: status, requestID: requestID, body: body)
                throw StripeClientError.unexpectedStatus(status: status, body: String(decoding: body, as: UTF8.self), requestID: requestID)
            }
            return body
        }
    }

    private func execute<Result>(
        _ request: HTTPClientRequest,
        _ finish: (Int, String?, Data) throws -> Result
    ) async throws -> Result {
        var lastError: any Swift.Error = StripeClientError.unexpectedStatus(
            status: 0,
            body: "",
            requestID: nil
        )
        let maxRetries = Self.isSafeToRetry(request) ? configuration.maxRetries : 0

        for attempt in 0...max(0, maxRetries) {
            do {
                let response = try await httpClient.execute(
                    request,
                    timeout: .init(configuration.timeout)
                )
                // Stripe error payloads are small; successful list responses can
                // be large, so allow a generous ceiling rather than the default.
                let buffer = try await response.body.collect(upTo: 32 * 1024 * 1024)

                return try finish(
                    Int(response.status.code),
                    response.headers.first(name: "Request-Id"),
                    Data(buffer.readableBytesView)
                )
            } catch let error as StripeClientError where error.isRetryable {
                lastError = error
                guard attempt < maxRetries else { break }
                // Exponential backoff with a conservative ceiling: 0.5s, 1s, 2s, … capped at 8s.
                // Shifted rather than `pow`ed because FoundationEssentials resolves `pow` to the
                // `Decimal` overload, which `Duration.seconds` will not take.
                let backoff = min(0.5 * Double(1 << min(attempt, 8)), 8.0)
                try await Task.sleep(for: .seconds(backoff))
            }
        }
        throw lastError
    }

    /// Turns a raw Stripe response into a decoded value or a typed error.
    ///
    /// A pure function over the response, so every status-code and error-payload
    /// path is testable without a network.
    static func decode<Response: Decodable>(
        status: Int,
        requestID: String?,
        body: Data
    ) throws -> Response {
        guard (200..<300).contains(status) else {
            if let envelope = try? decoder.decode(StripeErrorEnvelope.self, from: body) {
                throw StripeClientError.api(
                    status: status,
                    error: envelope.error,
                    requestID: requestID
                )
            }
            throw StripeClientError.unexpectedStatus(
                status: status,
                body: String(decoding: body, as: UTF8.self),
                requestID: requestID
            )
        }

        do {
            return try decoder.decode(Response.self, from: body)
        } catch {
            throw StripeClientError.decoding(
                underlying: error,
                body: String(decoding: body, as: UTF8.self)
            )
        }
    }
}

/// Stripe nests failures under a top-level `error` key.
private struct StripeErrorEnvelope: Decodable {
    let error: StripeError.Error
}
