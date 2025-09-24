//
//  ContentView.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import SwiftUI
import CoreData

struct MainAppRootView: View {
    @EnvironmentObject var persistenceManager: PersistenceManager
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            ExchangeRateView()
                .tabItem {
                    Image(systemName: "arrow.up.arrow.down")
                    Text("Exchange Rate")
                }
                .tag(1)
            
            Text("More")
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
                .tag(2)
        }
        .accentColor(.green)
    }
}



struct ExchangeRateCard: View {
    let pair: ExchangePair
    let base: String
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(pair.pair)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(base)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 4) {
                Text("Buy")
                    .font(.caption)
                    .foregroundColor(.green)
                    .fontWeight(.medium)
                Text(String(format: "%.4f", pair.rate))
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            
            VStack(alignment: .center, spacing: 4) {
                Text("Sell")
                    .font(.caption)
                    .foregroundColor(.red)
                    .fontWeight(.medium)
                Text(String(format: "%.4f", pair.rate * 0.98))
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppRootView()
            .environmentObject(PersistenceManager())
    }
}
