//
//  ViewController.swift
//  WordScramble-UiKit
//
//  Created by Daniel Stafford on 1/2/22.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))

        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        // 👀 The reason we use isEmpty is because some collection types, such as string, have to calculate their size by counting over all the elements they contain, so reading count == 0 can be significantly slower than using isEmpty.
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }

        startGame()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        // reloadData() forces it to call numberOfRowsInSection again, as well as calling cellForRowAt repeatedly.
        tableView.reloadData()
    }

    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        // adds an editable text input field to the UIAlertController
        ac.addTextField()

        // e're giving the UIAlertAction some code to execute when it is tapped, and it wants to know that that code accepts a parameter of type UIAlertAction
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            // This submit() method is external to the closure’s current context, so when you're writing it you might not realize that calling submit() implicitly requires that self be captured by the closure. That is, the closure can't call submit() if it doesn't capture the view controller.
            // We've already declared that self is weakly owned by the closure, but Swift wants us to be absolutely sure we know what we're doing: every call to a method or property of the current view controller must prefixed with "self?.”, as in self?.submit().
            // Implicit capture of self in closures is that place when using self is required and meaningful: Swift won't let you avoid it here. By restricting your use of self to closures you can easily check your code doesn’t have any reference cycles by searching for "self" – there ought not to be too many to look through!
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()

        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    if isLong(word: lowerAnswer) {
                        if isDifferent(word: lowerAnswer) {
                            usedWords.insert(lowerAnswer, at: 0)

                            let indexPath = IndexPath(row: 0, section: 0)
                            tableView.insertRows(at: [indexPath], with: .automatic)

                            return
                        } else {
                            showErrorMessage(title: "Same as start word!", message: "Use your brain")
                        }
                    } else {
                        showErrorMessage(title: "Word too short", message: "Use words longer than two characters.")
                    }
                } else {
                    showErrorMessage(title: "Word not recognised", message: "You can't just make them up, you know!")
                }
            } else {
                showErrorMessage(title: "Word used already", message: "Be more original!")
            }
        } else {
            guard let title = title?.lowercased() else { return }
            showErrorMessage(title: "Word not possible", message: "You can't spell that word from \(title)")
        }

    }

    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }

        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }

        return true
    }

    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()

        // 👀 when you’re working with UIKit, SpriteKit, or any other Apple framework, use utf16.count for the character count. If it’s just your own code - i.e. looping over characters and processing each one individually – then use count instead.
        let range = NSRange(location: 0, length: word.utf16.count)

        // Next, we call the rangeOfMisspelledWord(in:) method of our UITextChecker instance. This wants five parameters, but we only care about the first two and the last one: the first parameter is our string, word, the second is our range to scan (the whole string), and the last is the language we should be checking with, where en selects English.
        // Parameters three and four aren't useful here, but for the sake of completeness: parameter three selects a point in the range where the text checker should start scanning, and parameter four lets us set whether the UITextChecker should start at the beginning of the range if no misspelled words were found starting from parameter three. Neat, but not helpful here.
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func isLong(word: String) -> Bool {
        return word.count > 2
    }

    func isDifferent(word: String) -> Bool {
        return !(title == word)
    }

    func showErrorMessage(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
