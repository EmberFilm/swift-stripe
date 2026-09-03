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

import StripeCore
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Forwarding.Request {
    public enum Create {}
    public enum List {}
    public enum Retrieve {}
}

// POST /v1/forwarding/requests
extension Stripe.Forwarding.Request.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The PaymentMethod to insert into the forwarded request.
        public var paymentMethod: String
        /// The field kinds to be replaced in the forwarded request.
        public var replacements: [Replacements]
        /// The request body and headers to be sent to the destination endpoint.
        public var request: Request?
        /// The destination URL for the forwarded request.
        public var url: String

        public init(
            expand: [String]? = nil,
            metadata: [String: String]? = nil,
            paymentMethod: String,
            replacements: [Replacements],
            request: Request? = nil,
            url: String
        ) {
            self.expand = expand
            self.metadata = metadata
            self.paymentMethod = paymentMethod
            self.replacements = replacements
            self.request = request
            self.url = url
        }

        public enum Replacements: String, Codable, Hashable, Sendable {
            case cardCvc = "card_cvc"
            case cardExpiry = "card_expiry"
            case cardNumber = "card_number"
            case cardholderName = "cardholder_name"
            case requestSignature = "request_signature"
        }

        /// The request body and headers to be sent to the destination endpoint.
        public struct Request: Codable, Hashable, Sendable {
            /// The body payload to send to the destination endpoint.
            public var body: String?
            /// The headers to include in the forwarded request.
            public var headers: [Headers]?

            public init(
                body: String? = nil,
                headers: [Headers]? = nil
            ) {
                self.body = body
                self.headers = headers
            }

            public struct Headers: Codable, Hashable, Sendable {
                /// The header name.
                public var name: String
                /// The header value.
                public var value: String

                public init(
                    name: String,
                    value: String
                ) {
                    self.name = name
                    self.value = value
                }
            }
        }
    }

    public typealias Response = Stripe.Forwarding.Request
}

// GET /v1/forwarding/requests
extension Stripe.Forwarding.Request.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Similar to other List endpoints, filters results based on created timestamp.
        public var created: Created?
        /// A pagination cursor to fetch the previous page of the list.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A pagination cursor to fetch the next page of the list.
        public var startingAfter: String?

        public init(
            created: Created? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }

        /// Similar to other List endpoints, filters results based on created timestamp.
        public struct Created: Codable, Hashable, Sendable {
            /// Return results where the `created` field is greater than this value.
            public var gt: Int?
            /// Return results where the `created` field is greater than or equal to this value.
            public var gte: Int?
            /// Return results where the `created` field is less than this value.
            public var lt: Int?
            /// Return results where the `created` field is less than or equal to this value.
            public var lte: Int?

            public init(
                gt: Int? = nil,
                gte: Int? = nil,
                lt: Int? = nil,
                lte: Int? = nil
            ) {
                self.gt = gt
                self.gte = gte
                self.lt = lt
                self.lte = lte
            }
        }
    }

    public typealias Response = Stripe.Page<Stripe.Forwarding.Request>
}

// GET /v1/forwarding/requests/{id}
extension Stripe.Forwarding.Request.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Forwarding.Request
}
