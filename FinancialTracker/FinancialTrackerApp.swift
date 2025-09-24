//
//  FinancialTrackerApp.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import SwiftUI

@main
struct FinancialTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
