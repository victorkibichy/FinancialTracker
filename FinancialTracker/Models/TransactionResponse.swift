//
//  TransactionResponse.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import Foundation


struct TransactionResponse: Codable {
    let transactions: [TransactionModel]
}
