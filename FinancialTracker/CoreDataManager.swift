//
//  CoreDataManager.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import CoreData
import Foundation

public class CoreDataManager {
    static let shared = CoreDataManager()
     init() {}
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinanceTrackerModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: $error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext { container.viewContext }
    
    func save(transactions: [TransactionModel]) {
        // Delete existing
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDTransaction")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? context.execute(deleteRequest)
        
        // Save new
        for t in transactions {
            let cd = CDTransaction(context: context)
            cd.id = t.id
            cd.amount = t.amount
            cd.currency = t.curency
            cd.date = t.date
        }
        try? context.save()
    }
    
//    func loadTransactions() -> [TransactionModel] {
//        let request: NSFetchRequest<CDTransaction> = CDTransaction.fetchRequest()
//        guard let cds = try? context.fetch(request) else { return [] }
//        return cds.map {
//            TransactionModel(amount: Int, description: <#T##String?#>, curency: <#T##String#>, date: <#T##Date#>, isExpense: <#T##Bool?#>, merchant: <#T##String?#>)
//        }
//    }
}
