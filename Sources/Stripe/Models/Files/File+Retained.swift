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

// The File struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Files.File` that the generator spells differently.

// https://docs.stripe.com/api/files/object.md

extension Stripe {
    public typealias File = Stripe.Files.File
}

extension Stripe.Files.File {

    public enum `Type`: String, Codable, Sendable {
        case csv
        case docx
        case gif
        case jpg
        case pdf
        case png
        case xls
        case xlsx
    }
}
