//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Stafford on 12/17/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //Tip: When we were using the background() modifier, SwiftUI was able to figure out that .red actually meant Color.red. When we’re using the color as a free-standing view Swift has no context to help it figure out what .red means so we need to be specific that we mean Color.red.
        ZStack{
            VStack (spacing: 0) {
                LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
                LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: .white, location: 0.45),
                    Gradient.Stop(color: .black, location: 0.55),
                ]), startPoint: .top, endPoint: .bottom)
                LinearGradient(gradient: Gradient(stops: [
                     .init(color: .white, location: 0.45),
                     .init(color: .black, location: 0.55),
                 ]), startPoint: .top, endPoint: .bottom)
                RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
                AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
            }
//            Text("ZStack Content")
//                .foregroundStyle(.secondary)
//                .padding(100)
//                .background(.ultraThinMaterial)
        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
