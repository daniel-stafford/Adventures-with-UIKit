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
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4 ... 12, step: 0.25)
        // Now, you might think that label looks ugly, and try replacing it with this:
        DatePicker("Please enter a date", selection: $wakeUp)
        // But if you do that you now have two problems: the date picker still makes space for a label even though it’s empty, and now users with the screen reader active (more familiar to us as VoiceOver) won’t have any idea what the date picker is for.
        DatePicker("", selection: $wakeUp)
        // That still includes the original label so screen readers can use it for VoiceOver, but now they aren’t visible onscreen any more – the date picker won’t be pushed to one side by some empty text.
        DatePicker("Please enter a date", selection: $wakeUp)
            .labelsHidden()
        // Date pickers provide us with a couple of configuration options that control how they work. First, we can use displayedComponents to decide what kind of options users should see:
        //        If you don’t provide this parameter, users see a day, hour, and minute.
        //        If you use .date users see month, day, and year.
        //        If you use .hourAndMinute users see just the hour and minute components.
        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
        ///  //Finally, there’s an in parameter that works just the same as with Stepper: we can provide it with a date range, and the date picker will ensure the user can’t select beyond it.
        /// One side range <- Date.now...>
        DatePicker("Please enter a date", selection: $wakeUp, in: Date.now... , displayedComponents: .date)
    }

    //    Now, we’ve been using ranges for a while now, and you’re used to seeing things like 1...5 or 0..<10, but we can also use Swift dates with ranges. For example:
    func exampleDates() {
        // create a second Date instance set to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)
        // create a range from those two
        let range = Date.now ... tomorrow
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
