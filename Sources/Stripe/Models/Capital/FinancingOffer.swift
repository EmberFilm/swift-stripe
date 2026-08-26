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

extension Stripe.Capital {
    public struct FinancingOffer: Codable, Equatable, Sendable, Identifiable {
        public typealias ID = String

        public let id: ID
        public let object: String
        public let account: String
        public let created: Date
        public let expiresAfter: Date
        public let financingType: String
        public let livemode: Bool
        public let offeredTerms: OfferedTerms
        public let productType: String
        public let status: Status

        public struct OfferedTerms: Codable, Equatable, Sendable {
            public let advanceAmount: Int
            public let campaignType: String
            public let currency: Stripe.Currency
            public let feeAmount: Int
            public let previousFinancingFeeDiscountRate: Double?
            public let withholdRate: Double

        }

        public enum Status: String, Codable, Equatable, Sendable {
            case undelivered
            case delivered
            case accepted
            case declined
            case canceled
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case account
            case created
            case expiresAfter
            case financingType
            case livemode
            case offeredTerms
            case productType
            case status
        }
    }
}
