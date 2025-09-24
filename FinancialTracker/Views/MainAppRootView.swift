//
//  ContentView.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import SwiftUI
import CoreData

struct FinancialView: View{
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

#Preview {
    MainAppRootView()
        .environmentObject(
            MainViewModel(
                apiClient: TransactionService(),
                coreDataManager: CoreDataManager.shared
            )
        )
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    MainAppRootView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
