//
//  ContentView.swift
//  MultiplyThis
//
//  Created by Daniel Stafford on 12/22/21.
//

import SwiftUI

struct ContentView: View {
    @State private var chosenTable: Double = 2
    @State private var chosenNumQuestions = 5
    @State private var playerScore = 0
    @State private var numAttempts = 1
    @State private var firstNum = 0
    @State private var secondNum = 0
    @State private var correctAnswer = ""
    @State private var playerAnswer = ""
    @State private var showingSettings = true
    @State private var showingGame = false
    @State private var showingEnd = false
    @FocusState private var keyboardFocused: Bool

    let numQuesOpts = [5, 10, 20]

    var body: some View {
        if showingSettings {
            NavigationView {
                VStack {
                    List {
                        Stepper("Tables up to: \(chosenTable.formatted())", value: $chosenTable, in: 2 ... 12)
                        HStack {
                            Text("Number of questions: \(chosenNumQuestions)")
                            Spacer()
                            ForEach(numQuesOpts, id: \.self) { num in
                                Button {
                                    print("\(num) tapped")
                                    chosenNumQuestions = num
                                }
                                label: {
                                    Text("\(num)")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                    HStack {
                        Spacer()
                        Button {
                            print("Let's play tapped")
                            generateQuestion()
                            showingSettings.toggle()
                            showingGame.toggle()
                        }
                        label: {
                            Text("Let's play!")
                        }
                        Spacer()
                    }
                }.navigationTitle("MultiplyThis")
            }
        }
        if showingGame {
            NavigationView {
                VStack {
                    Form {
                        HStack {
                            Text(String(firstNum))
                            Text("*")
                            Text(String(secondNum))
                            Text("=")
                            TextField("???", text: $playerAnswer)
                                .keyboardType(.numberPad)
                                .focused($keyboardFocused)
                        }
                    }
                    Text("Your score: \(playerScore)")
                }
                .navigationTitle("Problem \(numAttempts) of \(chosenNumQuestions)")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            print("playerAnswer", playerAnswer, correctAnswer)
                            if playerAnswer == correctAnswer {
                                playerScore += 1
                            }
                            numAttempts += 1
                            generateQuestion()
                            keyboardFocused = false
                        }
                    }
                }
                //prevent keyboard from pushing up views
                .ignoresSafeArea(.keyboard)
            }
        }
        if showingEnd {
            NavigationView {
                VStack {
                    Text("The game is over")
                    Text("You got \(playerScore) out of \(chosenNumQuestions) questions")
                    Button("Start a New Game") {
                        print(playerScore / chosenNumQuestions)
                        resetGame()
                    }
                }.navigationTitle("Summary")
            }
        }
    }

    func generateQuestion() {
        if numAttempts == chosenNumQuestions {
            endGame()
        }
        let max = Int(chosenTable + 1)
        let num1 = Int.random(in: 1 ..< max)
        let num2 = Int.random(in: 1 ..< max)
        let ansr = num1 * num2
        renderQuestion(num1, num2, ansr)
    }

    func renderQuestion(_ num1: Int, _ num2: Int, _ ansr: Int) {
        firstNum = num1
        secondNum = num2
        correctAnswer = String(ansr)
        playerAnswer = ""
    }

    func endGame() {
        chosenTable = 2.0
        chosenNumQuestions = 5
        playerScore = 0
        numAttempts = 1
        correctAnswer = ""
        playerAnswer = ""
        showingGame.toggle()
        showingEnd.toggle()
    }

    func resetGame() {
        showingEnd.toggle()
        showingSettings.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
