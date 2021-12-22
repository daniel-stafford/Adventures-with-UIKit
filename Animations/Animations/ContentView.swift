//
//  ContentView.swift
//  Animations
//
//  Created by Daniel Stafford on 12/21/21.
//

import SwiftUI

struct ContentView: View {
    // Because we want to change the scale effect value every time the button is tapped, we need to use an @State property that will store a Double
    @State private var animationAmount = 1.0
    var body: some View {
        Button("Implicit") {
//            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        // Overlays are created using an overlay() modifier, which lets us create new views at the same size and position as the view we’re overlaying.
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .blur(radius: (animationAmount - 1) * 3)
                // That makes a stroked red circle over our button, using an opacity value of 2 - animationAmount so that when animationAmount is 1 the opacity is 1 (it’s opaque) and when animationAmount is 2 the opacity is 0 (it’s transparent).
                .opacity(2 - animationAmount)
                .animation(.easeIn(duration: 1).repeatForever(autoreverses: false), value: animationAmount
                )
        )
        .onAppear {
            animationAmount = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
