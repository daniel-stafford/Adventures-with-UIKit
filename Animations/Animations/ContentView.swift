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
        Button("Implicit"){
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        // What we want is for that button to get bigger every time it’s tapped, and we can do that with a new modifier called scaleEffect(). You provide this with a value from 0 up, and it will be drawn at that size – a value of 1.0 is equivalent to 100%, i.e. the button’s normal size.
        .scaleEffect(animationAmount)
        // we can ask SwiftUI to create an implicit animation for our changes so that all the scaling happens smoothly by adding an animation() modifier to the button:
        // apply a default animation whenever the value of animationAmount changes, and immediately you’ll see that tapping the button now causes it to scale up with an animation.
        // That implicit animation takes effect on all properties of the view that change, meaning that if we attach more animating modifiers to the view then they will all change together.
        .animation(.default, value: animationAmount)
        // A radius of (animationAmount - 1) * 3 means the blur raggio will start at 0 (no blur), but then move to 3 points, 6 points, 9 points, and beyond as you tap the button.
        .blur(radius: (animationAmount - 1) * 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
