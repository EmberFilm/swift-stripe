//
//  ReportType.Retained.swift
//
//
//  Created by Andrew Edwards on 12/3/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/reporting/report_types/object.md

public struct ReportTypeList: Codable, Hashable, Sendable {
    public var object: String
    public var data: [ReportType]?
    public var hasMore: Bool?
    public var url: String?

    public init(
        object: String,
        data: [ReportType]? = nil,
        hasMore: Bool? = nil,
        url: String? = nil
    ) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}

// The ReportType struct is generated (Models/Generated). These are the nested types the
// request layer still names under `ReportType` that the generator spells differently.

