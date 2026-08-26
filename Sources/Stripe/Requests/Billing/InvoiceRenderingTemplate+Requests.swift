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

extension Stripe.Billing.InvoiceRenderingTemplate {
    public enum Archive {}
    public enum List {}
    public enum Retrieve {}
    public enum Unarchive {}
}

// POST /v1/invoice_rendering_templates/{template}/archive
extension Stripe.Billing.InvoiceRenderingTemplate.Archive {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.InvoiceRenderingTemplate
}

// GET /v1/invoice_rendering_templates
extension Stripe.Billing.InvoiceRenderingTemplate.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        public var status: Status?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            status: Status? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
            self.status = status
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case active
            case archived
        }
    }

    public typealias Response = Stripe.Page<Stripe.Billing.InvoiceRenderingTemplate>
}

// GET /v1/invoice_rendering_templates/{template}
extension Stripe.Billing.InvoiceRenderingTemplate.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        public var version: Int?

        public init(
            expand: [String]? = nil,
            version: Int? = nil
        ) {
            self.expand = expand
            self.version = version
        }
    }

    public typealias Response = Stripe.Billing.InvoiceRenderingTemplate
}

// POST /v1/invoice_rendering_templates/{template}/unarchive
extension Stripe.Billing.InvoiceRenderingTemplate.Unarchive {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Billing.InvoiceRenderingTemplate
}
