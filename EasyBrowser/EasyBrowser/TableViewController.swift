//
//  TableViewController.swift
//  EasyBrowser
//
//  Created by Daniel Stafford on 1/2/22.
//

import UIKit

class TableViewController: UITableViewController {
    var websites = ["news.ycombinator.com", "apple.com", "hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        title = "Easy Browser"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.layer.borderWidth = 1
        cell.textLabel?.text = websites[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let browserView = storyboard?.instantiateViewController(withIdentifier: "Browser") as? ViewController {
            browserView.websites = websites
            browserView.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(browserView, animated: true)
        }
    }
}
