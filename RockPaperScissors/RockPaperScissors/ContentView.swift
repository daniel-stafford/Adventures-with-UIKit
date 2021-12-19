//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Daniel Stafford on 12/19/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @State var agreedToTerms = false
    @State var agreedToPrivacyPolicy = false
    @State var agreedToEmails = false

    var body: some View {
        // However, notice that the picker is now made using selection: binding – no dollar sign required. We don’t need to explicitly ask for the two-way binding here because it already is one.
        let binding = Binding(
            get: { selection },
            set: { selection = $0 }
        )

        let agreedToAll = Binding(
            get: {
                agreedToTerms && agreedToPrivacyPolicy && agreedToEmails
            },
            set: {
                agreedToTerms = $0
                agreedToPrivacyPolicy = $0
                agreedToEmails = $0
            }
        )
        print(binding)
        return Group {
            VStack {
                Picker("Select a number", selection: binding) {
                    ForEach(0 ..< 3) {
                        Text("Item \($0)")
                    }
                }
                .pickerStyle(.segmented)
            }
            VStack {
                Toggle("Agree to terms", isOn: $agreedToTerms)
                Toggle("Agree to privacy policy", isOn: $agreedToPrivacyPolicy)
                Toggle("Agree to receive shipping emails", isOn: $agreedToEmails)
                Toggle("Agree to all", isOn: agreedToAll)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
