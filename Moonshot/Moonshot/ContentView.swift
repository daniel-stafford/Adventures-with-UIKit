//
//  ContentView.swift
//  Moonshot
//
//  Created by Daniel Stafford on 12/24/21.

import SwiftUI

struct ContentView: View {
    let astronaunts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        let _ = print(missions.count)
        Text("Ther are \(astronaunts.count)")
    }
}

//

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

