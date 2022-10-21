//
//  Note.swift
//  Notes
//
//  Created by Daniel Stafford on 1/20/22.
//

import UIKit

class Note: NSObject, Codable {
    var createdAt = getCurrentDate()
    var id = UUID()
    var body: String
    
    internal init(body: String) {
        self.body = body
    }
}

func getCurrentDate() -> String {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: today)
}
