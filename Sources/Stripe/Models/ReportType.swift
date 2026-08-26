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

/// The Report Type resource corresponds to a particular type of report, such as the "Activity summary" or.
public struct ReportType: Codable, Hashable, Sendable, Identifiable {
    public typealias ID = String
    public let id: ID
    /// String representing the object's type.
    public let object: String
    /// Most recent time for which this Report Type is available.
    public var dataAvailableEnd: Date?
    /// Earliest time for which this Report Type is available.
    public var dataAvailableStart: Date?
    /// List of column names that are included by default when this Report Type gets run.
    public var defaultColumns: [String]?
    /// If the object exists in live mode, the value is `true`.
    public var livemode: Bool?
    /// Human-readable name of the Report Type.
    public var name: String?
    /// When this Report Type was latest updated.
    public var updated: Date?
    /// Version of the Report Type.
    public var version: Int?

    public init(
        id: ID,
        object: String,
        dataAvailableEnd: Date? = nil,
        dataAvailableStart: Date? = nil,
        defaultColumns: [String]? = nil,
        livemode: Bool? = nil,
        name: String? = nil,
        updated: Date? = nil,
        version: Int? = nil
    ) {
        self.id = id
        self.object = object
        self.dataAvailableEnd = dataAvailableEnd
        self.dataAvailableStart = dataAvailableStart
        self.defaultColumns = defaultColumns
        self.livemode = livemode
        self.name = name
        self.updated = updated
        self.version = version
    }
}
