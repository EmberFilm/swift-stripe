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

import StripeCore
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension TerminalConnectionToken {
    public enum Create {}
}

// POST /v1/terminal/connection_tokens
extension TerminalConnectionToken.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The id of the location that this connection token is scoped to.
        public var location: String?

        public init(
            expand: [String]? = nil,
            location: String? = nil
        ) {
            self.expand = expand
            self.location = location
        }
    }

    public typealias Response = TerminalConnectionToken
}
