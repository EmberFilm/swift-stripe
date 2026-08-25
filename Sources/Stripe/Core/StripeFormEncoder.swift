//
//  StripeFormEncoder.swift
//  swift-stripe
//
//  Stripe's REST API takes request bodies as `application/x-www-form-urlencoded`
//  with bracket notation for nesting:
//
//      items[0][price]=price_123&items[0][quantity]=2&metadata[order_id]=abc
//
//  `JSONEncoder` cannot produce that, which is why the original package reached
//  for `swift-html-form-coder` (and, transitively, a parser/primitives tree).
//  This is a direct `Encoder` conformance instead: no dependencies, ~230 lines.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Encodes `Encodable` values into Stripe's bracketed form-URL-encoded format.
public struct StripeFormEncoder: Sendable {
    public init() {}

    /// Encodes `value` into a percent-encoded request body.
    public func encode(_ value: some Encodable) throws -> String {
        Self.serialize(try pairs(of: value))
    }

    /// Encodes `value` into ordered key/value pairs, before percent-encoding.
    ///
    /// Useful for signing, logging, and tests that assert on structure rather
    /// than on escaping.
    public func pairs(of value: some Encodable) throws -> [(key: String, value: String)] {
        let storage = FormStorage()
        let encoder = FormEncoder(storage: storage, codingPath: [])
        try value.encode(to: encoder)
        return storage.pairs
    }

    static func serialize(_ pairs: [(key: String, value: String)]) -> String {
        pairs
            .map { "\(escape($0.key))=\(escape($0.value))" }
            .joined(separator: "&")
    }

    /// Percent-encoding for form bodies: space becomes `+`, and every byte outside the unreserved
    /// set is escaped. `CharacterSet.urlQueryAllowed` is too permissive here — it leaves `&`, `=`
    /// and `+` intact.
    ///
    /// Written over UTF-8 bytes rather than `CharacterSet`, which FoundationEssentials does not
    /// vend. That also fixes the encoding of non-ASCII text: `CharacterSet.alphanumerics` counts
    /// letters like `é` as allowed and would have passed them through unescaped.
    static func escape(_ string: String) -> String {
        var out = ""
        out.reserveCapacity(string.utf8.count)
        for byte in string.utf8 {
            switch byte {
            case UInt8(ascii: "A")...UInt8(ascii: "Z"),
                 UInt8(ascii: "a")...UInt8(ascii: "z"),
                 UInt8(ascii: "0")...UInt8(ascii: "9"),
                 UInt8(ascii: "-"), UInt8(ascii: "."), UInt8(ascii: "_"), UInt8(ascii: "~"):
                out.append(Character(UnicodeScalar(byte)))

            case UInt8(ascii: " "):
                out.append("+")

            default:
                out.append("%")
                out.append(Self.hexDigit(byte >> 4))
                out.append(Self.hexDigit(byte & 0x0F))
            }
        }
        return out
    }

    private static func hexDigit(_ nibble: UInt8) -> Character {
        Character(UnicodeScalar(nibble < 10 ? nibble + UInt8(ascii: "0")
                                            : nibble - 10 + UInt8(ascii: "A")))
    }
}

// MARK: - Key paths

/// Converts a camelCase key to Stripe's snake_case wire name.
///
/// Idempotent: keys that are already snake_case, numeric indices, and the two
/// bracket-notation keys (`request[headers]`) contain no uppercase and pass
/// through untouched. This mirrors `JSONDecoder`'s `.convertFromSnakeCase` on
/// the decode side, so models can declare plain camelCase properties.
func snakeCased(_ key: String) -> String {
    var out = ""
    out.reserveCapacity(key.count + 4)
    for (offset, character) in key.enumerated() {
        if character.isUppercase {
            if offset > 0 { out.append("_") }
            out.append(Character(character.lowercased()))
        } else {
            out.append(character)
        }
    }
    return out
}

/// Renders a coding path as Stripe bracket notation: `a`, then `a[b]`, `a[b][0]`.
private func bracketed(_ path: [any CodingKey]) -> String {
    guard let first = path.first else { return "" }
    return path.dropFirst().reduce(snakeCased(first.stringValue)) {
        $0 + "[\(snakeCased($1.stringValue))]"
    }
}

private final class FormStorage {
    var pairs: [(key: String, value: String)] = []

    func append(_ path: [any CodingKey], _ value: String) {
        pairs.append((bracketed(path), value))
    }
}

private struct IndexKey: CodingKey {
    let intValue: Int?
    var stringValue: String { String(intValue ?? 0) }
    init(_ index: Int) { self.intValue = index }
    init?(intValue: Int) { self.intValue = intValue }
    init?(stringValue: String) {
        guard let i = Int(stringValue) else { return nil }
        self.intValue = i
    }
}

// MARK: - Encoder

private struct FormEncoder: Encoder {
    let storage: FormStorage
    var codingPath: [any CodingKey]
    var userInfo: [CodingUserInfoKey: Any] { [:] }

    func container<Key: CodingKey>(keyedBy: Key.Type) -> KeyedEncodingContainer<Key> {
        KeyedEncodingContainer(KeyedContainer<Key>(storage: storage, codingPath: codingPath))
    }

    func unkeyedContainer() -> any UnkeyedEncodingContainer {
        UnkeyedContainer(storage: storage, codingPath: codingPath)
    }

    func singleValueContainer() -> any SingleValueEncodingContainer {
        SingleValueContainer(storage: storage, codingPath: codingPath)
    }
}

/// Renders a leaf value, or `nil` if the value should be encoded structurally.
///
/// Stripe expects `true`/`false` for booleans and Unix timestamps for dates —
/// neither is what `Codable`'s defaults produce.
private func leaf(_ value: Any) -> String? {
    switch value {
    case let v as String: return v
    case let v as Bool: return v ? "true" : "false"
    case let v as Date: return String(Int(v.timeIntervalSince1970))
    case let v as any BinaryInteger: return String(describing: v)
    case let v as Double: return v == v.rounded() ? String(Int(v)) : String(v)
    case let v as Float: return leaf(Double(v))
    case let v as URL: return v.absoluteString
    default: return nil
    }
}

private struct KeyedContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    let storage: FormStorage
    var codingPath: [any CodingKey]

    // Stripe omits absent parameters entirely; it does not accept an empty
    // string as "unset" for most fields.
    mutating func encodeNil(forKey key: Key) throws {}

    mutating func encode(_ value: some Encodable, forKey key: Key) throws {
        let path = codingPath + [key]
        if let rendered = leaf(value) {
            storage.append(path, rendered)
        } else {
            try value.encode(to: FormEncoder(storage: storage, codingPath: path))
        }
    }

    mutating func nestedContainer<NestedKey: CodingKey>(
        keyedBy: NestedKey.Type, forKey key: Key
    ) -> KeyedEncodingContainer<NestedKey> {
        KeyedEncodingContainer(
            KeyedContainer<NestedKey>(storage: storage, codingPath: codingPath + [key])
        )
    }

    mutating func nestedUnkeyedContainer(forKey key: Key) -> any UnkeyedEncodingContainer {
        UnkeyedContainer(storage: storage, codingPath: codingPath + [key])
    }

    mutating func superEncoder() -> any Encoder {
        FormEncoder(storage: storage, codingPath: codingPath)
    }

    mutating func superEncoder(forKey key: Key) -> any Encoder {
        FormEncoder(storage: storage, codingPath: codingPath + [key])
    }
}

private struct UnkeyedContainer: UnkeyedEncodingContainer {
    let storage: FormStorage
    var codingPath: [any CodingKey]
    var count: Int = 0

    mutating func encodeNil() throws {}

    mutating func encode(_ value: some Encodable) throws {
        let path = codingPath + [IndexKey(count)]
        count += 1
        if let rendered = leaf(value) {
            storage.append(path, rendered)
        } else {
            try value.encode(to: FormEncoder(storage: storage, codingPath: path))
        }
    }

    mutating func nestedContainer<NestedKey: CodingKey>(
        keyedBy: NestedKey.Type
    ) -> KeyedEncodingContainer<NestedKey> {
        defer { count += 1 }
        return KeyedEncodingContainer(
            KeyedContainer<NestedKey>(storage: storage, codingPath: codingPath + [IndexKey(count)])
        )
    }

    mutating func nestedUnkeyedContainer() -> any UnkeyedEncodingContainer {
        defer { count += 1 }
        return UnkeyedContainer(storage: storage, codingPath: codingPath + [IndexKey(count)])
    }

    mutating func superEncoder() -> any Encoder {
        defer { count += 1 }
        return FormEncoder(storage: storage, codingPath: codingPath + [IndexKey(count)])
    }
}

private struct SingleValueContainer: SingleValueEncodingContainer {
    let storage: FormStorage
    var codingPath: [any CodingKey]

    mutating func encodeNil() throws {}

    mutating func encode(_ value: some Encodable) throws {
        if let rendered = leaf(value) {
            storage.append(codingPath, rendered)
        } else {
            try value.encode(to: FormEncoder(storage: storage, codingPath: codingPath))
        }
    }
}
