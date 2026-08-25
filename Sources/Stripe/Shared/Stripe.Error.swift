//
//  File.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe {
    package enum Error: LocalizedError, Equatable {
        case invalidResponse
        case httpError(statusCode: Int, message: String)

        package var errorDescription: String? {
            switch self {
            case .invalidResponse:
                return "Invalid response from server"

            case .httpError(let statusCode, let message):
                return "HTTP error \(statusCode): \(message)"
            }
        }
    }
}
