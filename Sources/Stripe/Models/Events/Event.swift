//
//  Event.swift
//  Stripe
//
//  Created by Andrew Edwards on 12/8/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/events/object.md

extension Stripe.Events {
    /// A snapshot event, as delivered to a webhook endpoint or listed from `/v1/events`.
    ///
    /// Decoding is strict about the envelope and about the object it carries — a malformed
    /// payload throws, so a webhook endpoint answers 5xx and Stripe redelivers — but lenient
    /// about novelty: an event type this package does not model leaves `type` nil with the wire
    /// string in `rawType`, and an object it does not model decodes as `Object.unknown(type:)`.
    ///
    /// The payload's shape follows the API version of the webhook endpoint (`apiVersion`), not
    /// the version this package sends on requests. Set the endpoint's version to
    /// ``Stripe/generatedAPIVersion`` so the two agree.
    public struct Event: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public var id: ID
        /// String representing the object's type; always `event`.
        public var object: String
        /// The Stripe API version the payload was rendered with.
        public var apiVersion: String
        public var created: Date
        /// The object the event is about, and what changed.
        public var data: Data
        public var livemode: Bool
        /// Webhooks yet to be successfully delivered for this event.
        public var pendingWebhooks: Int
        /// The event's type, or `nil` for a type newer than this package. `rawType` always has it.
        public var type: `Type`?
        /// The event's type as Stripe sent it.
        public var rawType: String
        /// The API request that caused the event, when there was one.
        public var request: Request?
        /// The connected account the event is for, on Connect webhooks.
        public var account: String?
        public var context: String?

        public init(
            id: ID,
            object: String = "event",
            apiVersion: String,
            created: Date,
            data: Data,
            livemode: Bool,
            pendingWebhooks: Int = 0,
            type: `Type`? = nil,
            rawType: String? = nil,
            request: Request? = nil,
            account: String? = nil,
            context: String? = nil
        ) {
            self.id = id
            self.object = object
            self.apiVersion = apiVersion
            self.created = created
            self.data = data
            self.livemode = livemode
            self.pendingWebhooks = pendingWebhooks
            self.type = type
            self.rawType = rawType ?? type?.rawValue ?? ""
            self.request = request
            self.account = account
            self.context = context
        }

        // `rawType` is read from `type`; it is not a wire field.
        private enum CodingKeys: String, CodingKey {
            case id, object, apiVersion, created, data, livemode, pendingWebhooks, type, request, account, context
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(ID.self, forKey: .id)
            self.object = try container.decode(String.self, forKey: .object)
            self.apiVersion = try container.decode(String.self, forKey: .apiVersion)
            self.created = try container.decode(Date.self, forKey: .created)
            self.data = try container.decode(Data.self, forKey: .data)
            self.livemode = try container.decode(Bool.self, forKey: .livemode)
            self.pendingWebhooks = try container.decode(Int.self, forKey: .pendingWebhooks)
            self.rawType = try container.decode(String.self, forKey: .type)
            self.type = `Type`(rawValue: rawType)
            self.request = try container.decodeIfPresent(Request.self, forKey: .request)
            self.account = try container.decodeIfPresent(String.self, forKey: .account)
            self.context = try container.decodeIfPresent(String.self, forKey: .context)
        }
    }
}

extension Stripe.Events.Event {
    public struct Data: Codable, Hashable, Sendable {
        /// The object the event is about, at the time of the event.
        public var object: Stripe.Events.Event.Object
        /// On `*.updated` events, the attributes that changed with their previous values, keyed
        /// by wire name and shaped as they are on the object.
        public var previousAttributes: [String: Stripe.JSONValue]?

        public init(object: Stripe.Events.Event.Object, previousAttributes: [String: Stripe.JSONValue]? = nil) {
            self.object = object
            self.previousAttributes = previousAttributes
        }
    }

    public struct Request: Codable, Hashable, Sendable {
        /// The request that caused the event, if any; `nil` for events Stripe originates.
        public var id: String?
        /// The idempotency key of that request, if it carried one.
        public var idempotencyKey: String?

        public init(id: String? = nil, idempotencyKey: String? = nil) {
            self.id = id
            self.idempotencyKey = idempotencyKey
        }
    }
}
