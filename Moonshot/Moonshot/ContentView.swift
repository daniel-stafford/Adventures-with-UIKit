//
//  ContentView.swift
//  Moonshot
//
//  Created by Daniel Stafford on 12/24/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(0 ..< 100) { row in
                NavigationLink {
                    Text("Detail \(row))")
                } label: {
                    Text("Row \(row)")
                }
            }.navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
