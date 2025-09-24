//
//  CurrencyService.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


class CurrencyService {
    private let apiClient: TransactionService
    
    init(apiClient: TransactionService) {
        self.apiClient = apiClient
    }
    
    func fetchTransactions() async throws -> [TransactionModel] {
        return try await apiClient.fetchTransactions()
    }
    
  
}
