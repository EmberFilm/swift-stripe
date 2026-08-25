//
//  Namespaces.swift
//  swift-stripe
//
//  The upstream package declared these namespace enums inside per-target
//  `API.swift` files whose only other content was routing machinery. That
//  machinery is gone; the namespaces still anchor the request/response DTOs
//  that live beside it, so they are declared here.
//

extension Stripe.Fraud.Reviews {
    /// Namespace for Radar review request and response payloads.
    public enum API: Sendable {}
}

extension Stripe.Fraud.ValueLists {
    /// Namespace for Radar value-list request and response payloads.
    public enum API: Sendable {}
}

extension Stripe.Fraud.ValueListItems {
    /// Namespace for Radar value-list-item request and response payloads.
    public enum API: Sendable {}
}

extension Stripe.Fraud.EarlyFraudWarnings {
    /// Namespace for Radar early-fraud-warning request and response payloads.
    public enum API: Sendable {}
}
