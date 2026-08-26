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

extension Stripe.Setup.Attempt {
    public enum List {}
}

// GET /v1/setup_attempts
extension Stripe.Setup.Attempt.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A filter on the list, based on the object `created` field.
        public var created: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// Only return SetupAttempts created by the SetupIntent specified by this ID.
        public var setupIntent: String
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            created: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            setupIntent: String,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.setupIntent = setupIntent
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<Stripe.Setup.Attempt>
}
