//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Daniel Stafford on 12/18/21.
//

import SwiftUI

// let us create any number of views inside a fixed grid.
// The first line – struct GridStack<Content: View>: View – uses a more advanced feature of Swift called generics, which in this case means “you can provide any kind of content you like, but whatever it is it must conform to the View protocol.” After the colon we repeat View again to say that GridStack itself also conforms to the View protocol.
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    // closure that must be able to accept two integers and return some sort of content we can show.
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        GridStack(rows: 3, columns: 4, content: { row, col in
            Text("R\(row), C\(col)")
        }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
