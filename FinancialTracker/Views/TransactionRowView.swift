//
//  TransactionRowView.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import SwiftUI

struct TransactionRowView: View {
    let transaction: TransactionModel
    let transactionModifier : TransactionRepresentable
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.baseCurrency)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(transaction.date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(transactionModifier.formattedAmount())
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(transaction.rate
                                 >= 0 ? .green : .red)
        }
        .padding(.vertical, 6)
    }
}
