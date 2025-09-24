//
//  RecentTransactionViewModel.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import Foundation
import Combine

@MainActor
class RecentTransactionViewModel: ObservableObject {
    @Published var transactions: [TransactionModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let service: TransactionServiceProtocol

    init(service: TransactionServiceProtocol = TransactionService()) {
        self.service = service
    }

    func fetchTransactions() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let fetched = try await service.fetchTransactions()
            self.transactions = fetched
        } catch {
            self.errorMessage = "Failed to load: \(error.localizedDescription)"
        }
    }
}
