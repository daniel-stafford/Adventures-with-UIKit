//
//  TableViewController.swift
//  EasyBrowser
//
//  Created by Daniel Stafford on 1/2/22.
//

import UIKit

class TableViewController: UITableViewController {
    var allWebsites = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Easy Browser 🔥"
        
        if let websitesURL = Bundle.main.url(forResource: "websites", withExtension: "txt") {
            if let startWebsites = try? String(contentsOf: websitesURL) {
                allWebsites = startWebsites.components(separatedBy: "\n")
            }
        }

        if allWebsites.isEmpty {
            allWebsites = ["news.ycombinator.com"]
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allWebsites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = allWebsites[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let browserView = storyboard?.instantiateViewController(withIdentifier: "Browser") as? ViewController {
            browserView.websites = allWebsites
            browserView.selectedWebsite = allWebsites[indexPath.row]
            navigationController?.pushViewController(browserView, animated: true)
        }
    }
}
