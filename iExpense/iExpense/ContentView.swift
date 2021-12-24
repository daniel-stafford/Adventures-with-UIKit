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
    // track whether or not AddView is being shown
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
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
