//
//  FinancialTrackerApp.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import SwiftUI

@main
struct FinancialTrackerApp: App {
    @StateObject private var persistenceManager = PersistenceManager()
    
    var body: some Scene {
        WindowGroup {
            MainAppRootView()
                .environmentObject(persistenceManager)
        }
    }
}
