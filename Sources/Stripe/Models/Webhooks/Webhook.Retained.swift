//
//  Webhook.Retained.swift
//
//
//  Created by Andrew Edwards on 12/27/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/webhook_endpoints/object.md

public enum WebhookStatus: String, Codable, Sendable {
    case enabled
    case disabled
}

public struct WebhookList: Codable, Hashable, Sendable {
    public var object: String
    public var data: [Webhook]?
    public var hasMore: Bool?
    public var url: String?

    public init(
        object: String,
        data: [Webhook]? = nil,
        hasMore: Bool? = nil,
        url: String? = nil
    ) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}

// The Webhook struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Webhook` that the generator spells differently.

