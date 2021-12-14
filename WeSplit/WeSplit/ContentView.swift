//
//  ContentView.swift
//  WeSplit
//
//  Created by Daniel Stafford on 12/14/21.
//

import SwiftUI

//. View comes from SwiftUI, and is the basic protocol that must be adopted by anything you want to draw on the screen – all text, buttons, images, and more are all views, including your own layouts that combine other views.
//The View protocol has only one requirement, which is that you have a computed property called body that returns some View.
struct ContentView: View {
    //var body: some View < - defines a new computed property called body with type some View. This means it will return something that conforms to the View protocol, which is our layout. Behind the scenes this will actually result in a very complicated data type being returned based on all the things in our layout, but some View means we don’t need to worry about that.
    var body: some View {
        //Text views are simple pieces of static text that get drawn onto the screen, and will automatically wrap across multiple lines as needed.
        Text("This is a change")
        //This is what Swift calls a modifier, which are regular methods with one small difference: they always return a new view that contains both your original data, plus the extra modification you asked for. In our case that means body will return a padded text view, not just a regular text view.
            .padding()
    }
}

//. This piece of code won’t actually form part of your final app that goes to the App Store, but is instead specifically for Xcode to use so it can show a preview of your UI design alongside your code.
//You can customize the preview code if you want, and they will only affect the way the canvas shows your layouts – it won’t change the actual app that gets run.
// 👀 Option+Cmd+P does the same as clicking Resume.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
