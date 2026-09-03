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

// https://docs.stripe.com/api/invoiceitems/object.md

/// The [InvoiceItem Object](https://stripe.com/docs/api/invoiceitems/object).

// The Item struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.Invoice.Item` that the generator spells differently.
