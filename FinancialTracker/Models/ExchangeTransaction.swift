//
//  ExchangeTransaction.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import Foundation

struct ExchangeTransaction: Codable, Identifiable {
    let id = UUID()
    let transactionId: String
    let date: String
    let baseCurrency: String
    let targetCurrency: String
    let rate: Double
    let source: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case transactionId = "id"
        case date, baseCurrency, targetCurrency, rate, source, status
    }
}



struct ExchangeTransactionResponse: Codable {
    let transactions: [ExchangeTransaction]
}
