//
//  Expenses.swift
//  iExpense
//
//  Created by Daniel Stafford on 12/24/21.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
