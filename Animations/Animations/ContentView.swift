//
//  ContentView.swift
//  Animations
//
//  Created by Daniel Stafford on 12/21/21.
//

import SwiftUI

struct ContentView: View {
    let letters = Array("Ciao SwiftUI")
    @State private var enabled = false
    // First, we need some state to store the amount of their drag:
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< letters.count) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .foregroundColor(enabled ? .blue : .red)
                    // SwiftUI gives us a dedicated modifier for this called offset(), which lets us adjust the X and Y coordinate of a view without moving other views around it. You can pass in discrete X and Y coordinates if you want to, but – by no mere coincidence – offset() can also take a CGSize directly.
                    .offset(dragAmount)
                    // add an implicit animation that will animate the drag and the release
                    .animation(.default.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            // Drag gestures have two extra modifiers that are useful to us here: onChanged() lets us run a closure whenever the user moves their finger, and onEnded() lets us run a closure when the user lifts their finger off the screen, ending the drag.
            DragGesture()
                // For our onChanged() modifier we’re going to read the translation of the drag, which tells us how far it’s moved from the start point – we can assign that directly to dragAmount so that our view moves along with the gesture.
                .onChanged { dragAmount = $0.translation }
                // For onEnded() we’re going to ignore the input entirely, because we’ll be setting dragAmount back to zero.
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                    // explicit animiation
//                    withAnimation(.spring()) {
//                         dragAmount = .zero
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
