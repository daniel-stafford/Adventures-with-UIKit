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
    var allPokemon = [Pokemon]()
    var answer = [String]() {
        didSet {
            print("answer", answer)
        }
    }

    var maskedAnswer = [String]()
    var titleLabel: UILabel!
    var letterButton: UILabel!
    var letterButtons = [UIButton]()
    var answerLabel: UILabel!
    var mistakesLeftLabel: UILabel!
    var mistakesLeft = 7 {
        didSet {
            mistakesLeftLabel.text = "Mistakes Remaining: \(mistakesLeft)"
        }
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.systemBackground

        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Guess That Pokemon!"
        titleLabel.textColor = .none
        titleLabel.font = UIFont.boldSystemFont(ofSize: 35)
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

        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=100"

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self?.parse(json: data)
                    return
                }
            }
            self?.showError()
        }
    }

    @objc func letterTapped(_ sender: UIButton) {
        guard let guessedLetter = sender.titleLabel?.text else { return }

        if answer.contains(guessedLetter) {
            let foundIndices = answer.indexes(of: guessedLetter)

            for (i, _) in maskedAnswer.enumerated() {
                if foundIndices.contains(i) {
                    maskedAnswer[i] = guessedLetter
                    answerLabel.text = maskedAnswer.joined(separator: "")
                    if !maskedAnswer.contains("?") {
                        let ac = UIAlertController(title: "You win!", message: "Well done. Let's try another word", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        present(ac, animated: true)
                        resetGame()
                    }
                }
            }
        } else {
            mistakesLeft -= 1
            if mistakesLeft == 0 {
                let ac = UIAlertController(title: "You lose!", message: "Go ahead and try again.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
                resetGame()
                return
            }
        }
        sender.isHidden = true
    }

    func createAnswerLabelText(_ anwswer: [String]) {
        maskedAnswer = [String]()
        for _ in answer {
            maskedAnswer.append("?")
        }
        DispatchQueue.main.async { [weak self] in
            self?.answerLabel.text = self?.maskedAnswer.joined(separator: "")
        }
    }
    

    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Pokemons.self, from: json) {
            allPokemon = jsonPetitions.results
            var shuffled = allPokemon.shuffled()
            answer = shuffled.popLast()?.name.uppercased().map { String($0) } ?? ["B"]
            DispatchQueue.main.async { [weak self] in
                self?.createAnswerLabelText(self!.answer)
            }
        }
    }

    func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
        }
    }

    func resetGame() {
        guard let newAnswer = allPokemon.popLast()?.name else { return }
        answer = newAnswer.map { String($0) }
        maskedAnswer = [String]()
        for _ in answer {
            maskedAnswer.append("?")
        }
        answerLabel.text = maskedAnswer.joined(separator: "")
        mistakesLeft = 7
        resetKeyboard()
    }

    func resetKeyboard() {
        for letterButton in letterButtons {
            letterButton.isHidden = false
        }
        for i in 26 ..< 28 {
            letterButtons[i].isHidden = true
        }
    }
}
