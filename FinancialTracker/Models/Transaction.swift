//
//  Transaction.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import SwiftUI
import Foundation


struct TransactionModel: Identifiable, Codable {
    let id: String
    let date: String
    let baseCurrency: String
    let targetCurrency: String
    let rate: Double
    let source: String
    let status: String
}









