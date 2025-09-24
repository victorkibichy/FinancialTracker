//
//  ExchangeRateViewModel.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import Foundation

@MainActor
class ExchangeRateViewModel: ObservableObject {
    @Published var exchangeRates: [ExchangePair] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: ExchangeServiceProtocol

    init(service: ExchangeServiceProtocol = ExchangeService()) {
        self.service = service
    }

    func fetchExchangeRates() async {
        isLoading = true
        defer { isLoading = false }

        do {
            self.exchangeRates = try await service.fetchExchangeRates()
        } catch {
            print("DEBUG: Fetch error → \(error)")
            errorMessage = "Failed to load rates, showing sample data."

            // ✅ Fallback mock data
            self.exchangeRates = [
                ExchangePair(id: "1", pair: "KES/USD", rate: 0.0075)
            ]
        }
    }
}
