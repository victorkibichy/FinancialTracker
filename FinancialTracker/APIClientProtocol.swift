//
//  APIClientProtocol.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import Foundation
import Combine

protocol APIClientProtocol {
    func fetchTransactions() async throws -> [TransactionModel]
    func fetchExchangeRates() async throws -> [String: Double]
}

class APIClient: APIClientProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchTransactions() async throws -> [TransactionModel] {
        let url = URL(string: "https://collinm.free.beeceptor.com/transactions")!
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([TransactionModel].self, from: data)
    }

    func fetchExchangeRates() async throws -> [String: Double] {
        let url = URL(string: "https://collinm.free.beeceptor.com/exchangeRtes")!
        let (data, _) = try await session.data(from: url)
        return try JSONSerialization.jsonObject(with: data) as? [String: Double] ?? [:]
    }
}
