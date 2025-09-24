import Foundation
import Combine

class TransactionDataService {
    
    @Published var transactions: [TransactionModel] = []
    
    private var transactionSubscription: AnyCancellable?
    
    init() {
        fetchTransactions()
    }
    
    private func fetchTransactions() {
        guard let url = URL(string: "https://victork.free.beeceptor.com/transactions") else {
            return
        }
        
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