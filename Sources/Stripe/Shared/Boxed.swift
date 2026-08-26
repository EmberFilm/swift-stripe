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

//  Support for the generated models; not itself generated.
//

/// Heap-boxes a value so a resource can embed another resource by value.
///
/// Stripe resources reference each other in cycles — a PaymentIntent's last error carries the
/// PaymentIntent — and a Swift struct cannot contain itself. Applied by the generator to every
/// full resource embedded in another; the wrapped value reads exactly as if it were inline.
@propertyWrapper
public struct Boxed<Value: Codable & Hashable & Sendable>: Codable, Hashable, Sendable {
    private final class Storage: @unchecked Sendable {
        let value: Value
        init(_ value: Value) { self.value = value }
    }

    private let storage: Storage

    public var wrappedValue: Value { storage.value }

    public init(wrappedValue: Value) {
        self.storage = Storage(wrappedValue)
    }

    public init(from decoder: any Decoder) throws {
        self.init(wrappedValue: try decoder.singleValueContainer().decode(Value.self))
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool { lhs.wrappedValue == rhs.wrappedValue }
    public func hash(into hasher: inout Hasher) { hasher.combine(wrappedValue) }
}

// An absent key decodes to a boxed nil, and a boxed nil is omitted on encode — the same
// treatment a plain optional property gets, so the wrapper is invisible on the wire.
extension KeyedDecodingContainer {
    public func decode<T>(_ type: Boxed<T?>.Type, forKey key: Key) throws -> Boxed<T?> {
        try decodeIfPresent(type, forKey: key) ?? Boxed(wrappedValue: nil)
    }
}

extension KeyedEncodingContainer {
    public mutating func encode<T>(_ value: Boxed<T?>, forKey key: Key) throws {
        if let inner = value.wrappedValue {
            try encode(inner, forKey: key)
        }
    }
}
