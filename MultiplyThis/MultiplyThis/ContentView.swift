//
//  ContentView.swift
//  MultiplyThis
//
//  Created by Daniel Stafford on 12/22/21.
//

import SwiftUI

struct ButtonBasic: View {
    var text: String
    var function: () -> Void
    var body: some View {
        Button(text) {
            function()
        }
    }
}

struct MegaBig: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 60))

    }
}

extension View {
    func megaBigStyle() -> some View {
        modifier(MegaBig())
    }
}

struct ContentView: View {
    @State private var chosenTable: Double = 2
    @State private var chosenNumQuestions = 5
    @State private var playerScore = 0
    @State private var numAttempts = 1
    @State private var firstNum = 0
    @State private var secondNum = 0
    @State private var correctAnswer = ""
    @State private var playerAnswer = ""
    @State private var showingSettings = false
    @State private var showingGame = true
    @State private var showingEnd = false
    @State private var animationAmount = 0.0
    @FocusState private var keyboardFocused: Bool

    let numQuesOpts = [5, 10, 20]

    var body: some View {
        if showingSettings {
            NavigationView {
                VStack {
                    List {
                        Stepper("Tables up to: \(chosenTable.formatted())", value: $chosenTable, in: 2 ... 12)
                            .font(.headline)
                        HStack {
                            Text("Number of questions: \(chosenNumQuestions)")
                            Spacer()
                            ForEach(numQuesOpts, id: \.self) { num in
                                ButtonBasic(text: String(num), function: { chosenNumQuestions = num })
                                    .buttonStyle(BorderlessButtonStyle())
                                    .padding(20)
                                    .background(.blue)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                        }
                    }.padding(.top, 200)
                    HStack {
                        Spacer()
                        ButtonBasic(text: "Let's Play", function: {
                            generateQuestion()
                            showingSettings.toggle()
                            showingGame.toggle()

                        })
                            .padding(50)
                            .background(.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                        Spacer()
                    }
                    Spacer()
                }.navigationTitle("MultiplyThis")
            }
        }
        if showingGame {
            NavigationView {
                VStack {
                    Form {
                        HStack {
                            Text(String(firstNum)).megaBigStyle()
                            Text("*").megaBigStyle()
                            Text(String(secondNum)).megaBigStyle()
                            Text("=").megaBigStyle()
                            TextField("???", text: $playerAnswer)
                                .megaBigStyle()
                                .keyboardType(.numberPad)
                                .focused($keyboardFocused)
                        }
                    }.padding(.top, 100)
                    Text("Score: \(playerScore)").megaBigStyle().padding(.bottom, 10)
                }
                .navigationTitle("Problem \(numAttempts) of \(chosenNumQuestions)")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            if playerAnswer == correctAnswer {
                                playerScore += 1
                            }
                            numAttempts += 1
                            generateQuestion()
                            keyboardFocused = false
                        }
                    }
                }
                // prevent keyboard from pushing up views
                .ignoresSafeArea(.keyboard)
            }
        }
        if showingEnd {
            NavigationView {
                VStack {
                    Text("You got \(playerScore) out of \(chosenNumQuestions) questions correct.").padding(20).font(.largeTitle).padding(.top, 50)
                    Spacer()
                    ButtonBasic(text: "Start a New Game", function: resetGame)
                        .padding(100)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .padding(.bottom, 100)
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
