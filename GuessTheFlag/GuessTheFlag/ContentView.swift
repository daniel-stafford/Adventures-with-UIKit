//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Stafford on 12/17/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Button 1", role: .destructive) {}
            .buttonStyle(.bordered)
            Button("Button 2") {}
            .buttonStyle(.bordered)
            //Important: Apple explicitly recommends against using too many prominent buttons, because when everything is prominent nothing is.
            Button("Button 3") {}
            .buttonStyle(.borderedProminent)
            .tint(.mint)
            Button("Delete Section", role: .destructive, action: runDelete)
            //custom, button This is particularly common when you want to incorporate images into your buttons.
            Button {
                print("Button was tapped")
            } label: {
                Text("Tap Me")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.red)
            }
            Button {
                print("Edit button was tapped")
            } label: {
                Image(systemName: "pencil")
            }
            Button {
                print("Edit button was tapped")
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            //Tip: If you find that your images have become filled in with a color, for example showing as solid blue rather than your actual picture, this is probably SwiftUI coloring them to show that they are tappable. To fix the problem, use the renderingMode(.original) modifier to force SwiftUI to show the original image rather than the recolored version.
            Image(systemName: "pencil").renderingMode(.original)
        }
    }
    func runDelete(){
        print("I am deleting")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
