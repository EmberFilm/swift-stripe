#!/usr/bin/env python3
"""Reports how far the vendored models have drifted from Stripe's OpenAPI spec.

Exit status is the number of unacknowledged gaps, so this doubles as a CI gate.

The models came from swift-stripe-standard and are not regenerated, so fields Stripe adds are
absent and fields it moves decode to nil — silently, because every property is optional. This
turns that into a number.

    curl -sSLO https://raw.githubusercontent.com/stripe/openapi/master/openapi/spec3.sdk.json
    Scripts/model-drift.py spec3.sdk.json

"missing" = in the spec, not on the Swift type: the value is dropped on decode.
"stale"   = on the Swift type, not in the spec: the property is always nil.

Known blind spot: this reads property declarations, not `CodingKeys`. Where a type declares an
explicit `CodingKeys`, a property missing from it compiles, reports zero drift here, and still
decodes to nil forever. Adding a field is therefore not done until it is decoded in
Tests/StripeTests/AddedFieldDecodingTests.swift — and note that most of these types have no
`CodingKeys` of their own, so a case added to the first block in the file usually lands on a
nested type instead.
"""
import json, re, pathlib, sys

def snake(name: str) -> str:
    out = ""
    for i, c in enumerate(name):
        out += ("_" if i and c.isupper() else "") + c.lower()
    return out

def swift_fields(path: pathlib.Path, struct: str) -> set[str]:
    src = path.read_text()
    body = src[src.index(f"public struct {struct}"):]
    cut = body.find("public init(")
    body = body[:cut] if cut > 0 else body
    # `let` as well as `var`: immutable ids are declared `public let id: ID`.
    # `public var `type`: …` — a keyword used as a property name is back-ticked.
    names = set(re.findall(r"public (?:var|let) `?(\w+)`?\s*:", body))
    names |= set(re.findall(r"public (?:var|let) `?(\w+)`?\s*$", body, re.M))
    return {snake(n) for n in names}

# Properties this package adds on purpose, which will never appear in the spec.
INTENTIONAL_EXTRA: dict[str, set[str]] = {
    "event": {"raw_type"},
}

# Spec fields deliberately not modelled, with the reason. Anything here is excluded from the
# drift count, so the number means "unacknowledged gap" rather than "gap".
ACKNOWLEDGED_MISSING: dict[str, dict[str, str]] = {
    "charge": {
        "source": "deprecated legacy Source/Card/BankAccount union; Stripe is removing it",
    },
    "payment_intent": {
        "source": "deprecated legacy Source/Card/BankAccount union; Stripe is removing it",
    },
}

# Properties the API no longer returns, kept so accounts pinned to an older version still decode.
# Excluded from the stale count for the same reason.
VERSION_GATED: dict[str, dict[str, str]] = {
    "subscription": {
        "current_period_start": "moved to subscription items in 2025-03-31.basil",
        "current_period_end": "moved to subscription items in 2025-03-31.basil",
        "discount": "replaced by `discounts` in 2025-03-31.basil",
        "plan": "legacy single-plan field; read items instead",
        "quantity": "legacy single-plan field; read items instead",
    },
    "charge": {
        "dispute": "removed in 2025-03-31.basil; read `disputed` or list disputes",
        "invoice": "removed in 2025-03-31.basil",
    },
    "product": {
        "attributes": "removed from the Product object",
    },
    "payment_intent": {
        "invoice": "removed in 2025-03-31.basil",
    },
    "checkout.session": {
        "shipping_details": "moved to collected_information.shipping_details in 2025-03-31.basil",
        "shipping_rate": "replaced by shipping_cost.shipping_rate in 2025-03-31.basil",
    },
    "invoice": {
        "application_fee_amount": "removed in 2025-03-31.basil",
        "charge": "moved to payments[].payment.charge in 2025-03-31.basil",
        "paid": "removed in 2025-03-31.basil; read `status`",
        "paid_out_of_band": "moved to amount_paid_off_stripe in 2025-03-31.basil",
        "payment_intent": "moved to payments[].payment.payment_intent in 2025-03-31.basil",
        "quote": "moved to parent.quote_details.quote in 2025-03-31.basil",
        "rendering_options": "replaced by `rendering` in 2025-03-31.basil",
        "subscription_details": "moved under `parent` in 2025-03-31.basil",
        "subscription_proration_date": "moved under parent.subscription_details in 2025-03-31.basil",
        "tax": "replaced by total_taxes in 2025-03-31.basil",
        "total_tax_amounts": "replaced by total_taxes in 2025-03-31.basil",
        "transfer_data": "removed in 2025-03-31.basil",
    },
}

M = "Sources/Stripe/Models/"
G = M + "Generated/"   # emitted by generate-models.py; event stays hand-written
# schema name, model file, struct name
import importlib.util as _ilu
_spec = _ilu.spec_from_file_location("gen", pathlib.Path(__file__).with_name("generate-models.py"))
_gen = _ilu.module_from_spec(_spec); _spec.loader.exec_module(_gen)
# Every generated resource, from the generator's own list, plus the one hand-written resource.
TARGETS = [(name, G + f"Stripe.{path.lstrip('/')}.swift", path.split(".")[-1]) for name, path in _gen.RESOURCES.items()]
TARGETS.append(("event", M + "CoreResources/Events/Stripe.Events.Event.swift", "Event"))

def main() -> int:
    if len(sys.argv) < 2:
        print(__doc__)
        return 2
    spec = json.load(open(sys.argv[1]))
    schemas = spec["components"]["schemas"]
    print(f"spec version {spec['info']['version']}  ({len(schemas)} schemas)\n")
    print(f"{'schema':<20}{'spec':>5}{'model':>7}{'missing':>9}{'stale':>7}   detail")
    print("-" * 100)
    worst = 0
    for name, path, struct in TARGETS:
        schema = schemas.get(name)
        if schema is None:
            print(f"{name:<20}    schema not found in spec")
            continue
        spec_fields = set(schema.get("properties", {}).keys())
        try:
            model = swift_fields(pathlib.Path(path), struct)
        except (OSError, ValueError):
            print(f"{name:<20}    could not parse {path}")
            continue
        missing = sorted(spec_fields - model - set(ACKNOWLEDGED_MISSING.get(name, {})))
        stale = sorted(
            model - spec_fields
            - INTENTIONAL_EXTRA.get(name, set())
            - set(VERSION_GATED.get(name, {}))
        )
        worst += len(missing) + len(stale)
        detail = ", ".join(missing[:4]) + ("…" if len(missing) > 4 else "")
        print(f"{name:<20}{len(spec_fields):>5}{len(model):>7}{len(missing):>9}{len(stale):>7}   {detail}")
    print()
    if worst:
        print(f"{worst} unacknowledged gap(s). Model them, or record the reason in "
              f"ACKNOWLEDGED_MISSING / VERSION_GATED.")
    else:
        print("No unacknowledged drift.")
    return 1 if worst else 0

if __name__ == "__main__":
    sys.exit(main())
