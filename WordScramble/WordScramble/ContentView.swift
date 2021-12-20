//
//  ContentView.swift
//  WordScramble
//
//  Created by Daniel Stafford on 12/20/21.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        Button("Press me") {
            getText()
        }
    }

    func getText() {
        //chopping up strings, trimming, etc.
        let input = "a b c"
        let letters = input.components(separatedBy: " ")
        print(letters)
        let input2 = """
        a
        b
        c
        """
        let letters2 = input2.components(separatedBy: "\n")
        print(letters2)
        let letter = letters2.randomElement() ?? "a"
        let trimmed = letter.trimmingCharacters(in: .whitespacesAndNewlines)
        print(trimmed)
        
        //spell check
        let word = "swift"
        let checker = UITextChecker()
        print(checker)
        
        let range = NSRange(location: 0, length: word.utf16.count)
        print(range)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        print(misspelledRange)
        // NSNotFound is an empty optional i.e. no spelling mistakes
        let allGood = misspelledRange.location == NSNotFound
        print(allGood)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
