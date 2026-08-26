//
//  JSONValue.swift
//  Stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe {
    /// A JSON value whose shape is not known ahead of time.
    ///
    /// Used for `Event.Data.previousAttributes`, where Stripe sends the prior values of
    /// whichever attributes changed, in the shape those attributes have on the object.
    public indirect enum JSONValue: Codable, Hashable, Sendable {
        case string(String)
        case number(Double)
        case bool(Bool)
        case null
        case array([JSONValue])
        case object([String: JSONValue])

        public var stringValue: String? { if case .string(let v) = self { return v }; return nil }
        public var doubleValue: Double? { if case .number(let v) = self { return v }; return nil }
        public var intValue: Int? { if case .number(let v) = self, v == v.rounded() { return Int(v) }; return nil }
        public var boolValue: Bool? { if case .bool(let v) = self { return v }; return nil }
        public var arrayValue: [JSONValue]? { if case .array(let v) = self { return v }; return nil }
        public var objectValue: [String: JSONValue]? { if case .object(let v) = self { return v }; return nil }
        public var isNull: Bool { if case .null = self { return true }; return false }

        public subscript(key: String) -> JSONValue? { objectValue?[key] }
        public subscript(index: Int) -> JSONValue? {
            guard let array = arrayValue, array.indices.contains(index) else { return nil }
            return array[index]
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            if container.decodeNil() {
                self = .null
            } else if let bool = try? container.decode(Bool.self) {
                self = .bool(bool)
            } else if let number = try? container.decode(Double.self) {
                self = .number(number)
            } else if let string = try? container.decode(String.self) {
                self = .string(string)
            } else if let array = try? container.decode([JSONValue].self) {
                self = .array(array)
            } else {
                self = .object(try container.decode([String: JSONValue].self))
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .string(let v): try container.encode(v)
            case .number(let v): try container.encode(v)
            case .bool(let v): try container.encode(v)
            case .null: try container.encodeNil()
            case .array(let v): try container.encode(v)
            case .object(let v): try container.encode(v)
            }
        }
    }
}

extension Stripe.JSONValue: ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral,
    ExpressibleByBooleanLiteral, ExpressibleByNilLiteral, ExpressibleByArrayLiteral, ExpressibleByDictionaryLiteral
{
    public init(stringLiteral value: String) { self = .string(value) }
    public init(integerLiteral value: Int) { self = .number(Double(value)) }
    public init(floatLiteral value: Double) { self = .number(value) }
    public init(booleanLiteral value: Bool) { self = .bool(value) }
    public init(nilLiteral: ()) { self = .null }
    public init(arrayLiteral elements: Stripe.JSONValue...) { self = .array(elements) }
    public init(dictionaryLiteral elements: (String, Stripe.JSONValue)...) {
        self = .object(Dictionary(uniqueKeysWithValues: elements))
    }
}
