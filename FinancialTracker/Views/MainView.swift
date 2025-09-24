//
//  ContentView.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import SwiftUI
import CoreData

struct ContentView: View {
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

// MARK: - Home View
struct HomeView: View {
    @EnvironmentObject var persistenceManager: PersistenceManager
    @State private var showingAddTransaction = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
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
                
                // Balance Card
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
                        .fill(Color.green.opacity(0.8))
                )
                .padding(.horizontal)
                
                // Recent Transactions
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Recent Five Transactions")
                            .font(.headline)
                            .fontWeight(.medium)
                        Spacer()
                        Button("View All") {
                            // Handle view all
                        }
                        .foregroundColor(.green)
                        .font(.subheadline)
                    }
                    
                    LazyVStack(spacing: 12) {
                        ForEach(Array(persistenceManager.transactions.prefix(5))) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                // Add Transaction Button
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

// MARK: - Transaction Row
struct TransactionRow: View {
    let transaction: TransactionModel
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(merchantColor)
                .frame(width: 40, height: 40)
                .overlay(
                    Text(String(transaction.merchant?.prefix(1) ?? ""))
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .fontWeight(.medium)
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.merchant ?? "")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(transaction.description ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("Ksh. \(String(format: "%.2f", transaction.amount))")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.green)
                Text(transaction.isExpense ? "Expense" : "Income")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
    
    private var merchantColor: Color {
        switch transaction.merchant {
        case "KFC Westlands": return .red
        case "Naivas Supermarket": return .orange
        case "Total Energies": return .blue
        default: return .gray
        }
    }
}

// MARK: - Add Transaction View
struct AddTransactionView: View {
    @EnvironmentObject var persistenceManager: PersistenceManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var amount: String = "1000.00"
    @State private var description: String = "Fuel for wife's car"
    @State private var selectedCategory: String = "Transport"
    @State private var selectedDate = Date()
    @State private var isExpense = true
    
    let categories = ["Transport", "Food", "Shopping", "Utilities", "Entertainment", "Other"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Category Selection
                VStack(alignment: .leading, spacing: 8) {
                    Text("Category")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            isExpense = false
                        }) {
                            HStack {
                                Circle()
                                    .stroke(isExpense ? Color.gray : Color.green, lineWidth: 2)
                                    .fill(isExpense ? Color.clear : Color.green)
                                    .frame(width: 20, height: 20)
                                Text("Income")
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        Button(action: {
                            isExpense = true
                        }) {
                            HStack {
                                Circle()
                                    .stroke(!isExpense ? Color.gray : Color.green, lineWidth: 2)
                                    .fill(!isExpense ? Color.clear : Color.green)
                                    .frame(width: 20, height: 20)
                                Text("Expense")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
                
                // Amount
                VStack(alignment: .leading, spacing: 8) {
                    Text("Amount (KES)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    TextField("0.00", text: $amount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                // Date
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                // Category Dropdown
                VStack(alignment: .leading, spacing: 8) {
                    Text("Category")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Menu {
                        ForEach(categories, id: \.self) { category in
                            Button(category) {
                                selectedCategory = category
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: "car.fill")
                                .foregroundColor(.red)
                            Text(selectedCategory)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    TextField("Enter description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Spacer()
                
                // Add Transaction Button
                Button(action: addTransaction) {
                    Text("Add Transaction")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                }
            }
            .padding()
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    private func addTransaction() {
        guard let amountValue = Double(amount) else { return }
        
        let transaction = TransactionModel(
            amount: amountValue,
            description: description,
            currency: "",
            date: selectedDate,
            isExpense: isExpense,
            merchant: "Manual Entry"
        )
        
//        $persistenceManager.addTransaction(transaction)
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Exchange Rate View
struct ExchangeRateView: View {
    @State private var exchangeRates: [ExchangeRate] = [
        ExchangeRate(code: "USD", name: "United States Dollar", country: "United States", flagEmoji: "🇺🇸", buyRate: 144.25, sellRate: 145.25),
        ExchangeRate(code: "GBP", name: "Great British Pound", country: "Great Britain", flagEmoji: "🇬🇧", buyRate: 183.80, sellRate: 185.22),
        ExchangeRate(code: "EUR", name: "Euro", country: "European Union", flagEmoji: "🇪🇺", buyRate: 156.97, sellRate: 158.21),
        ExchangeRate(code: "CNY", name: "China Yuan", country: "China", flagEmoji: "🇨🇳", buyRate: 19.81, sellRate: 19.98),
        ExchangeRate(code: "UGX", name: "Uganda Shilling", country: "Uganda", flagEmoji: "🇺🇬", buyRate: 25.61, sellRate: 25.86),
        ExchangeRate(code: "TZS", name: "Tanzania Shilling", country: "Tanzania", flagEmoji: "🇹🇿", buyRate: 17.12, sellRate: 17.30),
        ExchangeRate(code: "RWF", name: "Rwanda Franc", country: "Rwanda", flagEmoji: "🇷🇼", buyRate: 7.96, sellRate: 8.21),
        ExchangeRate(code: "ZAR", name: "South Africa Rand", country: "South Africa", flagEmoji: "🇿🇦", buyRate: 7.40, sellRate: 7.65)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(exchangeRates) { rate in
                        ExchangeRateCard(rate: rate)
                    }
                }
                .padding()
            }
            .navigationTitle("Exchange Rates")
            .navigationBarItems(
                leading: Button(action: {}) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.primary)
                }
            )
        }
    }
}

// MARK: - Exchange Rate Card
struct ExchangeRateCard: View {
    let rate: ExchangeRate
    
    var body: some View {
        HStack(spacing: 16) {
            // Currency Info
            VStack(alignment: .leading, spacing: 4) {
                Text(rate.code)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(rate.country)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            // Flag
            Text(rate.flagEmoji)
                .font(.title)
            
            Spacer()
            
            // Buy Rate
            VStack(alignment: .center, spacing: 4) {
                Text("Buy")
                    .font(.caption)
                    .foregroundColor(.green)
                    .fontWeight(.medium)
                Text(String(format: "%.2f", rate.buyRate))
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            
            // Sell Rate
            VStack(alignment: .center, spacing: 4) {
                Text("Sell")
                    .font(.caption)
                    .foregroundColor(.red)
                    .fontWeight(.medium)
                Text(String(format: "%.2f", rate.sellRate))
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
        ContentView()
            .environmentObject(PersistenceManager())
    }
}
