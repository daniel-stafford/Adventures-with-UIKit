//
//  ViewController.swift
//  WhiteHousePetitions
//
//  Created by Daniel Stafford on 1/4/22.
//

import UIKit

class ViewController: UITableViewController {
    var allPetitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showInfo))

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(promptFilter))

        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
//            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"

        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        if let url = URL(string: urlString) {
            // contentsOF -> blocking call! Causes the entire program to freeze!
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

        if filteredPetitions.count != allPetitions.count {
            let resetSearch = UIAlertAction(title: "Show all results", style: .default) { [weak self] _ in
                self?.reset()
            }
            ac.addAction(resetSearch)
        }

        present(ac, animated: true)
    }

    func reset() {
        filteredPetitions = allPetitions
        tableView.reloadData()
    }

    func submit(_ userText: String) {
        filteredPetitions = allPetitions.filter { p in
            p.body.lowercased().contains(userText.lowercased())
        }
        tableView.reloadData()
    }

    @objc func showInfo() {
        let ac = UIAlertController(title: "Info", message: "This app is powerd by the We the People API. https://petitions.trumpwhitehouse.archives.gov/developers/get-code", preferredStyle: .alert)
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
            allPetitions = jsonPetitions.results
            filteredPetitions = allPetitions
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        filteredPetitions = filteredPetitions.sorted(by: { $0.signatureCount > $1.signatureCount })
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "\(petition.signatureCount.formatted()) signatures)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
