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
    public indirect enum BalanceTransactionSource: Codable, Hashable, Sendable {
        case applicationFee(Stripe.Connect.Application.Fee)
        case charge(Stripe.Charges.Charge)
        case connectCollectionTransfer(Stripe.Connect.CollectionTransfer)
        case customerCashBalanceTransaction(Stripe.Customers.CashBalanceTransaction)
        case dispute(Stripe.Disputes.Dispute)
        case feeRefund(Stripe.Connect.Application.Fee.Refund)
        case issuingAuthorization(Authorization)
        case issuingDispute(IssuingDispute)
        case issuingTransaction(Transaction)
        case payout(Stripe.Payouts.Payout)
        case refund(Stripe.Refunds.Refund)
        case reserveTransaction(Stripe.Reserve.Transaction)
        case taxDeductedAtSource(TaxDeductedAtSource)
        case topup(Stripe.Connect.TopUp)
        case transfer(Stripe.Connect.Transfer)
        case transferReversal(Stripe.Connect.Transfer.Reversal)
        case unknown(object: String)

        public var applicationFee: Stripe.Connect.Application.Fee? {
            if case .applicationFee(let value) = self { return value }
            return nil
        }
        public var charge: Stripe.Charges.Charge? {
            if case .charge(let value) = self { return value }
            return nil
        }
        public var connectCollectionTransfer: Stripe.Connect.CollectionTransfer? {
            if case .connectCollectionTransfer(let value) = self { return value }
            return nil
        }
        public var customerCashBalanceTransaction: Stripe.Customers.CashBalanceTransaction? {
            if case .customerCashBalanceTransaction(let value) = self { return value }
            return nil
        }
        public var dispute: Stripe.Disputes.Dispute? {
            if case .dispute(let value) = self { return value }
            return nil
        }
        public var feeRefund: Stripe.Connect.Application.Fee.Refund? {
            if case .feeRefund(let value) = self { return value }
            return nil
        }
        public var issuingAuthorization: Authorization? {
            if case .issuingAuthorization(let value) = self { return value }
            return nil
        }
        public var issuingDispute: IssuingDispute? {
            if case .issuingDispute(let value) = self { return value }
            return nil
        }
        public var issuingTransaction: Transaction? {
            if case .issuingTransaction(let value) = self { return value }
            return nil
        }
        public var payout: Stripe.Payouts.Payout? {
            if case .payout(let value) = self { return value }
            return nil
        }
        public var refund: Stripe.Refunds.Refund? {
            if case .refund(let value) = self { return value }
            return nil
        }
        public var reserveTransaction: Stripe.Reserve.Transaction? {
            if case .reserveTransaction(let value) = self { return value }
            return nil
        }
        public var taxDeductedAtSource: TaxDeductedAtSource? {
            if case .taxDeductedAtSource(let value) = self { return value }
            return nil
        }
        public var topup: Stripe.Connect.TopUp? {
            if case .topup(let value) = self { return value }
            return nil
        }
        public var transfer: Stripe.Connect.Transfer? {
            if case .transfer(let value) = self { return value }
            return nil
        }
        public var transferReversal: Stripe.Connect.Transfer.Reversal? {
            if case .transferReversal(let value) = self { return value }
            return nil
        }

        private enum CodingKeys: String, CodingKey {
            case object
        }

        public init(from decoder: any Decoder) throws {
            let object = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .object)
            switch object {
            case "application_fee": self = .applicationFee(try Stripe.Connect.Application.Fee(from: decoder))
            case "charge": self = .charge(try Stripe.Charges.Charge(from: decoder))
            case "connect_collection_transfer": self = .connectCollectionTransfer(try Stripe.Connect.CollectionTransfer(from: decoder))
            case "customer_cash_balance_transaction":
                self = .customerCashBalanceTransaction(try Stripe.Customers.CashBalanceTransaction(from: decoder))
            case "dispute": self = .dispute(try Stripe.Disputes.Dispute(from: decoder))
            case "fee_refund": self = .feeRefund(try Stripe.Connect.Application.Fee.Refund(from: decoder))
            case "issuing.authorization": self = .issuingAuthorization(try Authorization(from: decoder))
            case "issuing.dispute": self = .issuingDispute(try IssuingDispute(from: decoder))
            case "issuing.transaction": self = .issuingTransaction(try Transaction(from: decoder))
            case "payout": self = .payout(try Stripe.Payouts.Payout(from: decoder))
            case "refund": self = .refund(try Stripe.Refunds.Refund(from: decoder))
            case "reserve_transaction": self = .reserveTransaction(try Stripe.Reserve.Transaction(from: decoder))
            case "tax_deducted_at_source": self = .taxDeductedAtSource(try TaxDeductedAtSource(from: decoder))
            case "topup": self = .topup(try Stripe.Connect.TopUp(from: decoder))
            case "transfer": self = .transfer(try Stripe.Connect.Transfer(from: decoder))
            case "transfer_reversal": self = .transferReversal(try Stripe.Connect.Transfer.Reversal(from: decoder))
            default: self = .unknown(object: object)
            }
        }

        public func encode(to encoder: any Encoder) throws {
            switch self {
            case .applicationFee(let value): try value.encode(to: encoder)
            case .charge(let value): try value.encode(to: encoder)
            case .connectCollectionTransfer(let value): try value.encode(to: encoder)
            case .customerCashBalanceTransaction(let value): try value.encode(to: encoder)
            case .dispute(let value): try value.encode(to: encoder)
            case .feeRefund(let value): try value.encode(to: encoder)
            case .issuingAuthorization(let value): try value.encode(to: encoder)
            case .issuingDispute(let value): try value.encode(to: encoder)
            case .issuingTransaction(let value): try value.encode(to: encoder)
            case .payout(let value): try value.encode(to: encoder)
            case .refund(let value): try value.encode(to: encoder)
            case .reserveTransaction(let value): try value.encode(to: encoder)
            case .taxDeductedAtSource(let value): try value.encode(to: encoder)
            case .topup(let value): try value.encode(to: encoder)
            case .transfer(let value): try value.encode(to: encoder)
            case .transferReversal(let value): try value.encode(to: encoder)
            case .unknown(let object):
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(object, forKey: .object)
            }
        }
    }
}
