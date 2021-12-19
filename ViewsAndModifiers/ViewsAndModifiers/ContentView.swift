//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Daniel Stafford on 12/18/21.
//

import SwiftUI



// Custom modifiers
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

//add extension to make use of custom modifier cleaner
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

//Tip: Often folks wonder when it’s better to add a custom view modifier versus just adding a new method extension to View, and really it comes down to one main reason: custom view modifiers can have their own stored properties, whereas extensions to View cannot.
struct Watermark: ViewModifier {
    //new struct ViewModifier can take a parameter
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("custom modifier")
                .modifier(Title())
            Text("custom modifier with extension").titleStyle()
            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Modifier that creates a new view structure")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

