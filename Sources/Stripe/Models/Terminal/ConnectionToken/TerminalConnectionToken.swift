//
//  TerminalConnectionToken.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/terminal/connection_tokens/object.md

/// The [Connection Token Object](https://stripe.com/docs/api/terminal/connection_tokens/object)
public struct TerminalConnectionToken: Codable, Hashable, Sendable {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The id of the location that this connection token is scoped to.
    public var location: String?
    /// Your application should pass this token to the Stripe Terminal SDK.
    public var secret: String?

    public init(
        object: String,
        location: String? = nil,
        secret: String? = nil
    ) {
        self.object = object
        self.location = location
        self.secret = secret
    }
}
