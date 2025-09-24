//
//  TransactionRepresentable.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import Foundation

protocol TransactionRepresentable {
    var id: UUID { get }
    var amount: Double { get }
    var currency: String { get }
    var date: Date { get }
}

extension TransactionRepresentable {
    func formattedAmount() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
}