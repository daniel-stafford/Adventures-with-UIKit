//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Daniel Stafford on 12/24/21.
//

import Foundation

// Identifiable improves performance, requires property of id that is unique
// Identifiable allows us to no longer need to tell a ForEach to identity each item
// Make Codable as to be able to encode
struct ExpenseItem: Identifiable, Codable {
    // unique ID, no need for external UUID library! 😀
    // When making codable, , you will see a warning that id will not be decoded because we made it a constant and assigned a default value. This is actually the behavior we want, but Swift is trying to be helpful because it’s possible you did plan to decode this value from JSON. To make the warning go away, make the property var instead of let
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
