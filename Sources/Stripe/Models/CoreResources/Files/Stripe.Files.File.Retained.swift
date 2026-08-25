//
//  File.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/15/18.
//

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

