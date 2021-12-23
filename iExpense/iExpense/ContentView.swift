//
//  ContentView.swift
//  iExpense
//
//  Created by Daniel Stafford on 12/23/21.
//

import SwiftUI

//Codable allows for archiving
struct User: Codable {
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCount2 = 0

    var body: some View {
        Button("Save User") {
            //use endcoder for writing, decoder for getting
            let encoder = JSONEncoder()
            //writing the data direcctly rather than going through @AppStorage, which can only hold simple data
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
        
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")

        }
        Button("Tap count: \(tapCount2)") {
            tapCount2 += 1
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
