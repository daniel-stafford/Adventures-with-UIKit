//
//  ViewController.swift
//  Hangman
//
//  Created by Daniel Stafford on 1/6/22.
//

import UIKit

class ViewController: UIViewController {
    var answer = "Apple"
    var numGuess = 0 {
        didSet {
            print(numGuess, "numGuess")
        }
    }
    var titleLabel: UILabel!
    var letterButton: UILabel!
    var letterButtons = [UIButton]()
    var answerLabel : UILabel!
    var turnsLeftLabel: UILabel!

    override func loadView() {
        view = UIView()
        
        view.backgroundColor = UIColor.systemBackground
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Hangman"
        titleLabel.textColor = .none
        titleLabel.font = UIFont.systemFont(ofSize: 50)
        view.addSubview(titleLabel)

        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
//        buttonsView.layer.borderWidth = 1
//        buttonsView.layer.borderColor = UIColor.gray.cgColor
//        buttonsView.layer.cornerRadius = 20
//        buttonsView.layer.cornerCurve = .continuous
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
            print("i", i)
            letterButtons[i].setTitle(String(char), for: .normal)
        }
        print(letterButtons.count)
        
        // hide and disable buttons beyond the 25 letter alphabet
        for i in 26 ..< 28 {
            letterButtons[i].isEnabled = false
            letterButtons[i].isHidden = true
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            buttonsView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @objc func letterTapped() {
        print("letter tapped!")
    }
}
