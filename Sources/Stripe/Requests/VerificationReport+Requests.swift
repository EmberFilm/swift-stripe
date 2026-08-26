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

extension VerificationReport {
    public enum List {}
    public enum Retrieve {}
}

// GET /v1/identity/verification_reports
extension VerificationReport.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A string to reference this user.
        public var clientReferenceId: String?
        /// Only return VerificationReports that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return VerificationReports of this type.
        public var `type`: Type?
        /// Only return VerificationReports created by this VerificationSession ID.
        public var verificationSession: String?

        public init(
            clientReferenceId: String? = nil,
            created: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            `type`: Type? = nil,
            verificationSession: String? = nil
        ) {
            self.clientReferenceId = clientReferenceId
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
            self.`type` = `type`
            self.verificationSession = verificationSession
        }

        public enum `Type`: String, Codable, Hashable, Sendable {
            case document
            case idNumber = "id_number"
        }
    }

    public typealias Response = Stripe.Page<VerificationReport>
}

// GET /v1/identity/verification_reports/{report}
extension VerificationReport.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = VerificationReport
}
