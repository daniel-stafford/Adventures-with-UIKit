//
//  ViewController.swift
//  SwiftyWords
//
//  Created by Daniel Stafford on 1/4/22.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()

    var activatedButtons = [UIButton]()
    var solutions = [String]()

    var score = 0 {
        didSet {
            print("score updated")
            scoreLabel.text = "Score: \(score)"
        }
    }

    var level = 1

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)

        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        // will give us a 24-point font in whatever font is currently being used by iOS. This was Helvetica in the early days of iOS, then moved to Helvetica Neue and finally San Francisco. Asking for the system font means we’ll get whatever is the standard today, but our UI will update automatically if Apple makes more changes in the future.
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        // word wrapping
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)

        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        view.addSubview(answersLabel)

        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        // stops the user from activating the text field and typing into it.
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)

        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)

        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)

        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.gray.cgColor
        buttonsView.layer.cornerRadius = 20
        buttonsView.layer.cornerCurve = .continuous
        view.addSubview(buttonsView)

        // view.layoutMarginsGuide – that will make the score label have a little distance from the right edge of the screen.
        // remember NSLayoutConstraint.active take an array [], so be mindful of commas
        NSLayoutConstraint.activate([
            // top of label to top of screen (with padding)
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),

            // right of label to right of screen (with padding)
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

            // pin the top of the clues label to the bottom of the score label
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

            // pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),

            // make the clues label 60% of the width of our layout margins, minus 100 (indent)
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),

            // also pin the top of the answers label to the bottom of the score label
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

            // make the answers label stick to the trailing edge of our layout margins, minus 100
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),

            // make the answers label take up 40% of the available space, minus 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),

            // make the answers label match the height of the clues label
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),

            // entered in our view
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // only 50% its width
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),

            // place it below the clues label, with 20 points of spacing so the two don’t touch.
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),

            // top to bottom of the current answer text field,
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),

            // center horizontally. To stop them overlapping, we’ll subtract 100 from the submit button’s X position, and add 100 to the clear button’s X position.
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),

            // within recommended button at size of at least 44x44 (iOs makes really small by default)
            submit.heightAnchor.constraint(equalToConstant: 44),

            // center horizatonlly. To stop them overlapping, we’ll subtract 100 from the submit button’s X position, and add 100 to the clear button’s X position.
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),

            //  setting its Y anchor so that its stays aligned with the Y position of the submit button. This means both buttons will remain aligned even if we move one.
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),

            clear.heightAnchor.constraint(equalToConstant: 44),

            // width and height of 750x320 so that it precisely contains the buttons inside it.
            buttonsView.widthAnchor.constraint(equalToConstant: 750),

            buttonsView.heightAnchor.constraint(equalToConstant: 320),

            // centered horizontally.
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // top anchor to be the bottom of the submit button, plus 20 points to add a little spacing.
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),

            // bottom of our layout margins, -20 so that it doesn’t run quite to the edge.
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),

        ])

        // set some values for the width and height of each button
        let width = 150
        let height = 80

        for row in 0 ..< 4 {
            for col in 0 ..< 5 {
                // create a new button and give it a big font size
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)

                // give the button some temporary text so we can see it on-screen
                letterButton.setTitle("WWW", for: .normal)

                // calculate the frame of this button using its column and row
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)

                // add it to the buttons view
                buttonsView.addSubview(letterButton)

                // and also to our letterButtons array
                letterButtons.append(letterButton)
            }
        }
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(loadLevel), with: nil)
    }

    @objc func loadLevel() {
        // e.g.Head of state, British style
        var clueString = ""
        // e.g. 7 letters
        var solutionString = ""
        // e.g. ["ELI", "ZAB", "ETH", "LE"...  ]
        var letterBits = [String]()

        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                // e.g. ["HA|UNT|ED: Ghosts in residence", "LE|PRO|SY: A Biblical skin disease"...]
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()

                for (index, line) in lines.enumerated() {
                    // e.g. parts = ["ELI|ZAB|ETH", "Head of state, British style"]
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]

                    // e.g. 1. Head of state, British style
                    clueString += "\(index + 1). \(clue)\n"

                    // e.g. ELIZABETH
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)

                    // e.g. ["ELI", "ZAB", "ETH"]
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        // switch back to main thread fpr UI updates
        DispatchQueue.main.async { [weak self] in
            // remove final line breaks
            self?.cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
            self?.answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

            letterBits.shuffle()

            // check we have same number of buttons and bits
            guard let chckdLetterButtons = self?.letterButtons else { return }
            if letterBits.count == chckdLetterButtons.count {
                for i in 0 ..< chckdLetterButtons.count {
                    chckdLetterButtons[i].setTitle(letterBits[i], for: .normal)
                }
            }
        }
    }

    @objc func letterTapped(_ sender: UIButton) {
        // let's be safe when getting the button title
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        // hold all the hiden buttons during a single answer
        activatedButtons.append(sender)
        // animate here!!!
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            sender.alpha = 0
        })
    }

    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }

        // if no anoswer is found, no value back, so unwrap carefully
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()

            // get answer list array
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")

            // reaplce answer text inside the solutions strings
            splitAnswers?[solutionPosition] = answerText

            // put array back into string
            answersLabel.text = splitAnswers?.joined(separator: "\n")

            // clear out input (but not buttons!)
            currentAnswer.text = ""
            score += 1

            // If the score is evenly divisible by 7, we know they have found all seven words so we're going to show a UIAlertController that will prompt the user to go to the next level.
            if letterButtons.allSatisfy({ $0.alpha == 0 }) {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        } else {
            let ac = UIAlertController(title: "Incorrect", message: "Keep on trying!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: clearAfterWrong))
            present(ac, animated: true)
        }
    }

    @objc func clearTapped(_ sender: UIButton) {
        // clear out user input
        currentAnswer.text = ""

        // show all tapped buttons for last answer
        for btn in activatedButtons {
            btn.alpha = 1
        }

        activatedButtons.removeAll()
    }

    func clearAfterWrong(action: UIAlertAction) {
        // clear out user input
        currentAnswer.text = ""

        // show all tapped buttons for last answer
        for btn in activatedButtons {
            btn.alpha = 1
        }
        activatedButtons.removeAll()
        score -= 1
    }

    func levelUp(action: UIAlertAction) {
        level += 1
        // keep 7 elements ready to be filled, as we wil repopulate
        solutions.removeAll(keepingCapacity: true)

        loadLevel()

        for letterButton in letterButtons {
            letterButton.alpha = 1
        }
    }
}
