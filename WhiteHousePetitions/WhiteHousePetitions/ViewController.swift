//
//  ViewController.swift
//  WhiteHousePetitions
//
//  Created by Daniel Stafford on 1/4/22.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showInfo))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(promptFilter))
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                parse(json: data)
                return
            }
        }

        showError()
    }

    @objc func promptFilter() {
        let ac = UIAlertController(title: "Search", message: "What kind of petition are you looking for? Enter a keyword.", preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] _ in
            guard let userText = ac?.textFields?[0].text else { return }
            self?.submit(userText)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    // MARK: - -

    func submit(_ userText: String) {
        print("Here is the user text", userText)
//        var filteredPetitions: [Petitions]?
        let filtered = petitions.filter { p in
            p.body.contains(userText)
        }
        petitions = filtered
        tableView.reloadData()
    }

    @objc func showInfo() {
        let ac = UIAlertController(title: "Info", message: "This app is powerd by the White House Petitions API", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
