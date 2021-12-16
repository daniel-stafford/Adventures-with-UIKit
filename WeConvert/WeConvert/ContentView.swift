//
//  ContentView.swift
//  WeConvert
//
//  Created by Daniel Stafford on 12/16/21.
//

import SwiftUI

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

struct ContentView: View {
    @FocusState private var quantityIsFocused: Bool
    var units = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    @State private var selectedInputUnit = "Meters"
    @State private var selectedOutputUnit = "Feet"
    @State private var quantity: Double = 0
    var getResult: Double {
        var inputInFeet = 0.0
        let quantityDouble = Double(quantity)
        switch selectedInputUnit {
            case "Meters":
                inputInFeet = quantityDouble * 3.28
            case "Kilometers":
                inputInFeet = quantityDouble * 3281
            case "Yards":
                inputInFeet = quantityDouble / 3
            case "Miles":
                inputInFeet = quantityDouble * 5280
            //case feet
            default:
                inputInFeet = quantityDouble
            }
        var finalConversion = inputInFeet
        switch selectedOutputUnit {
            case "Meters":
                finalConversion = inputInFeet / 3.28
            case "Kilometers":
                finalConversion = inputInFeet / 3281
            case "Yards":
                finalConversion = inputInFeet * 3
            case "Miles":
                finalConversion = inputInFeet / 5280
            //case feet
            default:
                finalConversion = inputInFeet
            }
        return finalConversion
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Quantity", value: $quantity, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($quantityIsFocused)
                } header: {
                    Text("Quantity to be coverted:")
                }
                Section {
                    Picker("Input Unit", selection: $selectedInputUnit){
                        ForEach(units, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("I want to convert from:")
                }
                Section {
                    Picker("Input Unit", selection: $selectedOutputUnit){
                        ForEach(units, id: \.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(.menu)
                } header: {
                    Text("I want to convert to:")
                }
                Section {
                    Text(getResult.formatted())
                } header: {
                    Text("\(quantity.formatted()) \(selectedInputUnit) converted to \(selectedOutputUnit):")
                }
            }
            .navigationTitle("WeConvert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        quantityIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
