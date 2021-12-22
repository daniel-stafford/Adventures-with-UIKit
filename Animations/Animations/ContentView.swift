//
//  ContentView.swift
//  Animations
//
//  Created by Daniel Stafford on 12/21/21.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Explicit Animiation") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(100)
        .background(.green)
        .foregroundColor(.white)
        .clipShape(Circle())
        // explicit animation
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
