//
//  ReportRun.Retained.swift
//
//
//  Created by Andrew Edwards on 12/3/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/reporting/report_runs/object.md

public struct ReportRunParameters: Codable, Hashable, Sendable {
    /// The set of output columns requested for inclusion in the report run.
    public var columns: [String]?
    /// Connected account ID by which to filter the report run.
    public var connectedAccount: String?
    /// Currency of objects to be included in the report run.
    public var currency: Stripe.Currency?
    /// Ending timestamp of data to be included in the report run (exclusive).
    public var intervalEnd: Date?
    /// Starting timestamp of data to be included in the report run.
    public var intervalStart: Date?
    /// Payout ID by which to filter the report run.
    public var payout: Stripe.Payouts.Payout.ID?
    /// Category of balance transactions to be included in the report run.
    public var reportingCategory: String?
    /// Defaults to Etc/UTC. The output timezone for all timestamps in the report. A list of possible time zone values is maintained at the IANA Time Zone Database. Has no effect on `interval_start` or `interval_end`.
    public var timezone: String?

    public init(
        columns: [String]? = nil,
        connectedAccount: String? = nil,
        currency: Stripe.Currency? = nil,
        intervalEnd: Date? = nil,
        intervalStart: Date? = nil,
        payout: Stripe.Payouts.Payout.ID? = nil,
        reportingCategory: String? = nil,
        timezone: String? = nil
    ) {
        self.columns = columns
        self.connectedAccount = connectedAccount
        self.currency = currency
        self.intervalEnd = intervalEnd
        self.intervalStart = intervalStart
        self.payout = payout
        self.reportingCategory = reportingCategory
        self.timezone = timezone
    }
}

public enum ReportRunStatus: String, Codable, Sendable {
    case pending
    case succeeded
    case failed
}

public struct ReportRunList: Codable, Hashable, Sendable {
    public var object: String
    public var data: [ReportRun]?
    public var hasMore: Bool?
    public var url: String?

    public init(
        object: String,
        data: [ReportRun]? = nil,
        hasMore: Bool? = nil,
        url: String? = nil
    ) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}

// The ReportRun struct is generated (Models/Generated). These are the nested types the
// request layer still names under `ReportRun` that the generator spells differently.

