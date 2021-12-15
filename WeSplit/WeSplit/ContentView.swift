//
//  ContentView.swift
//  WeSplit
//
//  Created by Daniel Stafford on 12/15/21.
//

import SwiftUI

//struct ContentView: View {
//    let pets = ["Cat", "Fish", "Dog"]
//    @State private var selectedPet = "Dog"
////     @State private var dob = ""
//    //  Cant use mutating as this is a property. @State, a property wrapper,eeeeeeeee is specifically designed for simple properties that are stored in one view.
////    @State private var tapCount = 0
//
  
struct ContentView: View {
    let pets = ["Dog", "Cat", "Fish"]
    @State private var selectedPet = "Dog"

    var body: some View {
        NavigationView {
            Form {
                Picker("Select your pet", selection: $selectedPet){
                    //\.self <- means “the strings themselves are uniqu
                    ForEach(pets, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
    
//        NavigationView {
//            Form {
//                //when you see a dollar sign before a property name, it creates a two-way binding: the value of the property is read, but also written.
//                Section {
//                    TextField("s", text: $dob)
//                }
//                Section {
//                    Text("Your birthday is\(dob)")
//                }
//            }
//            .navigationTitle("Binding state to user interface controls")
//            .navigationBarTitleDisplayMode(.inline)
//        }
        
//        Button("Tap Count: \(tapCount)") {
//            tapCount += 1
//        }
        
        //give a title to a page
//        NavigationView {
//            Form {
//                //can use groups (10+ items) or sections in a form
//                Section {
//                    Text("This is a form")
//                }
//            }
//            //navigationTitle belongs to form
//            .navigationTitle("SwiftUI")
//            //more compact title
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
    }
}

//this is used for canvas but not used when deployed
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
