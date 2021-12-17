//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Stafford on 12/17/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isAlertShown = false
    
    var body: some View {
        Button("Show Alert"){
            isAlertShown = true
        }
        .alert("This is the alert header", isPresented: $isAlertShown){
//            That’s an empty closure, meaning that we aren’t assigning any functionality to run when the button is pressed. That doesn’t matter, though, because any button inside an alert will automatically dismiss the alert – that closure is there to let us add any extra functionality beyond just dismissing the alert.
//            Button("Thanks"){}
            Button("Delete", role:.destructive){}
            Button("Ceancel", role: .cancel){}
        } message: {
            Text("This is the alert text")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
