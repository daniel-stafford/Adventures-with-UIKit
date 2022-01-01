//
//  DetailViewController.swift
//  WorldFlags
//
//  Created by Daniel Stafford on 1/1/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var flagImage: UIImageView!
    var selectedFlag: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let flagToLoad = selectedFlag {
            flagImage.image = UIImage(named: flagToLoad)
        }
    }

    @objc func shareTapped() {
        guard let image = flagImage.image?.jpegData(compressionQuality: 1.0) else {
            print("No image found")
            return
        }

        let vc = UIActivityViewController(activityItems: [image, "Check out this flag"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
