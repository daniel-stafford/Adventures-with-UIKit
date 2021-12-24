//
//  AddView.swift
//  iExpense
//
//  Created by Daniel Stafford on 12/24/21.
//

import SwiftUI

struct AddView: View {
    // store an Expenses object. It won’t create the object there, which means we need to use @ObservedObject rather than @StateObject.
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var showingAddExpense = false

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        // tries to create an AddView instance without providing a value for the expenses property. That isn’t allowed any more, but we can just pass in a dummy value instead
        AddView(expenses: Expenses())
    }
}
