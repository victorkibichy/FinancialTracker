import Foundation
import Combine

class ExchangeDataService: ObservableObject {
    @Published var exchangeRates: [ExchangePair] = []
    
    private var cancellable: AnyCancellable?
    
    init() {
        fetchExchangeRates()
    }
    
    func fetchExchangeRates() {
        guard let url = URL(string: "https://victork.free.beeceptor.com/exchangeRtes") else { return }
        
        cancellable = NetworkingManager.download(url: url)
            .decode(type: ExchangeResponse.self, decoder: JSONDecoder())
            .map { $0.pairs }
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedRates in
                self?.exchangeRates = returnedRates
            })
    }
}
