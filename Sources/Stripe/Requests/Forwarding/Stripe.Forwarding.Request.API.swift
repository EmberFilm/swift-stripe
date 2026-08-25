#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Forwarding.Request {
    // https://docs.stripe.com/api/forwarding/request/create.md
    public enum Create {}
    public enum List {}
}

extension Stripe.Forwarding.Request.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The PaymentMethod to insert into the forwarded request. Forwarding previously consumed PaymentMethods is allowed.
        public var paymentMethod: String
        /// The field replacement set for this object.
        public var replacements: [Stripe.Forwarding.Request.Replacement]
        /// The destination URL for the forwarded request. Must be supported by the config.
        public var url: String
        /// The headers to include in the forwarded request. Can be omitted if no additional headers (excluding Stripe-generated ones such as the Content-Type header) should be included.
        public var requestHeaders: [Stripe.Forwarding.Request.Header]?
        /// The body payload to send to the destination endpoint.
        public var requestBody: String?

        private enum CodingKeys: String, CodingKey {
            case paymentMethod
            case replacements
            case url
            case requestHeaders = "request[headers]"
            case requestBody = "request[body]"
        }

        public init(
            paymentMethod: String,
            replacements: [Stripe.Forwarding.Request.Replacement],
            url: String,
            requestHeaders: [Stripe.Forwarding.Request.Header]? = nil,
            requestBody: String? = nil
        ) {
            self.paymentMethod = paymentMethod
            self.replacements = replacements
            self.url = url
            self.requestHeaders = requestHeaders
            self.requestBody = requestBody
        }
    }
}

extension Stripe.Forwarding.Request.List {
    public struct Request: Codable, Equatable, Sendable {
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_bar, your subsequent call can include ending_before=obj_bar in order to fetch the previous page of the list.
        public var endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public var limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include starting_after=obj_foo in order to fetch the next page of the list.
        public var startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case endingBefore
            case limit
            case startingAfter
        }

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }
}

extension Stripe.Forwarding.Request.List {
    public struct Response: Codable, Hashable, Sendable {
        public var object: String
        public var data: [Stripe.Forwarding.Request]?
        public var hasMore: Bool?
        public var url: String?

        private enum CodingKeys: String, CodingKey {
            case object
            case data
            case hasMore
            case url
        }

        public init(
            object: String,
            data: [Stripe.Forwarding.Request]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
        }
    }
}
