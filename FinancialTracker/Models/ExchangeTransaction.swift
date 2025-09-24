struct ExchangeTransaction: Codable, Identifiable {
    let id = UUID()
    let transactionId: String
    let date: String
    let baseCurrency: String
    let targetCurrency: String
    let rate: Double
    let source: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case transactionId = "id"
        case date, baseCurrency, targetCurrency, rate, source, status
    }
}