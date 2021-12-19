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
        Button("Hello World"){
            useRedText.toggle()
        }
        //tenary more efficient than if (if clause creates two different Button views)
        .foregroundColor(useRedText ? .red : .yellow)
        // Sometimes using if statements are unavoidable, but where possible prefer to use the ternary operator instead.
        if useRedText {
        Button("Hello World") {
            useRedText.toggle()
        }
        .foregroundColor(.red)
        } else {
            Button("Hello World") {
                useRedText.toggle()
            }
            .foregroundColor(.blue)
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

