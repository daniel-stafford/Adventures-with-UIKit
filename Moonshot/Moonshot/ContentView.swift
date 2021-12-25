//
//  ContentView.swift
//  Moonshot
//
//  Created by Daniel Stafford on 12/24/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { Geo in
            Image("xmas")
                .resizable()
                .scaledToFit().frame(width: Geo.size.width * 0.8)
                .frame(width: Geo.size.width, height: Geo.size.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
