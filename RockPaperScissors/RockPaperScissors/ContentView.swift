//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Daniel Stafford on 12/19/21.
//

import SwiftUI

var objects = ["rock", "paper", "scissors"]

struct ContentView: View {
    @State private var isSummaryShown = false
    @State private var object = objects[Int.random(in: 0 ..< objects.count)]
    @State private var shouldWin = Bool.random()
    @State private var playerChoice = ""
    @State private var playerScore = 0
    @State private var totalTurns = 0
    private var numQuestions = 4

    var body: some View {
        return VStack {
            Text(object)
            Text(shouldWin ? "Win" : "Lose")
            HStack {
                ForEach(objects, id: \.self) { object in
                    Button {
                        choiceTapped(object)
                    }
                    label: {
                        Image(object).resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(12)
                    }
                }
            }
            Text("Your score: \(playerScore)")
        }.alert("Game Over", isPresented: $isSummaryShown) {
            Button("OK", action: resetGame)
        } message: {
            Text("Your total score is \(playerScore).")
        }
    }

    func choiceTapped(_ playerChoice: String) {
        var isCorrect = false
        if (object == "rock" && shouldWin && playerChoice == "paper") ||
            (object == "rock" && !shouldWin && playerChoice == "scissors") ||
            (object == "paper" && shouldWin && playerChoice == "scissors") ||
            (object == "paper" && !shouldWin && playerChoice == "rock") ||
            (object == "scissors" && shouldWin && playerChoice == "rock") ||
            (object == "scissors" && !shouldWin && playerChoice == "paper")
        {
            isCorrect.toggle()
        }
        if isCorrect { playerScore += 1 } else { playerScore -= 1 }
        shouldWin.toggle()
        getRandomObject()
        totalTurns += 1
        checkTurns()
    }

    func getRandomObject() {
        object = objects[Int.random(in: 0 ..< objects.count)]
    }

    func resetGame() {
        shouldWin = Bool.random()
        getRandomObject()
        playerScore = 0
        totalTurns = 0
    }

    func checkTurns() {
        print("totalTurns")
        print(totalTurns)
        if totalTurns == numQuestions { isSummaryShown.toggle() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
