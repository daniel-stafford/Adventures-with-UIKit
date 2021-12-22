//
//  ContentView.swift
//  Animations
//
//  Created by Daniel Stafford on 12/21/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingRed = false
    var body: some View {
        VStack {
            Button("Tap Me") {
                // We can get SwiftUI’s default view transition by wrapping the state change using withAnimation(), like this:
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    // the app now fades the red rectangle in and out, while also moving the button up to make space. It looks OK, but we can do better with the transition() modifier.
//                    .transition(.scale)
                    // . A useful one is .asymmetric, which lets us use one transition when the view is being shown and another when it’s disappearing. 
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
