//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Daniel Stafford on 12/18/21.
//

import SwiftUI

struct ContentView: View {
    //keeping views outside of the body = cleaner code
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    //you can create computed properties
    //Swift won’t automatically apply the @ViewBuilder attribute here, so if more than one view, change technique
    var motto3: some View {
        Text("Blah blah")
    }
    var spells: some View {
        //can place them in a stack
        VStack {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    //can also place in a group
    var spells2: some View {
        //will ineherit whatever stack inside of (e.g. VStack from body below)
        Group {
            Text("Stuff")
            Text("Other stuff")
        }
    }
    //I prefer to use @ViewBuilder because it mimics the way body works
    //Will wrap in tuple
    //Don't make too complex
    @ViewBuilder var spells3: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    
    var body: some View {
        VStack {
            motto1
                //can modify
                .foregroundColor(.red)
            motto2
                .foregroundColor(.blue)
            motto3
            spells
            spells2
            spells3
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

