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
    /// A request parameter Stripe lets you clear by sending an empty value.
    ///
    /// Stripe unsets `metadata`, `shipping`, `default_payment_method` and some four hundred
    /// other parameters when they are posted as an empty string; the generated request types
    /// model those as `Clearable`. Leave the property `nil` to leave the field alone, give it a
    /// value to set it, or pass `.clear` to unset it:
    ///
    ///     Customer.Update.Request(metadata: ["plan": "pro"])   // set
    ///     Customer.Update.Request(metadata: .clear)            // unset
    ///     Customer.Update.Request(shipping: .value(.init(…)))  // set a structured value
    ///
    /// A plain `String` parameter needs no wrapper: an empty string already clears it.
    public enum Clearable<Value: Codable & Hashable & Sendable>: Codable, Hashable, Sendable {
        case value(Value)
        case clear

        public init(_ value: Value) { self = .value(value) }

        /// The value, or `nil` when this clears the field.
        public var value: Value? {
            if case .value(let value) = self { return value }
            return nil
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let value = try? container.decode(Value.self) {
                self = .value(value)
            } else if try container.decode(String.self).isEmpty {
                self = .clear
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "expected a \(Value.self) or an empty string")
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .value(let value): try container.encode(value)
            case .clear: try container.encode("")
            }
        }
    }
}

// Literals set the value directly, so the common case reads as it did before.
extension Stripe.Clearable: ExpressibleByDictionaryLiteral where Value == [String: String] {
    public init(dictionaryLiteral elements: (String, String)...) {
        self = .value(Dictionary(uniqueKeysWithValues: elements))
    }
}

extension Stripe.Clearable: ExpressibleByArrayLiteral where Value: RangeReplaceableCollection {
    public init(arrayLiteral elements: Value.Element...) {
        self = .value(Value(elements))
    }
}

extension Stripe.Clearable: ExpressibleByIntegerLiteral where Value == Int {
    public init(integerLiteral value: Int) { self = .value(value) }
}

extension Stripe.Clearable: ExpressibleByBooleanLiteral where Value == Bool {
    public init(booleanLiteral value: Bool) { self = .value(value) }
}

extension Stripe.Clearable: ExpressibleByFloatLiteral where Value == Decimal {
    public init(floatLiteral value: Double) { self = .value(Decimal(value)) }
}
