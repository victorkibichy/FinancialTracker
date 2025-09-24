//
//  TransactionViewModel.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import Foundation
import SwiftUI

@MainActor
class TransactionViewModel: ObservableObject {
    @Published var transactions: [TransactionModel] = []
    @Published var isLoading = false
    @Published var error: String? = nil
    
    private let url = URL(string: "https://victork.free.beeceptor.com/transactions")!
    
    func fetchTransactions() {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let response = try JSONDecoder().decode(TransactionResponse.self, from: data)
                self.transactions = response.transactions
            } catch {
                self.error = error.localizedDescription
            }
            self.isLoading = false
        }
    }
}
