#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.WebElements {
    /// Address Element for collecting address information
    /// See: https://docs.stripe.com/elements/address-element
    public struct Address: Codable, Hashable, Sendable {
        public let options: Options?

        public init(options: Options? = nil) {
            self.options = options
        }

        public struct Options: Codable, Hashable, Sendable {
            public let mode: Mode?
            public let defaultValues: DefaultValues?
            public let validation: Validation?
            public let fields: Fields?
            public let display: Display?
            public let autocomplete: Autocomplete?

            public init(
                mode: Mode? = nil,
                defaultValues: DefaultValues? = nil,
                validation: Validation? = nil,
                fields: Fields? = nil,
                display: Display? = nil,
                autocomplete: Autocomplete? = nil
            ) {
                self.mode = mode
                self.defaultValues = defaultValues
                self.validation = validation
                self.fields = fields
                self.display = display
                self.autocomplete = autocomplete
            }
        }
    }
}

extension Stripe.WebElements.Address.Options {
    public enum Mode: String, Codable, Sendable {
        case billing
        case shipping
    }

    public struct DefaultValues: Codable, Hashable, Sendable {
        public let name: String?
        public let firstName: String?
        public let lastName: String?
        public let address: AddressData?
        public let phone: String?

        public init(
            name: String? = nil,
            firstName: String? = nil,
            lastName: String? = nil,
            address: AddressData? = nil,
            phone: String? = nil
        ) {
            self.name = name
            self.firstName = firstName
            self.lastName = lastName
            self.address = address
            self.phone = phone
        }
    }

    public struct AddressData: Codable, Hashable, Sendable {
        public let line1: String?
        public let line2: String?
        public let city: String?
        public let state: String?
        public let postalCode: String?
        public let country: String?

        public init(
            line1: String? = nil,
            line2: String? = nil,
            city: String? = nil,
            state: String? = nil,
            postalCode: String? = nil,
            country: String? = nil
        ) {
            self.line1 = line1
            self.line2 = line2
            self.city = city
            self.state = state
            self.postalCode = postalCode
            self.country = country
        }
    }

    public struct Validation: Codable, Hashable, Sendable {
        public let phone: PhoneValidation?

        public init(phone: PhoneValidation? = nil) {
            self.phone = phone
        }

        public struct PhoneValidation: Codable, Hashable, Sendable {
            public let required: String?

            public init(required: String? = nil) {
                self.required = required
            }
        }
    }

    public struct Fields: Codable, Hashable, Sendable {
        public let phone: String?

        public init(phone: String? = nil) {
            self.phone = phone
        }
    }

    public struct Display: Codable, Hashable, Sendable {
        public let name: String?

        public init(name: String? = nil) {
            self.name = name
        }
    }

    public struct Autocomplete: Codable, Hashable, Sendable {
        public let mode: String?

        public init(mode: String? = nil) {
            self.mode = mode
        }
    }
}
