//
//  StripeClientError.swift
//  swift-stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Failures raised by the client itself, as opposed to errors Stripe returns.
///
/// Stripe's own error payloads decode into `StripeError` (from `StripeTypes`)
/// and surface via ``api(status:error:requestID:)``.
public enum StripeClientError: Swift.Error, Sendable {
    /// Stripe returned a non-2xx status with a decodable error body.
    case api(status: Int, error: StripeError.Error, requestID: String?)

    /// Stripe returned a non-2xx status whose body was not a Stripe error.
    case unexpectedStatus(status: Int, body: String, requestID: String?)

    /// A 2xx response body did not decode into the expected type.
    case decoding(underlying: any Swift.Error, body: String)

    /// The request could not be built (bad path or query components).
    case invalidURL(String)
}

extension StripeClientError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .api(let status, let error, let requestID):
            let message = error.message ?? "no message"
            let code = error.code.map { " (\($0))" } ?? ""
            let request = requestID.map { " [request \($0)]" } ?? ""
            return "Stripe API error \(status): \(message)\(code)\(request)"
        case .unexpectedStatus(let status, let body, let requestID):
            let request = requestID.map { " [request \($0)]" } ?? ""
            return "Unexpected Stripe response \(status)\(request): \(body.prefix(500))"
        case .decoding(let underlying, let body):
            return "Failed to decode Stripe response: \(underlying). Body: \(body.prefix(500))"
        case .invalidURL(let path):
            return "Could not build a valid Stripe URL from path '\(path)'."
        }
    }
}

extension StripeClientError {
    /// Whether retrying the same request could plausibly succeed.
    var isRetryable: Bool {
        switch self {
        case .api(let status, _, _), .unexpectedStatus(let status, _, _):
            // 429 rate limit, and 5xx other than 501.
            return status == 429 || (status >= 500 && status != 501)
        default:
            return false
        }
    }
}
