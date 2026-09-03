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

/// If you have scheduled a Sigma query, you'll receive a `sigma.scheduled_query_run.created` webhook each time the query.
public struct ScheduledQueryRun: Codable, Hashable, Sendable, Identifiable {
    public typealias ID = String
    public let id: ID
    /// String representing the object's type.
    public let object: String
    /// Time at which the object was created.
    public var created: Date?
    /// When the query was run, Sigma contained a snapshot of your Stripe data at this time.
    public var dataLoadTime: Date?
    public var error: Error?
    /// The file object representing the results of the query.
    @Boxed public var file: Stripe.Files.File?
    /// If the object exists in live mode, the value is `true`.
    public var livemode: Bool?
    /// Time at which the result expires and is no longer available for download.
    public var resultAvailableUntil: Date?
    /// SQL for the query.
    public var sql: String?
    /// The query's execution status, which will be `completed` for successful runs, and `canceled`, `failed`, or `timed_out`.
    public var status: String?
    /// Title of the query.
    public var title: String?

    public init(
        id: ID,
        object: String,
        created: Date? = nil,
        dataLoadTime: Date? = nil,
        error: Error? = nil,
        file: Stripe.Files.File? = nil,
        livemode: Bool? = nil,
        resultAvailableUntil: Date? = nil,
        sql: String? = nil,
        status: String? = nil,
        title: String? = nil
    ) {
        self.id = id
        self.object = object
        self.created = created
        self.dataLoadTime = dataLoadTime
        self.error = error
        self._file = Boxed(wrappedValue: file)
        self.livemode = livemode
        self.resultAvailableUntil = resultAvailableUntil
        self.sql = sql
        self.status = status
        self.title = title
    }

    public struct Error: Codable, Hashable, Sendable {
        /// Information about the run failure.
        public var message: String?

        public init(
            message: String? = nil
        ) {
            self.message = message
        }
    }
}
