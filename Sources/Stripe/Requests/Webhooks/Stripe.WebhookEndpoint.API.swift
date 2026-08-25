#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.WebhookEndpoint {
    // https://docs.stripe.com/api/webhook_endpoints/create.md
    public enum Create {}

    // https://docs.stripe.com/api/webhook_endpoints/update.md
    public enum Update {}

    // https://docs.stripe.com/api/webhook_endpoints/list.md
    public enum List {}
}

extension Stripe.WebhookEndpoint.Create {
    public struct Request: Codable, Equatable, Sendable {
        public let url: String
        public let enabledEvents: [String]
        public let apiVersion: String?
        public let connect: Bool?
        public let description: String?
        public let metadata: [String: String]?

        public init(
            url: String,
            enabledEvents: [String],
            apiVersion: String? = nil,
            connect: Bool? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil
        ) {
            self.url = url
            self.enabledEvents = enabledEvents
            self.apiVersion = apiVersion
            self.connect = connect
            self.description = description
            self.metadata = metadata
        }

        private enum CodingKeys: String, CodingKey {
            case url
            case enabledEvents
            case apiVersion
            case connect
            case description
            case metadata
        }
    }
}

extension Stripe.WebhookEndpoint.Update {
    public struct Request: Codable, Equatable, Sendable {
        public let url: String?
        public let enabledEvents: [String]?
        public let description: String?
        public let disabled: Bool?
        public let metadata: [String: String]?

        public init(
            url: String? = nil,
            enabledEvents: [String]? = nil,
            description: String? = nil,
            disabled: Bool? = nil,
            metadata: [String: String]? = nil
        ) {
            self.url = url
            self.enabledEvents = enabledEvents
            self.description = description
            self.disabled = disabled
            self.metadata = metadata
        }

        private enum CodingKeys: String, CodingKey {
            case url
            case enabledEvents
            case description
            case disabled
            case metadata
        }
    }
}

extension Stripe.WebhookEndpoint.List {
    public struct Request: Codable, Equatable, Sendable {
        public let endingBefore: String?
        public let limit: Int?
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
        public let data: [Webhook]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}
