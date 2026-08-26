//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-stripe open source project
//
// Copyright (c) 2026 the swift-stripe project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
// See NOTICE for attribution of derived work
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe {
    /// Namespace for Stripe Web Elements.
    ///
    /// Web Elements are pre-built UI components for collecting payment information
    /// and other details in your web application. They handle validation, formatting,
    /// and security while providing a consistent user experience.
    ///
    /// See: https://docs.stripe.com/elements
    public enum WebElements {}
}
