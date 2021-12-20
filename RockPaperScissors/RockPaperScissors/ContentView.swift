//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Daniel Stafford on 12/19/21.
//

import SwiftUI


struct ContentView: View {
    private var objects = ["rock", "paper", "scissors"]
    @State private var randomObj = Int.random(in: 0 ..< 3)
    @State private var isSummaryShown = false
    @State private var shouldWin = Bool.random()
    @State private var playerChoice = ""
    @State private var playerScore = 0
    @State private var totalTurns = 0
    private var numQuestions = 8

    var body: some View {
        return VStack {
            VStack{
                Spacer()
                Text(shouldWin ? "Win Against" : "Lose Against").fontWeight(.bold).font(.largeTitle)
                Image(objects[randomObj]).resizable().frame(width: 200, height: 200)
                Spacer()
            }
            HStack {
                ForEach(objects, id: \.self) { object in
                    Button {
                        choiceTapped(object)
                    }
                    label: {
                        Image(object)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)


                    }
                }
            }
            Spacer()
            Text("Your score: \(playerScore)").font(.largeTitle).padding(70)

        }.alert("Game Over", isPresented: $isSummaryShown) {
            Button("OK", action: resetGame)
        } message: {
            Text("Your total score is \(playerScore).")
        }
    }

    func choiceTapped(_ playerChoice: String) {
        var isCorrect = false
        let object = objects[randomObj]
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
        randomObj = Int.random(in: 0 ..< 3)
    }

    func checkTurns() {
        print("totalTurns")
        print(totalTurns)
        if totalTurns == numQuestions { isSummaryShown.toggle() }
    }

    func resetGame() {
        shouldWin = Bool.random()
        getRandomObject()
        playerScore = 0
        totalTurns = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
