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

/// A Connection Token is used by the Stripe Terminal SDK to connect to a reader.
public struct TerminalConnectionToken: Codable, Hashable, Sendable {
    /// String representing the object's type.
    public let object: String
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
