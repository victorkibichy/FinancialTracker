//
//  MainViewModel.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import Foundation
import SwiftUI

@MainActor
class MainViewModel: ObservableObject {
    @Published var transactions: [TransactionModel] = []
    @Published var exchangeRates = [:]
    @Published var searchText = ""
    
    private let apiClient: TransactionService
    private let coreDataManager: CoreDataManager
    private var debouncer = Debouncer(delay: 0.5)
    private var allTransactions: [TransactionModel] = []
    
    init(apiClient: TransactionService, coreDataManager: CoreDataManager) {
        self.apiClient = apiClient
        self.coreDataManager = coreDataManager
    }
    
    func loadData() {
        Task {
            do {
                let fetched = try await apiClient.fetchTransactions()
                await MainActor.run {
                    self.allTransactions = fetched
                    self.transactions = fetched
                    coreDataManager.save(transactions: fetched)
                }
            } catch {
                print("❌ Failed to load transactions: \(error)")
               
                
            }
            
           
            do {
                let rates = try await apiClient.fetchTransactions()
                await MainActor.run {}
            } catch {
                print("❌ Failed to load exchange rates: \(error)")
            }
        }
    }
    
    func loadFromPersistence() {
        
    }
    
    func refreshData(completion: (() -> Void)? = nil) {
        Task { [weak self] in
            guard let self else { return }
            await self.loadData()
            await MainActor.run {
                completion?()
            }
        }
    }
    
    func searchTransactions() {}
}
