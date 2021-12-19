//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Daniel Stafford on 12/18/21.
//

import SwiftUI

struct ContentView: View {
   @State private var useRedText = false
    var body: some View {
        VStack {
            Text("Gryffindor")
                // in the case of an enviromental modifier, the child’s modifier overrides.
                .font(.largeTitle)
            Text("Hufflepuff")
                // in the case of a normal modifier, the child's modifier is additive.
                .blur(radius: 0)
            Text("Ravenclaw")
            Text("Slytherin")
        }
        //.Font is an environment modifier, and is different from a regular modifier that is applied to a view.
        .font(.title)
        //blur() is a regular modifier, so any blurs applied to child views are added to the VStack blur rather than replacing it.
        .blur(radius: 5)
        // 👀 To the best of my knowledge there is no way of knowing ahead of time which modifiers are environment modifiers and which are regular modifiers other than reading the individual documentation for each modifier and hope it’s mentioned. Still, I’d rather have them than not: being able to apply one modifier everywhere is much better than copying and pasting the same thing into multiple places.
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

