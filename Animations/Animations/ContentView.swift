//
//  ContentView.swift
//  Animations
//
//  Created by Daniel Stafford on 12/21/21.
//

import SwiftUI

struct ContentView: View {
    @State private var enabled = false

    var body: some View {
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        // important to fill background before clipShape 😁
        .background(enabled ? .blue : .red)
        //  For even more control, it’s possible to disable animations entirely by passing nil to the modifier. For example, you might want the color change to happen immediately but the clip shape to retain its animation, in which case you’d write this:
        .animation(nil, value: enabled)
//        .animation(.default, value: enabled)
        .foregroundColor(.white)
        // create another animiation to affect modifier after the previous animation
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
