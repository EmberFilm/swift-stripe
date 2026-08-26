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
