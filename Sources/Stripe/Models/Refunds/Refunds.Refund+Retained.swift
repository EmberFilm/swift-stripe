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

//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/refunds/object.md

/// The [Refund Object](https://stripe.com/docs/api/refunds/object) .

// The Refund struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Refunds.Refund` that the generator spells differently.

extension Stripe.Refunds.Refund {

    public enum Status: String, Codable, Sendable {
        case pending
        case succeeded
        case failed
        case canceled
    }

}
