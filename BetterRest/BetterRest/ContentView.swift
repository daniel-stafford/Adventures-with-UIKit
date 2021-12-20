//
//  ContentView.swift
//  BetterRest
//
//  Created by Daniel Stafford on 12/20/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    var body: some View {
        Text("Dates are hard!")
    }

    func exampleDates() {
        // create a second Date instance set to one day in seconds from now
        // issue with tomorrow is that not all days have 86400 seconds
        // hence use iOS' Date API
        let tomorrow = Date.now.addingTimeInterval(86400)
        var components = DateComponents()
        // we want to say “give me an 8am wake up time, regardless of what day it is today.”
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? Date.now
        // The second challenge is how we could read the hour they want to wake up. Remember, DatePicker is bound to a Date giving us lots of information, so we need to find a way to pull out just the hour and minute components.
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
       // we still need to unwrap the optionals or provide default values.
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        // using format
        //get time from a date
        Text(Date.now, format: .dateTime.hour().minute())
        //get day, month, year, from date
        Text(Date.now, format: .dateTime.day().month().year())
        //use format directly
        Text(Date.now.formatted(date: .long, time: .shortened))
    }
     
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
