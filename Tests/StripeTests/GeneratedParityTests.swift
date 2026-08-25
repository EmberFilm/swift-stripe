//
//  GeneratedParityTests.swift
//  swift-stripe
//
//  Stage 2 exit criterion: a generated type must carry exactly what the hand-written type
//  carries. Each fixture has every spec field populated; both types decode it, both re-encode
//  canonically, and the two JSON trees are diffed. A path in one tree and not the other is a
//  field one side drops.
//

import Foundation
import Testing

@testable import Stripe
import StripeGenerated

@Suite("Generated model parity")
struct GeneratedParityTests {

    /// Extra fields a hand type carries on purpose, which the spec does not describe.
    private static let deliberateHandExtras: [String: Set<String>] = [
        "event": ["raw_type"],
    ]

    /// Paths where the hand type models something the generator does not yet: `event.data.object`
    /// is a discriminated union the hand type decodes by its `object` field (stage 3), so the
    /// hand side drops the fixture's placeholder while the generated side keeps it as a map.
    private static let knownUnionPaths: [String: Set<String>] = [
        "event": ["data"],
    ]

    private static func fixture(_ name: String) throws -> Data {
        let url = try #require(Bundle.module.url(forResource: name, withExtension: "json", subdirectory: "Fixtures"))
        return try Data(contentsOf: url)
    }

    private static let encoder: JSONEncoder = {
        let e = JSONEncoder()
        e.keyEncodingStrategy = .convertToSnakeCase
        e.dateEncodingStrategy = .secondsSince1970
        e.outputFormatting = [.sortedKeys]
        return e
    }()

    private static func canonical<T: Codable>(_ type: T.Type, _ data: Data) throws -> Any {
        let value = try StripeAPI.decoder.decode(type, from: data)
        return withoutNulls(try JSONSerialization.jsonObject(with: encoder.encode(value)))
    }

    /// `Expandable` encodes an absent value as an explicit null; an absent key and a null key
    /// are the same thing on Stripe's wire, so neither side gets credit for one.
    private static func withoutNulls(_ value: Any) -> Any {
        switch value {
        case let d as [String: Any]:
            return d.compactMapValues { $0 is NSNull ? nil : withoutNulls($0) }
        case let l as [Any]:
            return l.map(withoutNulls)
        default:
            return value
        }
    }

    /// Decodes, and on failure removes the rejected field from the fixture and tries again, so
    /// one strict enum does not hide every other difference. Each rejection is reported.
    private static func canonicalTolerant<T: Codable>(
        _ type: T.Type, _ data: Data, label: String, rejections: inout [String]
    ) throws -> Any {
        var json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        for _ in 0..<40 {
            let attempt = try JSONSerialization.data(withJSONObject: json)
            do {
                return try canonical(type, attempt)
            } catch let error as DecodingError {
                let (path, reason) = describe(error)
                guard !path.isEmpty else { throw error }
                guard remove(path: path, from: &json) else {
                    rejections.append("\(label) type rejects \(path.joined(separator: ".")) and the harness could not strip it: \(reason)")
                    throw error
                }
                rejections.append("\(label) type rejects \(path.joined(separator: ".")): \(reason)")
            } catch {
                // A model's own validation (StatementDescriptor.ValidationError) carries no path.
                rejections.append("\(label) type threw outside DecodingError, so the field cannot be located: \(error)")
                throw error
            }
        }
        throw NSError(domain: "parity", code: 1, userInfo: [NSLocalizedDescriptionKey: "too many rejections"])
    }

    private static func describe(_ error: DecodingError) -> ([String], String) {
        let context: DecodingError.Context
        switch error {
        case .typeMismatch(_, let c), .valueNotFound(_, let c), .keyNotFound(_, let c), .dataCorrupted(let c):
            context = c
        @unknown default:
            return ([], "\(error)")
        }
        // Coding keys are camelCase after convertFromSnakeCase; map back to the wire spelling.
        let path = context.codingPath.map { key -> String in
            if let i = key.intValue { return "[\(i)]" }
            return key.stringValue.replacingOccurrences(
                of: "([A-Z])", with: "_$1", options: .regularExpression
            ).lowercased()
        }
        return (path, context.debugDescription)
    }

    /// Removes the value at `path` (wire-spelled keys, `[n]` for indices). Returns false if absent.
    private static func remove(path: [String], from json: inout [String: Any]) -> Bool {
        guard let first = path.first else { return false }
        if path.count == 1 {
            return json.removeValue(forKey: first) != nil
        }
        let rest = Array(path.dropFirst())
        if var child = json[first] as? [String: Any] {
            guard remove(path: rest, from: &child) else { return false }
            json[first] = child; return true
        }
        if var list = json[first] as? [Any], let idx = rest.first, idx.hasPrefix("["),
           let i = Int(idx.dropFirst().dropLast()), i < list.count {
            if rest.count == 1 { list.remove(at: i); json[first] = list; return true }
            guard var element = list[i] as? [String: Any],
                  remove(path: Array(rest.dropFirst()), from: &element) else { return false }
            list[i] = element; json[first] = list; return true
        }
        return false
    }

    /// Paths present in `a` but not `b`, and paths whose leaf values differ.
    private static func diff(_ a: Any, _ b: Any, path: String, into out: inout [String]) {
        switch (a, b) {
        case let (da as [String: Any], db as [String: Any]):
            for (k, va) in da {
                let p = path.isEmpty ? k : "\(path).\(k)"
                if let vb = db[k] { diff(va, vb, path: p, into: &out) } else { out.append("only in first: \(p)") }
            }
            for k in db.keys where da[k] == nil { out.append("only in second: \(path.isEmpty ? k : "\(path).\(k)")") }
        case let (la as [Any], lb as [Any]):
            if la.count != lb.count { out.append("count differs at \(path): \(la.count) vs \(lb.count)"); return }
            for (i, (x, y)) in zip(la, lb).enumerated() { diff(x, y, path: "\(path)[\(i)]", into: &out) }
        default:
            let sa = "\(a)", sb = "\(b)"
            if sa != sb { out.append("value differs at \(path): \(sa) vs \(sb)") }
        }
    }

    private static func compare<H: Codable, G: Codable>(
        _ schema: String, hand: H.Type, generated: G.Type
    ) throws -> [String] {
        let data = try fixture(schema)
        var out: [String] = []
        let h = try canonicalTolerant(hand, data, label: "hand", rejections: &out)
        let g = try canonicalTolerant(generated, data, label: "generated", rejections: &out)
        diff(h, g, path: "", into: &out)
        let extras = deliberateHandExtras[schema, default: []].union(knownUnionPaths[schema, default: []])
        out = out.filter { line in !extras.contains { line.hasSuffix(": \($0)") } }
        return out.sorted()
    }

    /// Splits differences into what fails the test and what is only reported.
    ///
    /// The generated type must never drop or change a value the hand type carries, and must
    /// decode everything the spec describes — those fail. A field the hand type lacks is the
    /// drift the cutover exists to fix, and a value the hand type rejects is a hand defect; both
    /// are reported so they can be acted on, but neither is the generated type's fault.
    private static func classify(_ differences: [String]) -> (failing: [String], reported: [String]) {
        // Rejections spell an index as `.[0]`, the diff as `[0]`; compare on one form.
        func normalized(_ path: Substring) -> String { path.replacingOccurrences(of: ".[", with: "[") }
        let handRejectedPaths = Set(differences.compactMap { line -> String? in
            guard line.hasPrefix("hand type rejects ") else { return nil }
            return line.dropFirst("hand type rejects ".count).split(separator: ":").first.map(normalized)
        })
        var failing: [String] = [], reported: [String] = []
        for d in differences {
            if d.hasPrefix("only in second") || d.hasPrefix("hand type rejects") {
                reported.append(d)
            } else if d.hasPrefix("count differs at "),
                      let path = d.dropFirst("count differs at ".count).split(separator: ":").first.map(normalized),
                      handRejectedPaths.contains(where: { $0.hasPrefix(path) }) {
                // The hand side rejected an element, which the retry removed; an echo, not a gap.
                reported.append(d + "   (element rejected by the hand type)")
            } else if d.hasPrefix("generated type rejects "),
                      let path = d.dropFirst("generated type rejects ".count).split(separator: ":").first.map(normalized),
                      handRejectedPaths.contains { path.hasSuffix($0) || $0.hasSuffix(path) || path == $0 } {
                reported.append(d + "   (same shared hand type)")
            } else {
                failing.append(d)
            }
        }
        return (failing, reported)
    }

    private static func report(_ schema: String, _ differences: [String]) -> [String] {
        let (failing, reported) = classify(differences)
        let handLacks = reported.filter { $0.hasPrefix("only in second") }.count
        let handRejects = reported.filter { $0.contains("type rejects") }.count
        if !reported.isEmpty {
            print("\n\(schema): hand type lacks \(handLacks) field(s) and rejects \(handRejects) value(s) the spec allows")
            for d in reported { print("   \(d)") }
        }
        if !failing.isEmpty {
            print("\n\(schema): \(failing.count) FAILING difference(s) in the generated type")
            for d in failing { print("   \(d)") }
        }
        return failing
    }

    @Test("checkout.session") func checkoutSession() throws {
        let d = try Self.compare("checkout.session", hand: Stripe.Checkout.Session.self, generated: Generated.Checkout.Session.self)
        #expect(Self.report("checkout.session", d).isEmpty)
    }
    @Test("subscription") func subscription() throws {
        let d = try Self.compare("subscription", hand: Stripe.Billing.Subscription.self, generated: Generated.Billing.Subscription.self)
        #expect(Self.report("subscription", d).isEmpty)
    }
    @Test("subscription_item") func subscriptionItem() throws {
        let d = try Self.compare("subscription_item", hand: Stripe.Billing.Subscription.Item.self, generated: Generated.Billing.Subscription.Item.self)
        #expect(Self.report("subscription_item", d).isEmpty)
    }
    @Test("customer") func customer() throws {
        let d = try Self.compare("customer", hand: Stripe.Customers.Customer.self, generated: Generated.Customers.Customer.self)
        #expect(Self.report("customer", d).isEmpty)
    }
    @Test("invoice") func invoice() throws {
        let d = try Self.compare("invoice", hand: Stripe.Billing.Invoice.self, generated: Generated.Billing.Invoice.self)
        #expect(Self.report("invoice", d).isEmpty)
    }
    @Test("price") func price() throws {
        let d = try Self.compare("price", hand: Stripe.Products.Price.self, generated: Generated.Products.Price.self)
        #expect(Self.report("price", d).isEmpty)
    }
    @Test("product") func product() throws {
        let d = try Self.compare("product", hand: Stripe.Products.Product.self, generated: Generated.Products.Product.self)
        #expect(Self.report("product", d).isEmpty)
    }
    @Test("event") func event() throws {
        let d = try Self.compare("event", hand: Stripe.Events.Event.self, generated: Generated.Events.Event.self)
        #expect(Self.report("event", d).isEmpty)
    }
    @Test("payment_intent") func paymentIntent() throws {
        let d = try Self.compare("payment_intent", hand: Stripe.PaymentIntents.PaymentIntent.self, generated: Generated.PaymentIntents.PaymentIntent.self)
        #expect(Self.report("payment_intent", d).isEmpty)
    }
    @Test("charge") func charge() throws {
        let d = try Self.compare("charge", hand: Stripe.Charges.Charge.self, generated: Generated.Charges.Charge.self)
        #expect(Self.report("charge", d).isEmpty)
    }
}
