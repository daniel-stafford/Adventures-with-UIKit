//
//  ViewController.swift
//  NamesToFaces
//
//  Created by Daniel Stafford on 1/7/22.

import UIKit

// UIImagePickerControllerDelegate tells us when the user either selected a picture or cancelled the picker
// UINavigationControllerDelegate isn't important, simply whether users goes back or foward inside picker
class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }

    // similar to numberOfRows
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        people.count
    }

    // design for each cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell.")
        }

        // pick out the person fomr the people array
        let person = people[indexPath.item]

        //assign the person's name to our custom UILabele cell's (PersonCell) name
        cell.name.text = person.name

        // get path for image
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        // set found image to cell image
        cell.imageView.image = UIImage(contentsOfFile: path.path)

        // a new UIColor initializer: UIColor(white:alpha:). This is useful when you only want grayscale colors.
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        // rounded corners
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        return cell
    }

    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        // allows the user to crop the picture they select.
        picker.allowsEditing = true
        // When you set self as the delegate (respond to the picker), you'll need to conform not only to the UIImagePickerControllerDelegate protocol, but also the UINavigationControllerDelegate protocol.
        picker.delegate = self
        present(picker, animated: true)
    }

    // didFinishPickingMediaWithInfo - extracts image from dictionry (the method parameter), generate unique filename, convert to JPEG, write JEP to disk, dmiss the view controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // names of dictionary keys is either .originalImage or .editedImage
        // use optional typecast to ensure UIImage
        guard let image = info[.editedImage] as? UIImage else { return }

        // unique file name for each image we're importing, won't overwrite anything and if user delete image, we have a copy, use UUID to generate
        let imageName = UUID().uuidString
        // get path for saving
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        // convert JPEG to data (any binary type)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            // write to disk
            try? jpegData.write(to: imagePath)
        }

        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()

        dismiss(animated: true)
    }

    // The first parameter of FileManager.default.urls asks for the documents directory, and its second parameter adds that we want the path to be relative to the user's home directory. This returns an array that nearly always contains only one thing: the user's documents directory. So, we pull out the first element and return it.  We don't want to have find this by hand!
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }eeeee

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]

        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName

            self?.collectionView.reloadData()
        })

        present(ac, animated: true)
    }
}
