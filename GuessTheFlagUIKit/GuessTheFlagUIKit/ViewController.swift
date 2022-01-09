//
//  ViewController.swift
//  UIKitPreview
//
//  Created by Daniel Stafford on 12/30/21.
//

import SwiftUI
import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var buttons: [UIButton]!
    // not sure why this isn't appearing 😕
    @IBOutlet var scoreText: UILabel!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var turns = 0
    var numQuestions = 5
    var highScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard

        if let avedHighScore = defaults.object(forKey: "highScore") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                highScore = try jsonDecoder.decode(Int.self, from: avedHighScore)
                print("high score loaded", highScore)
            } catch {
                print("Failed to load high score")
            }
        }

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        if score == 0 { scoreText.text = "Your score: 0" }
        askQuestion()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))
    }

    // UIAlertAction! = nil, force unwrap and set to nil, allows askQuestion() to work without writing askQuestion(action:nil)
    func askQuestion(action: UIAlertAction! = nil) {
        turns += 1

        countries.shuffle()

        correctAnswer = Int.random(in: 0 ... 2)

        getTitle()
        for (index, button) in buttons.enumerated() {
            button.layer.borderWidth = 1
            button.setImage(UIImage(named: countries[index]), for: .normal)
        }
    }

    func formatCountry(country: String) -> String {
        var result = ""

        if country == "us" { result = "The United States" }
        else if country == "uk" { result = "The United Kingdom" } else {
            result = country.capitalized
        }
        return result
    }

    func getTitle() {
        let country = formatCountry(country: countries[correctAnswer])

        title = "\(country) (current score: \(score))"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag - 1 == correctAnswer {
            score += 1
            title = "Correct"
            print("score", score)
            print("highscore", highScore)
        } else {
            score -= 1
            let tappedFlag = formatCountry(country: countries[sender.tag - 1])
            title = "Wrong. That's the flag of \(tappedFlag)"
        }

        scoreText.text = "Your score: \(score)"

        alertTurn(title: title)
    }

    func checkHighScore(action: UIAlertAction! = nil) {
    }

    func alertHighScore() {
        let ac = UIAlertController(title: "High score", message: "Great job. That's a new high score!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: checkTurns))
        present(ac, animated: true)
    }

    func checkTurns(action: UIAlertAction! = nil) {
        if turns == numQuestions {
            alertSummary()
        } else {
            askQuestion()
        }
    }

    func alertTurn(title: String) {
        let ac = UIAlertController(title: title, message: "Your score is now \(score)", preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: checkTurns))
        present(ac, animated: true)
    }

    func alertSummary() {
        if score > highScore {
            highScore = score
            save()
            let ac = UIAlertController(title: "Game Over", message: "Congrats! Your score of \(score) is a new high score!", preferredStyle: .alert)

            ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: resetGame))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Game Over", message: "That's it! Your score was \(score) out of \(numQuestions)", preferredStyle: .alert)

            ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: resetGame))
            present(ac, animated: true)
        }
    }

    func resetGame(action: UIAlertAction! = nil) {
        score = 0

        turns = 0

        askQuestion()
    }

    @objc func sharedTapped() {
        // Share the app challenge👍
        let vc = UIActivityViewController(activityItems: ["Hey, I scored \(score) on the Guess the Flag app!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    func save() {
        print("saving")
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(highScore) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "highScore")
        } else {
            print("Failed to save high score.")
        }
    }
}
