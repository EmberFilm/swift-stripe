#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Customers {
    public enum BankAccounts: Sendable {}
}

extension Stripe.Customers.BankAccounts {
    // https://docs.stripe.com/api/customer_bank_accounts/create.md
    public enum Create {}
    // https://docs.stripe.com/api/customer_bank_accounts/update.md
    public enum Update {}
    // https://docs.stripe.com/api/customer_bank_accounts/list.md
    public enum List {}
    // https://docs.stripe.com/api/customer_bank_accounts/verify.md
    public enum Verify {}
}

extension Stripe.Customers.BankAccounts.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// Either a token, like the ones returned by Stripe.js, or a dictionary containing a user's bank account details.
        public let source: Source
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public let metadata: [String: String]?

        public init(
            source: Source,
            metadata: [String: String]? = nil
        ) {
            self.source = source
            self.metadata = metadata
        }

        public enum Source: Codable, Equatable, Sendable {
            case token(String)
            case bankAccount(BankAccountDetails)

            // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
            // signature. The standard library declares the requirement with untyped `throws`, so
            // the thrown type cannot be narrowed here without failing to satisfy it.
            // swiftlint:disable:next typed_throws_required
            public func encode(to encoder: Encoder) throws {
                var container = encoder.singleValueContainer()
                switch self {
                case .token(let token):
                    try container.encode(token)

                case .bankAccount(let details):
                    try container.encode(details)
                }
            }

            // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
            // signature. The standard library declares the requirement with untyped `throws`, so
            // the thrown type cannot be narrowed here without failing to satisfy it.
            // swiftlint:disable:next typed_throws_required
            public init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                // REASON: probing a decoding container for an alternative payload shape. `decode` throws
                // the standard library's untyped error domain, and a failed probe is control flow here —
                // the next shape is attempted — not an error this type can classify.
                // swiftlint:disable:next no_try_optional
                if let token = try? container.decode(String.self) {
                    self = .token(token)
                } else {
                    let details = try container.decode(BankAccountDetails.self)
                    self = .bankAccount(details)
                }
            }
        }

        public struct BankAccountDetails: Codable, Equatable, Sendable {
            /// The account number for the bank account, in string form. Must be a checking account.
            public let accountNumber: String
            /// The country in which the bank account is located.
            public let country: String
            /// The currency the bank account is in.
            public let currency: Stripe.Currency
            /// The name of the person or business that owns the bank account.
            public let accountHolderName: String?
            /// The type of entity that holds the account.
            public let accountHolderType: BankAccountHolderType?
            /// The routing number, sort code, or other country-appropriate institution number for the bank account.
            public let routingNumber: String?

            private enum CodingKeys: String, CodingKey {
                case accountNumber
                case country
                case currency
                case accountHolderName
                case accountHolderType
                case routingNumber
                case object
            }

            public init(
                accountNumber: String,
                country: String,
                currency: Stripe.Currency,
                accountHolderName: String? = nil,
                accountHolderType: BankAccountHolderType? = nil,
                routingNumber: String? = nil
            ) {
                self.accountNumber = accountNumber
                self.country = country
                self.currency = currency
                self.accountHolderName = accountHolderName
                self.accountHolderType = accountHolderType
                self.routingNumber = routingNumber
            }

            // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
            // signature. The standard library declares the requirement with untyped `throws`, so
            // the thrown type cannot be narrowed here without failing to satisfy it.
            // swiftlint:disable:next typed_throws_required
            public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode("bank_account", forKey: .object)
                try container.encode(accountNumber, forKey: .accountNumber)
                try container.encode(country, forKey: .country)
                try container.encode(currency, forKey: .currency)
                try container.encodeIfPresent(accountHolderName, forKey: .accountHolderName)
                try container.encodeIfPresent(accountHolderType, forKey: .accountHolderType)
                try container.encodeIfPresent(routingNumber, forKey: .routingNumber)
            }

            // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
            // signature. The standard library declares the requirement with untyped `throws`, so
            // the thrown type cannot be narrowed here without failing to satisfy it.
            // swiftlint:disable:next typed_throws_required
            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.accountNumber = try container.decode(String.self, forKey: .accountNumber)
                self.country = try container.decode(String.self, forKey: .country)
                self.currency = try container.decode(Stripe.Currency.self, forKey: .currency)
                self.accountHolderName = try container.decodeIfPresent(
                    String.self,
                    forKey: .accountHolderName
                )
                self.accountHolderType = try container.decodeIfPresent(
                    BankAccountHolderType.self,
                    forKey: .accountHolderType
                )
                self.routingNumber = try container.decodeIfPresent(
                    String.self,
                    forKey: .routingNumber
                )
            }
        }
    }
}

extension Stripe.Customers.BankAccounts.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// The name of the person or business that owns the bank account.
        public let accountHolderName: String?
        /// The type of entity that holds the account.
        public let accountHolderType: BankAccountHolderType?
        /// Set of key-value pairs that you can attach to an object.
        public let metadata: [String: String]?

        private enum CodingKeys: String, CodingKey {
            case accountHolderName
            case accountHolderType
            case metadata
        }

        public init(
            accountHolderName: String? = nil,
            accountHolderType: BankAccountHolderType? = nil,
            metadata: [String: String]? = nil
        ) {
            self.accountHolderName = accountHolderName
            self.accountHolderType = accountHolderType
            self.metadata = metadata
        }
    }
}

extension Stripe.Customers.BankAccounts.List {
    public struct Request: Codable, Equatable, Sendable {
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public let endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public let limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public let startingAfter: String?

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

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [BankAccount]

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [BankAccount]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}

extension Stripe.Customers.BankAccounts.Verify {
    public struct Request: Codable, Equatable, Sendable {
        /// Two positive integers, in cents, equal to the values of the microdeposits sent to the bank account.
        public let amounts: [Int]?

        public init(
            amounts: [Int]? = nil
        ) {
            self.amounts = amounts
        }
    }
}
