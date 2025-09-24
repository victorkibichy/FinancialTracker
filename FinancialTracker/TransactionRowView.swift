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
                Text(transaction.curency)
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

//struct TransactionRowView_Previews: PreviewProvider {
//    static let sampleTransaction = TransactionModel(
//        amount: -45.99,
//        description: "USD",
//        curency: "",
//        date: Date(),
//        isExpense: false,
//        merchant: <#T##String?#>
//    )
//    
//    static var previews: some View {
//        TransactionRowView(transaction: tr, transactionModifier: <#any TransactionRepresentable#>)
//            .padding()
//    }
//}
