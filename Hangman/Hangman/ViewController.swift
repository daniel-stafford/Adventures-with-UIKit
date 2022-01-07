//
//  ViewController.swift
//  Hangman
//
//  Created by Daniel Stafford on 1/6/22.
//

import UIKit

extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}

class ViewController: UIViewController {
    var mistakesLeft = 7 {
        didSet {
            mistakesLeftLabel.text = "Mistakes Remaining: \(mistakesLeft)"
        }
    }

    var answer = [String]()
    var maskedAnswer = [String]()
    var titleLabel: UILabel!
    var letterButton: UILabel!
    var letterButtons = [UIButton]()
    var answerLabel: UILabel!
    var mistakesLeftLabel: UILabel!

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.systemBackground

        // get 1000 words from API
        // store words in an array, shuffle it
        // pop the last one, take string, turn into array, set to answer

        answer = ["A", "P", "P", "L", "E"]

        createAnswerLabelText(answer)

        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Hangman"
        titleLabel.textColor = .none
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        view.addSubview(titleLabel)

        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = UIFont.systemFont(ofSize: 40)
        answerLabel.textColor = .none
        answerLabel.text = maskedAnswer.joined(separator: "")
        view.addSubview(answerLabel)

        mistakesLeftLabel = UILabel()
        mistakesLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        mistakesLeftLabel.font = UIFont.systemFont(ofSize: 25)
        mistakesLeftLabel.textColor = .none
        mistakesLeftLabel.text = "Mistakes remaining: \(mistakesLeft)"
        view.addSubview(mistakesLeftLabel)

        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(buttonsView)

        let dimension = 51
        let width = dimension
        let height = dimension

        for row in 0 ..< 4 {
            for col in 0 ..< 7 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 46)
                letterButton.setTitle("X", for: .normal)

                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }

        let alphabet = "abcdefghijklmnopqrstuvwxyz"
        for (i, char) in alphabet.uppercased().enumerated() {
            letterButtons[i].setTitle(String(char), for: .normal)
        }

        // hide and disable buttons beyond the 26 letter alphabet
        for i in 26 ..< 28 {
            letterButtons[i].isEnabled = false
            letterButtons[i].isHidden = true
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            answerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 150),
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            mistakesLeftLabel.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 150),
            mistakesLeftLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            buttonsView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc func letterTapped(_ sender: UIButton) {
        guard let guessedLetter = sender.titleLabel?.text else { return }

        if answer.contains(guessedLetter) {
            let foundIndices = answer.indexes(of: guessedLetter)

            for (i, _) in maskedAnswer.enumerated() {
                if foundIndices.contains(i) {
                    maskedAnswer[i] = guessedLetter
                    answerLabel.text = maskedAnswer.joined(separator: "")
                }
            }
        } else {
            mistakesLeft -= 1
            if mistakesLeft == 0 {
                let ac = UIAlertController(title: "You lose!", message: "Go ahead and try again.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
                // reset game
            }
        }
        sender.isHidden = true
    }

    func correctAnswer() {
        print("Noice!")
    }

    func createAnswerLabelText(_ anwswer: [String]) {
        for _ in answer {
            maskedAnswer.append("?")
        }
    }
}
