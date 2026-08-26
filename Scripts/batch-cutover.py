#!/usr/bin/env python3
"""Cuts every hand-modelled resource with no request-layer entanglement over to the generator.

    Scripts/batch-cutover.py spec3.sdk.json [--max-refs 0] [--dry-run]

For each spec resource that is modelled by hand and not yet generated, locates the hand struct
(by RESOURCE_TYPES, else by a unique docs link or type name), counts request-layer references
to nested types under it, and — when that count is within --max-refs — registers it in
generate-models.py at the same Swift path, generates it, and runs cutover.py on the hand file.
Anything it cannot locate uniquely, or that is more entangled, is listed and left alone.
"""
import argparse, importlib.util, json, pathlib, re, subprocess, sys

ap = argparse.ArgumentParser(); ap.add_argument("spec"); ap.add_argument("--max-refs", type=int, default=0)
ap.add_argument("--dry-run", action="store_true"); args = ap.parse_args()

S = json.load(open(args.spec))["components"]["schemas"]
GEN = pathlib.Path("Scripts/generate-models.py")
spec = importlib.util.spec_from_file_location("gen", GEN); gen = importlib.util.module_from_spec(spec); spec.loader.exec_module(gen)
hand_files = {p: p.read_text() for p in pathlib.Path("Sources/Stripe/Models").rglob("*.swift") if not gen.is_generated(p)}
requests = "\n".join(p.read_text() for p in list(pathlib.Path("Sources/Stripe/Requests").rglob("*.swift")) + list(pathlib.Path("Sources/Stripe/Clients").rglob("*.swift")))
KEEP_BY_HAND = {"event"}   # lenient decoding and the Object union

# Hand types whose names do not follow from the schema name. Each is verified to exist before
# it is used; a wrong entry is reported, not acted on.
IRREGULAR = {
    "webhook_endpoint": "Webhook",
    "payment_method_configuration": "Stripe.PaymentMethodConfigurations.Configuration",
    "confirmation_token": "ConfirmationToken",
    "login_link": "Stripe.Connect.Account.LoginLink",
    "ephemeral_key": "Stripe.EphemeralKey",
    "file_link": "Stripe.FileLinks.FileLink",
    "account_session": "Stripe.Connect.Account.Session",
    "capability": "Stripe.Connect.Capability",
    "country_spec": "Stripe.Connect.CountrySpec",
    "customer_session": "Stripe.Customers.Customer.Session",
    "transfer_reversal": "Stripe.Connect.Transfer.Reversal",
    "setup_attempt": "Stripe.Setup.Attempt",
    "tax.calculation": "Stripe.Tax.Calculation",
    "billing_portal.configuration": "Stripe.Billing.Customer.Portal.Configuration",
    "billing_portal.session": "Stripe.Billing.Customer.Portal.Session",
    "billing.credit_balance_summary": "Stripe.Billing.Credit.Balance.Summary",
    "radar.early_fraud_warning": "Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning",
    "radar.value_list": "Stripe.Fraud.ValueLists.ValueList",
    "radar.value_list_item": "Stripe.Fraud.ValueListItems.ValueListItem",
    "terminal.location": "Stripe.Terminal.Locations.Location",
    "terminal.reader": "Stripe.Terminal.Readers.Reader",
    "terminal.configuration": "TerminalConfiguration",
    "terminal.connection_token": "TerminalConnectionToken",
    "forwarding.request": "Stripe.Forwarding.Request",
    "payment_method_domain": "Stripe.PaymentMethodDomain",
    "financial_connections.account": "FinancialConnections.Account",
    "financial_connections.session": "FinancialConnections.Session",
    "financial_connections.transaction": "FinancialConnections.Transaction",
    "identity.verification_report": "VerificationReport",
    "identity.verification_session": "VerificationSession",
    "issuing.card": "IssuingCard",
    "issuing.cardholder": "Cardholder",
    "issuing.dispute": "IssuingDispute",
    "issuing.transaction": "Transaction",
    "issuing.authorization": "Authorization",
    "funding_instructions": "FundingInstructions",
    "reporting.report_run": "ReportRun",
    "reporting.report_type": "ReportType",
    "scheduled_query_run": "ScheduledQueryRun",
    "bank_account": "BankAccount",
    "card": "Card",
    "source": "StripePaymentSource",
    "tax_id": "Stripe.Tax.ID",
    "payout": "Stripe.Payouts.Payout",
}

def locate(name):
    """-> (file, namespace, struct) for the hand type, or None if not uniquely found."""
    t = IRREGULAR.get(name) or gen.RESOURCE_TYPES.get(name)
    candidates = []
    if t and name not in gen.RESOURCES:
        parts = t.split("."); ns, struct = ".".join(parts[:-1]), parts[-1]
        for p, s in hand_files.items():
            if (ns and re.search(rf"^extension {re.escape(ns)} \{{\s*\n(?:\s*///[^\n]*\n)*\s*public struct {struct}\b", s, re.M)) or \
               (not ns and re.search(rf"^public struct {struct}\b", s, re.M)):
                candidates.append((p, ns, struct))
    if not candidates:
        # The hand files open with `// https://docs.stripe.com/api/<path>/object.md`. Match that
        # header only, with the full path, so a file that merely mentions many objects (Event)
        # does not claim them, and `issuing/tokens` is not mistaken for `tokens`.
        api_path = "/".join(seg.replace("_", "-") + "s" if i < len(name.split(".")) - 1 else seg.replace("_", "-")
                            for i, seg in enumerate(name.split(".")))
        last = name.split(".")[-1].replace("_", "-")
        alts = [api_path, api_path + "s"] + ([] if "." in name else [last, last + "s"])   # a dotted name must match its full path
        link = re.compile(rf"docs\.stripe\.com/api/(?:{'|'.join(re.escape(a) for a in alts)})/object\.md")
        for p, s in hand_files.items():
            head = "\n".join(s.splitlines()[:25])
            if link.search(head):
                m = re.search(r"^(?:extension ([\w.]+) \{\s*\n(?:\s*///[^\n]*\n)*\s*)?public struct (\w+)\b", s, re.M)
                if m: candidates.append((p, m.group(1) or "", m.group(2)))
    return candidates[0] if len(candidates) == 1 else None

todo, skipped = [], []
for name, sch in sorted(S.items()):
    if "x-resourceId" not in sch or sch.get("type") != "object" or name.startswith("deleted"): continue
    if name in gen.RESOURCES or name in gen.INLINE_RESOURCES or name in gen.ID_ONLY_RESOURCES or name in KEEP_BY_HAND: continue
    loc = locate(name)
    if not loc: skipped.append((name, "not located uniquely")); continue
    f, ns, struct = loc
    full = f"{ns}.{struct}" if ns else struct
    refs = len(re.findall(rf"\b{re.escape(full)}\.[A-Z]\w*", requests))
    if refs > args.max_refs: skipped.append((name, f"{refs} request refs")); continue
    if ns.startswith("Stripe."):
        todo.append((name, ns[len("Stripe."):] + "." + struct, f, struct, ns + "." + struct))
    else:
        # module-level container or a bare module-level struct: a "/" path
        todo.append((name, "/" + (ns + "." + struct if ns else struct), f, struct, (ns + "." + struct) if ns else struct))

print(f"cutting over {len(todo)}; skipping {len(skipped)}")
for n, why in skipped: print(f"   skip {n:<40} {why}")
if args.dry_run or not todo: sys.exit(0)

# register in the generator
s = GEN.read_text()
marker = "    # stage 4a: resources that had no model at all\n"
s = s.replace(marker, marker.replace("resources that had no model at all", "cut over from hand models (batch-cutover.py)") + "".join(f'    "{n}": "{p}",\n' for n, p, *_ in todo) + marker, 1)
tmarker = "    # everything else is the hand-written Stripe type\n"
s = s.replace(tmarker, "".join(f'    "{n}": "{p.lstrip("/") if p.startswith("/") else "Stripe." + p}",\n' for n, p, *_ in todo) + tmarker, 1)
# drop the old hand mapping for these — only in RESOURCE_TYPES, after the hand-type marker
head, tail = s.split(tmarker, 1)
for n, *_ in todo:
    tail = re.sub(rf'\n    "{re.escape(n)}": "[^"]+",', "", tail)
GEN.write_text(head + tmarker + tail)
subprocess.run([sys.executable, str(GEN), args.spec, "--only", *[n for n, *_ in todo], "--keep"], check=True)
for n, p, f, struct, full in todo:
    ns = ".".join(full.split(".")[:-1])
    r = subprocess.run([sys.executable, "Scripts/cutover.py", str(f), struct, full, "Sources/Stripe/Models/" + gen.model_file(*gen.layout()[n])], capture_output=True, text=True)
    print(("   ok   " if r.returncode == 0 else "   FAIL ") + f"{n:<36} {r.stdout.splitlines()[0] if r.stdout else r.stderr.strip().splitlines()[-1]}")
