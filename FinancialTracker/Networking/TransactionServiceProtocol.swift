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
        guard let url = URL(string: "https://victork-free.free.beeceptor.com/transactions") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check HTTP status
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // Optional: Debug raw response
        if let rawString = String(data: data, encoding: .utf8) {
            print("DEBUG: Raw response → \(rawString)")
        }
        
        // Check if response is HTML (Beeceptor default page)
        if String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix("<!DOCTYPE") == true ||
           String(data: data, encoding: .utf8)?.contains("Hey ya! Great to see you here") == true {
            print("⚠️ Received Beeceptor default page — configure your mock endpoint!")
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // if you switch `date` to `Date` type
        
        return try decoder.decode([TransactionModel].self, from: data)
    }
}
