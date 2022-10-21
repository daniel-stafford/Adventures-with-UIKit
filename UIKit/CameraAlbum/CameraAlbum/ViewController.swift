//
//  ViewController.swift
//  CameraAlbum
//
//  Created by Daniel Stafford on 1/9/22.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Album"

        let defaults = UserDefaults.standard

                if let savedPhotos = defaults.object(forKey: "photos") as? Data {
                    let jsonDecoder = JSONDecoder()

                    do {
                        photos = try jsonDecoder.decode([Photo].self, from: savedPhotos)
                    } catch {
                        print("Failed to load photos")
                    }
                }

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue PhotoCell")
        }

        let photo = photos[indexPath.item]

        let path = getDocumentsDirectory().appendingPathComponent(photo.image)
        cell.iamgeView.image = UIImage(contentsOfFile: path.path)
        cell.fileName.text = photo.fileName

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.photo = photos[indexPath.item]

            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func addNewPhoto() {
        let picker = UIImagePickerController()

        // MARK: TODO: Switch back to using camera

        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
        } else {
            let ac = UIAlertController(title: "Error", message: "Please activate your camera", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            // write to disk
            try? jpegData.write(to: imagePath)
        }

        let photo = Photo(fileName: "", image: imageName)
        photos.append(photo)
        collectionView.reloadData()
        dismiss(animated: true)
        let ac = UIAlertController(title: "Caption", message: "Please enter a caption for your new photo", preferredStyle: .alert)
        ac.addTextField()

        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newCaption = ac?.textFields?[0].text else { return }
            photo.fileName = newCaption
            self?.save()
            self?.collectionView.reloadData()
        })
        present(ac, animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(photos) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "photos")
            print("saving photos:", photos)
        } else {
            print("Failed to save photos.")
        }
    }
}
