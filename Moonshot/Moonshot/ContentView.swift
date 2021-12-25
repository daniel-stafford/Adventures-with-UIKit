//
//  ContentView.swift
//  Moonshot
//
//  Created by Daniel Stafford on 12/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0 {
        didSet {
            print("counter", counter)
        }
    }
    var body: some View {
        Button("Up One"){
        counter += 1
        }
        Button("Down") {
            counter -= 1
        }
        Text("Counter\(counter)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
