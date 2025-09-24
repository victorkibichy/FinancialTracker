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
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Amount (KES)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    TextField("0.00", text: $amount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
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
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    TextField("Enter description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Spacer()
                
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
        
//        let transaction = TransactionModel(
//            from: <#any Decoder#>, amount: amountValue,
//            description: description,
//            currency: "",
//            date: selectedDate,
//            isExpense: isExpense,
//            merchant: "Manual Entry"
//        )
        
//        $persistenceManager.addTransaction(transaction)
        presentationMode.wrappedValue.dismiss()
    }
}