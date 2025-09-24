//
//  ExchangeRate.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//
 

import Foundation


struct ExchangeResponse: Codable {
    let base: String
    let date: String
    let pairs: [ExchangePair]
    let provider: String
    let timestamp: Int
}

struct ExchangePair: Codable, Identifiable {
    let id : String
    let pair: String
    let rate: Double
}
