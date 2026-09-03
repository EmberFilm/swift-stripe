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

import StripeCore
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension ReportRun {
    public enum Create {}
    public enum List {}
    public enum Retrieve {}
}

// POST /v1/reporting/report_runs
extension ReportRun.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Parameters specifying how the report should be run.
        public var parameters: Parameters?
        /// The ID of the report type to run, such as `"balance.summary.1"`.
        public var reportType: String

        public init(
            expand: [String]? = nil,
            parameters: Parameters? = nil,
            reportType: String
        ) {
            self.expand = expand
            self.parameters = parameters
            self.reportType = reportType
        }

        /// Parameters specifying how the report should be run.
        public struct Parameters: Codable, Hashable, Sendable {
            /// The set of report columns to include in the report output.
            public var columns: [String]?
            /// Connected account ID to filter for in the report run.
            public var connectedAccount: String?
            /// Currency of objects to be included in the report run.
            public var currency: Stripe.Currency?
            /// Ending timestamp of data to be included in the report run (exclusive).
            public var intervalEnd: Date?
            /// Starting timestamp of data to be included in the report run.
            public var intervalStart: Date?
            /// Payout ID by which to filter the report run.
            public var payout: String?
            /// Category of balance transactions to be included in the report run.
            public var reportingCategory: ReportingCategory?
            /// Defaults to `Etc/UTC`.
            public var timezone: String?

            public init(
                columns: [String]? = nil,
                connectedAccount: String? = nil,
                currency: Stripe.Currency? = nil,
                intervalEnd: Date? = nil,
                intervalStart: Date? = nil,
                payout: String? = nil,
                reportingCategory: ReportingCategory? = nil,
                timezone: String? = nil
            ) {
                self.columns = columns
                self.connectedAccount = connectedAccount
                self.currency = currency
                self.intervalEnd = intervalEnd
                self.intervalStart = intervalStart
                self.payout = payout
                self.reportingCategory = reportingCategory
                self.timezone = timezone
            }

            public enum ReportingCategory: String, Codable, Hashable, Sendable {
                case advance
                case advanceFunding = "advance_funding"
                case anticipationRepayment = "anticipation_repayment"
                case charge
                case chargeFailure = "charge_failure"
                case climateOrderPurchase = "climate_order_purchase"
                case climateOrderRefund = "climate_order_refund"
                case connectCollectionTransfer = "connect_collection_transfer"
                case connectReservedFunds = "connect_reserved_funds"
                case contribution
                case dispute
                case disputeReversal = "dispute_reversal"
                case fee
                case financingPaydown = "financing_paydown"
                case financingPaydownReversal = "financing_paydown_reversal"
                case financingPayout = "financing_payout"
                case financingPayoutReversal = "financing_payout_reversal"
                case issuingAuthorizationHold = "issuing_authorization_hold"
                case issuingAuthorizationRelease = "issuing_authorization_release"
                case issuingDispute = "issuing_dispute"
                case issuingTransaction = "issuing_transaction"
                case networkCost = "network_cost"
                case otherAdjustment = "other_adjustment"
                case partialCaptureReversal = "partial_capture_reversal"
                case payout
                case payoutReversal = "payout_reversal"
                case platformEarning = "platform_earning"
                case platformEarningRefund = "platform_earning_refund"
                case refund
                case refundFailure = "refund_failure"
                case riskReservedFunds = "risk_reserved_funds"
                case tax
                case topup
                case topupReversal = "topup_reversal"
                case transfer
                case transferReversal = "transfer_reversal"
                case unreconciledCustomerFunds = "unreconciled_customer_funds"
            }
        }
    }

    public typealias Response = ReportRun
}

// GET /v1/reporting/report_runs
extension ReportRun.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return Report Runs that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?

        public init(
            created: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public typealias Response = Stripe.Page<ReportRun>
}

// GET /v1/reporting/report_runs/{report_run}
extension ReportRun.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = ReportRun
}
