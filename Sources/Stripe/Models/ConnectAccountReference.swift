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

/// A reference to the account an object acts on behalf of: either the requesting account.
///
/// (`self`) or a connected one. Backs `issuer` on invoices.
extension Stripe {
    public struct ConnectAccountReference: Codable, Hashable, Sendable {
        /// The connected account, when `type` is `account`.
        @ExpandableOf<Stripe.Connect.Account> public var account: Stripe.Connect.Account.ID?
        public var type: `Type`?

        public init(account: Stripe.Connect.Account.ID? = nil, type: `Type`? = nil) {
            self._account = Expandable(id: account)
            self.type = type
        }

        public enum `Type`: String, Codable, Sendable {
            case account
            case `self`
        }
    }
}
