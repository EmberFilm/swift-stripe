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
    public struct StatementDescriptor: Codable, Hashable, Sendable {
        public let rawValue: String

        public init(_ string: String) throws(ValidationError) {
            try StatementDescriptor.validate(string)
            self.rawValue = string
        }

        private static func validate(_ string: String) throws(ValidationError) {
            guard !string.isEmpty else {
                throw ValidationError.empty
            }

            guard string.count <= 22 else {
                throw ValidationError.tooLong
            }

            // Character-wise rather than via `CharacterSet`, which FoundationEssentials
            // does not vend.
            let invalidCharacters: Set<Character> = ["<", ">", "'", "\"", "*"]
            guard !string.contains(where: invalidCharacters.contains) else {
                throw ValidationError.invalidCharacters
            }

            guard !string.allSatisfy(\.isNumber) else {
                throw ValidationError.onlyNumbers
            }
        }
    }
}

extension Stripe.StatementDescriptor: RawRepresentable {
    public init?(rawValue: String) {
        do throws(Stripe.StatementDescriptor.ValidationError) {
            try self.init(rawValue)
        } catch {
            return nil
        }
    }
}

extension Stripe.StatementDescriptor {
    // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
    // signature. The standard library declares the requirement with untyped `throws`, so
    // the thrown type cannot be narrowed here without failing to satisfy it.
    // swiftlint:disable:next typed_throws_required
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(string)
    }

    // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
    // signature. The standard library declares the requirement with untyped `throws`, so
    // the thrown type cannot be narrowed here without failing to satisfy it.
    // swiftlint:disable:next typed_throws_required
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}

extension Stripe.StatementDescriptor {
    public enum ValidationError: Swift.Error {
        case tooLong
        case invalidCharacters
        case onlyNumbers
        case empty

        public var description: String {
            switch self {
            case .tooLong:
                return "Statement descriptor must not exceed 22 characters"

            case .invalidCharacters:
                return "Statement descriptor contains invalid characters"

            case .onlyNumbers:
                return "Statement descriptor must not consist solely of numbers"

            case .empty:
                return "Statement descriptor cannot be empty"
            }
        }
    }
}
// String-like behavior
extension Stripe.StatementDescriptor: CustomStringConvertible {
    public var description: String {
        self.rawValue
    }
}
