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
//    let pets = ["Dog", "Cat", "Fish"]
//    @State private var selectedPet = "Dog"
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount: Double = 0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    // TODO: figure out way to make currency format as computed property
//    var getCurrency: FloatingPointFormatStyle<Double>.Currency = {
//        currency(code:Locale.current.currencyCode ?? "USD"))
//    }
    let tipPercentages = [Int](0..<101)
    //computed property <- use function naming convention? ❔
    var getTotalPerPerson: Double {checkAmount / (Double(numberOfPeople) + 2.0) + (checkAmount * (Double(tipPercentage) / 100))
    }
    var getTotalAmount: Double {Double(checkAmount) + (checkAmount * Double(tipPercentage) / 100)
    }
    
    var body: some View {
        //allow picker to open a new view
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code:Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Cost of meal")
                }
                
                Section {
                    //declarative user interface design.
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<10) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("How much do you want to tip?")
                }
                Section {
                    Text(getTotalPerPerson, format:
                    .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Each person's contribution:")
                }
                Section {
                    Text(getTotalAmount, format:
                    .currency(code: Locale.current.currencyCode ?? "USD"))
                        //conditional modifier for day 24 😁
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total Cost")
                }

            }.navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            //The toolbar() modifier lets us specify toolbar items for a view. These toolbar items might appear in various places on the screen – in the navigation bar at the top, in a special toolbar area at the bottom, and so on.
            .toolbar {
                //ToolbarItemGroup lets us place one or more buttons in a specific location, and this is where we get to specify we want a keyboard toolbar – a toolbar that is attached to the keyboard, so it will automatically appear and disappear with the keyboard.
                ToolbarItemGroup(placement: .keyboard) {
                    //push Done button to the right
                    Spacer()
                    //The Button view we’re using here displays some tappable text, which in our case is “Done”. We also need to provide it with some code to run when the button is pressed, which in our case sets amountIsFocused to false so that the keyboard is dismissed.
                    Button("Done"){
                        amountIsFocused = false
                }
            }
        }
            //Tip: It’s tempting to think that modifier, navigationTitle, should be attached to the end of the NavigationView, but it needs to be attached to the end of the Form instead. The reason is that navigation views are capable of showing many views as your program runs, so by attaching the title to the thing inside the navigation view we’re allowing iOS to change titles freely.
    }
        //        NavigationView {
//            Form {
//                Picker("Select your pet", selection: $selectedPet){
//                    /\.self <- means “the strings themselves are uniqu
//                    ForEach(pets, id: \.self) {
//                        Text($0)
//                    }
//                }
//            }
//        }
    
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
