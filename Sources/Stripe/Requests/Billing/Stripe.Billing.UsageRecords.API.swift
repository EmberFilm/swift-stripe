#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Billing.UsageRecords {
    public struct UsageRecord: Codable, Equatable, Sendable, Identifiable {
        public let id: ID
        public let object: String
        public let livemode: Bool
        public let quantity: Int
        public let subscriptionItem: String
        public let timestamp: Int

        public typealias ID = String

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case livemode
            case quantity
            case subscriptionItem
            case timestamp
        }
    }
}

// MARK: - Create
extension Stripe.Billing.UsageRecords {
    public enum Create {}
}

extension Stripe.Billing.UsageRecords.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The usage quantity for the specified timestamp.
        public let quantity: Int

        /// The timestamp for the usage event. This timestamp must be within the current billing period of the subscription of the provided subscription_item.
        public let timestamp: Either<Int, Keyword>

        /// Valid values are increment (default) or set. When using increment the specified quantity will be added to the usage at the specified timestamp. The set action will overwrite the usage quantity at that timestamp. If the subscription has billing thresholds, increment is the only allowed value.
        public let action: Action?

        public enum Keyword: String, Codable, Equatable, Sendable {
            case now
        }

        public enum Action: String, Codable, Equatable, Sendable {
            case increment
            case set
        }

        public init(
            quantity: Int,
            timestamp: Either<Int, Keyword> = .right(.now),
            action: Action? = nil
        ) {
            self.quantity = quantity
            self.timestamp = timestamp
            self.action = action
        }
    }
}

extension Stripe.Billing.UsageRecords.Create.Request {
    /// Flat single-value coding union for the usage-record timestamp.
    ///
    /// Stripe encodes this field as a bare integer or the bare string `now`, not as
    /// a tagged object, so this type owns its own single-value `Codable` shape. It
    /// deliberately does NOT reuse `Either_Primitives.Either`, whose synthesized
    /// `Codable` conformance is keyed rather than flat, and it is nested here rather
    /// than declared at module scope so it cannot shadow that primitive.
    public enum Either<A: Codable & Equatable & Sendable, B: Codable & Equatable & Sendable>:
        Codable,
        Equatable, Sendable
    {
        case left(A)
        case right(B)

        // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
        // signature. The standard library declares the requirement with untyped `throws`, so
        // the thrown type cannot be narrowed here without failing to satisfy it.
        // swiftlint:disable:next typed_throws_required
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            // REASON: probing a decoding container for an alternative payload shape. `decode` throws
            // the standard library's untyped error domain, and a failed probe is control flow here —
            // the next shape is attempted — not an error this type can classify.
            // swiftlint:disable:next no_try_optional
            if let a = try? container.decode(A.self) {
                self = .left(a)
                // REASON: probing a decoding container for an alternative payload shape. `decode` throws
                // the standard library's untyped error domain, and a failed probe is control flow here —
                // the next shape is attempted — not an error this type can classify.
                // swiftlint:disable:next no_try_optional
            } else if let b = try? container.decode(B.self) {
                self = .right(b)
            } else {
                throw DecodingError.typeMismatch(
                    Either.self,
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Could not decode Either"
                    )
                )
            }
        }

        // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
        // signature. The standard library declares the requirement with untyped `throws`, so
        // the thrown type cannot be narrowed here without failing to satisfy it.
        // swiftlint:disable:next typed_throws_required
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .left(let a):
                try container.encode(a)

            case .right(let b):
                try container.encode(b)
            }
        }
    }
}

// MARK: - List
extension Stripe.Billing.UsageRecords {
    public enum List {}
}

extension Stripe.Billing.UsageRecords.List {
    public struct Request: Codable, Equatable, Sendable {
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public let endingBefore: String?

        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public let limit: Int?

        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public let startingAfter: String?

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }

        private enum CodingKeys: String, CodingKey {
            case endingBefore
            case limit
            case startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.UsageRecords.UsageRecord]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}
