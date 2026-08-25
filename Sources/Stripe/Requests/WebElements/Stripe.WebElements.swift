#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe {
    /// Namespace for Stripe Web Elements
    ///
    /// Web Elements are pre-built UI components for collecting payment information
    /// and other details in your web application. They handle validation, formatting,
    /// and security while providing a consistent user experience.
    ///
    /// See: https://docs.stripe.com/elements
    public enum WebElements {}
}
