#!/usr/bin/env python3
"""Generates Swift model types from Stripe's OpenAPI spec.

    Scripts/generate-models.py spec3.sdk.json            # emit into Sources/Stripe/Models/Generated
    Scripts/generate-models.py spec3.sdk.json --check    # only report what it cannot map

The generated files are committed; there is no build plugin. Each resource's former hand file
survives as *.Retained.swift, holding only the nested types the request layer still names that
the generator spells differently (see Scripts/cutover.py).

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
    # stage 4a: cut over from hand models (batch-cutover.py)
    "application_fee": "Connect.Application.Fee",
    "apps.secret": "Connect.Secret",
    "balance_transaction": "Balance.Transaction",
    "billing.credit_balance_transaction": "Billing.Credit.Balance.Transaction",
    "cash_balance": "Customers.CustomerCashBalance",
    "customer_balance_transaction": "Billing.Customer.Balance.Transaction",
    "dispute": "Disputes.Dispute",
    "invoiceitem": "Billing.Invoice.Item",
    "item": "Checkout.Session.LineItem",
    "person": "Connect.Person",
    "review": "Fraud.Reviews.Review",
    "tax_code": "Tax.Code",
    "test_helpers.test_clock": "Billing.TestClocks.TestClock",
    "token": "Tokens.Token",
    "topup": "Connect.TopUp",
    # stage 4a: cut over from hand models (batch-cutover.py)
    "bank_account": "/BankAccount",
    "capability": "Connect.Capability",
    "card": "/Card",
    "country_spec": "Connect.CountrySpec",
    "customer_session": "Customers.Customer.Session",
    "ephemeral_key": "/Stripe.EphemeralKey",
    "fee_refund": "Connect.Application.Fee.Refund",
    "file_link": "FileLinks.FileLink",
    "financial_connections.account": "/FinancialConnections.Account",
    "funding_instructions": "/FundingInstructions",
    "identity.verification_report": "/VerificationReport",
    "identity.verification_session": "/VerificationSession",
    "issuing.authorization": "/Authorization",
    "issuing.card": "/IssuingCard",
    "issuing.cardholder": "/Cardholder",
    "issuing.dispute": "/IssuingDispute",
    "issuing.transaction": "/Transaction",
    "payment_method_domain": "/Stripe.PaymentMethodDomain",
    "radar.early_fraud_warning": "Fraud.EarlyFraudWarnings.EarlyFraudWarning",
    "radar.value_list_item": "Fraud.ValueListItems.ValueListItem",
    "reporting.report_run": "/ReportRun",
    "reporting.report_type": "/ReportType",
    "scheduled_query_run": "/ScheduledQueryRun",
    "setup_attempt": "Setup.Attempt",
    "source": "/Source",
    "terminal.configuration": "/TerminalConfiguration",
    "terminal.connection_token": "/TerminalConnectionToken",
    "terminal.reader": "Terminal.Readers.Reader",
    "webhook_endpoint": "/Webhook",
    # stage 4a: cut over from hand models (batch-cutover.py)
    "account_session": "Connect.Account.Session",
    "balance": "/Stripe.Balance",
    "billing.credit_balance_summary": "Billing.Credit.Balance.Summary",
    "billing_portal.session": "Billing.Customer.Portal.Session",
    "confirmation_token": "/ConfirmationToken",
    "credit_note": "Billing.Credit.Note",
    "file": "Files.File",
    "line_item": "Billing.Invoice.LineItem",
    "login_link": "Connect.Account.LoginLink",
    "mandate": "Mandates.Mandate",
    "payment_method_configuration": "PaymentMethodConfigurations.Configuration",
    "quote": "Billing.Quote",
    "radar.value_list": "Fraud.ValueLists.ValueList",
    "refund": "Refunds.Refund",
    "tax.calculation": "Tax.Calculation",
    "tax_id": "Tax.ID",
    "tax_rate": "Tax.Rate",
    "terminal.location": "Terminal.Locations.Location",
    "transfer_reversal": "Connect.Transfer.Reversal",
    # stage 4a: cut over from hand models (batch-cutover.py)
    "account": "Connect.Account",
    "billing.credit_grant": "Billing.Credit.Grant",
    "billing_portal.configuration": "Billing.Customer.Portal.Configuration",
    "coupon": "Products.Coupon",
    "forwarding.request": "Forwarding.Request",
    "payment_method": "PaymentMethods.PaymentMethod",
    "payout": "Payouts.Payout",
    "plan": "Billing.Plan",
    "promotion_code": "/Promotion.Code",
    "setup_intent": "Setup.Intent",
    "shipping_rate": "Products.Shipping.Rate",
    "transfer": "Connect.Transfer",
    # stage 4a: cut over from hand models (batch-cutover.py)
    "payment_link": "/Stripe.PaymentLink",
    "subscription_schedule": "Billing.Subscription.Schedule",
    # stage 4a: resources that had no model at all
    "climate.order": "Climate.Order",
    "climate.product": "Climate.Product",
    "tax.settings": "Tax.Settings",
    "tax.transaction": "Tax.Transaction",
    "financial_connections.session": "/FinancialConnections.Session",
    "financial_connections.transaction": "/FinancialConnections.Transaction",
    "entitlements.feature": "Entitlements.Feature",
    "treasury.transaction": "Treasury.Transaction",
    "treasury.credit_reversal": "Treasury.CreditReversal",
    "treasury.debit_reversal": "Treasury.DebitReversal",
    "treasury.financial_account": "Treasury.FinancialAccount",
    "treasury.financial_account_features": "Treasury.FinancialAccountFeatures",
    "treasury.inbound_transfer": "Treasury.InboundTransfer",
    "treasury.outbound_payment": "Treasury.OutboundPayment",
    "treasury.outbound_transfer": "Treasury.OutboundTransfer",
    "treasury.received_credit": "Treasury.ReceivedCredit",
    "treasury.received_debit": "Treasury.ReceivedDebit",
    "treasury.transaction_entry": "Treasury.TransactionEntry",
    "billing.alert": "Billing.Alert",
    "billing.meter": "Billing.Meter",
    "billing.meter_event": "Billing.MeterEvent",
    "billing.meter_event_adjustment": "Billing.MeterEventAdjustment",
    "billing.meter_event_summary": "Billing.MeterEventSummary",
    "invoice_rendering_template": "Billing.InvoiceRenderingTemplate",
    "credit_note_line_item": "Billing.CreditNoteLineItem",
    "tax.association": "Tax.Association",
    "tax.calculation_line_item": "Tax.CalculationLineItem",
    "tax.registration": "Tax.Registration",
    "tax.transaction_line_item": "Tax.TransactionLineItem",
    "issuing.personalization_design": "Issuing.PersonalizationDesign",
    "issuing.physical_bundle": "Issuing.PhysicalBundle",
    "climate.supplier": "Climate.Supplier",
    "entitlements.active_entitlement": "Entitlements.ActiveEntitlement",
    "radar.payment_evaluation": "Fraud.PaymentEvaluation",
    "terminal.onboarding_link": "Terminal.OnboardingLink",
    "financial_connections.account_owner": "/FinancialConnections.AccountOwner",
    "account_link": "Connect.AccountLink",
    "apple_pay_domain": "ApplePayDomain",
    "balance_settings": "BalanceSettings",
    "exchange_rate": "ExchangeRate",
    "payment_attempt_record": "PaymentAttemptRecord",
    "product_feature": "Products.ProductFeature",
    "source_transaction": "SourceTransaction",
    "customer_cash_balance_transaction": "Customers.CashBalanceTransaction",
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
    "treasury.credit_reversal": "Generated.Treasury.CreditReversal",
    "treasury.debit_reversal": "Generated.Treasury.DebitReversal",
    "treasury.financial_account": "Generated.Treasury.FinancialAccount",
    "treasury.financial_account_features": "Generated.Treasury.FinancialAccountFeatures",
    "treasury.inbound_transfer": "Generated.Treasury.InboundTransfer",
    "treasury.outbound_payment": "Generated.Treasury.OutboundPayment",
    "treasury.outbound_transfer": "Generated.Treasury.OutboundTransfer",
    "treasury.received_credit": "Generated.Treasury.ReceivedCredit",
    "treasury.received_debit": "Generated.Treasury.ReceivedDebit",
    "treasury.transaction_entry": "Generated.Treasury.TransactionEntry",
    "billing.alert": "Generated.Billing.Alert",
    "billing.meter": "Generated.Billing.Meter",
    "billing.meter_event": "Generated.Billing.MeterEvent",
    "billing.meter_event_adjustment": "Generated.Billing.MeterEventAdjustment",
    "billing.meter_event_summary": "Generated.Billing.MeterEventSummary",
    "invoice_rendering_template": "Generated.Billing.InvoiceRenderingTemplate",
    "credit_note_line_item": "Generated.Billing.CreditNoteLineItem",
    "tax.association": "Generated.Tax.Association",
    "tax.calculation_line_item": "Generated.Tax.CalculationLineItem",
    "tax.registration": "Generated.Tax.Registration",
    "tax.transaction_line_item": "Generated.Tax.TransactionLineItem",
    "issuing.personalization_design": "Generated.Issuing.PersonalizationDesign",
    "issuing.physical_bundle": "Generated.Issuing.PhysicalBundle",
    "climate.supplier": "Generated.Climate.Supplier",
    "entitlements.active_entitlement": "Generated.Entitlements.ActiveEntitlement",
    "radar.payment_evaluation": "Generated.Fraud.PaymentEvaluation",
    "terminal.onboarding_link": "Generated.Terminal.OnboardingLink",
    "financial_connections.account_owner": "FinancialConnections.AccountOwner",
    "account_link": "Generated.Connect.AccountLink",
    "apple_pay_domain": "Generated.ApplePayDomain",
    "balance_settings": "Generated.BalanceSettings",
    "exchange_rate": "Generated.ExchangeRate",
    "payment_attempt_record": "Generated.PaymentAttemptRecord",
    "product_feature": "Generated.Products.ProductFeature",
    "source_transaction": "Generated.SourceTransaction",
    "customer_cash_balance_transaction": "Generated.Customers.CashBalanceTransaction",
    "entitlements.feature": "Generated.Entitlements.Feature",
    "treasury.transaction": "Generated.Treasury.Transaction",
    "application_fee": "Generated.Connect.Application.Fee",
    "apps.secret": "Generated.Connect.Secret",
    "balance_transaction": "Generated.Balance.Transaction",
    "billing.credit_balance_transaction": "Generated.Billing.Credit.Balance.Transaction",
    "cash_balance": "Generated.Customers.CustomerCashBalance",
    "customer_balance_transaction": "Generated.Billing.Customer.Balance.Transaction",
    "dispute": "Generated.Disputes.Dispute",
    "invoiceitem": "Generated.Billing.Invoice.Item",
    "item": "Generated.Checkout.Session.LineItem",
    "person": "Generated.Connect.Person",
    "review": "Generated.Fraud.Reviews.Review",
    "tax_code": "Generated.Tax.Code",
    "test_helpers.test_clock": "Generated.Billing.TestClocks.TestClock",
    "token": "Generated.Tokens.Token",
    "topup": "Generated.Connect.TopUp",
    "bank_account": "BankAccount",
    "capability": "Generated.Connect.Capability",
    "card": "Card",
    "country_spec": "Generated.Connect.CountrySpec",
    "customer_session": "Generated.Customers.Customer.Session",
    "ephemeral_key": "Stripe.EphemeralKey",
    "fee_refund": "Generated.Connect.Application.Fee.Refund",
    "file_link": "Generated.FileLinks.FileLink",
    "financial_connections.account": "FinancialConnections.Account",
    "funding_instructions": "FundingInstructions",
    "identity.verification_report": "VerificationReport",
    "identity.verification_session": "VerificationSession",
    "issuing.authorization": "Authorization",
    "issuing.card": "IssuingCard",
    "issuing.cardholder": "Cardholder",
    "issuing.dispute": "IssuingDispute",
    "issuing.transaction": "Transaction",
    "payment_method_domain": "Stripe.PaymentMethodDomain",
    "radar.early_fraud_warning": "Generated.Fraud.EarlyFraudWarnings.EarlyFraudWarning",
    "radar.value_list_item": "Generated.Fraud.ValueListItems.ValueListItem",
    "reporting.report_run": "ReportRun",
    "reporting.report_type": "ReportType",
    "scheduled_query_run": "ScheduledQueryRun",
    "setup_attempt": "Generated.Setup.Attempt",
    "source": "Source",
    "terminal.configuration": "TerminalConfiguration",
    "terminal.connection_token": "TerminalConnectionToken",
    "terminal.reader": "Generated.Terminal.Readers.Reader",
    "webhook_endpoint": "Webhook",
    "climate.order": "Generated.Climate.Order",
    "climate.product": "Generated.Climate.Product",
    "tax.settings": "Generated.Tax.Settings",
    "tax.transaction": "Generated.Tax.Transaction",
    "financial_connections.session": "FinancialConnections.Session",
    "financial_connections.transaction": "FinancialConnections.Transaction",
    "account_session": "Generated.Connect.Account.Session",
    "balance": "Stripe.Balance",
    "billing.credit_balance_summary": "Generated.Billing.Credit.Balance.Summary",
    "billing_portal.session": "Generated.Billing.Customer.Portal.Session",
    "confirmation_token": "ConfirmationToken",
    "credit_note": "Generated.Billing.Credit.Note",
    "file": "Generated.Files.File",
    "line_item": "Generated.Billing.Invoice.LineItem",
    "login_link": "Generated.Connect.Account.LoginLink",
    "mandate": "Generated.Mandates.Mandate",
    "payment_method_configuration": "Generated.PaymentMethodConfigurations.Configuration",
    "quote": "Generated.Billing.Quote",
    "radar.value_list": "Generated.Fraud.ValueLists.ValueList",
    "refund": "Generated.Refunds.Refund",
    "tax.calculation": "Generated.Tax.Calculation",
    "tax_id": "Generated.Tax.ID",
    "tax_rate": "Generated.Tax.Rate",
    "terminal.location": "Generated.Terminal.Locations.Location",
    "transfer_reversal": "Generated.Connect.Transfer.Reversal",
    "account": "Generated.Connect.Account",
    "billing.credit_grant": "Generated.Billing.Credit.Grant",
    "billing_portal.configuration": "Generated.Billing.Customer.Portal.Configuration",
    "coupon": "Generated.Products.Coupon",
    "forwarding.request": "Generated.Forwarding.Request",
    "payment_method": "Generated.PaymentMethods.PaymentMethod",
    "payout": "Generated.Payouts.Payout",
    "plan": "Generated.Billing.Plan",
    "promotion_code": "Promotion.Code",
    "setup_intent": "Generated.Setup.Intent",
    "shipping_rate": "Generated.Products.Shipping.Rate",
    "transfer": "Generated.Connect.Transfer",
    "payment_link": "Stripe.PaymentLink",
    "subscription_schedule": "Generated.Billing.Subscription.Schedule",
    # everything else is the hand-written Stripe type
    "billing_portal.configuration": "Stripe.Billing.Customer.Portal.Configuration",
    "tax_id": "Stripe.Tax.ID",
    "issuing.authorization": "Authorization",
    "application": "Stripe.Connect.Application",
    # Not the top-level `CashBalance`: inside Customer that name resolves to the empty request
    # namespace `Stripe.Customers.CashBalance`. This is the type the hand Customer used.
    "discount": "Stripe.Products.Discount",
    "deleted_discount": "Stripe.Products.Discount",
    "payment_source": "StripePaymentSource",
}

# Resources with no Swift type at all. A reference to one is kept as its id, never expanded.
ID_ONLY_RESOURCES: set[str] = {
    "payment_record",
    "external_account",   # bank account | card; a union, kept as the id until unions are modelled
    "issuing.token",      # no hand type, and a top-level placement the generator does not do yet
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
    """A Swift case name for a spec enum value; the raw value is always emitted alongside."""
    c = camel(value)
    if not c.strip("_") or not re.match(r"^[A-Za-z]", c.lstrip("_")):
        # nothing usable survives ("_", "-", a bare digit): name it for its raw text
        c = "value" + re.sub(r"\W", "_", value) or "empty"
    elif not re.match(r"^[A-Za-z_]", c):
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
    def __init__(self, spec: dict, namespace: str = "Stripe", only: set[str] | None = None):
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
        if node.get("type") == "array":
            # reached for map values and nested arrays; a property-level array is handled by
            # resolve(), which also decides whether it is an expandable collection
            return f"[{self.element_type(node.get('items', {}), prop, owner)}]"

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
            # Half the package keys on `Resource.ID`, so a root resource always gets the alias.
            # Whether `id` itself is optional follows the spec: an upcoming-invoice preview has
            # none, which is why `invoice` does not list it as required.
            if prop == "id" and (root or "id" in required):
                s.has_id = True
                s.id_optional = "id" not in required
                continue
            if prop == "object" and "object" in required:
                # the discriminator Stripe always sends; hand unions switch on it directly
                s.has_object = True
                continue
            s.fields.append(self.resolve(node, prop, expandable, s))
        return s

    def run(self) -> dict[str, str]:
        self.shared_done: dict[str, "Struct | None"] = {}
        self.shared_refs_by_name: dict[str, str] = {}
        self.shared_names_by_ref: dict[str, str] = {}
        # The survey always covers every resource, whatever --only emits: which schemas count as
        # shared, and what they are named, must not depend on which subset is being written.
        for name in RESOURCES:
            self.survey(name, name, set())
        if self.only:
            # Shared types are built on demand as resources reference them; with a subset emitted,
            # build every shared type up front so the Shared file is complete and stable.
            for ref, parents in list(self.ref_parents.items()):
                if len(parents) > 1:
                    self.type_for_ref(ref, next(iter(self.ref_prop_names[ref])), Struct("_", "_", None))
        files: dict[str, str] = {}
        for name, swift_path in RESOURCES.items():
            if self.only and name not in self.only:
                continue
            path = swift_path.lstrip("/")
            root = self.build_struct(path.split(".")[-1], self.schemas[name],
                                     path if swift_path.startswith("/") else f"{self.ns}.{path}", root=True)
            files[f"Generated.{path}.swift"] = self.render_resource(name, swift_path, root)
        files["Generated.Shared.swift"] = self.render_shared()
        if self.ns != "Stripe":
            files[f"{self.ns}.swift"] = self.render_namespace()
        else:
            files["Generated.Namespaces.swift"] = self.render_missing_namespaces()
        files = {k: v.replace("Generated.", f"{self.ns}.") for k, v in files.items()}
        if self.ns == "Stripe":
            files = {k: v.replace("#endif\nimport Stripe\n", "#endif\n") for k, v in files.items()}
        return files

    # ---- rendering ------------------------------------------------------------------------

    def render_resource(self, schema_name: str, swift_path: str, root: "Struct") -> str:
        # A leading "/" places the resource under a top-level container (`FinancialConnections`
        # is a module-level enum, not `Stripe.FinancialConnections`).
        top_level = swift_path.startswith("/")
        parts = swift_path.lstrip("/").split(".")
        container = ".".join(parts[:-1]) if top_level else \
            self.ns + ("." + ".".join(parts[:-1]) if len(parts) > 1 else "")
        if not container:
            # "/Webhook": a module-level struct, the way the hand sources declared it
            return HEADER.format(version=self.version, schema=schema_name) + root.render(indent="")
        body = root.render(indent="    ")
        return HEADER.format(version=self.version, schema=schema_name) + \
            f"extension {container} {{\n{body}}}\n"

    def render_shared(self) -> str:
        out = HEADER.format(version=self.version, schema="(schemas reached from more than one resource)")
        out += f"extension {self.ns} {{\n    public enum Shared {{}}\n}}\n\n"
        for ref, s in sorted(self.shared_done.items(), key=lambda kv: kv[1].name):
            out += f"// {ref}\nextension {self.ns}.Shared {{\n{s.render(indent='    ')}}}\n\n"
        return out

    def render_missing_namespaces(self) -> str:
        """Declares first-level containers (`Stripe.Treasury`) the hand sources do not."""
        hand = "\n".join(p.read_text() for p in pathlib.Path("Sources/Stripe").rglob("*.swift")
                         if "Generated" not in p.parts)
        wanted = sorted({p.split(".")[0] for p in RESOURCES.values() if "." in p and not p.startswith("/")})
        def exists(e):   # `Stripe.X` in use, or declared directly inside the root enum's extension
            return re.search(rf"\bStripe\.{e}\b", hand) or re.search(rf"extension Stripe \{{[^}}]*\bpublic enum {e}\b", hand)
        missing = [e for e in wanted if not exists(e)]
        out = HEADER.format(version=self.version, schema="(namespaces the hand sources do not declare)")
        out += "extension Stripe {\n" + "".join(f"    public enum {e} {{}}\n" for e in missing) + "}\n"
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
        self.id_optional = False
        self.has_object = False

    def render(self, indent: str) -> str:
        i = indent
        conformances = "Codable, Hashable, Sendable" + (", Identifiable" if self.has_id and not self.id_optional else "")
        out = ""
        if self.description:
            out += f"{i}/// {self.description}\n"
        out += f"{i}public struct {ident(self.name)}: {conformances} {{\n"
        if self.has_id:
            decl = "public var id: ID?" if self.id_optional else "public let id: ID"
            out += f"{i}    public typealias ID = String\n{i}    {decl}\n"
        if self.has_object:
            out += f"{i}    /// String representing the object's type.\n{i}    public let object: String\n"
        for f in self.fields:
            if f.description:
                out += f"{i}    /// {f.description}\n"
            if f.wrapper:
                out += f"{i}    {f.wrapper} public var {ident(f.name)}: {f.swift_type}?\n"
            else:
                out += f"{i}    public var {ident(f.name)}: {f.swift_type}?\n"
        # A spec object with no properties (`konbini: {}`) is a marker; it has nothing to key.
        if not self.fields and not self.has_id and not self.has_object:
            out += f"{i}    public init() {{}}\n{i}}}\n"
            return out
        # CodingKeys, from the same list as the properties
        out += f"\n{i}    private enum CodingKeys: String, CodingKey {{\n"
        if self.has_id:
            out += f"{i}        case id\n"
        if self.has_object:
            out += f"{i}        case object\n"
        for f in self.fields:
            out += f"{i}        case {ident(f.name)}\n"
        out += f"{i}    }}\n\n"
        # init
        params = ([("id: ID? = nil" if self.id_optional else "id: ID")] if self.has_id else []) + \
                 (["object: String"] if self.has_object else []) + \
                 [f"{ident(f.name)}: {f.swift_type}? = nil" for f in self.fields]
        out += f"{i}    public init(\n" + ",\n".join(f"{i}        {p}" for p in params) + f"\n{i}    ) {{\n"
        if self.has_id:
            out += f"{i}        self.id = id\n"
        if self.has_object:
            out += f"{i}        self.object = object\n"
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
    ap.add_argument("--out", default="Sources/Stripe/Models/Generated")
    ap.add_argument("--namespace", default="Stripe",
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
        for stale in list(out.glob("Generated.*.swift")) + list(out.glob("Stripe.*.swift")):
            stale.unlink()
    for name, content in files.items():
        (out / name).write_text(content)
    print(f"\nwrote {len(files)} files to {out}/")
    return 0


if __name__ == "__main__":
    sys.exit(main())
