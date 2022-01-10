//
//  ViewController.swift
//  Instafilter
//
//  Created by Daniel Stafford on 1/9/22.
//

import CoreImage
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var context: CIContext!
    var currentFilter: CIFilter!
    var currentImage: UIImage!

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    // delete this properly (just erasing causing a compile error)
    @IBOutlet var intensityChanged: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Instafilter"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))

        context = CIContext()
        // example filter to apply sepa effect to images
        currentFilter = CIFilter(name: "CISepiaTone")
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // check we have an image
        guard let image = info[.editedImage] as? UIImage else { return }
        // clear the imagePicker
        dismiss(animated: true)

        // use our image as input for the filter
        currentImage = image

        // CIImage is the CoreImage equivalent of UIImage in this context
        // CIImage is like a recipe describing what kind of transformations to apply.
        let beginImage = CIImage(image: currentImage)
        // lots of random keys in CoreImage, this is the input key
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

        // start porcessing when photo is imported
        applyProcessing()
    }

    @IBAction func intensityChanged(_ sender: Any) {
        // start processing when slider is moved
        applyProcessing()
    }

    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        // uses the value of our intensity slider to set the kCIInputIntensityKey value of our current Core Image filter. For sepia toning a value of 0 means "no effect" and 1 means "fully sepia."
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey) }
        // raidus takes values from 0 - 200
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey) }
        // scale from 0 to 10
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey) }
        // centering by halving size and width
        if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }

        // create CGImage from the output image of the current filter.
        // /We need to specify which part of the image we want to render, but using image.extent means "all of it." Until this method is called, no actual processing is done, so this is the one that does the real work. This returns an optional CGImage so we need to check and unwrap with if let.
        if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
            // The fourth line creates a new UIImage from the CGImage, and line five assigns that UIImage to our image view. So we have UIImage -> CIimage -> CGImage -> UIImage!
            let processedImage = UIImage(cgImage: cgimg)
            imageView.image = processedImage
        }
    }

    @IBAction func changeFilter(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)

        // ipad options
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
    }

    func setFilter(action: UIAlertAction) {
        // make sure we have a valid image before continuing!
        guard currentImage != nil else { return }

        // safely read the alert action's title
        guard let actionTitle = action.title else { return }

        currentFilter = CIFilter(name: actionTitle)

        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

        applyProcessing()
    }

    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else {
            let ac = UIAlertController(title: "Error", message: "Please import a photo before saving", preferredStyle: .alert)
            present(ac, animated: true)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            return
        }
        // write a UI image to the photos album
        // takes UIimage, notify self (our View Controller, very specfic #selector call)
        // nil context
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    // must call this to save photo. very ugly
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            // use user's own language
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
