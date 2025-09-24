//
//  TransactionDataService.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import Foundation
import Combine

class TransactionDataService: ObservableObject {
    
    @Published var transactions: [TransactionModel] = []
    
    private var transactionSubscription: AnyCancellable?
    
    init() {
        fetchTransactions()
    }
    
    func fetchTransactions() {
        guard let url = URL(string: "https://victork.free.beeceptor.com/transactions") else { return }
        
        transactionSubscription = NetworkingManager.download(url: url)
            .decode(type: [TransactionModel].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedTransactions in
                    self?.transactions = returnedTransactions
                    self?.transactionSubscription?.cancel()
                }
            )
    }
}
