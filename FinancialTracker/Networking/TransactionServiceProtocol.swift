//
//  TransactionServiceProtocol.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import Foundation

protocol TransactionServiceProtocol {
    func fetchTransactions() async throws -> [TransactionModel]
}

struct TransactionService: TransactionServiceProtocol {
    func fetchTransactions() async throws -> [TransactionModel] {
        guard let url = URL(string: "https://victork.free.beeceptor.com/transactions") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        if let raw = String(data: data, encoding: .utf8) {
            print("DEBUG: Raw response → \(raw)")
        }

        let decoded = try JSONDecoder().decode(TransactionResponse.self, from: data)
        return decoded.transactions
    }
}
