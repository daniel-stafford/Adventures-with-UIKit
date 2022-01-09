//
//  DetailViewController.swift
//  CameraAlbum
//
//  Created by Daniel Stafford on 1/9/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var photo: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()

        let path = getDocumentsDirectory().appendingPathComponent(photo!.image)
        imageView.image = UIImage(contentsOfFile: path.path)

    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
