struct ExchangeRateView: View {
    @StateObject private var dataService = ExchangeDataService()
    
    var body: some View {
        NavigationView {
            List(dataService.exchangeRates) { rate in
                HStack {
                    Text(rate.pair)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(rate.rate, specifier: "%.4f")")
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle("Exchange Rates")
        }
    }
}