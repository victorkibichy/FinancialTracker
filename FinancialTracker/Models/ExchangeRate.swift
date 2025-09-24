struct ExchangeRate: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let country: String
    let flagEmoji: String
    let buyRate: Double
    let sellRate: Double
}