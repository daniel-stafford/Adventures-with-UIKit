//
//  ContentView.swift
//  Moonshot
//
//  Created by Daniel Stafford on 12/24/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(0 ..< 100) { item in
                    Text("Item #\(item)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
