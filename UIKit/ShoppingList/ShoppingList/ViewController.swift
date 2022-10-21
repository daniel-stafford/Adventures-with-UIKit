//
//  ViewController.swift
//  ShoppingList
//
//  Created by Daniel Stafford on 1/4/22.
//

import UIKit

class ViewController: UITableViewController {
    var allItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List 🍅"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetList))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let share = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        
        toolbarItems = [spacer, share]
        navigationController?.isToolbarHidden = false
        

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItem", for: indexPath)
        cell.textLabel?.text = allItems[indexPath.row]

        return cell
    }

    @objc func promptForItem() {
        let ac = UIAlertController(title: "Add to shopping list", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let userText = ac?.textFields?[0].text else { return }
            self?.submit(userText)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    func submit(_ userText: String) {
        allItems.insert(userText, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    
    @objc func sharedTapped() {
        let listToShare = allItems.joined(separator: "\n")
        let shareMessage = "Hey, here's my shopping list: \n\(listToShare)"
        print("shareMessage", shareMessage)
        let vc = UIActivityViewController(activityItems: [shareMessage], applicationActivities: []
        )
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    @objc func resetList() {
        allItems = []
        tableView.reloadData()
    }
}
