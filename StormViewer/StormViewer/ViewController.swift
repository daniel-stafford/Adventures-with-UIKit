//
//  ViewController.swift
//  StormViewer
//
//  Created by Daniel Stafford on 12/24/21.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var selectedPictureNumber = 0
    var totalPictures = 0
    var viewTracker = [String: Int]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard

        if let savedViewTracker = defaults.object(forKey: "viewTracker") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                viewTracker = try jsonDecoder.decode([String: Int].self, from: savedViewTracker)
            } catch {
                print("Failed to load viewTracker")
            }
        }

        // set navigation bar title, may get cut off due to length of word and reverted to "Back"
        title = "Storm Viewer"

        navigationController?.navigationBar.prefersLargeTitles = true

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)

            for item in items {
                if item.hasPrefix("nssl") {
                    self?.pictures.append(item)
                }
            }
            self?.pictures.sort()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "\(pictures[indexPath.row]) - \(viewTracker[pictures[indexPath.row]] ?? 0) views"
        

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.title = "Pictures \(indexPath.row + 1) of \(pictures.count)"
            // 3: now push it onto the navigation controller
            trackViews(pictures[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func trackViews(_ selectedImage: String) {
        if viewTracker[selectedImage] != nil {
            viewTracker[selectedImage]! += 1
        } else {
            viewTracker[selectedImage] = 1
        }
        save()
        tableView.reloadData()
    }

    func save() {
        print("saving", viewTracker)
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(viewTracker) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "viewTracker")
        } else {
            print("Failed to save viewTracker.")
        }
    }
}
