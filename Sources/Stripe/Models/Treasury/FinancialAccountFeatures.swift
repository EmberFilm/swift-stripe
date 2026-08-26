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

extension Stripe.Treasury {
    /// Encodes whether a FinancialAccount has access to a particular Feature, with a `status` enum and associated.
    public struct FinancialAccountFeatures: Codable, Hashable, Sendable {
        /// String representing the object's type.
        public let object: String
        public var cardIssuing: CardIssuing?
        public var depositInsurance: DepositInsurance?
        public var financialAddresses: FinancialAddresses?
        public var inboundTransfers: InboundTransfers?
        public var intraStripeFlows: IntraStripeFlows?
        public var outboundPayments: OutboundPayments?
        public var outboundTransfers: OutboundTransfers?

        public init(
            object: String,
            cardIssuing: CardIssuing? = nil,
            depositInsurance: DepositInsurance? = nil,
            financialAddresses: FinancialAddresses? = nil,
            inboundTransfers: InboundTransfers? = nil,
            intraStripeFlows: IntraStripeFlows? = nil,
            outboundPayments: OutboundPayments? = nil,
            outboundTransfers: OutboundTransfers? = nil
        ) {
            self.object = object
            self.cardIssuing = cardIssuing
            self.depositInsurance = depositInsurance
            self.financialAddresses = financialAddresses
            self.inboundTransfers = inboundTransfers
            self.intraStripeFlows = intraStripeFlows
            self.outboundPayments = outboundPayments
            self.outboundTransfers = outboundTransfers
        }

        /// Toggle settings for enabling/disabling a feature.
        public struct CardIssuing: Codable, Hashable, Sendable {
            /// Whether the FinancialAccount should have the Feature.
            public var requested: Bool?
            /// Whether the Feature is operational.
            public var status: Status?
            /// Additional details; includes at least one entry when the status is not `active`.
            public var statusDetails: [StatusDetails]?

            public init(
                requested: Bool? = nil,
                status: Status? = nil,
                statusDetails: [StatusDetails]? = nil
            ) {
                self.requested = requested
                self.status = status
                self.statusDetails = statusDetails
            }

            /// Whether the Feature is operational.
            public enum Status: String, Codable, Hashable, Sendable {
                case active
                case pending
                case restricted
            }

            /// Additional details on the FinancialAccount Features information.
            public struct StatusDetails: Codable, Hashable, Sendable {
                /// Represents the reason why the status is `pending` or `restricted`.
                public var code: Code?
                /// Represents what the user should do, if anything, to activate the Feature.
                public var resolution: Resolution?
                /// The `platform_restrictions` that are restricting this Feature.
                public var restriction: Restriction?

                public init(
                    code: Code? = nil,
                    resolution: Resolution? = nil,
                    restriction: Restriction? = nil
                ) {
                    self.code = code
                    self.resolution = resolution
                    self.restriction = restriction
                }

                /// Represents the reason why the status is `pending` or `restricted`.
                public enum Code: String, Codable, Hashable, Sendable {
                    case activating
                    case capabilityNotRequested = "capability_not_requested"
                    case financialAccountClosed = "financial_account_closed"
                    case rejectedOther = "rejected_other"
                    case rejectedUnsupportedBusiness = "rejected_unsupported_business"
                    case requirementsPastDue = "requirements_past_due"
                    case requirementsPendingVerification = "requirements_pending_verification"
                    case restrictedByPlatform = "restricted_by_platform"
                    case restrictedOther = "restricted_other"
                }

                /// Represents what the user should do, if anything, to activate the Feature.
                public enum Resolution: String, Codable, Hashable, Sendable {
                    case contactStripe = "contact_stripe"
                    case provideInformation = "provide_information"
                    case removeRestriction = "remove_restriction"
                }

                /// The `platform_restrictions` that are restricting this Feature.
                public enum Restriction: String, Codable, Hashable, Sendable {
                    case inboundFlows = "inbound_flows"
                    case outboundFlows = "outbound_flows"
                }
            }
        }

        /// Toggle settings for enabling/disabling a feature.
        public struct DepositInsurance: Codable, Hashable, Sendable {
            /// Whether the FinancialAccount should have the Feature.
            public var requested: Bool?
            /// Whether the Feature is operational.
            public var status: Status?
            /// Additional details; includes at least one entry when the status is not `active`.
            public var statusDetails: [StatusDetails]?

            public init(
                requested: Bool? = nil,
                status: Status? = nil,
                statusDetails: [StatusDetails]? = nil
            ) {
                self.requested = requested
                self.status = status
                self.statusDetails = statusDetails
            }

            /// Whether the Feature is operational.
            public enum Status: String, Codable, Hashable, Sendable {
                case active
                case pending
                case restricted
            }

            /// Additional details on the FinancialAccount Features information.
            public struct StatusDetails: Codable, Hashable, Sendable {
                /// Represents the reason why the status is `pending` or `restricted`.
                public var code: Code?
                /// Represents what the user should do, if anything, to activate the Feature.
                public var resolution: Resolution?
                /// The `platform_restrictions` that are restricting this Feature.
                public var restriction: Restriction?

                public init(
                    code: Code? = nil,
                    resolution: Resolution? = nil,
                    restriction: Restriction? = nil
                ) {
                    self.code = code
                    self.resolution = resolution
                    self.restriction = restriction
                }

                /// Represents the reason why the status is `pending` or `restricted`.
                public enum Code: String, Codable, Hashable, Sendable {
                    case activating
                    case capabilityNotRequested = "capability_not_requested"
                    case financialAccountClosed = "financial_account_closed"
                    case rejectedOther = "rejected_other"
                    case rejectedUnsupportedBusiness = "rejected_unsupported_business"
                    case requirementsPastDue = "requirements_past_due"
                    case requirementsPendingVerification = "requirements_pending_verification"
                    case restrictedByPlatform = "restricted_by_platform"
                    case restrictedOther = "restricted_other"
                }

                /// Represents what the user should do, if anything, to activate the Feature.
                public enum Resolution: String, Codable, Hashable, Sendable {
                    case contactStripe = "contact_stripe"
                    case provideInformation = "provide_information"
                    case removeRestriction = "remove_restriction"
                }

                /// The `platform_restrictions` that are restricting this Feature.
                public enum Restriction: String, Codable, Hashable, Sendable {
                    case inboundFlows = "inbound_flows"
                    case outboundFlows = "outbound_flows"
                }
            }
        }

        /// Settings related to Financial Addresses features on a Financial Account.
        public struct FinancialAddresses: Codable, Hashable, Sendable {
            public var aba: Aba?

            public init(
                aba: Aba? = nil
            ) {
                self.aba = aba
            }

            /// Toggle settings for enabling/disabling the ABA address feature.
            public struct Aba: Codable, Hashable, Sendable {
                /// Whether the FinancialAccount should have the Feature.
                public var requested: Bool?
                /// Whether the Feature is operational.
                public var status: Status?
                /// Additional details; includes at least one entry when the status is not `active`.
                public var statusDetails: [StatusDetails]?

                public init(
                    requested: Bool? = nil,
                    status: Status? = nil,
                    statusDetails: [StatusDetails]? = nil
                ) {
                    self.requested = requested
                    self.status = status
                    self.statusDetails = statusDetails
                }

                /// Whether the Feature is operational.
                public enum Status: String, Codable, Hashable, Sendable {
                    case active
                    case pending
                    case restricted
                }

                /// Additional details on the FinancialAccount Features information.
                public struct StatusDetails: Codable, Hashable, Sendable {
                    /// Represents the reason why the status is `pending` or `restricted`.
                    public var code: Code?
                    /// Represents what the user should do, if anything, to activate the Feature.
                    public var resolution: Resolution?
                    /// The `platform_restrictions` that are restricting this Feature.
                    public var restriction: Restriction?

                    public init(
                        code: Code? = nil,
                        resolution: Resolution? = nil,
                        restriction: Restriction? = nil
                    ) {
                        self.code = code
                        self.resolution = resolution
                        self.restriction = restriction
                    }

                    /// Represents the reason why the status is `pending` or `restricted`.
                    public enum Code: String, Codable, Hashable, Sendable {
                        case activating
                        case capabilityNotRequested = "capability_not_requested"
                        case financialAccountClosed = "financial_account_closed"
                        case rejectedOther = "rejected_other"
                        case rejectedUnsupportedBusiness = "rejected_unsupported_business"
                        case requirementsPastDue = "requirements_past_due"
                        case requirementsPendingVerification = "requirements_pending_verification"
                        case restrictedByPlatform = "restricted_by_platform"
                        case restrictedOther = "restricted_other"
                    }

                    /// Represents what the user should do, if anything, to activate the Feature.
                    public enum Resolution: String, Codable, Hashable, Sendable {
                        case contactStripe = "contact_stripe"
                        case provideInformation = "provide_information"
                        case removeRestriction = "remove_restriction"
                    }

                    /// The `platform_restrictions` that are restricting this Feature.
                    public enum Restriction: String, Codable, Hashable, Sendable {
                        case inboundFlows = "inbound_flows"
                        case outboundFlows = "outbound_flows"
                    }
                }
            }
        }

        /// InboundTransfers contains inbound transfers features for a FinancialAccount.
        public struct InboundTransfers: Codable, Hashable, Sendable {
            public var ach: Ach?

            public init(
                ach: Ach? = nil
            ) {
                self.ach = ach
            }

            /// Toggle settings for enabling/disabling an inbound ACH specific feature.
            public struct Ach: Codable, Hashable, Sendable {
                /// Whether the FinancialAccount should have the Feature.
                public var requested: Bool?
                /// Whether the Feature is operational.
                public var status: Status?
                /// Additional details; includes at least one entry when the status is not `active`.
                public var statusDetails: [StatusDetails]?

                public init(
                    requested: Bool? = nil,
                    status: Status? = nil,
                    statusDetails: [StatusDetails]? = nil
                ) {
                    self.requested = requested
                    self.status = status
                    self.statusDetails = statusDetails
                }

                /// Whether the Feature is operational.
                public enum Status: String, Codable, Hashable, Sendable {
                    case active
                    case pending
                    case restricted
                }

                /// Additional details on the FinancialAccount Features information.
                public struct StatusDetails: Codable, Hashable, Sendable {
                    /// Represents the reason why the status is `pending` or `restricted`.
                    public var code: Code?
                    /// Represents what the user should do, if anything, to activate the Feature.
                    public var resolution: Resolution?
                    /// The `platform_restrictions` that are restricting this Feature.
                    public var restriction: Restriction?

                    public init(
                        code: Code? = nil,
                        resolution: Resolution? = nil,
                        restriction: Restriction? = nil
                    ) {
                        self.code = code
                        self.resolution = resolution
                        self.restriction = restriction
                    }

                    /// Represents the reason why the status is `pending` or `restricted`.
                    public enum Code: String, Codable, Hashable, Sendable {
                        case activating
                        case capabilityNotRequested = "capability_not_requested"
                        case financialAccountClosed = "financial_account_closed"
                        case rejectedOther = "rejected_other"
                        case rejectedUnsupportedBusiness = "rejected_unsupported_business"
                        case requirementsPastDue = "requirements_past_due"
                        case requirementsPendingVerification = "requirements_pending_verification"
                        case restrictedByPlatform = "restricted_by_platform"
                        case restrictedOther = "restricted_other"
                    }

                    /// Represents what the user should do, if anything, to activate the Feature.
                    public enum Resolution: String, Codable, Hashable, Sendable {
                        case contactStripe = "contact_stripe"
                        case provideInformation = "provide_information"
                        case removeRestriction = "remove_restriction"
                    }

                    /// The `platform_restrictions` that are restricting this Feature.
                    public enum Restriction: String, Codable, Hashable, Sendable {
                        case inboundFlows = "inbound_flows"
                        case outboundFlows = "outbound_flows"
                    }
                }
            }
        }

        /// Toggle settings for enabling/disabling a feature.
        public struct IntraStripeFlows: Codable, Hashable, Sendable {
            /// Whether the FinancialAccount should have the Feature.
            public var requested: Bool?
            /// Whether the Feature is operational.
            public var status: Status?
            /// Additional details; includes at least one entry when the status is not `active`.
            public var statusDetails: [StatusDetails]?

            public init(
                requested: Bool? = nil,
                status: Status? = nil,
                statusDetails: [StatusDetails]? = nil
            ) {
                self.requested = requested
                self.status = status
                self.statusDetails = statusDetails
            }

            /// Whether the Feature is operational.
            public enum Status: String, Codable, Hashable, Sendable {
                case active
                case pending
                case restricted
            }

            /// Additional details on the FinancialAccount Features information.
            public struct StatusDetails: Codable, Hashable, Sendable {
                /// Represents the reason why the status is `pending` or `restricted`.
                public var code: Code?
                /// Represents what the user should do, if anything, to activate the Feature.
                public var resolution: Resolution?
                /// The `platform_restrictions` that are restricting this Feature.
                public var restriction: Restriction?

                public init(
                    code: Code? = nil,
                    resolution: Resolution? = nil,
                    restriction: Restriction? = nil
                ) {
                    self.code = code
                    self.resolution = resolution
                    self.restriction = restriction
                }

                /// Represents the reason why the status is `pending` or `restricted`.
                public enum Code: String, Codable, Hashable, Sendable {
                    case activating
                    case capabilityNotRequested = "capability_not_requested"
                    case financialAccountClosed = "financial_account_closed"
                    case rejectedOther = "rejected_other"
                    case rejectedUnsupportedBusiness = "rejected_unsupported_business"
                    case requirementsPastDue = "requirements_past_due"
                    case requirementsPendingVerification = "requirements_pending_verification"
                    case restrictedByPlatform = "restricted_by_platform"
                    case restrictedOther = "restricted_other"
                }

                /// Represents what the user should do, if anything, to activate the Feature.
                public enum Resolution: String, Codable, Hashable, Sendable {
                    case contactStripe = "contact_stripe"
                    case provideInformation = "provide_information"
                    case removeRestriction = "remove_restriction"
                }

                /// The `platform_restrictions` that are restricting this Feature.
                public enum Restriction: String, Codable, Hashable, Sendable {
                    case inboundFlows = "inbound_flows"
                    case outboundFlows = "outbound_flows"
                }
            }
        }

        /// Settings related to Outbound Payments features on a Financial Account.
        public struct OutboundPayments: Codable, Hashable, Sendable {
            public var ach: Ach?
            public var usDomesticWire: UsDomesticWire?

            public init(
                ach: Ach? = nil,
                usDomesticWire: UsDomesticWire? = nil
            ) {
                self.ach = ach
                self.usDomesticWire = usDomesticWire
            }

            /// Toggle settings for enabling/disabling an outbound ACH specific feature.
            public struct Ach: Codable, Hashable, Sendable {
                /// Whether the FinancialAccount should have the Feature.
                public var requested: Bool?
                /// Whether the Feature is operational.
                public var status: Status?
                /// Additional details; includes at least one entry when the status is not `active`.
                public var statusDetails: [StatusDetails]?

                public init(
                    requested: Bool? = nil,
                    status: Status? = nil,
                    statusDetails: [StatusDetails]? = nil
                ) {
                    self.requested = requested
                    self.status = status
                    self.statusDetails = statusDetails
                }

                /// Whether the Feature is operational.
                public enum Status: String, Codable, Hashable, Sendable {
                    case active
                    case pending
                    case restricted
                }

                /// Additional details on the FinancialAccount Features information.
                public struct StatusDetails: Codable, Hashable, Sendable {
                    /// Represents the reason why the status is `pending` or `restricted`.
                    public var code: Code?
                    /// Represents what the user should do, if anything, to activate the Feature.
                    public var resolution: Resolution?
                    /// The `platform_restrictions` that are restricting this Feature.
                    public var restriction: Restriction?

                    public init(
                        code: Code? = nil,
                        resolution: Resolution? = nil,
                        restriction: Restriction? = nil
                    ) {
                        self.code = code
                        self.resolution = resolution
                        self.restriction = restriction
                    }

                    /// Represents the reason why the status is `pending` or `restricted`.
                    public enum Code: String, Codable, Hashable, Sendable {
                        case activating
                        case capabilityNotRequested = "capability_not_requested"
                        case financialAccountClosed = "financial_account_closed"
                        case rejectedOther = "rejected_other"
                        case rejectedUnsupportedBusiness = "rejected_unsupported_business"
                        case requirementsPastDue = "requirements_past_due"
                        case requirementsPendingVerification = "requirements_pending_verification"
                        case restrictedByPlatform = "restricted_by_platform"
                        case restrictedOther = "restricted_other"
                    }

                    /// Represents what the user should do, if anything, to activate the Feature.
                    public enum Resolution: String, Codable, Hashable, Sendable {
                        case contactStripe = "contact_stripe"
                        case provideInformation = "provide_information"
                        case removeRestriction = "remove_restriction"
                    }

                    /// The `platform_restrictions` that are restricting this Feature.
                    public enum Restriction: String, Codable, Hashable, Sendable {
                        case inboundFlows = "inbound_flows"
                        case outboundFlows = "outbound_flows"
                    }
                }
            }

            /// Toggle settings for enabling/disabling a feature.
            public struct UsDomesticWire: Codable, Hashable, Sendable {
                /// Whether the FinancialAccount should have the Feature.
                public var requested: Bool?
                /// Whether the Feature is operational.
                public var status: Status?
                /// Additional details; includes at least one entry when the status is not `active`.
                public var statusDetails: [StatusDetails]?

                public init(
                    requested: Bool? = nil,
                    status: Status? = nil,
                    statusDetails: [StatusDetails]? = nil
                ) {
                    self.requested = requested
                    self.status = status
                    self.statusDetails = statusDetails
                }

                /// Whether the Feature is operational.
                public enum Status: String, Codable, Hashable, Sendable {
                    case active
                    case pending
                    case restricted
                }

                /// Additional details on the FinancialAccount Features information.
                public struct StatusDetails: Codable, Hashable, Sendable {
                    /// Represents the reason why the status is `pending` or `restricted`.
                    public var code: Code?
                    /// Represents what the user should do, if anything, to activate the Feature.
                    public var resolution: Resolution?
                    /// The `platform_restrictions` that are restricting this Feature.
                    public var restriction: Restriction?

                    public init(
                        code: Code? = nil,
                        resolution: Resolution? = nil,
                        restriction: Restriction? = nil
                    ) {
                        self.code = code
                        self.resolution = resolution
                        self.restriction = restriction
                    }

                    /// Represents the reason why the status is `pending` or `restricted`.
                    public enum Code: String, Codable, Hashable, Sendable {
                        case activating
                        case capabilityNotRequested = "capability_not_requested"
                        case financialAccountClosed = "financial_account_closed"
                        case rejectedOther = "rejected_other"
                        case rejectedUnsupportedBusiness = "rejected_unsupported_business"
                        case requirementsPastDue = "requirements_past_due"
                        case requirementsPendingVerification = "requirements_pending_verification"
                        case restrictedByPlatform = "restricted_by_platform"
                        case restrictedOther = "restricted_other"
                    }

                    /// Represents what the user should do, if anything, to activate the Feature.
                    public enum Resolution: String, Codable, Hashable, Sendable {
                        case contactStripe = "contact_stripe"
                        case provideInformation = "provide_information"
                        case removeRestriction = "remove_restriction"
                    }

                    /// The `platform_restrictions` that are restricting this Feature.
                    public enum Restriction: String, Codable, Hashable, Sendable {
                        case inboundFlows = "inbound_flows"
                        case outboundFlows = "outbound_flows"
                    }
                }
            }
        }

        /// OutboundTransfers contains outbound transfers features for a FinancialAccount.
        public struct OutboundTransfers: Codable, Hashable, Sendable {
            public var ach: Ach?
            public var usDomesticWire: UsDomesticWire?

            public init(
                ach: Ach? = nil,
                usDomesticWire: UsDomesticWire? = nil
            ) {
                self.ach = ach
                self.usDomesticWire = usDomesticWire
            }

            /// Toggle settings for enabling/disabling an outbound ACH specific feature.
            public struct Ach: Codable, Hashable, Sendable {
                /// Whether the FinancialAccount should have the Feature.
                public var requested: Bool?
                /// Whether the Feature is operational.
                public var status: Status?
                /// Additional details; includes at least one entry when the status is not `active`.
                public var statusDetails: [StatusDetails]?

                public init(
                    requested: Bool? = nil,
                    status: Status? = nil,
                    statusDetails: [StatusDetails]? = nil
                ) {
                    self.requested = requested
                    self.status = status
                    self.statusDetails = statusDetails
                }

                /// Whether the Feature is operational.
                public enum Status: String, Codable, Hashable, Sendable {
                    case active
                    case pending
                    case restricted
                }

                /// Additional details on the FinancialAccount Features information.
                public struct StatusDetails: Codable, Hashable, Sendable {
                    /// Represents the reason why the status is `pending` or `restricted`.
                    public var code: Code?
                    /// Represents what the user should do, if anything, to activate the Feature.
                    public var resolution: Resolution?
                    /// The `platform_restrictions` that are restricting this Feature.
                    public var restriction: Restriction?

                    public init(
                        code: Code? = nil,
                        resolution: Resolution? = nil,
                        restriction: Restriction? = nil
                    ) {
                        self.code = code
                        self.resolution = resolution
                        self.restriction = restriction
                    }

                    /// Represents the reason why the status is `pending` or `restricted`.
                    public enum Code: String, Codable, Hashable, Sendable {
                        case activating
                        case capabilityNotRequested = "capability_not_requested"
                        case financialAccountClosed = "financial_account_closed"
                        case rejectedOther = "rejected_other"
                        case rejectedUnsupportedBusiness = "rejected_unsupported_business"
                        case requirementsPastDue = "requirements_past_due"
                        case requirementsPendingVerification = "requirements_pending_verification"
                        case restrictedByPlatform = "restricted_by_platform"
                        case restrictedOther = "restricted_other"
                    }

                    /// Represents what the user should do, if anything, to activate the Feature.
                    public enum Resolution: String, Codable, Hashable, Sendable {
                        case contactStripe = "contact_stripe"
                        case provideInformation = "provide_information"
                        case removeRestriction = "remove_restriction"
                    }

                    /// The `platform_restrictions` that are restricting this Feature.
                    public enum Restriction: String, Codable, Hashable, Sendable {
                        case inboundFlows = "inbound_flows"
                        case outboundFlows = "outbound_flows"
                    }
                }
            }

            /// Toggle settings for enabling/disabling a feature.
            public struct UsDomesticWire: Codable, Hashable, Sendable {
                /// Whether the FinancialAccount should have the Feature.
                public var requested: Bool?
                /// Whether the Feature is operational.
                public var status: Status?
                /// Additional details; includes at least one entry when the status is not `active`.
                public var statusDetails: [StatusDetails]?

                public init(
                    requested: Bool? = nil,
                    status: Status? = nil,
                    statusDetails: [StatusDetails]? = nil
                ) {
                    self.requested = requested
                    self.status = status
                    self.statusDetails = statusDetails
                }

                /// Whether the Feature is operational.
                public enum Status: String, Codable, Hashable, Sendable {
                    case active
                    case pending
                    case restricted
                }

                /// Additional details on the FinancialAccount Features information.
                public struct StatusDetails: Codable, Hashable, Sendable {
                    /// Represents the reason why the status is `pending` or `restricted`.
                    public var code: Code?
                    /// Represents what the user should do, if anything, to activate the Feature.
                    public var resolution: Resolution?
                    /// The `platform_restrictions` that are restricting this Feature.
                    public var restriction: Restriction?

                    public init(
                        code: Code? = nil,
                        resolution: Resolution? = nil,
                        restriction: Restriction? = nil
                    ) {
                        self.code = code
                        self.resolution = resolution
                        self.restriction = restriction
                    }

                    /// Represents the reason why the status is `pending` or `restricted`.
                    public enum Code: String, Codable, Hashable, Sendable {
                        case activating
                        case capabilityNotRequested = "capability_not_requested"
                        case financialAccountClosed = "financial_account_closed"
                        case rejectedOther = "rejected_other"
                        case rejectedUnsupportedBusiness = "rejected_unsupported_business"
                        case requirementsPastDue = "requirements_past_due"
                        case requirementsPendingVerification = "requirements_pending_verification"
                        case restrictedByPlatform = "restricted_by_platform"
                        case restrictedOther = "restricted_other"
                    }

                    /// Represents what the user should do, if anything, to activate the Feature.
                    public enum Resolution: String, Codable, Hashable, Sendable {
                        case contactStripe = "contact_stripe"
                        case provideInformation = "provide_information"
                        case removeRestriction = "remove_restriction"
                    }

                    /// The `platform_restrictions` that are restricting this Feature.
                    public enum Restriction: String, Codable, Hashable, Sendable {
                        case inboundFlows = "inbound_flows"
                        case outboundFlows = "outbound_flows"
                    }
                }
            }
        }
    }
}
