//
//  ContentView.swift
//  iExpense
//
//  Created by Daniel Stafford on 12/23/21.
//

import SwiftUI

struct ContentView: View {
    let currencyFormater: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    // watch published property inside our class for any changes
    // as we are creating the class instance, we use @StateObject
    // all other times we used @ObservableObject when reading/modifying a class
    @StateObject var expenses = Expenses()
    // track whether or not AddView is being shown
    @State private var showingAddExpense = false

    var expenseTypes: [String] { Array(Set(expenses.items.map { $0.type })) }

    var body: some View {
        NavigationView {
            List {
                ForEach(expenseTypes, id: \.self) { type in
                    Section {
                        ForEach(expenses.items.filter { $0.type == type }) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }

                                Spacer()
                                Text(item.amount, format: currencyFormater)
                                    .foregroundColor(getColorExpense(item.amount))
                            }
                        }.onDelete(perform: { removeItems(at: $0, type: type) })
                    }
                }
                .navigationTitle("iExpense")
                .toolbar {
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: expenses)
                }
            }.padding(.top, 40)
        }
    }

    func removeItems(at offsets: IndexSet, type: String) {
        for i in offsets {
            print(i)
            let itemToDelete = expenses.items.filter { $0.type == type }[i]
            if let index = expenses.items.firstIndex(where: { $0.id == itemToDelete.id }) {
                expenses.items.remove(at: index)
            }
        }
    }

    func getColorExpense(_ amount: Double) -> Color {
        var color = Color(.blue)
        if amount >= 100 {
            color = Color(.red)
        } else if amount <= 10 {
            color = Color(.green)
        }
        return color
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
