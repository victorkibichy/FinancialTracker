//
//  CurrencyService.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


class CurrencyService {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchTransactions() async throws -> [TransactionModel] {
        return try await apiClient.fetchTransactions()
    }
    
    func fetchExchangeRates() async throws -> [String: Double] {
        return try await apiClient.fetchExchangeRates()
    }
}
