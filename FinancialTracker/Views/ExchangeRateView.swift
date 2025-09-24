//
//  ExchangeRateView.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import SwiftUI

struct ExchangeRateView: View {
    @StateObject private var viewModel = ExchangeRateViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Fetching exchange rates...")
                    .padding()
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(viewModel.exchangeRates) { pair in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(pair.pair)
                                .font(.headline)
                            Spacer()
                            Text(String(format: "%.4f", pair.rate))
                                .bold()
                        }
                        Text("Based on KES")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 6)
                }
                .listStyle(.insetGrouped)
                .refreshable {
                    await viewModel.fetchExchangeRates()
                }
            }
        }
        .navigationTitle("Exchange Rates")
        .task {
            await viewModel.fetchExchangeRates()
        }
    }
}

#Preview {
    ExchangeRateView()
}





