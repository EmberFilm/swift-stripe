//
//  ExternalAccounts.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

// https://docs.stripe.com/api/external_accounts/object.md

extension Stripe.Connect.Account {
    public enum ExternalAccounts {}
}
extension Stripe.Connect.Account.ExternalAccounts {
    /// External accounts list. [See here](https://stripe.com/docs/api/accounts/object#account_object-external_accounts)
    public struct List: Codable, Hashable, Sendable {
        /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
        public var object: String
        /// Needs to be a string because the result can be an array of 2 possible types ``Card`` and/or ``BankAccount``.
        /// We'll actually decode the array of accounts seperately based on type and filtered based on object. See the initializer.
        /// The `data` key is still needed in the `CodingKeys` and for decoding that property from the Stripe API, so we still have to declare it even though the type is unused.
        private var data: String?
        /// True if this list has another page of items after this one that can be fetched.
        public var hasMore: Bool?
        /// The URL where this list can be accessed.
        public var url: String?
        /// An array of `StripeCard`s associated with the account.
        public var cardAccounts: [Card]?
        /// An array of `StripeBankAccount`s associated with the account.
        public var bankAccounts: [BankAccount]?

        // REASON: every failure this can produce originates in a `Decoder`/`Encoder` standard
        // library call, whose requirements are declared with untyped `throws`. Narrowing the
        // thrown type here would misdescribe the standard library's error domain.
        // swiftlint:disable typed_throws_required
        public init(
            from decoder: Decoder
        ) throws {
            // swiftlint:enable typed_throws_required
            let container = try decoder.container(keyedBy: CodingKeys.self)
            object = try container.decode(String.self, forKey: .object)
            hasMore = try container.decodeIfPresent(Bool.self, forKey: .hasMore)
            url = try container.decodeIfPresent(String.self, forKey: .url)

            cardAccounts = try container.decodeIfPresent([Card].self, forKey: .data)?.filter {
                $0.object == "card"
            }
            bankAccounts = try container.decodeIfPresent([BankAccount].self, forKey: .data)?.filter
            {
                $0.object == "bank_account"
            }
        }

        // REASON: `encode(to: any Encoder) throws` is the exact Encodable protocol requirement
        // signature (Swift.Encodable); both the existential and the untyped `throws` are fixed
        // by the standard library and cannot be narrowed here without failing to satisfy it.
        // swiftlint:disable:next no_any_protocol_existential typed_throws_required
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(object, forKey: .object)
            try container.encodeIfPresent(hasMore, forKey: .hasMore)
            try container.encodeIfPresent(url, forKey: .url)

            // Merge cardAccounts and bankAccounts into a single array
            var accounts: [AnyEncodable] = []
            if let cardAccounts {
                accounts.append(contentsOf: cardAccounts.map { AnyEncodable($0) })
            }
            if let bankAccounts {
                accounts.append(contentsOf: bankAccounts.map { AnyEncodable($0) })
            }

            try container.encode(accounts, forKey: .data)
        }

        public init(
            object: String,
            data: String? = nil,
            hasMore: Bool? = nil,
            url: String? = nil,
            cardAccounts: [Card]? = nil,
            bankAccounts: [BankAccount]? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
            self.cardAccounts = cardAccounts
            self.bankAccounts = bankAccounts
        }

        enum CodingKeys: CodingKey {
            case object
            case data
            case hasMore
            case url
        }

        // A helper type to encode heterogeneous elements
        struct AnyEncodable: Encodable {
            // REASON: every failure this can produce originates in a `Decoder`/`Encoder` standard
            // library call, whose requirements are declared with untyped `throws`. Narrowing the
            // thrown type here would misdescribe the standard library's error domain.
            // swiftlint:disable:next typed_throws_required
            private let _encode: (Encoder) throws -> Void

            init<T: Encodable>(_ encodable: T) {
                _encode = encodable.encode
            }

            // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
            // signature. The standard library declares the requirement with untyped `throws`, so
            // the thrown type cannot be narrowed here without failing to satisfy it.
            // swiftlint:disable:next typed_throws_required
            func encode(to encoder: Encoder) throws {
                try _encode(encoder)
            }
        }
    }

}
