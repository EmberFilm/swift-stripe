#!/usr/bin/env python3
"""Emits one maximal JSON fixture per generated resource from Stripe's OpenAPI spec.

    Scripts/spec-fixture.py spec3.sdk.json

Every property is populated with a deterministic sample, so a type that drops a field on decode
shows up as a difference in the parity test rather than as a nil nobody noticed. Written to
Tests/StripeTests/Fixtures/<schema>.json and committed.
"""
import importlib.util
import json
import pathlib
import re
import sys

SPEC = json.load(open(sys.argv[1]))
S = SPEC["components"]["schemas"]
_spec = importlib.util.spec_from_file_location("gen", pathlib.Path(__file__).with_name("generate-models.py"))
_gen = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_gen)
RESOURCES = dict(_gen.RESOURCES)          # schema -> Swift path, the generator's own list
DEPTH = 4


def ref(node):
    if "$ref" in node:
        return node["$ref"].split("/")[-1]
    for m in node.get("anyOf", []):
        if "$ref" in m:
            return m["$ref"].split("/")[-1]
    return None


def offers_id(node):
    """`anyOf: [string, $ref]` — an id that may be expanded. Only then is a string valid."""
    if node.get("type") == "array":
        node = node.get("items", {})
    return any(m.get("type") == "string" for m in node.get("anyOf", []))


def documented_value(node, exclude):
    """The first back-ticked token in a description: many free strings document their values
    ("one of `open`, `paid`, or `canceled`") without declaring an enum. Tokens that are field
    names in scope are skipped — a description of `type` that mentions `next_action` is not
    offering `next_action` as a value."""
    for m in re.finditer(r"`([a-z][a-z0-9_]*)`", node.get("description", "")):
        if m.group(1) not in exclude:
            return m.group(1)
    return None


def is_resource_union(node):
    refs = [m["$ref"].split("/")[-1] for m in node.get("anyOf", []) if "$ref" in m]
    if len(refs) > 1 and not offers_id(node):
        return True
    r = ref(node)          # a bare $ref to a schema that is itself a union (`payment_source`)
    return bool(r) and len(refs) <= 1 and "anyOf" in S.get(r, {}) and "properties" not in S.get(r, {})


def sample(node, prop, expandable, depth, stack, parent=None, siblings=()):
    """A sample value for one property schema."""
    r = ref(node)
    if r and offers_id(node):
        return [f"{r}_1"] if node.get("type") == "array" else f"{r}_1"
    if is_resource_union(node):
        return None          # discriminated unions are stage 3; a fixture cannot pick a member
    t = node.get("type")
    if t == "array":
        item = node.get("items", {})
        v = sample(item, prop, set(), depth, stack)
        return [] if v is None else [v]
    if r:
        return build(r, depth - 1, stack, parent=prop)      # always the object, resource or not
    if t == "string":
        if "enum" in node and node["enum"]:
            return node["enum"][0]
        if node.get("format") == "currency" or "currenc" in prop:
            return "usd"
        if "statement_descriptor" in prop:
            return "EMBERFILM"        # validated to 22 characters by the hand type
        # a description often names sibling fields ("if `address_zip` was provided…"); those
        # are not values either
        return documented_value(node, {prop, parent, *siblings}) or f"{prop}_1"
    if t == "integer":
        return 1700000000 if node.get("format") == "unix-time" else 1
    if t == "number":
        return 1.5
    if t == "boolean":
        return True
    if t == "object":
        if "properties" in node:
            return build_inline(node, depth - 1, stack, parent=prop)
        extra = node.get("additionalProperties")
        if isinstance(extra, dict) and extra:
            v = sample(extra, prop, set(), depth, stack)
            key = "usd" if "currency" in prop else "key"
            return {} if v is None else {key: v}
        return {"key": "value"}
    return None


def build_inline(schema, depth, stack, parent=None):
    if depth < 0:
        return None
    out = {}
    expandable = set(schema.get("x-expandableFields", []))
    names = tuple(schema.get("properties", {}).keys())
    for prop, node in schema.get("properties", {}).items():
        v = sample(node, prop, expandable, depth, stack, parent=parent, siblings=names)
        if v is not None:
            out[prop] = v
    return out


def build(name, depth, stack, parent=None):
    if depth < 0 or name in stack:
        return None
    return build_inline(S[name], depth, stack | {name}, parent=parent)


out_dir = pathlib.Path("Tests/StripeTests/Fixtures")
out_dir.mkdir(parents=True, exist_ok=True)
for name in RESOURCES:
    obj = build(name, DEPTH, frozenset())
    obj["id"] = f"{name}_1"
    (out_dir / f"{name}.json").write_text(json.dumps(obj, indent=1, sort_keys=True) + "\n")
print(f"{len(RESOURCES)} fixtures written")

# The decode gate, one case per generated resource, kept in step with the generator's list.


def test_name(resource: str) -> str:
    words = "".join(w.title() for w in re.split(r"[._]", resource))
    return words[0].lower() + words[1:]


cases = "".join(
    f'    @Test("{name}") func {test_name(name)}() throws {{ try Self.decodes("{name}", as: {path}.self) }}\n'
    for name, path in ((n, p.lstrip("/") if p.startswith("/") else f"Stripe.{p}") for n, p in RESOURCES.items()))
TEST_FILE = pathlib.Path("Tests/StripeTests/FixtureDecodingTests.swift")
TEST_FILE.write_text(f'''{_gen.LICENSE_HEADER}
import Foundation
import Testing

@testable import Stripe

/// Every generated resource decodes a fixture in which every spec field is populated.
///
/// Written by Scripts/spec-fixture.py. A resource must accept every value the spec allows; a
/// rejection here is a model that will throw on a real object one day.
@Suite("Spec fixture decoding")
struct FixtureDecodingTests {{

    private static func fixture(_ name: String) throws -> Data {{
        let url = try #require(Bundle.module.url(forResource: name, withExtension: "json", subdirectory: "Fixtures"))
        return try Data(contentsOf: url)
    }}

    /// Hand-written types the generated ones reference that reject a value the spec allows.
    ///
    /// A strict enum on a field the spec types as a free string. Each is a defect in that hand
    /// type, listed here by path so it is acknowledged rather than silently tolerated; remove an
    /// entry when the hand type is fixed. Anything not listed fails.
    private static let knownHandStrictness: [String: Set<String>] = [
        "treasury.received_credit": ["linked_flows.source_flow_details.payout.failure_code"],
        "treasury.received_debit": ["linked_flows.source_flow_details.payout.failure_code"],
    ]

    /// Hand-written enums that are strict on a field the spec types as a free string.
    ///
    /// Reached from many resources through the card types. Same status as the paths above:
    /// acknowledged defects, matched by the enum's name in the decoding error, to be removed as
    /// each is fixed.
    private static let knownStrictHandEnums: Set<String> = [
        "CardBrand", "CardFundingType", "CardValidationCheck", "CardTokenizedMethod",
    ]

    private static func decodes<T: Decodable>(_ schema: String, as type: T.Type) throws {{
        var json = try JSONSerialization.jsonObject(with: fixture(schema)) as! [String: Any]
        for _ in 0..<20 {{
            let data = try JSONSerialization.data(withJSONObject: json)
            do {{
                _ = try StripeAPI.decoder.decode(type, from: data)
                return
            }} catch let error as DecodingError {{
                let (path, reason) = describe(error)
                let wire = path.joined(separator: ".")
                let strictEnum = knownStrictHandEnums.contains {{ reason.contains("Cannot initialize \\($0) from") }}
                let known = strictEnum || knownHandStrictness[schema, default: []].contains {{ wire.hasSuffix($0) }}
                guard known, remove(path: path, from: &json) else {{
                    Issue.record("\\(schema): \\(wire): \\(reason)")
                    return
                }}
                // acknowledged: strip the field and keep checking the rest of the object
            }}
        }}
        Issue.record("\\(schema): too many rejections")
    }}

    private static func describe(_ error: DecodingError) -> ([String], String) {{
        let context: DecodingError.Context
        switch error {{
        case .typeMismatch(_, let c), .valueNotFound(_, let c), .keyNotFound(_, let c), .dataCorrupted(let c):
            context = c
        @unknown default:
            return ([], "\\(error)")
        }}
        let path = context.codingPath.map {{ key -> String in
            if let i = key.intValue {{ return "[\\(i)]" }}
            return key.stringValue.replacingOccurrences(of: "([A-Z])", with: "_$1", options: .regularExpression).lowercased()
        }}
        return (path, context.debugDescription)
    }}

    private static func remove(path: [String], from json: inout [String: Any]) -> Bool {{
        guard let first = path.first else {{ return false }}
        if path.count == 1 {{ return json.removeValue(forKey: first) != nil }}
        let rest = Array(path.dropFirst())
        if var child = json[first] as? [String: Any] {{
            guard remove(path: rest, from: &child) else {{ return false }}
            json[first] = child; return true
        }}
        if var list = json[first] as? [Any], let idx = rest.first, idx.hasPrefix("["),
           let i = Int(idx.dropFirst().dropLast()), i < list.count {{
            if rest.count == 1 {{ list.remove(at: i); json[first] = list; return true }}
            guard var element = list[i] as? [String: Any],
                  remove(path: Array(rest.dropFirst()), from: &element) else {{ return false }}
            list[i] = element; json[first] = list; return true
        }}
        return false
    }}

{cases}}}
''')
_gen.swift_format([TEST_FILE])
print("FixtureDecodingTests.swift written")
