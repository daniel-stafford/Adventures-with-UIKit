//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Daniel Stafford on 12/24/21.
//

import Foundation

// Identifiable improves performance, requires property of id that is unique
// Identifiable allows us to no longer need to tell a ForEach to identity each item
struct ExpenseItem: Identifiable {
    // unique ID, no need for external UUID library! 😀
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
