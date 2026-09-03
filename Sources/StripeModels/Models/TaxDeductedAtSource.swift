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

public struct TaxDeductedAtSource: Codable, Hashable, Sendable, Identifiable {
    public typealias ID = String
    public let id: ID
    /// String representing the object's type.
    public let object: String
    /// The end of the invoicing period.
    public var periodEnd: Date?
    /// The start of the invoicing period.
    public var periodStart: Date?
    /// The TAN that was supplied to Stripe when TDS was assessed.
    public var taxDeductionAccountNumber: String?

    public init(
        id: ID,
        object: String,
        periodEnd: Date? = nil,
        periodStart: Date? = nil,
        taxDeductionAccountNumber: String? = nil
    ) {
        self.id = id
        self.object = object
        self.periodEnd = periodEnd
        self.periodStart = periodStart
        self.taxDeductionAccountNumber = taxDeductionAccountNumber
    }
}
