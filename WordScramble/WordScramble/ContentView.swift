//
//  ContentView.swift
//  WordScramble
//
//  Created by Daniel Stafford on 12/20/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        TextField("Enter your word", text: $newWord)
                            // default lowercase
                            .autocapitalization(.none)
                        Text("Your score: \(getScore())")
                    }
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Start a New Game") {
                        startGame()
                    }
                }
            }
        }
    }

    func getScore() -> Int {
        var totalScore = 0
        for word in usedWords {
            totalScore = totalScore + Array(word).count
        }
        return totalScore
    }

    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else { return }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isLongEnough(word: answer) else {
            wordError(title: "Word too short", message: "Please use words longer than two characters")
            return
        }

        // very simople animation
        withAnimation {
            // insert at 0 rather than append to avoid new words running off screen
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        // this method will make an instance of UITextChecker, which is responsible for scanning strings for misspelled words.
        let checker = UITextChecker()
        // We’ll then create an NSRange to scan the entire length of our string,
        let range = NSRange(location: 0, length: word.utf16.count)
        // then call rangeOfMisspelledWord() on our text checker so that it looks for wrong words.
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        // get back another NSRange telling us where the misspelled word was found, but if the word was OK the location for that range will be the special value NSNotFound.
        return misspelledRange.location == NSNotFound
    }

    func isLongEnough(word: String) -> Bool {
        !(Array(word).count < 3)
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. Pick one random word, or use "silkworm" as a sensible default (which will never be used)
                rootWord = allWords.randomElement() ?? "silkworm"

                // clear any used words (when starting a new game)
                usedWords = [String]()

                // If we are here everything has worked, so we can exit
                return
            }
        }

        // If were are *here* then there was a problem – trigger a crash and report the error
        // The key to this technique – the thing that stops it from being recklessly dangerous – is knowing when a specific condition ought to be impossible.
        fatalError("Could not load start.txt from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
