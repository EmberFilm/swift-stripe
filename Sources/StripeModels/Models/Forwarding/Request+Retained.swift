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

// The Request struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Forwarding.Request` that the generator spells differently.

// https://docs.stripe.com/api/forwarding/request/object.md

// MARK: - Nested Types

extension Stripe.Forwarding.Request {

    public struct Header: Codable, Hashable, Sendable {
        /// The header name.
        public var name: String?
        /// The header value.
        public var value: String?

        public init(name: String? = nil, value: String? = nil) {
            self.name = name
            self.value = value
        }
    }

    public enum HTTPMethod: String, Codable, Sendable {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
}
