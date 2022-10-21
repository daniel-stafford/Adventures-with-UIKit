//
//  ContentView.swift
//  BetterRest
//
//  Created by Daniel Stafford on 12/20/21.
//

// alphabetical import is a good idea
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    // a default wake up time somewhere between 6am and 8am is going to be more useful to the vast majority of users.
    // we can make defaultWakeTime a static variable, which means it belongs to the ContentView struct itself rather than a single instance of that struct. This in turn means defaultWakeTime can be read whenever we want, because it doesn’t rely on the existence of any other properties.
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    var body: some View {
        NavigationView {
            Form {
                // remove dividing lines between each view (Text - DatePicker/Stepper)
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4 ... 12, step: 0.25)
                }
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)
                    // challenge convert stepper to picker
                    Picker("", selection: $coffeeAmount) {
                        ForEach(1 ..< 21) { number in
                            number == 1 ? Text("1 cup") : Text("\(number) cups")
                        }
                    }
                }
                Section {
                    Text("Recommended Bedtime:").font(.headline)
                    Text(calculateBedtime())
                        .font(.largeTitle)
                }.multilineTextAlignment(.center)
            }
            .navigationTitle("BetterRest")
        }
    }

    func calculateBedtime() -> String {
        do {
            // unlikely you will need to change the config
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            // That code uses 0 if either the hour or minute can’t be read, but realistically that’s never going to happen so it will result in hour and minute being set to those values in seconds.
            // in seconds
            let hour = (components.hour ?? 0) * 60 * 60
            // in seconds
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            // However, it’s not a helpful value for users – it will be some number in seconds. What we want is to convert that into the time they should go to bed, which means we need to subtract that value in seconds from the time they need to wake up.
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)

            // errors are rare but do catch them
        } catch {
            return "Unavailable"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
