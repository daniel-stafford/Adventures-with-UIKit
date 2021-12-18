//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Stafford on 12/17/21.
//

import SwiftUI

var backgroundTop = Color(red: 0.1, green: 0.2, blue: 0.45)
var backgroundBottom = Color(red: 0.76, green: 0.15, blue: 0.26)

struct ContentView: View {
    @State private var isScoreAlertShown = false
    @State private var isSummaryShown = false
    @State private var scoreAlertTitle = ""
    @State private var summaryAlertTitle = ""
    @State private var playerScore = 0
    @State private var playerTurns = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain","UK", "US" ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    var lengthOfGame = 5

    var body: some View {
        // Self._printChanges()
        return ZStack{
            LinearGradient(gradient: Gradient(colors: [backgroundTop, backgroundBottom]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))}
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        }
                            label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(playerScore)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                Spacer()
            }
            .padding()
        }.alert(scoreAlertTitle, isPresented: $isScoreAlertShown){
            Button("Continue", action: askNewQuestion)
        } message: {
            Text("Your score is \(playerScore)")
        }
        .alert(summaryAlertTitle, isPresented: $isSummaryShown) {
            Button("Start over", action: resetGame)
        } message: {
           Text("You got \(playerScore) out of \(lengthOfGame) correct.")
        }
}

    func flagTapped(_ number: Int){
        if number == correctAnswer {
            playerScore += 1
            scoreAlertTitle = "Correct."
        } else {
            scoreAlertTitle = "Wrong! That's the flag of \(countries[number])"
        }
        isScoreAlertShown.toggle()
        playerTurns += 1
    }

    func askNewQuestion(){
        if playerTurns == lengthOfGame {
            summaryAlertTitle = "Game over"
            isSummaryShown.toggle()
        } else {
            shuffleCountries()
        }
    }

    func resetGame(){
        shuffleCountries()
        playerTurns = 0
        playerScore = 0
    }

    func shuffleCountries(){
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0..<3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
