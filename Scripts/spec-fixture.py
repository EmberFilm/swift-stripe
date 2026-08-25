#!/usr/bin/env python3
"""Emits one maximal JSON fixture per generated resource from Stripe's OpenAPI spec.

    Scripts/spec-fixture.py spec3.sdk.json

Every property is populated with a deterministic sample, so a type that drops a field on decode
shows up as a difference in the parity test rather than as a nil nobody noticed. Written to
Tests/StripeTests/Fixtures/<schema>.json and committed.
"""
import json, pathlib, sys

SPEC = json.load(open(sys.argv[1]))
S = SPEC["components"]["schemas"]
RESOURCES = ["checkout.session", "subscription", "subscription_item", "customer", "invoice",
             "price", "product", "event", "payment_intent", "charge", "invoice_payment"]
DEPTH = 4

def ref(node):
    if "$ref" in node: return node["$ref"].split("/")[-1]
    for m in node.get("anyOf", []):
        if "$ref" in m: return m["$ref"].split("/")[-1]
    return None

def offers_id(node):
    """`anyOf: [string, $ref]` — an id that may be expanded. Only then is a string valid."""
    if node.get("type") == "array":
        node = node.get("items", {})
    return any(m.get("type") == "string" for m in node.get("anyOf", []))

import re

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

def sample(node, prop, expandable, depth, stack, parent=None):
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
        if node.get("format") == "currency" or prop == "currency" or prop.endswith("_currency"):
            return "usd"
        return documented_value(node, {prop, parent}) or f"{prop}_1"
    if t == "integer":
        return 1700000000 if node.get("format") == "unix-time" else 1
    if t == "number": return 1.5
    if t == "boolean": return True
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
    if depth < 0: return None
    out = {}
    expandable = set(schema.get("x-expandableFields", []))
    for prop, node in schema.get("properties", {}).items():
        v = sample(node, prop, expandable, depth, stack, parent=parent)
        if v is not None: out[prop] = v
    return out

def build(name, depth, stack, parent=None):
    if depth < 0 or name in stack: return None
    return build_inline(S[name], depth, stack | {name}, parent=parent)

out_dir = pathlib.Path("Tests/StripeTests/Fixtures"); out_dir.mkdir(parents=True, exist_ok=True)
for name in RESOURCES:
    obj = build(name, DEPTH, frozenset())
    obj["id"] = f"{name}_1"
    (out_dir / f"{name}.json").write_text(json.dumps(obj, indent=1, sort_keys=True) + "\n")
    print(f"{name:<20} {len(obj)} top-level keys")
