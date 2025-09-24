//
//  Transaction.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import SwiftUI
import Foundation

// MARK: - Data Models

struct TransactionModel: Codable, Identifiable {
    var id = UUID()
    var amount: Double
    var description: String?
    var currency: String // Fixed typo: was "curency"
    var date: Date
    var isExpense: Bool // Non-optional Bool
    var merchant: String?
}

struct ExchangeRate: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let country: String
    let flagEmoji: String
    let buyRate: Double
    let sellRate: Double
}

// MARK: - Persistence Manager
class PersistenceManager: ObservableObject {
    @Published var transactions: [TransactionModel] = []
    @Published var currentBalance: Double = 152500.00
    @Published var moneyIn: Double = 120000.00
    @Published var moneyOut: Double = 12000.00
    
    private let transactionsKey = "SavedTransactions"
    private let balanceKey = "CurrentBalance"
    private let moneyInKey = "MoneyIn"
    private let moneyOutKey = "MoneyOut"
    
    init() {
        loadData()
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(transactions) {
            UserDefaults.standard.set(encoded, forKey: transactionsKey)
        }
        UserDefaults.standard.set(currentBalance, forKey: balanceKey)
        UserDefaults.standard.set(moneyIn, forKey: moneyInKey)
        UserDefaults.standard.set(moneyOut, forKey: moneyOutKey)
    }
    
    func loadData() {
        // Load transactions
        if let data = UserDefaults.standard.data(forKey: transactionsKey),
           let decoded = try? JSONDecoder().decode([TransactionModel].self, from: data) {
            transactions = decoded
        }
        
        // Load balance — only use default if key has never been set
        if UserDefaults.standard.object(forKey: balanceKey) != nil {
            currentBalance = UserDefaults.standard.double(forKey: balanceKey)
        }
        
        if UserDefaults.standard.object(forKey: moneyInKey) != nil {
            moneyIn = UserDefaults.standard.double(forKey: moneyInKey)
        }
        
        if UserDefaults.standard.object(forKey: moneyOutKey) != nil {
            moneyOut = UserDefaults.standard.double(forKey: moneyOutKey)
        }
    }
    
    func addTransaction(_ transaction: TransactionModel) {
        transactions.append(transaction)
        
        if transaction.isExpense {
            currentBalance -= transaction.amount
            moneyOut += transaction.amount
        } else {
            currentBalance += transaction.amount
            moneyIn += transaction.amount
        }
        
        saveData()
    }
}

// MARK: - Main App


// MARK: - Content View with Tab Navigation


// MARK: - Home View
