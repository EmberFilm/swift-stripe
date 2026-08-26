//
//  ConnectAccountReference.swift
//  swift-stripe
//

/// A reference to the account an object acts on behalf of: either the requesting account
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
