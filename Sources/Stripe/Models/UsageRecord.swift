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

// https://docs.stripe.com/api/subscriptionItems/usage_record.md

public struct UsageRecord: Codable, Hashable, Sendable, Identifiable {
    public typealias ID = String
    /// Unique identifier for the object.
    public var id: ID
    /// String representing the object’s type.
    ///
    /// Objects of the same type share the same value.
    public var object: String
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool
    /// The usage quantity for the specified date.
    public var quantity: Int?
    /// The ID of the subscription item this usage record contains data for.
    public var subscriptionItem: String?
    /// The timestamp when this usage occurred.
    public var timestamp: Date?

    public init(
        id: ID,
        object: String,
        livemode: Bool,
        quantity: Int? = nil,
        subscriptionItem: String? = nil,
        timestamp: Date? = nil
    ) {
        self.id = id
        self.object = object
        self.livemode = livemode
        self.quantity = quantity
        self.subscriptionItem = subscriptionItem
        self.timestamp = timestamp
    }
}

public enum UsageRecordAction: String, Codable, Sendable {
    case set
    case increment
}

public struct UsageRecordSummary: Codable, Hashable, Sendable, Identifiable {
    public typealias ID = String
    /// Unique identifier for the object.
    public var id: ID
    /// String representing the object's type.
    ///
    /// Objects of the same type share the same value.
    public var object: String
    /// The invoice in which this usage period has been billed for.
    public var invoice: Stripe.Billing.Invoice.ID?
    /// Has the value `true`if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool
    ///
    public var period: UsageRecordSummaryPeriod?
    /// The ID of the subscription item this summary is describing.
    public var subscriptionItem: String?
    /// The total usage within this usage period.
    public var totalUsage: Int?

    public init(
        id: ID,
        object: String,
        invoice: Stripe.Billing.Invoice.ID? = nil,
        livemode: Bool,
        period: UsageRecordSummaryPeriod? = nil,
        subscriptionItem: String? = nil,
        totalUsage: Int? = nil
    ) {
        self.id = id
        self.object = object
        self.invoice = invoice
        self.livemode = livemode
        self.period = period
        self.subscriptionItem = subscriptionItem
        self.totalUsage = totalUsage
    }
}

public struct UsageRecordSummaryPeriod: Codable, Hashable, Sendable {
    /// The end date of this usage period.
    ///
    /// All usage up to and including this point in time is included.
    public var end: Date?
    /// The start date of this usage period.
    ///
    /// All usage after this point in time is included.
    public var start: Date?

    public init(
        end: Date? = nil,
        start: Date? = nil
    ) {
        self.end = end
        self.start = start
    }
}

public struct UsageRecordSummaryList: Codable, Hashable, Sendable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [UsageRecordSummary]?

    public init(
        object: String,
        hasMore: Bool? = nil,
        url: String? = nil,
        data: [UsageRecordSummary]? = nil
    ) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
