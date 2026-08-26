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

extension Stripe.Tax {
    /// Tax codes classify goods and services for tax purposes.
    public struct Code: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// A detailed description of which types of products the tax code represents.
        public var description: String?
        /// A short name for the tax code.
        public var name: String?

        public init(
            id: ID,
            object: String,
            description: String? = nil,
            name: String? = nil
        ) {
            self.id = id
            self.object = object
            self.description = description
            self.name = name
        }
    }
}
