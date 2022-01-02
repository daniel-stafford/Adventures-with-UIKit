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

    func startGame() {
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
        print(answer, "answer")
    }
}
