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
        let container = NSPersistentContainer(name: "FinancialTracker")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext { container.viewContext }
    
    func save(transactions: [TransactionModel]) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDTransaction")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed to delete old transactions: \(error)")
        }
        
        for t in transactions {
            let cd = CDTransaction(context: context)
            cd.id = t.id
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save transactions to Core Data: \(error)")
        }
    }
    
    func fetchAllTransactions()   {
    }
    
}
