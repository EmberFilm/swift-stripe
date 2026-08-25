//
//  StripeAPI.swift
//  swift-stripe
//

import AsyncHTTPClient
#if canImport(FoundationEssentials)
import FoundationEssentials
import NIOFoundationEssentialsCompat
#else
import Foundation
import NIOFoundationCompat
#endif
import NIOCore
import NIOHTTP1

/// Executes Stripe API requests: builds them, signs them, retries them, and
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
    public func send<Response: Decodable>(
        _ method: HTTPMethod,
        _ path: String,
        as: Response.Type = Response.self
    ) async throws -> Response {
        try await perform(makeRequest(method, path))
    }

    /// Sends a request whose parameters are form-encoded into the body.
    public func send<Body: Encodable, Response: Decodable>(
        _ method: HTTPMethod,
        _ path: String,
        body: Body,
        as: Response.Type = Response.self
    ) async throws -> Response {
        let encoded = try formEncoder.encode(body)
        return try await perform(makeRequest(method, path, body: Data(encoded.utf8)))
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

    // MARK: - Building

    /// Builds the `HTTPClientRequest` for a Stripe call.
    ///
    /// Kept separate from ``perform(_:)`` so its output — URL, method, headers —
    /// can be asserted on directly in tests without issuing a request.
    func makeRequest(
        _ method: HTTPMethod,
        _ path: String,
        query: [(key: String, value: String)] = [],
        body: Data? = nil
    ) throws -> HTTPClientRequest {
        guard var components = URLComponents(
            url: configuration.baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        ) else {
            throw StripeClientError.invalidURL(path)
        }
        if !query.isEmpty {
            components.percentEncodedQuery = query
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
        if let body {
            request.headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
            request.body = .bytes(ByteBuffer(data: body))
        }
        return request
    }

    // MARK: - Execution

    private func perform<Response: Decodable>(
        _ request: HTTPClientRequest
    ) async throws -> Response {
        var lastError: any Swift.Error = StripeClientError.unexpectedStatus(
            status: 0, body: "", requestID: nil
        )

        for attempt in 0...max(0, configuration.maxRetries) {
            do {
                let response = try await httpClient.execute(
                    request,
                    timeout: .init(configuration.timeout)
                )
                // Stripe error payloads are small; successful list responses can
                // be large, so allow a generous ceiling rather than the default.
                let buffer = try await response.body.collect(upTo: 32 * 1024 * 1024)

                return try Self.decode(
                    status: Int(response.status.code),
                    requestID: response.headers.first(name: "Request-Id"),
                    body: Data(buffer.readableBytesView)
                )
            } catch let error as StripeClientError where error.isRetryable {
                lastError = error
                guard attempt < configuration.maxRetries else { break }
                // Exponential backoff with a conservative ceiling.
                try await Task.sleep(for: .seconds(min(pow(2.0, Double(attempt)) * 0.5, 8.0)))
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
