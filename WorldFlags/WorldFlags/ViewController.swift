//
//  ViewController.swift
//  WorldFlags
//
//  Created by Daniel Stafford on 12/31/21.
//

import UIKit

class ViewController: UITableViewController {
    var flags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "World Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasSuffix("3x.png") {
                flags.append(item)
            }
        }
        
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.textLabel?.text = flags[indexPath.row].components(separatedBy: "@")[0].uppercased()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dvc = storyboard?.instantiateViewController(withIdentifier: "FlagDetail") as? DetailViewController {
            dvc.selectedFlag = flags[indexPath.row]
            dvc.title = flags[indexPath.row].components(separatedBy: "@")[0].uppercased()
            navigationController?.pushViewController(dvc, animated: true)
        }
        
    }
    
    
}
