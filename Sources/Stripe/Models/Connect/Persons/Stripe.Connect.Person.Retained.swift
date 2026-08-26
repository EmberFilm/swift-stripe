//
//  Person.swift
//  Stripe
//
//  Created by Andrew Edwards on 2/24/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/persons/object.md

// The Person struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.Person` that the generator spells differently.

extension Stripe.Connect.Person {
    public struct DOB: Codable, Hashable, Sendable {
        /// The day of birth, between 1 and 31.
        public var day: Int?
        /// The month of birth, between 1 and 12.
        public var month: Int?
        /// The four-digit year of birth.
        public var year: Int?

        public init(
            day: Int? = nil,
            month: Int? = nil,
            year: Int? = nil
        ) {
            self.day = day
            self.month = month
            self.year = year
        }
    }
}

