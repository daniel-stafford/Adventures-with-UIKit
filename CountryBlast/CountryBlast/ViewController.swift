//
//  ViewController.swift
//  CountryBlast
//
//  Created by Daniel Stafford on 1/11/22.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

class ViewController: UITableViewController {
    var allCountries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Country Smash"

        let urlString = "https://restcountries.com/v3.1/all"

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self?.parse(json: data)
                    return
                }
            }
            self?.showError()
        }
    }

    func parse(json: Data) {
        print("parse is running")
        let decoder = JSONDecoder()

        if let jsonResults = try? decoder.decode([Country].self, from: json) {
            print("json", jsonResults.count)
            allCountries = jsonResults
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCountries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        var content = cell.defaultContentConfiguration()
        print("allCountries", allCountries.count)
        let imageUrl = allCountries[indexPath.row].flags.png
//        let flagImage: UIImage = setImage(from: imageUrl)
        let flagImage = setImage(from: imageUrl)
        content.image = flagImage
        content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        content.imageToTextPadding = CGFloat(30)
        content.text = allCountries[indexPath.row].name.common
        cell.contentConfiguration = content

        return cell
    }

//    func setImage(from url: String) -> UIImage {
//        if let imageURL = URL(string: url) {
//            DispatchQueue.global().async {
//                if let imageData = try? Data(contentsOf: imageURL) {
//                    return UIImage(data: imageData)
//                }
//            }
//        }
//    }

    func setImage(from url: String) -> UIImage {
        let imageURL = URL(string: url)
        let imageData = try? Data(contentsOf: imageURL!)
        return UIImage(data: imageData!)!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") {
            vc.title = "Country \(indexPath.row)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
