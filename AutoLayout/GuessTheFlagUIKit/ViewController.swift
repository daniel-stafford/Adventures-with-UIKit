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

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var turns = 0
    var numQuestions = 5

    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

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
        } else {
            score -= 1
            let tappedFlag = formatCountry(country: countries[sender.tag - 1])
            title = "Wrong. That's the flag of \(tappedFlag)"
        }

        alertTurn(title: title)
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
        let ac = UIAlertController(title: "Game Over", message: "That's it! Your score was \(score) out of \(numQuestions)", preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: resetGame))
        present(ac, animated: true)
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
}
