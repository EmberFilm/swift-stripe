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
    public struct FinancingSummary: Codable, Equatable, Sendable {
        public let object: String
        public let details: Details?
        public let financingOffer: String?
        public let status: String

        public struct Details: Codable, Equatable, Sendable {
            public let advanceAmount: Int
            public let advancePaidOutAt: Date?
            public let currency: Stripe.Currency
            public let currentRepaymentInterval: String?
            public let feeAmount: Int
            public let paidAmount: Int
            public let remainingAmount: Int
            public let repaymentsBeginAt: Date?
            public let withholdRate: Double

        }

        private enum CodingKeys: String, CodingKey {
            case object
            case details
            case financingOffer
            case status
        }
    }
}
