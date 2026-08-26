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

extension Stripe {
    /// One page of a list endpoint.
    ///
    /// Every generated `List.Response` is a `Page` of the resource. Pass the last element's
    /// `id` as `startingAfter` to fetch the next page while `hasMore` is true.
    public struct Page<Element: Codable & Hashable & Sendable>: Codable, Hashable, Sendable {
        /// String representing the object's type; always `list`.
        public let object: String
        public var data: [Element]
        /// True if this list has another page of items after this one that can be fetched.
        public var hasMore: Bool
        /// The URL where this list can be accessed.
        public var url: String
        /// The total number of items available, when the request asked for it.
        public var totalCount: Int?

        public init(object: String = "list", data: [Element], hasMore: Bool, url: String, totalCount: Int? = nil) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
            self.totalCount = totalCount
        }
    }

    /// One page of a search endpoint.
    ///
    /// Search paginates by `nextPage` token rather than by object ID: pass it as the next
    /// request's `page`.
    public struct SearchPage<Element: Codable & Hashable & Sendable>: Codable, Hashable, Sendable {
        /// String representing the object's type; always `search_result`.
        public let object: String
        public var data: [Element]
        /// True if this list has another page of items after this one that can be fetched.
        public var hasMore: Bool
        /// The URL where this list can be accessed.
        public var url: String
        /// The page token to pass as `page` to fetch the next page, while `hasMore` is true.
        public var nextPage: String?
        /// The total number of objects that match the query, when the request asked for it.
        public var totalCount: Int?

        public init(
            object: String = "search_result",
            data: [Element],
            hasMore: Bool,
            url: String,
            nextPage: String? = nil,
            totalCount: Int? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
            self.nextPage = nextPage
            self.totalCount = totalCount
        }
    }

    /// A timestamp or amount filter on a list endpoint: an exact value, or bounds.
    ///
    /// Encodes as `created=1700000000` or `created[gte]=…&created[lt]=…`, the two shapes Stripe
    /// accepts for `created`, `arrival_date`, `amount` and similar filters.
    public enum RangeQuery: Codable, Hashable, Sendable {
        case exactly(Int)
        case range(gt: Int? = nil, gte: Int? = nil, lt: Int? = nil, lte: Int? = nil)

        public static func exactly(_ date: Date) -> RangeQuery {
            .exactly(Int(date.timeIntervalSince1970))
        }

        public static func range(after: Date? = nil, before: Date? = nil) -> RangeQuery {
            .range(gte: after.map { Int($0.timeIntervalSince1970) }, lt: before.map { Int($0.timeIntervalSince1970) })
        }

        private enum CodingKeys: String, CodingKey {
            case gt, gte, lt, lte
        }

        public init(from decoder: any Decoder) throws {
            if let value = try? decoder.singleValueContainer().decode(Int.self) {
                self = .exactly(value)
                return
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self = .range(
                gt: try container.decodeIfPresent(Int.self, forKey: .gt),
                gte: try container.decodeIfPresent(Int.self, forKey: .gte),
                lt: try container.decodeIfPresent(Int.self, forKey: .lt),
                lte: try container.decodeIfPresent(Int.self, forKey: .lte)
            )
        }

        public func encode(to encoder: any Encoder) throws {
            switch self {
            case .exactly(let value):
                var container = encoder.singleValueContainer()
                try container.encode(value)
            case .range(let gt, let gte, let lt, let lte):
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encodeIfPresent(gt, forKey: .gt)
                try container.encodeIfPresent(gte, forKey: .gte)
                try container.encodeIfPresent(lt, forKey: .lt)
                try container.encodeIfPresent(lte, forKey: .lte)
            }
        }
    }
}
