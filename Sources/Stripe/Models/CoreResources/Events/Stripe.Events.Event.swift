//
//  Event.swift
//
//
//  Created by Andrew Edwards on 12/8/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/events/object.md

/// The [Event Object](https://stripe.com/docs/api/events/object)
extension Stripe.Events {
    public struct Event: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// The Stripe API version used to render data. Note: This property is populated only for events on or after October 31, 2014.
        public var apiVersion: String?
        /// Object containing data associated with the event.
        public var data: Stripe.Events.Event.Data?
        /// Information on the API request that instigated the event.
        public var request: Stripe.Events.Event.Request?
        /// Description of the event (e.g., invoice.created or charge.refunded).
        public var type: Stripe.Events.Event.`Type`?
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// The connected account that originated the event.
        public var account: String?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// Number of webhooks that have yet to be successfully delivered (i.e., to return a 20x response) to the URLs you've specified.
        public var pendingWebhooks: Int?
        /// Authentication context needed to fetch the event or related object.
        public var context: String?
        /// The event type exactly as Stripe sent it, including types this package does not model.
        ///
        /// ``type`` is `nil` for an event Stripe has added since this package was built; this
        /// carries the string either way, so an unrecognised event can still be logged or routed.
        public var rawType: String?

        public init(
            id: ID,
            apiVersion: String? = nil,
            data: Stripe.Events.Event.Data? = nil,
            request: Stripe.Events.Event.Request? = nil,
            type: Stripe.Events.Event.`Type`? = nil,
            object: String,
            account: String? = nil,
            created: Date? = nil,
            livemode: Bool? = nil,
            pendingWebhooks: Int? = nil,
            context: String? = nil,
            rawType: String? = nil
        ) {
            self.id = id
            self.apiVersion = apiVersion
            self.data = data
            self.request = request
            self.type = type
            self.object = object
            self.account = account
            self.created = created
            self.livemode = livemode
            self.pendingWebhooks = pendingWebhooks
            self.context = context
            self.rawType = rawType ?? type?.rawValue
        }

        private enum CodingKeys: String, CodingKey {
            case id, apiVersion, data, request, type, object, account, created, livemode
            case pendingWebhooks, context
        }

        /// Decodes an event without letting an unrecognised payload reject the delivery.
        ///
        /// A webhook endpoint receives whatever event types are enabled on it, and Stripe adds new
        /// ones over time. Failing to decode one means answering Stripe with an error and being
        /// redelivered the same event forever, so ``type`` and ``data`` degrade to `nil` rather
        /// than throwing; ``rawType`` still reports what arrived.
        // REASON: the `Swift.Decodable` requirement is declared with untyped `throws`, so the
        // thrown type cannot be narrowed here without failing to satisfy it.
        // swiftlint:disable:next typed_throws_required
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(ID.self, forKey: .id)
            self.object = try container.decode(String.self, forKey: .object)
            self.apiVersion = try container.decodeIfPresent(String.self, forKey: .apiVersion)
            self.request = try container.decodeIfPresent(Request.self, forKey: .request)
            self.account = try container.decodeIfPresent(String.self, forKey: .account)
            self.created = try container.decodeIfPresent(Date.self, forKey: .created)
            self.livemode = try container.decodeIfPresent(Bool.self, forKey: .livemode)
            self.pendingWebhooks = try container.decodeIfPresent(Int.self, forKey: .pendingWebhooks)
            self.context = try container.decodeIfPresent(String.self, forKey: .context)
            self.rawType = try container.decodeIfPresent(String.self, forKey: .type)
            self.type = try? container.decodeIfPresent(`Type`.self, forKey: .type)
            self.data = try? container.decodeIfPresent(Data.self, forKey: .data)
        }
    }
}

extension Stripe.Events.Event {
    public struct Data: Codable, Hashable, Sendable {
        /// Object containing the API resource relevant to the event. For example, an `invoice.created` event will have a full [invoice object](https://stripe.com/docs/api/events/object#invoice_object) as the value of the object key.
        public var object: Stripe.Events.Event.Object

        // TODO: - Figure out how to decode this.
        // Object containing the names of the attributes that have changed, and their previous values (sent along only with *.updated events).
        // public var previousAttributes: [String: Any]?

        public init(
            object: Stripe.Events.Event.Object
        ) {
            self.object = object
        }
    }
}

extension Stripe.Events.Event {
    public struct Request: Codable, Hashable, Sendable {
        /// ID of the API request that caused the event. If null, the event was automatic (e.g., Stripe's automatic subscription handling). Request logs are available in the dashboard, but currently not in the API.
        public var id: String?
        /// The idempotency key transmitted during the request, if any. Note: This property is populated only for events on or after May 23, 2017.
        public var idempotencyKey: String?

        public init(
            id: String? = nil,
            idempotencyKey: String? = nil
        ) {
            self.id = id
            self.idempotencyKey = idempotencyKey
        }
    }
}
