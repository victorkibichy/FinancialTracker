import Foundation

@MainActor
class ExchangeRateViewModel: ObservableObject {
    @Published var exchangeRates: [ExchangePair] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchExchangeRates() async {
        guard let url = URL(string: "https://victork.free.beeceptor.com/exchangeRtes") else {
            errorMessage = "Invalid URL"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(ExchangeResponse.self, from: data)
            self.exchangeRates = decoded.pairs
        } catch {
            errorMessage = "Failed to load: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
