//
//  ContentView.swift
//  iExpense
//
//  Created by Daniel Stafford on 12/23/21.
//

import SwiftUI

struct ContentView: View {
    // watch published property inside our class for any changes
    // as we are creating the class instance, we use @StateObject
    // all other times we used @ObservableObject when reading/modifying a class
    @StateObject var expenses = Expenses()

    var body: some View {
        NavigationView {
            List {
                //ForEach<Array<ExpenseItem>, String, Text>: the ID Test occurs multiple times within the collection, this will give undefined results! 😦  Fix in next section! 
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    expenses.items.append(expense)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
