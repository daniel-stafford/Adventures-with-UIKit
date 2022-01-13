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
        title = "Country Blast"
        navigationController?.navigationBar.prefersLargeTitles = true

        performSelector(onMainThread: #selector(getCountries), with: nil, waitUntilDone: false)
    }

    @objc func getCountries() {
        let urlString = "https://restcountries.com/v3.1/all"
        if let url = URL(string: urlString) {
            parse(url: url, type: [Country].self) {
                allCountries = $0
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                    return
                }
            }
        }
    }
    
    func parse<T: Codable>(url: URL, type: T.Type, after: (T) -> Void) {
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            let json = try jsonDecoder.decode(type, from: data)
            after(json)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
            showError()
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

        let country = allCountries[indexPath.row]

        var content = cell.defaultContentConfiguration()

        content.image = UIImage(named: country.cca2.lowercased())
        content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        content.imageToTextPadding = CGFloat(30)
        content.text = country.name.common

        content.textProperties.font = UIFont.systemFont(ofSize: 20)

        cell.contentConfiguration = content

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.4,
            animations: {
                cell.alpha = 1
            })
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? CountryVC {
            let country = allCountries[indexPath.row]
            vc.title = country.name.common
            vc.selectedCountry = country

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
