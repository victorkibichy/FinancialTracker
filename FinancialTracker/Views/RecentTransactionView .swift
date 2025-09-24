//
//  RecentTransactionView .swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import SwiftUI

struct RecentTransactionView: View {
    @StateObject private var viewModel = RecentTransactionViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Fetching transactions...")
                    .padding()
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
                VStack(spacing: 0) {
                    TransactionRowItem(
                        icon: Image("kfc-icon"),
                        title: "KFC Westlands",
                        subtitle: "Today • 2024 14:26",
                        amount: "Ksh. 780.00",
                        status: "Eating out"
                    )
                    
                    TransactionRowItem(
                        icon: Image("naivas"),
                        title: "Naivas Supermarket",
                        subtitle: "Today • 2024 13:56",
                        amount: "Ksh. 1,200.00",
                        status: "Shopping"
                    )
                    
                    TransactionRowItem(
                        icon: Image("imagestotal"),
                        title: "Total Energies",
                        subtitle: "Today • 2024 12:30",
                        amount: "Ksh. 1,200.00",
                        status: "Shopping"
                    )
                    
                    TransactionRowItem(
                        icon: Image("imagestotal"),
                        title: "Total Energies",
                        subtitle: "Today • 2024 12:30",
                        amount: "Ksh. 1,200.00",
                        status: "Shopping"
                    )
                    
                    TransactionRowItem(
                        icon: Image("imagestotal"),
                        title: "Total Energies",
                        subtitle: "Today • 2024 12:30",
                        amount: "Ksh. 1,200.00",
                        status: "Shopping",
                        isLast: true
                    )
                }
            } else {
                List(viewModel.transactions) { transaction in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(transaction.id)
                                .font(.headline)
                            Spacer()
                            Text(transaction.date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Text("\(transaction.baseCurrency) → \(transaction.targetCurrency)")
                                .font(.subheadline)
                            Spacer()
                            Text(String(format: "%.4f", transaction.rate))
                                .font(.subheadline)
                                .bold()
                        }
                        
                        HStack {
                            Text("Source: \(transaction.source)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(transaction.status)
                                .foregroundColor(transaction.status == "Success" ? .green : .red)
                                .font(.caption)
                                .bold()
                        }
                    }
                    .padding(.vertical, 6)
                }
                .listStyle(.insetGrouped)
                .refreshable {
                    await viewModel.fetchTransactions()
                }
            }
        }
        .navigationTitle("Recent Transactions")
        .task {
            await viewModel.fetchTransactions()
        }
    }
}

#Preview {
    RecentTransactionView()
}




struct TransactionRowItem: View {
    let icon: Image
    let title: String
    let subtitle: String
    let amount: String
    let status: String
    var isLast: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.orange.opacity(0.1))
                    .frame(width: 40, height: 40)
                    .overlay(
                        icon
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                            .clipShape(Circle())
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                    
                    Text(subtitle)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(amount)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.red)
                    
                    Text(status)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            
            if !isLast {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 0.5)
                    .padding(.leading, 72)
            }
        }
        .background(Color.white)
    }
}
