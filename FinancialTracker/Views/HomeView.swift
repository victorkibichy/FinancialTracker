//
//  HomeView.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import SwiftUI

struct HomeView: View {
    @EnvironmentObject var persistenceManager: PersistenceManager
    @State private var showingAddTransaction = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text("T")
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                    Text("Good Morning Tony")
                        .font(.title3)
                        .fontWeight(.medium)
                    Spacer()
                }
                .padding()
                
                VStack(spacing: 16) {
                    VStack {
                        Text("Current Balance")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.caption)
                        HStack(alignment: .bottom, spacing: 4) {
                            Text(String(format: "%.2f", persistenceManager.currentBalance))
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("KES")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.caption)
                        }
                    }
                    
                    HStack {
                        VStack {
                            Text("Money In")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.caption)
                            Text("KES \(String(format: "%.2f", persistenceManager.moneyIn))")
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        
                        Spacer()
                        
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 1, height: 30)
                        
                        Spacer()
                        
                        VStack {
                            Text("Money Out")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.caption)
                            Text("KES \(String(format: "%.2f", persistenceManager.moneyOut))")
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.financialDashboard,
                                    Color(hex: "C8E6A3")          
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Recent Five Transactions")
                            .font(.headline)
                            .fontWeight(.medium)
                        Spacer()
                        Button("View All") {
                        }
                        .foregroundColor(.green)
                        .font(.subheadline)
                    }
                    RecentTransactionView()
//                    LazyVStack(spacing: 12) {
//                        ForEach(Array(persistenceManager.transactions.prefix(5))) { transaction in
//                            RecentTransactionView()                        }
//                    }
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    showingAddTransaction = true
                }) {
                    Text("Add Transaction")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingAddTransaction) {
            AddTransactionView()
        }
    }
}

