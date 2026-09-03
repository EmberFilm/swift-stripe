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

// https://docs.stripe.com/api/issuing/authorizations/object.md

public enum AuthorizationMethod: String, Codable, Sendable {
    /// The card number was manually entered into a terminal.
    case keyedIn = "keyed_in"
    /// The card was physically swiped in a terminal.
    case swipe
    /// The card was physically present and inserted into a chip-enabled terminal.
    ///
    /// The transaction is cryptographically secured.
    case chip
    /// The card was tapped on a contactless-enabled terminal.
    ///
    /// If a digital wallet copy of the card was used, the wallet field will be present.
    case contactless
    /// The card was used in a card-not-present scenario, such as a transaction initiated at an online e-commerce checkout.
    case online
}
