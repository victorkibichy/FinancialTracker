@MainActor
class RecentTransactionViewModel: ObservableObject {
    @Published var transactions: [ExchangeTransaction] = []
    @Published var isLoading = false
    @Published var error: String? = nil
    
//    private let url = URL(string: "https://victork.free.beeceptor.com/transactions")!
    
    func fetchTransactions() {
        guard let url = URL(string: "https://victork.free.beeceptor.com/transactions") else {
            self.errorMessage = "Invalid transactions URL"
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    self.errorMessage = "Transactions error: \(err.localizedDescription)"
                }
            }, receiveValue: { resp in
                self.transactions = resp
            })
            .store(in: &cancellables)
    }

}
