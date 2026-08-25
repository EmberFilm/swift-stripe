#!/usr/bin/env python3
"""Generates Swift model types from Stripe's OpenAPI spec.

    Scripts/generate-models.py spec3.sdk.json            # emit into Sources/StripeGenerated
    Scripts/generate-models.py spec3.sdk.json --check    # only report what it cannot map

Stage 2 of the model-fidelity plan. The output lives under the `Generated` namespace in its own
target, so it can be compared field-for-field against the hand-written `Stripe` types before
anything is cut over. The generated files are committed; there is no build plugin.

Mapping rules, in the order they apply to a property:

  expandable   listed in the parent's x-expandableFields          @Expandable<T, String>
               array of such                                       @ExpandableCollection<T>
  resource     $ref to a schema with x-resourceId                  RESOURCE_TYPES[name], or an error
  shared       $ref reached from more than one parent              Generated.Shared.<Name>
  nested       $ref reached from one parent, or an inline object   nested struct named for the property
  enum         string with an enum of more than one value          nested enum with raw values
  union        anyOf of several $refs, not expandable              first member, marked for stage 3
  map          object with additionalProperties                    [String: T]
  scalar       string / integer / unix-time / number / boolean     String / Int / Date / Double / Bool
  embedded     a full generated resource inside another             @Boxed, to break reference cycles

Every property is optional except `id`. Every struct gets an explicit CodingKeys listing every
property, emitted from the same list — the omission that silently disables decoding cannot
happen here.
"""
from __future__ import annotations

import argparse
import json
import pathlib
import re
import sys
from collections import Counter, defaultdict

# --------------------------------------------------------------------------------------------
# Configuration
# --------------------------------------------------------------------------------------------

# The resources generated, and where they sit under `Generated`. Mirrors the hand-written
# nesting so that cutover is a namespace rename and a file move.
RESOURCES: dict[str, str] = {
    "checkout.session": "Checkout.Session",
    "subscription": "Billing.Subscription",
    "subscription_item": "Billing.Subscription.Item",
    "customer": "Customers.Customer",
    "invoice": "Billing.Invoice",
    "price": "Products.Price",
    "product": "Products.Product",
    "payment_intent": "PaymentIntents.PaymentIntent",
    "charge": "Charges.Charge",
    "invoice_payment": "Billing.Invoice.Payment",
}

# Schemas that carry x-resourceId but are sub-objects of one parent, not standalone
# resources. Generated as nested types rather than mapped.
INLINE_RESOURCES: set[str] = {
    "payment_intent_amount_details_line_item",
}

# A $ref to any of these resolves to the existing hand-written type. Anything with an
# x-resourceId that is not here is an error, never a guess.
RESOURCE_TYPES: dict[str, str] = {
    # the generated set refers to itself through Generated
    "checkout.session": "Generated.Checkout.Session",
    "subscription": "Generated.Billing.Subscription",
    "subscription_item": "Generated.Billing.Subscription.Item",
    "customer": "Generated.Customers.Customer",
    "invoice": "Generated.Billing.Invoice",
    "price": "Generated.Products.Price",
    "product": "Generated.Products.Product",
    "event": "Stripe.Events.Event",
    "payment_intent": "Generated.PaymentIntents.PaymentIntent",
    "charge": "Generated.Charges.Charge",
    "invoice_payment": "Generated.Billing.Invoice.Payment",
    # everything else is the hand-written Stripe type
    "item": "Stripe.Checkout.Session.LineItem",
    "line_item": "Stripe.Billing.Invoice.LineItem",
    "tax_code": "Stripe.Tax.Code",
    "account": "Stripe.Connect.Account",
    "application": "Stripe.Connect.Application",
    "application_fee": "Stripe.Connect.Application.Fee",
    "balance_transaction": "Stripe.Balance.Transaction",
    "bank_account": "BankAccount",
    "billing.credit_balance_transaction": "Stripe.Billing.Credit.Balance.Transaction",
    "card": "Card",
    # Not the top-level `CashBalance`: inside Customer that name resolves to the empty request
    # namespace `Stripe.Customers.CashBalance`. This is the type the hand Customer used.
    "cash_balance": "Stripe.Customers.CustomerCashBalance",
    "coupon": "Stripe.Products.Coupon",
    "discount": "Stripe.Products.Discount",
    "deleted_discount": "Stripe.Products.Discount",
    "file": "Stripe.Files.File",
    "mandate": "Stripe.Mandates.Mandate",
    "payment_link": "Stripe.PaymentLink",
    "payment_method": "Stripe.PaymentMethods.PaymentMethod",
    "payment_source": "StripePaymentSource",
    "plan": "Stripe.Billing.Plan",
    "promotion_code": "Promotion.Code",
    "quote": "Stripe.Billing.Quote",
    "refund": "Stripe.Refunds.Refund",
    "review": "Stripe.Fraud.Reviews.Review",
    "setup_intent": "Stripe.Setup.Intent",
    "shipping_rate": "Stripe.Products.Shipping.Rate",
    "subscription_schedule": "Stripe.Billing.Subscription.Schedule",
    "tax_id": "Stripe.Tax.ID",
    "tax_rate": "Stripe.Tax.Rate",
    "test_helpers.test_clock": "Stripe.Billing.TestClocks.TestClock",
    "transfer": "Stripe.Connect.Transfer",
    "customer_balance_transaction": "Stripe.Billing.Customer.Balance.Transaction",
    "credit_note": "Stripe.Billing.Credit.Note",
    "invoiceitem": "Stripe.Billing.Invoice.Item",
    "source": "StripePaymentSource",
    "dispute": "Stripe.Disputes.Dispute",
    "billing.credit_grant": "Stripe.Billing.Credit.Grant",
}

# Resources with no Swift type at all. A reference to one is kept as its id, never expanded.
ID_ONLY_RESOURCES: set[str] = {
    "payment_record",
}

# Non-resource schemas that already have a hand-written shared type worth reusing.
SHARED_TYPES: dict[str, str] = {
    "address": "Address",
    "shipping": "ShippingLabel",
}

SWIFT_KEYWORDS = {
    "type", "self", "default", "operator", "protocol", "class", "struct", "enum", "func", "var",
    "let", "in", "is", "as", "where", "return", "case", "import", "init", "Type", "extension",
    "static", "public", "private", "internal", "true", "false", "nil", "switch", "if", "else",
    "for", "while", "repeat", "do", "try", "throws", "throw", "catch", "guard", "defer",
    "break", "continue", "fallthrough", "super", "subscript", "associatedtype", "typealias",
    "inout", "rethrows", "some", "any",
}

# --------------------------------------------------------------------------------------------
# Naming
# --------------------------------------------------------------------------------------------

def camel(name: str) -> str:
    parts = re.split(r"[_\-.]", name)
    parts = [p for p in parts if p]
    if not parts:
        return "value"
    head, *rest = parts
    out = head + "".join(p[:1].upper() + p[1:] for p in rest)
    if out[0].isdigit():
        out = "_" + out
    return out

def pascal(name: str) -> str:
    c = camel(name)
    return c[:1].upper() + c[1:]

def ident(name: str) -> str:
    return f"`{name}`" if name in SWIFT_KEYWORDS else name

def enum_case(value: str) -> str:
    c = camel(value)
    if not re.match(r"^[A-Za-z_]", c):
        c = "_" + c
    return ident(c)

def doc(description: str | None) -> str | None:
    if not description:
        return None
    text = re.sub(r"\[([^\]]+)\]\([^)]+\)", r"\1", description)   # [text](url) -> text
    text = re.sub(r"\s+", " ", text).strip()
    first = re.split(r"(?<=[.!?])\s", text, maxsplit=1)[0]
    return first[:118] + ("…" if len(first) > 118 else "")

# --------------------------------------------------------------------------------------------
# Spec walking
# --------------------------------------------------------------------------------------------

class Generator:
    def __init__(self, spec: dict, namespace: str = "Generated", only: set[str] | None = None):
        self.ns = namespace
        self.only = only
        self.schemas: dict = spec["components"]["schemas"]
        self.version: str = spec["info"]["version"]
        self.unmapped: set[str] = set()
        self.unions: list[str] = []
        # schema name -> set of parents that reach it, for shared-type detection
        self.ref_parents: dict[str, set[str]] = defaultdict(set)
        self.ref_prop_names: dict[str, Counter] = defaultdict(Counter)

    def ref_name(self, node: dict) -> str | None:
        if "$ref" in node:
            return node["$ref"].split("/")[-1]
        return None

    def is_resource(self, name: str) -> bool:
        return "x-resourceId" in self.schemas.get(name, {}) and name not in INLINE_RESOURCES

    # ---- pass 1: discover which nested schemas are shared -------------------------------

    def survey(self, name: str, parent: str, seen: set[str]) -> None:
        schema = self.schemas[name]
        for prop, node in schema.get("properties", {}).items():
            for ref in self.refs_in(node):
                if self.is_resource(ref) or ref in SHARED_TYPES:
                    continue
                self.ref_parents[ref].add(parent)
                self.ref_prop_names[ref][prop] += 1
                if ref not in seen:
                    seen.add(ref)
                    self.survey(ref, parent, seen)

    @staticmethod
    def offers_id(node: dict) -> bool:
        """True when the schema is `anyOf: [string, $ref …]` — an id that may be expanded.

        Stripe's x-expandableFields lists every object-valued property, including plain nested
        objects such as `address`, so membership alone does not mean the value can be an id.
        """
        if node.get("type") == "array":
            node = node.get("items", {})
        return any(m.get("type") == "string" for m in node.get("anyOf", []))

    def refs_in(self, node: dict) -> list[str]:
        out = []
        if "$ref" in node:
            out.append(self.ref_name(node))
        for member in node.get("anyOf", []):
            if "$ref" in member:
                out.append(self.ref_name(member))
        if node.get("type") == "array":
            out += self.refs_in(node.get("items", {}))
        if node.get("type") == "object" and isinstance(node.get("additionalProperties"), dict):
            out += self.refs_in(node["additionalProperties"])
        return out

    def is_shared(self, ref: str) -> bool:
        return len(self.ref_parents.get(ref, ())) > 1

    def shared_type_name(self, ref: str) -> str:
        # Prefer the property name every parent agrees on. Several distinct schemas can share a
        # property name (`mandate_options` under each payment method), so a name already claimed
        # by another schema falls back to the schema name, which is unique by construction.
        if ref in self.shared_names_by_ref:
            return self.shared_names_by_ref[ref]
        names = self.ref_prop_names[ref]
        candidate = pascal(next(iter(names))) if len(names) == 1 else pascal(ref.replace(".", "_"))
        if self.shared_refs_by_name.get(candidate, ref) != ref:
            candidate = pascal(ref.replace(".", "_"))
        assert self.shared_refs_by_name.get(candidate, ref) == ref, (candidate, ref)
        self.shared_refs_by_name[candidate] = ref
        self.shared_names_by_ref[ref] = candidate
        return candidate

    # ---- pass 2: emit ---------------------------------------------------------------------

    def resolve(self, node: dict, prop: str, parent_expandable: set[str], owner: "Struct") -> "Field":
        """Turns one property schema into a Swift field."""
        name = camel(prop)
        description = doc(node.get("description"))
        expandable = prop in parent_expandable and self.offers_id(node)

        # arrays
        if node.get("type") == "array":
            items = node.get("items", {})
            item_refs = [r for r in self.refs_in(items) if r]
            if expandable and item_refs:
                t = self.type_for_ref(item_refs[0], prop, owner)
                return Field(name, prop, f"[String]", description,
                             wrapper=f"@ExpandableCollection<{t}>", collection_wrapper=True)
            elem = self.element_type(items, prop, owner)
            return Field(name, prop, f"[{elem}]", description)

        # expandable single
        if expandable:
            refs = [r for r in self.refs_in(node) if r]
            if refs and refs[0] in ID_ONLY_RESOURCES:
                return Field(name, prop, "String", description)
            if refs:
                t = self.type_for_ref(refs[0], prop, owner)
                return Field(name, prop, "String", description,
                             wrapper=f"@Expandable<{t}, String>", id_wrapper=True)

        swift_type = self.element_type(node, prop, owner)
        # A full resource embedded by value in another resource: box it, since these are the
        # references that form cycles (PaymentIntent -> ApiErrors -> PaymentIntent).
        boxed = node.get("type") != "array" and swift_type in RESOURCE_TYPES.values() \
            and swift_type.startswith("Generated.")
        return Field(name, prop, swift_type, description,
                     wrapper="@Boxed" if boxed else None, boxed=boxed)

    def element_type(self, node: dict, prop: str, owner: "Struct") -> str:
        ref = self.ref_name(node)
        if ref:
            return self.type_for_ref(ref, prop, owner)

        members = [m for m in node.get("anyOf", []) if "$ref" in m]
        if members:
            if len(members) > 1:
                self.unions.append(f"{owner.path}.{prop}: {[self.ref_name(m) for m in members]}")
            return self.type_for_ref(self.ref_name(members[0]), prop, owner)

        t = node.get("type")
        if t == "string":
            if node.get("format") == "currency":
                return "Stripe.Currency"
            enum = node.get("enum")
            if enum and len(enum) > 1:
                owner.enums.append(Enum(pascal(prop), enum, doc(node.get("description"))))
                return pascal(prop)
            return "String"
        if t == "integer":
            return "Date" if node.get("format") == "unix-time" else "Int"
        if t == "number":
            return "Double"
        if t == "boolean":
            return "Bool"
        if t == "object":
            if "properties" in node:
                nested = self.build_struct(pascal(prop), node, f"{owner.path}.{pascal(prop)}")
                owner.nested.append(nested)
                return pascal(prop)
            extra = node.get("additionalProperties")
            if isinstance(extra, dict) and extra:
                return f"[String: {self.element_type(extra, prop, owner)}]"
            return "[String: String]"
        return "String"

    @staticmethod
    def qualified(hand_type: str) -> str:
        """Hand types are named as they resolve from inside `Stripe`.

        The module and the root enum share the name `Stripe`, and inside the module the enum
        shadows the module completely, so a top-level type cannot be reached as `Stripe.X`. A
        bare name is right unless a nested namespace shadows it — then RESOURCE_TYPES must name
        a type that lives under the enum, as `cash_balance` does.
        """
        return hand_type

    def type_for_ref(self, ref: str, prop: str, owner: "Struct") -> str:
        if ref in ID_ONLY_RESOURCES:
            return "String"
        if self.is_resource(ref):
            if ref not in RESOURCE_TYPES:
                self.unmapped.add(ref)
                return "String"
            return self.qualified(RESOURCE_TYPES[ref])
        if ref in SHARED_TYPES:
            return self.qualified(SHARED_TYPES[ref])
        if self.is_shared(ref):
            name = self.shared_type_name(ref)
            self.emit_shared(ref, name)
            return f"Generated.Shared.{name}"
        nested = self.build_struct(pascal(prop), self.schemas[ref], f"{owner.path}.{pascal(prop)}")
        owner.nested.append(nested)
        return pascal(prop)

    def emit_shared(self, ref: str, name: str) -> None:
        if ref in self.shared_done:
            return
        self.shared_done[ref] = None   # reserve first: shared types can reference each other
        self.shared_done[ref] = self.build_struct(name, self.schemas[ref], f"Generated.Shared.{name}")

    def build_struct(self, name: str, schema: dict, path: str, root: bool = False) -> "Struct":
        s = Struct(name, path, doc(schema.get("description")))
        expandable = set(schema.get("x-expandableFields", []))
        required = set(schema.get("required", []))
        for prop, node in schema.get("properties", {}).items():
            # Every Stripe resource has an id; the spec's `required` list is not the signal
            # (a draft invoice omits it), and half the package keys on `Resource.ID`.
            if prop == "id" and (root or "id" in required):
                s.has_id = True
                continue
            s.fields.append(self.resolve(node, prop, expandable, s))
        return s

    def run(self) -> dict[str, str]:
        self.shared_done: dict[str, "Struct | None"] = {}
        self.shared_refs_by_name: dict[str, str] = {}
        self.shared_names_by_ref: dict[str, str] = {}
        for name in RESOURCES:
            self.survey(name, name, set())
        files: dict[str, str] = {}
        for name, swift_path in RESOURCES.items():
            if self.only and name not in self.only:
                continue
            root = self.build_struct(swift_path.split(".")[-1], self.schemas[name], f"{self.ns}.{swift_path}", root=True)
            files[f"{self.ns}.{swift_path}.swift"] = self.render_resource(name, swift_path, root)
        files[f"{self.ns}.Shared.swift"] = self.render_shared()
        if self.ns != "Stripe":
            files[f"{self.ns}.swift"] = self.render_namespace()
        files = {k: v.replace("Generated.", f"{self.ns}.") for k, v in files.items()}
        if self.ns == "Stripe":
            files = {k: v.replace("#endif\nimport Stripe\n", "#endif\n") for k, v in files.items()}
        return files

    # ---- rendering ------------------------------------------------------------------------

    def render_resource(self, schema_name: str, swift_path: str, root: "Struct") -> str:
        parts = swift_path.split(".")
        container = self.ns + ("." + ".".join(parts[:-1]) if len(parts) > 1 else "")
        body = root.render(indent="    ")
        return HEADER.format(version=self.version, schema=schema_name) + \
            f"extension {container} {{\n{body}}}\n"

    def render_shared(self) -> str:
        out = HEADER.format(version=self.version, schema="(schemas reached from more than one resource)")
        out += f"extension {self.ns} {{\n    public enum Shared {{}}\n}}\n\n"
        for ref, s in sorted(self.shared_done.items(), key=lambda kv: kv[1].name):
            out += f"// {ref}\nextension {self.ns}.Shared {{\n{s.render(indent='    ')}}}\n\n"
        return out

    def render_namespace(self) -> str:
        enums = sorted({p.split(".")[0] for p in RESOURCES.values()})
        out = HEADER.format(version=self.version, schema="(namespace)")
        out += "/// Generated models live here until they are cut over into `Stripe`.\n"
        out += "public enum Generated {\n"
        for e in enums:
            out += f"    public enum {e} {{}}\n"
        out += "}\n\n"
        # second-level containers, e.g. Billing.Subscription is itself a struct that holds Item —
        # nothing to declare; Swift nests through the struct.
        return out


HEADER = """//
//  Generated by Scripts/generate-models.py — do not edit.
//  Source: Stripe OpenAPI spec, version {version}
//  Schema: {schema}
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import Stripe

"""


class Enum:
    def __init__(self, name: str, values: list[str], description: str | None):
        self.name, self.values, self.description = name, values, description

    def render(self, indent: str) -> str:
        out = ""
        if self.description:
            out += f"{indent}/// {self.description}\n"
        out += f"{indent}public enum {ident(self.name)}: String, Codable, Hashable, Sendable {{\n"
        for v in self.values:
            c = enum_case(v)
            raw = f' = "{v}"' if c.strip("`") != v else ""
            out += f"{indent}    case {c}{raw}\n"
        out += f"{indent}}}\n"
        return out


class Field:
    def __init__(self, name, wire, swift_type, description, wrapper=None,
                 id_wrapper=False, collection_wrapper=False, boxed=False):
        self.name, self.wire, self.swift_type, self.description = name, wire, swift_type, description
        self.wrapper, self.id_wrapper, self.collection_wrapper = wrapper, id_wrapper, collection_wrapper
        self.boxed = boxed


class Struct:
    def __init__(self, name: str, path: str, description: str | None):
        self.name, self.path, self.description = name, path, description
        self.fields: list[Field] = []
        self.enums: list[Enum] = []
        self.nested: list[Struct] = []
        self.has_id = False

    def render(self, indent: str) -> str:
        i = indent
        conformances = "Codable, Hashable, Sendable" + (", Identifiable" if self.has_id else "")
        out = ""
        if self.description:
            out += f"{i}/// {self.description}\n"
        out += f"{i}public struct {ident(self.name)}: {conformances} {{\n"
        if self.has_id:
            out += f"{i}    public typealias ID = String\n{i}    public let id: ID\n"
        for f in self.fields:
            if f.description:
                out += f"{i}    /// {f.description}\n"
            if f.wrapper:
                out += f"{i}    {f.wrapper} public var {ident(f.name)}: {f.swift_type}?\n"
            else:
                out += f"{i}    public var {ident(f.name)}: {f.swift_type}?\n"
        # A spec object with no properties (`konbini: {}`) is a marker; it has nothing to key.
        if not self.fields and not self.has_id:
            out += f"{i}    public init() {{}}\n{i}}}\n"
            return out
        # CodingKeys, from the same list as the properties
        out += f"\n{i}    private enum CodingKeys: String, CodingKey {{\n"
        if self.has_id:
            out += f"{i}        case id\n"
        for f in self.fields:
            out += f"{i}        case {ident(f.name)}\n"
        out += f"{i}    }}\n\n"
        # init
        params = ([f"id: ID"] if self.has_id else []) + \
                 [f"{ident(f.name)}: {f.swift_type}? = nil" for f in self.fields]
        out += f"{i}    public init(\n" + ",\n".join(f"{i}        {p}" for p in params) + f"\n{i}    ) {{\n"
        if self.has_id:
            out += f"{i}        self.id = id\n"
        for f in self.fields:
            n = ident(f.name)
            if f.id_wrapper:
                out += f"{i}        self._{f.name} = Expandable(id: {n})\n"
            elif f.collection_wrapper:
                out += f"{i}        self._{f.name} = ExpandableCollection(ids: {n})\n"
            elif f.boxed:
                out += f"{i}        self._{f.name} = Boxed(wrappedValue: {n})\n"
            else:
                out += f"{i}        self.{n} = {n}\n"
        out += f"{i}    }}\n"
        for e in self.enums:
            out += "\n" + e.render(i + "    ")
        for n in self.nested:
            out += "\n" + n.render(i + "    ")
        out += f"{i}}}\n"
        return out


# --------------------------------------------------------------------------------------------

def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("spec")
    ap.add_argument("--out", default="Sources/StripeGenerated")
    ap.add_argument("--namespace", default="Generated",
                    help="root namespace for the emitted types (Stripe, or Generated for side-by-side)")
    ap.add_argument("--check", action="store_true", help="report unmapped refs and unions; write nothing")
    ap.add_argument("--only", nargs="*", help="emit only these schemas (Shared is always emitted)")
    ap.add_argument("--keep", action="store_true", help="do not delete other generated files in --out")
    args = ap.parse_args()

    gen = Generator(json.load(open(args.spec)), namespace=args.namespace, only=set(args.only or []) or None)
    files = gen.run()

    print(f"spec {gen.version}: {len(RESOURCES)} resources, {len(gen.shared_done)} shared types")
    if gen.unions:
        print(f"\n{len(gen.unions)} union(s) emitted as their first member (stage 3):")
        for u in gen.unions:
            print(f"  {u}")
    if gen.unmapped:
        print(f"\n{len(gen.unmapped)} resource ref(s) with no entry in RESOURCE_TYPES:")
        for r in sorted(gen.unmapped):
            print(f"  {r}")
        return 1
    if args.check:
        return 0

    out = pathlib.Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    if not args.keep:
        for stale in out.glob(f"{args.namespace}.*.swift"):
            stale.unlink()
    for name, content in files.items():
        (out / name).write_text(content)
    print(f"\nwrote {len(files)} files to {out}/")
    return 0


if __name__ == "__main__":
    sys.exit(main())
