struct TransactionRow: View {
    let transaction: ExchangeTransaction
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(currencyColor)
                .frame(width: 40, height: 40)
                .overlay(
                    Text(transaction.targetCurrency.prefix(2))
                        .foregroundColor(.white)
                        .font(.caption)
                        .fontWeight(.bold)
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(transaction.baseCurrency) → \(transaction.targetCurrency)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(transaction.source)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("1 \(transaction.baseCurrency) = \(String(format: "%.2f", transaction.rate)) \(transaction.targetCurrency)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(statusColor)
                Text(transaction.status)
                    .font(.caption)
                    .foregroundColor(statusColor.opacity(0.7))
            }
        }
        .padding(.vertical, 4)
    }
    
    private var currencyColor: Color {
        switch transaction.targetCurrency {
        case "USD": return .blue
        case "EUR": return .orange
        case "GBP": return .green
        case "JPY": return .red
        case "CNY": return .yellow
        default: return .purple
        }
    }
    
    private var statusColor: Color {
        switch transaction.status.lowercased() {
        case "completed", "success": return .green
        case "pending": return .orange
        case "failed", "error": return .red
        default: return .gray
        }
    }
}