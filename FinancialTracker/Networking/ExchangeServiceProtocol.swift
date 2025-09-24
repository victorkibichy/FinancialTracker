import Foundation

protocol ExchangeServiceProtocol {
    func fetchExchangeRates() async throws -> [ExchangePair]
}

struct ExchangeService: ExchangeServiceProtocol {
    func fetchExchangeRates() async throws -> [ExchangePair] {
        guard let url = URL(string: "https://victork.free.beeceptor.com/exchangeRtes") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        // Debug raw response
        if let raw = String(data: data, encoding: .utf8) {
            print("DEBUG: Raw response → \(raw)")
            // Stop decoding if not valid JSON
            guard raw.trimmingCharacters(in: .whitespacesAndNewlines).first == "{" else {
                throw URLError(.badServerResponse)
            }
        }

        let decoded = try JSONDecoder().decode(ExchangeResponse.self, from: data)
        return decoded.pairs
    }
}
