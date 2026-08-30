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

extension Stripe.Billing.FeedbackOption {
    public enum Create {}
    public enum Deactivate {}
    public enum List {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/billing/feedback_options
extension Stripe.Billing.FeedbackOption.Create {
    public struct Request: Codable, Hashable, Sendable {
        public var description: String
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            description: String,
            expand: [String]? = nil
        ) {
            self.description = description
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.FeedbackOption
}

// POST /v1/billing/feedback_options/{id}/deactivate
extension Stripe.Billing.FeedbackOption.Deactivate {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.FeedbackOption
}

// GET /v1/billing/feedback_options
extension Stripe.Billing.FeedbackOption.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Filter results to only include feedback options with the given status.
        public var status: Status?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            status: Status? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
            self.status = status
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case active
            case inactive
        }
    }

    public typealias Response = Stripe.Page<Stripe.Billing.FeedbackOption>
}

// GET /v1/billing/feedback_options/{id}
extension Stripe.Billing.FeedbackOption.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.FeedbackOption
}

// POST /v1/billing/feedback_options/{id}
extension Stripe.Billing.FeedbackOption.Update {
    public struct Request: Codable, Hashable, Sendable {
        public var description: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            description: String? = nil,
            expand: [String]? = nil
        ) {
            self.description = description
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.FeedbackOption
}
