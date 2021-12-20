//
//  ContentView.swift
//  WordScramble
//
//  Created by Daniel Stafford on 12/20/21.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        Section {
            List(people, id: \.self) {
                Text($0)
            }.listStyle(.grouped)
            List {
                Text("Static Row")
                ForEach(people, id: \.self) {
                    Text($0)
                }
                Text("Static Row")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
