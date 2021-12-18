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
    @State private var scoreAlertTitle = ""
    @State private var playerScore = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain","UK", "US" ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {
//        Self._printChanges()
//        print("Scoreshown", self._isScoreAlertShown, "ScoreTitle", scoreAlertTitle, "countries", countries)
        
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
                    .border(Color.green)
                Spacer()
            }
            .padding()
        }.alert(scoreAlertTitle, isPresented: $isScoreAlertShown){
            Button("Continue", action: askNewQuestion)
        } message: {
            Text("Your score is \(playerScore)")
    }
}
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            playerScore += 1
            scoreAlertTitle = "Correct"
        } else {
            scoreAlertTitle = "Wrong"
        }
        isScoreAlertShown = true
    }
    
    func askNewQuestion(){
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0..<3)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
