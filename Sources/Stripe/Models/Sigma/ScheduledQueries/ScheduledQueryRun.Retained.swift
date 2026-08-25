//
//  ScheduledQueryRun.Retained.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/sigma/scheduled_query_runs/object.md

public struct ScheduledQueryRunList: Codable, Hashable, Sendable {
    public var object: String
    public var data: [ScheduledQueryRun]?
    public var hasMore: Bool?
    public var url: String?

    public init(
        object: String,
        data: [ScheduledQueryRun]? = nil,
        hasMore: Bool? = nil,
        url: String? = nil
    ) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}

public struct ScheduledQueryRunError: Codable, Hashable, Sendable {
    /// Information about the run failure.
    public var message: String?

    public init(
        message: String? = nil
    ) {
        self.message = message
    }
}

public enum ScheduledQueryRunStatus: String, Codable, Sendable {
    case completed
    case canceled
    case failed
    case timedOut = "time_out"
}

// The ScheduledQueryRun struct is generated (Models/Generated). These are the nested types the
// request layer still names under `ScheduledQueryRun` that the generator spells differently.

