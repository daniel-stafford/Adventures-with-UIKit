//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Daniel Stafford on 12/25/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

//        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never

        // https://www.hackingwithswift.com/read/3/2/uiactivityviewcontroller-explained
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    // when Objective-C code needs to call a Swift method – and that’s any time it gets called by one of Apple’s UI components, for example – then the @objc is required.
    @objc func sharedTapped() {
        //add imageName challenge 👍
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8), let imageName = selectedImage else {
            print("No image found")
            return
        }
        print("imageName", imageName)

        let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
