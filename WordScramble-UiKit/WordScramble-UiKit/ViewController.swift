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
    var currentWord = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        let jsonDecoder = JSONDecoder()

        if let savedCurrentWord = defaults.object(forKey: "currentWord") as? Data {
            do {
                currentWord = try jsonDecoder.decode(String.self, from: savedCurrentWord)
                print("loading saved currentWord", currentWord)
            } catch {
                print("Failed to load curren word")
            }
        }

        if let savedWords = defaults.object(forKey: "usedWords") as? Data {
            do {
                usedWords = try jsonDecoder.decode([String].self, from: savedWords)
                print("loading used words", usedWords)
            } catch {
                print("Failed to load used words")
            }
        }

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

        if currentWord == "" {
            startGame()
        } else {
            continueGame()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    func continueGame() {
        title = currentWord
    }

    @objc func startGame() {
        title = allWords.randomElement()
        currentWord = title ?? allWords[0]
        usedWords.removeAll(keepingCapacity: true)
        save()
        // reloadData() forces it to call numberOfRowsInSection again, as well as calling cellForRowAt repeatedly.
        tableView.reloadData()
    }

    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
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
                            save()
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

    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    func save() {
        let jsonEncoder = JSONEncoder()
        let defaults = UserDefaults.standard

        if let savedData = try? jsonEncoder.encode(currentWord) {
            defaults.set(savedData, forKey: "currentWord")
            print("Saved current word:", currentWord)
        } else {
            print("Failed to save current word.")
        }

        if let savedData = try? jsonEncoder.encode(usedWords) {
            defaults.set(savedData, forKey: "usedWords")
            print("Saved used words:", usedWords)
        } else {
            print("Failed to save used words.")
        }
    }
}
