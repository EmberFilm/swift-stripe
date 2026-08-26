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

// The Transfer struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.Transfer` that the generator spells differently.

// https://docs.stripe.com/api/transfers/object.md

extension Stripe.Connect.Transfer {
    public enum SourceType: String, Codable, Sendable {
        case card
        case fpx
        case bankAccount = "bank_account"
    }
}
