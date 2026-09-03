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

//
//  Application.swift
//
//
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/application/object.md

extension Stripe.Connect {
    /// The [Application Object](https://stripe.com/docs/api/application/object).
    public struct Application: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// The name of the application.
        public var name: String?
        /// String representing the object’s type.
        ///
        /// Objects of the same type share the same value.
        public var object: String

        public init(
            id: ID,
            name: String? = nil,
            object: String
        ) {
            self.id = id
            self.name = name
            self.object = object
        }
    }
}
