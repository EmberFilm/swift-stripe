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

extension Stripe {
    public indirect enum PaymentSource: Codable, Hashable, Sendable {
        case account(Stripe.Connect.Account)
        case bankAccount(BankAccount)
        case card(Card)
        case source(Source)
        case unknown(object: String)

        public var account: Stripe.Connect.Account? {
            if case .account(let value) = self { return value }
            return nil
        }
        public var bankAccount: BankAccount? {
            if case .bankAccount(let value) = self { return value }
            return nil
        }
        public var card: Card? {
            if case .card(let value) = self { return value }
            return nil
        }
        public var source: Source? {
            if case .source(let value) = self { return value }
            return nil
        }

        private enum CodingKeys: String, CodingKey {
            case object
        }

        public init(from decoder: any Decoder) throws {
            let object = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .object)
            switch object {
            case "account": self = .account(try Stripe.Connect.Account(from: decoder))
            case "bank_account": self = .bankAccount(try BankAccount(from: decoder))
            case "card": self = .card(try Card(from: decoder))
            case "source": self = .source(try Source(from: decoder))
            default: self = .unknown(object: object)
            }
        }

        public func encode(to encoder: any Encoder) throws {
            switch self {
            case .account(let value): try value.encode(to: encoder)
            case .bankAccount(let value): try value.encode(to: encoder)
            case .card(let value): try value.encode(to: encoder)
            case .source(let value): try value.encode(to: encoder)
            case .unknown(let object):
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(object, forKey: .object)
            }
        }
    }
}
