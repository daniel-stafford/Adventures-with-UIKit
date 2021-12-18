//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Daniel Stafford on 12/18/21.
//

import SwiftUI

struct ContentView: View {
    //merely using View has a hole in it, like saying an array.  Do you mean array of strings? Swift wants to know what's inside the view.  If only text, you could have var body: Text
    //We don't want to write <ModifiedContent<ModifiedContent> blah bllah, it's simply too painful
    var body: some View {
//        Text("Hello, world!")
        //in a VStack Swift uses TupleView, which contains two views inside behind the scnes
        //e.g.  hold two views -> public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> TupleView<(C0, C1)> where C0 : View, C1 : View
        // e.g. tuple that can hold 10 max ->  public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View, C9 : View
        //why SwiftUI has a 10 item limit. 😎
//        VStack {
//            Text("Hello")
//            Text("Hello")
        
       //in the case of four text items, Swift uses ViewBuilder to create a view tuple (again, up to 10), so we're not sending back four things but rather one (tuple)
        Text("Hello")
        Text("Hello")
        Text("Hello")
        Text("Hello")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

