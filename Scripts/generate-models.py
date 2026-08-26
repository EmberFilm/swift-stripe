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
  shared       $ref reached from more than one parent              Stripe.Shared.<Name>
  nested       $ref reached from one parent, or an inline object   nested struct named for the property
  enum         string with an enum of more than one value          nested enum with raw values
  union        anyOf of several $refs, not expandable              first member, marked for stage 3
  map          object with additionalProperties                    [String: T]
  scalar       string / integer / unix-time / number / boolean     String / Int / Date / Double / Bool
  embedded     a full generated resource inside another             @Boxed, to break reference cycles

Every property is optional except `id`. Coding keys are synthesized (the decoder converts
snake_case, the form encoder produces it); only a union spells its keys out. Formerly: every
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

# The resources generated, and where they sit under `Stripe`. Mirrors the hand-written
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
    "ephemeral_key": "EphemeralKey",
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
    "payment_method_domain": "PaymentMethodDomain",
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
    "balance": "Balance",
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
    "payment_link": "PaymentLink",
    "subscription_schedule": "Billing.Subscription.Schedule",
    # stage 4a: resources that had no model at all
    "reserve.hold": "Reserve.Hold",
    "reserve.plan": "Reserve.Plan",
    "reserve.release": "Reserve.Release",
    "reserve_transaction": "Reserve.Transaction",
    "billing.alert_triggered": "Billing.AlertTriggered",
    "financial_connections.authorization": "/FinancialConnections.Authorization",
    "issuing.token": "Issuing.Token",
    "payment_record": "PaymentRecord",
    "source_mandate_notification": "/SourceMandateNotification",
    "entitlements.active_entitlement_summary": "Entitlements.ActiveEntitlementSummary",
    "tax_deducted_at_source": "/TaxDeductedAtSource",
    "connect_collection_transfer": "Connect.CollectionTransfer",
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
    # the generated set refers to itself through Stripe
    "checkout.session": "Stripe.Checkout.Session",
    "subscription": "Stripe.Billing.Subscription",
    "subscription_item": "Stripe.Billing.Subscription.Item",
    "customer": "Stripe.Customers.Customer",
    "invoice": "Stripe.Billing.Invoice",
    "price": "Stripe.Products.Price",
    "product": "Stripe.Products.Product",
    "event": "Stripe.Events.Event",
    "payment_intent": "Stripe.PaymentIntents.PaymentIntent",
    "charge": "Stripe.Charges.Charge",
    "invoice_payment": "Stripe.Billing.Invoice.Payment",
    "treasury.credit_reversal": "Stripe.Treasury.CreditReversal",
    "treasury.debit_reversal": "Stripe.Treasury.DebitReversal",
    "treasury.financial_account": "Stripe.Treasury.FinancialAccount",
    "treasury.financial_account_features": "Stripe.Treasury.FinancialAccountFeatures",
    "treasury.inbound_transfer": "Stripe.Treasury.InboundTransfer",
    "treasury.outbound_payment": "Stripe.Treasury.OutboundPayment",
    "treasury.outbound_transfer": "Stripe.Treasury.OutboundTransfer",
    "treasury.received_credit": "Stripe.Treasury.ReceivedCredit",
    "treasury.received_debit": "Stripe.Treasury.ReceivedDebit",
    "treasury.transaction_entry": "Stripe.Treasury.TransactionEntry",
    "billing.alert": "Stripe.Billing.Alert",
    "billing.meter": "Stripe.Billing.Meter",
    "billing.meter_event": "Stripe.Billing.MeterEvent",
    "billing.meter_event_adjustment": "Stripe.Billing.MeterEventAdjustment",
    "billing.meter_event_summary": "Stripe.Billing.MeterEventSummary",
    "invoice_rendering_template": "Stripe.Billing.InvoiceRenderingTemplate",
    "credit_note_line_item": "Stripe.Billing.CreditNoteLineItem",
    "tax.association": "Stripe.Tax.Association",
    "tax.calculation_line_item": "Stripe.Tax.CalculationLineItem",
    "tax.registration": "Stripe.Tax.Registration",
    "tax.transaction_line_item": "Stripe.Tax.TransactionLineItem",
    "issuing.personalization_design": "Stripe.Issuing.PersonalizationDesign",
    "issuing.physical_bundle": "Stripe.Issuing.PhysicalBundle",
    "climate.supplier": "Stripe.Climate.Supplier",
    "entitlements.active_entitlement": "Stripe.Entitlements.ActiveEntitlement",
    "radar.payment_evaluation": "Stripe.Fraud.PaymentEvaluation",
    "terminal.onboarding_link": "Stripe.Terminal.OnboardingLink",
    "financial_connections.account_owner": "FinancialConnections.AccountOwner",
    "account_link": "Stripe.Connect.AccountLink",
    "apple_pay_domain": "Stripe.ApplePayDomain",
    "balance_settings": "Stripe.BalanceSettings",
    "exchange_rate": "Stripe.ExchangeRate",
    "payment_attempt_record": "Stripe.PaymentAttemptRecord",
    "product_feature": "Stripe.Products.ProductFeature",
    "source_transaction": "Stripe.SourceTransaction",
    "customer_cash_balance_transaction": "Stripe.Customers.CashBalanceTransaction",
    "entitlements.feature": "Stripe.Entitlements.Feature",
    "treasury.transaction": "Stripe.Treasury.Transaction",
    "application_fee": "Stripe.Connect.Application.Fee",
    "apps.secret": "Stripe.Connect.Secret",
    "balance_transaction": "Stripe.Balance.Transaction",
    "billing.credit_balance_transaction": "Stripe.Billing.Credit.Balance.Transaction",
    "cash_balance": "Stripe.Customers.CustomerCashBalance",
    "customer_balance_transaction": "Stripe.Billing.Customer.Balance.Transaction",
    "dispute": "Stripe.Disputes.Dispute",
    "invoiceitem": "Stripe.Billing.Invoice.Item",
    "item": "Stripe.Checkout.Session.LineItem",
    "person": "Stripe.Connect.Person",
    "review": "Stripe.Fraud.Reviews.Review",
    "tax_code": "Stripe.Tax.Code",
    "test_helpers.test_clock": "Stripe.Billing.TestClocks.TestClock",
    "token": "Stripe.Tokens.Token",
    "topup": "Stripe.Connect.TopUp",
    "bank_account": "BankAccount",
    "capability": "Stripe.Connect.Capability",
    "card": "Card",
    "country_spec": "Stripe.Connect.CountrySpec",
    "customer_session": "Stripe.Customers.Customer.Session",
    "ephemeral_key": "Stripe.EphemeralKey",
    "fee_refund": "Stripe.Connect.Application.Fee.Refund",
    "file_link": "Stripe.FileLinks.FileLink",
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
    "radar.early_fraud_warning": "Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning",
    "radar.value_list_item": "Stripe.Fraud.ValueListItems.ValueListItem",
    "reporting.report_run": "ReportRun",
    "reporting.report_type": "ReportType",
    "scheduled_query_run": "ScheduledQueryRun",
    "setup_attempt": "Stripe.Setup.Attempt",
    "source": "Source",
    "terminal.configuration": "TerminalConfiguration",
    "terminal.connection_token": "TerminalConnectionToken",
    "terminal.reader": "Stripe.Terminal.Readers.Reader",
    "webhook_endpoint": "Webhook",
    "climate.order": "Stripe.Climate.Order",
    "climate.product": "Stripe.Climate.Product",
    "tax.settings": "Stripe.Tax.Settings",
    "tax.transaction": "Stripe.Tax.Transaction",
    "financial_connections.session": "FinancialConnections.Session",
    "financial_connections.transaction": "FinancialConnections.Transaction",
    "account_session": "Stripe.Connect.Account.Session",
    "balance": "Stripe.Balance",
    "billing.credit_balance_summary": "Stripe.Billing.Credit.Balance.Summary",
    "billing_portal.session": "Stripe.Billing.Customer.Portal.Session",
    "confirmation_token": "ConfirmationToken",
    "credit_note": "Stripe.Billing.Credit.Note",
    "file": "Stripe.Files.File",
    "line_item": "Stripe.Billing.Invoice.LineItem",
    "login_link": "Stripe.Connect.Account.LoginLink",
    "mandate": "Stripe.Mandates.Mandate",
    "payment_method_configuration": "Stripe.PaymentMethodConfigurations.Configuration",
    "quote": "Stripe.Billing.Quote",
    "radar.value_list": "Stripe.Fraud.ValueLists.ValueList",
    "refund": "Stripe.Refunds.Refund",
    "tax.calculation": "Stripe.Tax.Calculation",
    "tax_id": "Stripe.Tax.ID",
    "tax_rate": "Stripe.Tax.Rate",
    "terminal.location": "Stripe.Terminal.Locations.Location",
    "transfer_reversal": "Stripe.Connect.Transfer.Reversal",
    "account": "Stripe.Connect.Account",
    "billing.credit_grant": "Stripe.Billing.Credit.Grant",
    "billing_portal.configuration": "Stripe.Billing.Customer.Portal.Configuration",
    "coupon": "Stripe.Products.Coupon",
    "forwarding.request": "Stripe.Forwarding.Request",
    "payment_method": "Stripe.PaymentMethods.PaymentMethod",
    "payout": "Stripe.Payouts.Payout",
    "plan": "Stripe.Billing.Plan",
    "promotion_code": "Promotion.Code",
    "setup_intent": "Stripe.Setup.Intent",
    "shipping_rate": "Stripe.Products.Shipping.Rate",
    "transfer": "Stripe.Connect.Transfer",
    "payment_link": "Stripe.PaymentLink",
    "subscription_schedule": "Stripe.Billing.Subscription.Schedule",
    # everything else is the hand-written Stripe type
    "billing_portal.configuration": "Stripe.Billing.Customer.Portal.Configuration",
    "tax_id": "Stripe.Tax.ID",
    "issuing.authorization": "Authorization",
    "application": "Stripe.Connect.Application",
    # Not the top-level `CashBalance`: inside Customer that name resolves to the empty request
    # namespace `Stripe.Customers.CashBalance`. This is the type the hand Customer used.
    "discount": "Stripe.Products.Discount",
    "deleted_discount": "Stripe.Products.Discount",
    "issuing.token": "Stripe.Issuing.Token",
    "payment_record": "Stripe.PaymentRecord",
    "payment_source": "Stripe.PaymentSource",
    "external_account": "Stripe.ExternalAccount",
    "balance_transaction_source": "Stripe.BalanceTransactionSource",
    "deleted_external_account": "Stripe.DeletedExternalAccount",
}

# Resources with no Swift type at all. A reference to one is kept as its id, never expanded.
# Schemas that are `anyOf` several resources, told apart by `object`: generated as enums.
UNION_RESOURCES: dict[str, str] = {
    "payment_source": "PaymentSource",
    "external_account": "ExternalAccount",
    "balance_transaction_source": "BalanceTransactionSource",
    "deleted_external_account": "DeletedExternalAccount",
}

ID_ONLY_RESOURCES: set[str] = {
      # no hand type, and a top-level placement the generator does not do yet
}

# Types the generator emits; a resource embedded by value in another is boxed to break cycles.
GENERATED_TYPES: set[str] = {RESOURCE_TYPES[n] for n in list(RESOURCES) + list(UNION_RESOURCES) if n in RESOURCE_TYPES}

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
    def __init__(self, spec: dict, only: set[str] | None = None):
        self.ns = "Stripe"
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
            and swift_type in GENERATED_TYPES
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
                refs = {self.ref_name(m) for m in members}
                for union, name in UNION_RESOURCES.items():
                    if refs <= self.union_alternatives(union):
                        return f"Stripe.{name}"
                self.unions.append(f"{owner.path}.{prop}: {sorted(refs)}")
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
        if ref in UNION_RESOURCES:
            return f"Stripe.{UNION_RESOURCES[ref]}"
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
            return f"Stripe.Shared.{name}"
        nested = self.build_struct(pascal(prop), self.schemas[ref], f"{owner.path}.{pascal(prop)}")
        owner.nested.append(nested)
        return pascal(prop)

    def emit_shared(self, ref: str, name: str) -> None:
        if ref in self.shared_done:
            return
        self.shared_done[ref] = None   # reserve first: shared types can reference each other
        self.shared_done[ref] = self.build_struct(name, self.schemas[ref], f"Stripe.Shared.{name}")

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
        self.detect_union(s, schema)
        return s

    def union_alternatives(self, union: str) -> set[str]:
        return {self.ref_name(a) for a in self.schemas[union].get("anyOf", []) if "$ref" in a}

    def detect_union(self, s: "Struct", schema: dict) -> None:
        """A required `type` string beside object-valued properties named after its values —
        `payment_method_details`, `payment_method`, `next_action` — is one payload chosen by
        `type`: those properties become the cases of a `Details` enum."""
        props = schema.get("properties", {})
        t = props.get("type")
        if not isinstance(t, dict) or t.get("type") != "string" or "type" not in schema.get("required", []):
            return
        def is_object(v: dict) -> bool:
            return "$ref" in v or v.get("type") == "object" or \
                any("$ref" in a or a.get("type") == "object" for a in v.get("anyOf", []))
        enum = t.get("enum")
        wires = [p for p, v in props.items() if p != "type" and is_object(v) and (enum is None or p in enum)]
        if len(wires) < 3:
            return
        by_wire = {f.wire: f for f in s.fields}
        cases = [by_wire[w] for w in wires if w in by_wire]
        s.fields = [f for f in s.fields if f.wire not in wires]
        keywords = [v for v in (enum or []) if v not in wires]
        taken = {e.name for e in s.enums} | {n.name for n in s.nested}
        s.union = Union("Details" if "Details" not in taken else "Kind", cases, keywords, enum is None)

    def render_union_resource(self, union: str, name: str) -> str:
        alts = []
        for alt in sorted(self.union_alternatives(union)):
            deleted = alt.startswith("deleted_")
            base = alt[len("deleted_"):] if deleted else alt
            if base in RESOURCE_TYPES:
                t = self.qualified(RESOURCE_TYPES[base])
            elif base in RESOURCES:
                t = RESOURCES[base].lstrip("/") if RESOURCES[base].startswith("/") else f"Stripe.{RESOURCES[base]}"
            else:
                self.unions.append(f"{union}: alternative {alt} has no Swift type; decodes as .unknown")
                continue
            wire = self.schemas[alt]["properties"]["object"]["enum"][0]
            alts.append((camel(base), wire, f"DeletedObject<{t}>" if deleted else t))
        d = doc(self.schemas[union].get("description"))
        out = HEADER.format(version=self.version, schema=union) + f"extension {self.ns} {{\n"
        if d:
            out += f"    /// {d}\n"
        out += f"    public indirect enum {name}: Codable, Hashable, Sendable {{\n"
        for case, _, t in alts:
            out += f"        case {ident(case)}({t})\n"
        out += "        case unknown(object: String)\n\n"
        for case, _, t in alts:
            out += f"        public var {ident(case)}: {t}? {{ if case .{ident(case)}(let value) = self {{ return value }}; return nil }}\n"
        out += "\n        private enum CodingKeys: String, CodingKey {\n            case object\n        }\n\n"
        out += "        public init(from decoder: any Decoder) throws {\n"
        out += "            let object = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .object)\n"
        out += "            switch object {\n"
        for case, wire, t in alts:
            out += f'            case "{wire}": self = .{ident(case)}(try {t}(from: decoder))\n'
        out += "            default: self = .unknown(object: object)\n            }\n        }\n\n"
        out += "        public func encode(to encoder: any Encoder) throws {\n            switch self {\n"
        for case, _, _ in alts:
            out += f"            case .{ident(case)}(let value): try value.encode(to: encoder)\n"
        out += "            case .unknown(let object):\n                var container = encoder.container(keyedBy: CodingKeys.self)\n"
        out += "                try container.encode(object, forKey: .object)\n            }\n        }\n    }\n}\n"
        return out

    def render_event_object(self) -> str:
        """`Event.Object`: one case per resource any event carries, told apart by `object`."""
        targets: dict[str, str] = {}   # resource -> object wire value
        for name, schema in self.schemas.items():
            if "x-stripeEvent" not in schema:
                continue
            node = schema["properties"].get("object", {})
            refs = [self.ref_name(node)] if "$ref" in node else [self.ref_name(a) for a in node.get("anyOf", []) if "$ref" in a]
            for ref in refs:
                wire = self.schemas[ref].get("properties", {}).get("object", {}).get("enum", [None])[0]
                if wire:
                    targets[ref] = wire
        cases = []
        for ref, wire in sorted(targets.items(), key=lambda kv: kv[1]):
            if ref in RESOURCE_TYPES:
                t = self.qualified(RESOURCE_TYPES[ref])
            elif ref in RESOURCES:
                t = RESOURCES[ref].lstrip("/") if RESOURCES[ref].startswith("/") else f"Stripe.{RESOURCES[ref]}"
            else:
                self.unions.append(f"event: {ref} has no Swift type; decodes as .unknown")
                continue
            cases.append((ident(camel(ref)), wire, t))
        out = HEADER.format(version=self.version, schema="event (data.object across every event type)")
        out += f"extension {self.ns}.Events.Event {{\n"
        out += "    /// The object an event carries, told apart by its `object` value.\n"
        out += "    ///\n    /// `indirect` keeps the payload off the stack: the largest resources are kilobytes wide, and\n"
        out += "    /// musl gives a thread 128 KiB. The decoder is split into small groups for the same reason.\n"
        out += "    public indirect enum Object: Codable, Hashable, Sendable {\n        case unknown(type: String)\n"
        for case, _, t in cases:
            out += f"        case {case}({t})\n"
        out += "\n        private enum CodingKeys: String, CodingKey {\n            case object\n        }\n\n"
        groups = [cases[i:i + 8] for i in range(0, len(cases), 8)]
        out += "        public init(from decoder: any Decoder) throws {\n"
        out += "            let object = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .object)\n"
        for i in range(len(groups)):
            out += f"            if let value = try Self.decodeGroup{i}(object, decoder) {{ self = value; return }}\n"
        out += "            self = .unknown(type: object)\n        }\n"
        for i, group in enumerate(groups):
            out += f"\n        @inline(never)\n        private static func decodeGroup{i}(_ object: String, _ decoder: any Decoder) throws -> Object? {{\n"
            out += "            switch object {\n"
            for case, wire, t in group:
                out += f'            case "{wire}": return .{case}(try {t}(from: decoder))\n'
            out += "            default: return nil\n            }\n        }\n"
        out += "\n        public func encode(to encoder: any Encoder) throws {\n            switch self {\n"
        for case, _, _ in cases:
            out += f"            case .{case}(let value): try value.encode(to: encoder)\n"
        out += "            case .unknown(let type):\n                var container = encoder.container(keyedBy: CodingKeys.self)\n"
        out += "                try container.encode(type, forKey: .object)\n            }\n        }\n    }\n}\n"
        return out

    def render_event_type(self) -> str:
        names = sorted(n for n, sc in self.schemas.items() if "x-stripeEvent" in sc)
        out = HEADER.format(version=self.version, schema="event (every event type)")
        out += f"extension {self.ns}.Events.Event {{\n"
        out += "    /// Every event type Stripe documents. An event of a newer type decodes with `type == nil`\n"
        out += "    /// and its `rawType` set.\n"
        out += "    public enum `Type`: String, Codable, Hashable, Sendable {\n"
        for n in names:
            out += f'        case {enum_case(n)} = "{n}"\n'
        out += "    }\n}\n"
        return out

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
        places = layout()
        for name, swift_path in RESOURCES.items():
            if self.only and name not in self.only:
                continue
            path = swift_path.lstrip("/")
            root = self.build_struct(path.split(".")[-1], self.schemas[name],
                                     path if swift_path.startswith("/") else f"{self.ns}.{path}", root=True)
            files[model_file(*places[name])] = self.render_resource(name, swift_path, root)
        for union, name in UNION_RESOURCES.items():
            if not self.only or union in self.only:
                files[model_file(*places[union])] = self.render_union_resource(union, name)
        if not self.only:
            files["Events/Event.Object.swift"] = self.render_event_object()
            files["Events/Event.Type.swift"] = self.render_event_type()
            files["APIVersion.swift"] = HEADER.format(version=self.version, schema="(the spec's API version)") + \
                f"extension {self.ns} {{\n    /// The Stripe API version the generated models describe; ``StripeConfiguration`` sends\n" \
                f"    /// it as `Stripe-Version` unless told otherwise.\n    public static let generatedAPIVersion = \"{self.version}\"\n}}\n"
        files["Shared.swift"] = self.render_shared()
        if True:
            files["Namespaces.swift"] = self.render_missing_namespaces()
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
                         if not is_generated(p))
        wanted = sorted({p.split(".")[0] for p in RESOURCES.values() if "." in p and not p.startswith("/")})
        def exists(e):   # `Stripe.X` in use, or declared directly inside the root enum's extension
            return re.search(rf"\bStripe\.{e}\b", hand) or re.search(rf"^    public enum {e}\b", hand, re.M)
        missing = [e for e in wanted if not exists(e)]
        out = HEADER.format(version=self.version, schema="(namespaces the hand sources do not declare)")
        out += "extension Stripe {\n" + "".join(f"    public enum {e} {{}}\n" for e in missing) + "}\n"
        return out



GENERATED_MARKER = "//  Generated by Scripts/"


def is_generated(path: pathlib.Path) -> bool:
    """Generated files sit beside hand-written ones; their header tells them apart."""
    with open(path) as f:
        return any(GENERATED_MARKER in line for line, _ in zip(f, range(8)))


def generated_files(root: pathlib.Path) -> list[pathlib.Path]:
    return [p for p in root.rglob("*.swift") if is_generated(p)]


def shortest_unique(dotted: dict[str, str], taken: set[str]) -> dict[str, str]:
    """key -> file stem: the leaf of a dotted type path, lengthened by parent components while
    it clashes with another key or a name already taken. SwiftPM requires unique basenames
    across a target, folders notwithstanding."""
    import collections
    parts = {k: v.split(".") for k, v in dotted.items()}
    depth = {k: 1 for k in dotted}
    while True:
        stems = {k: ".".join(parts[k][-depth[k]:]) for k in dotted}
        count = collections.Counter(stems.values())
        grew = False
        for k, s in stems.items():
            if (count[s] > 1 or s in taken) and depth[k] < len(parts[k]):
                depth[k] += 1
                grew = True
        if not grew:
            return stems


def layout(source_root: str = "Sources/Stripe") -> dict[str, tuple[str, str]]:
    """resource -> (folder, stem) of its generated model file. Requests (`stem+Requests.swift`)
    and retained hand types (`stem+Retained.swift`) share the stem, so a resource's files sit
    together. Hand-written files count as taken names, so a generated file lengthens rather
    than collide with one."""
    dotted = {n: p.lstrip("/") for n, p in RESOURCES.items()}
    dotted.update(UNION_RESOURCES)
    taken: set[str] = set()
    root = pathlib.Path(source_root)
    if root.exists():
        for p in root.rglob("*.swift"):
            if "+" not in p.name and not is_generated(p):
                taken.add(p.name[:-len(".swift")])
    stems = shortest_unique(dotted, taken)
    return {n: ("/".join(dotted[n].split(".")[:-1]), stems[n]) for n in dotted}


def model_file(folder: str, stem: str, suffix: str = "") -> str:
    return f"{folder}/{stem}{suffix}.swift" if folder else f"{stem}{suffix}.swift"


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


class Union:
    def __init__(self, name: str, cases: list, keywords: list[str], free: bool):
        self.name, self.cases, self.keywords, self.free = name, cases, keywords, free


class Struct:
    def __init__(self, name: str, path: str, description: str | None):
        self.name, self.path, self.description = name, path, description
        self.fields: list[Field] = []
        self.enums: list[Enum] = []
        self.nested: list[Struct] = []
        self.has_id = False
        self.id_optional = False
        self.has_object = False
        self.union: Union | None = None

    @staticmethod
    def wrapper_type(f: "Field") -> str:
        if f.boxed:
            return f"Boxed<{f.swift_type}?>"
        return f.wrapper.lstrip("@")

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
            if self.union and f.wire == "type":
                out += f"{i}    /// The payload `type` selects.\n{i}    public var details: {self.union.name}\n"
        # A spec object with no properties (`konbini: {}`) is a marker; it has nothing to key.
        if not self.fields and not self.has_id and not self.has_object:
            out += f"{i}    public init() {{}}\n{i}}}\n"
            return out
        # CodingKeys, from the same list as the properties
        # a union's `Details` decodes from this container, so the keys are visible to the file
        # Keys are synthesized: the decoder converts snake_case and the form encoder produces it.
        # A union decodes its payloads under keys that are not stored properties, so it spells
        # its keys out, visible to the file for the `Details` enum.
        if self.union:
            out += f"\n{i}    fileprivate enum CodingKeys: String, CodingKey {{\n"
            if self.has_id:
                out += f"{i}        case id\n"
            if self.has_object:
                out += f"{i}        case object\n"
            for f in self.fields:
                out += f"{i}        case {ident(f.name)}\n"
            for f in self.union.cases:
                out += f"{i}        case {ident(f.name)}\n"
            out += f"{i}    }}\n"
        out += "\n"
        # init
        params = ([("id: ID? = nil" if self.id_optional else "id: ID")] if self.has_id else []) + \
                 (["object: String"] if self.has_object else [])
        for f in self.fields:
            params.append(f"{ident(f.name)}: {f.swift_type}? = nil")
            if self.union and f.wire == "type":
                params.append(f"details: {self.union.name}")
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
            if self.union and f.wire == "type":
                out += f"{i}        self.details = details\n"
        out += f"{i}    }}\n"
        if self.union:
            out += self.render_union_codable(i + "    ")
        for e in self.enums:
            out += "\n" + e.render(i + "    ")
        for n in self.nested:
            out += "\n" + n.render(i + "    ")
        if self.union:
            out += "\n" + self.render_union_enum(i + "    ")
        out += f"{i}}}\n"
        return out

    def render_union_codable(self, i: str) -> str:
        u = self.union
        out = f"\n{i}public init(from decoder: any Decoder) throws {{\n"
        out += f"{i}    let container = try decoder.container(keyedBy: CodingKeys.self)\n"
        if self.has_id:
            out += f"{i}    self.id = try container.decode{'IfPresent' if self.id_optional else ''}(ID.self, forKey: .id)\n"
        if self.has_object:
            out += f"{i}    self.object = try container.decode(String.self, forKey: .object)\n"
        for f in self.fields:
            n = ident(f.name)
            if f.wrapper:
                out += f"{i}    self._{f.name} = try container.decode({self.wrapper_type(f)}.self, forKey: .{n})\n"
            else:
                out += f"{i}    self.{n} = try container.decodeIfPresent({f.swift_type}.self, forKey: .{n})\n"
        out += f"{i}    self.details = try {u.name}(type: try container.decodeIfPresent(String.self, forKey: .type) ?? \"\", from: container)\n"
        out += f"{i}}}\n\n"
        out += f"{i}public func encode(to encoder: any Encoder) throws {{\n"
        out += f"{i}    var container = encoder.container(keyedBy: CodingKeys.self)\n"
        if self.has_id:
            out += f"{i}    try container.encode{'IfPresent' if self.id_optional else ''}(id, forKey: .id)\n"
        if self.has_object:
            out += f"{i}    try container.encode(object, forKey: .object)\n"
        for f in self.fields:
            n = ident(f.name)
            if f.wrapper:
                out += f"{i}    try container.encode(_{f.name}, forKey: .{n})\n"
            else:
                out += f"{i}    try container.encodeIfPresent({n}, forKey: .{n})\n"
        out += f"{i}    try details.encode(into: &container)\n{i}}}\n"
        return out

    def render_union_enum(self, i: str) -> str:
        u = self.union
        out = f"{i}/// The payload `type` selects; `unknown` carries a type this package does not model.\n"
        out += f"{i}public indirect enum {u.name}: Hashable, Sendable {{\n"
        def payload(f):   # an expandable id keeps its wrapper, so an expanded object is not lost
            return self.wrapper_type(f) if f.id_wrapper else f.swift_type
        for f in u.cases:
            out += f"{i}    case {ident(f.name)}({payload(f)})\n"
        for k in u.keywords:
            out += f"{i}    case {enum_case(k)}\n"
        out += f"{i}    case unknown(type: String)\n\n"
        for f in u.cases:
            n = ident(f.name)
            out += f"{i}    public var {n}: {payload(f)}? {{ if case .{n}(let value) = self {{ return value }}; return nil }}\n"
        out += "\n"
        out += f"{i}    fileprivate init(type: String, from container: KeyedDecodingContainer<CodingKeys>) throws {{\n"
        out += f"{i}        switch type {{\n"
        for f in u.cases:
            n = ident(f.name)
            out += f'{i}        case "{f.wire}":\n'
            if f.id_wrapper:
                out += f"{i}            let value = try container.decode({payload(f)}.self, forKey: .{n})\n"
                out += f"{i}            if value.wrappedValue != nil || value.projectedValue != nil {{ self = .{n}(value) }} else {{ self = .unknown(type: type) }}\n"
            else:
                out += f"{i}            if let value = try container.decodeIfPresent({f.swift_type}.self, forKey: .{n}) {{ self = .{n}(value) }} else {{ self = .unknown(type: type) }}\n"
        for k in u.keywords:
            out += f'{i}        case "{k}": self = .{enum_case(k)}\n'
        out += f"{i}        default: self = .unknown(type: type)\n{i}        }}\n{i}    }}\n\n"
        out += f"{i}    fileprivate func encode(into container: inout KeyedEncodingContainer<CodingKeys>) throws {{\n"
        out += f"{i}        switch self {{\n"
        for f in u.cases:
            n = ident(f.name)
            out += f"{i}        case .{n}(let value): try container.encode(value, forKey: .{n})\n"
        out += f"{i}        default: break\n{i}        }}\n{i}    }}\n{i}}}\n"
        return out


# --------------------------------------------------------------------------------------------

def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("spec")
    ap.add_argument("--out", default="Sources/Stripe/Models")
    ap.add_argument("--check", action="store_true", help="exit 1 if the files on disk differ from what would be written")
    ap.add_argument("--only", nargs="*", help="emit only these schemas (Shared is always emitted)")
    ap.add_argument("--keep", action="store_true", help="do not delete other generated files under --out")
    args = ap.parse_args()

    gen = Generator(json.load(open(args.spec)), only=set(args.only or []) or None)
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
    out = pathlib.Path(args.out)
    if args.check:
        stale = [n for n, body in files.items() if not (out / n).exists() or (out / n).read_text() != body]
        extra = [p for p in generated_files(out) if str(p.relative_to(out)) not in files]
        for n in stale:
            print(f"out of date: {out / n}")
        for p in extra:
            print(f"unexpected: {p}")
        return 1 if stale or extra else 0

    if not args.keep:
        for p in generated_files(out):
            if str(p.relative_to(out)) not in files:
                p.unlink()
    for name, content in files.items():
        (out / name).parent.mkdir(parents=True, exist_ok=True)
        (out / name).write_text(content)
    for d in sorted((d for d in out.rglob("*") if d.is_dir()), reverse=True):
        if not any(d.iterdir()):
            d.rmdir()
    print(f"\nwrote {len(files)} files under {out}/")
    return 0


if __name__ == "__main__":
    sys.exit(main())
