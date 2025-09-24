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
            cd.amount = t.amount
            cd.currency = t.currency
            cd.date = t.date
            cd.isExpense = t.isExpense
            cd.merchant = t.merchant
            cd.transactionDescription = t.description
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save transactions to Core Data: \(error)")
        }
    }
    
    func fetchAllTransactions() -> [TransactionModel] {
        let request: NSFetchRequest<CDTransaction> = CDTransaction.fetchRequest()
        do {
            let cds = try context.fetch(request)
            return cds.compactMap { cd in
                guard let id = cd.id else { return nil }
                return TransactionModel(
                    id: id,
                    amount: cd.amount,
                    description: cd.transactionDescription,
                    currency: cd.currency ?? "KES",
                    date: cd.date ?? Date(),
                    isExpense: cd.isExpense,
                    merchant: cd.merchant
                )
            }
        } catch {
            print("Failed to load transactions from Core Data: \(error)")
            return []
        }
    }
}
