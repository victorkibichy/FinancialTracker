import Foundation
import SwiftUI

@MainActor
class MainViewModel: ObservableObject {
    @Published var transactions: [TransactionModel] = []
    @Published var exchangeRates: [String: Double] = [:]
    @Published var searchText = ""
    
    private let currencyService: CurrencyService
    private let coreDataManager: CoreDataManager
    private var debouncer = Debouncer(delay: 0.5)
    
    init(currencyService: CurrencyService, coreDataManager: CoreDataManager) {
        self.currencyService = currencyService
        self.coreDataManager = coreDataManager
    }
    
    func loadData() {
        Task {
            do {
                let fetched = try await currencyService.fetchTransactions()
                await MainActor.run {
                    self.transactions = fetched
                    coreDataManager.save(transactions: fetched)
                }
            } catch {
                print("Error loading transactions: $error)")
                await MainActor.run {
                   
                }
            }
            
            do {
                let rates = try await currencyService.fetchExchangeRates()
                await MainActor.run {
                    self.exchangeRates = rates
                }
            } catch {
                print("Error loading exchange rates: $error)")
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
    
    func searchTransactions() {
        debouncer.debounce {
        }
    }
}
