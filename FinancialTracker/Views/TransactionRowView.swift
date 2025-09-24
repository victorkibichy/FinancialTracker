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
                Text(transaction.currency)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(transaction.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(transactionModifier.formattedAmount())
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(transaction.amount >= 0 ? .green : .red)
        }
        .padding(.vertical, 6)
    }
}
