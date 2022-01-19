//
//  ActionViewController.swift
//  Extension
//
//  Created by Daniel Stafford on 1/17/22.
//

import MobileCoreServices
import UIKit
import UniformTypeIdentifiers

class ActionViewController: UIViewController {
    @IBOutlet var script: UITextView!
    var pageTitle = ""
    var pageURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(chooseScript))

        // access notification center
        let notificationCenter = NotificationCenter.default
        // we care about hiding and changing frames of keyboard
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        //  we only care about first input item created by the extension
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            // gives the us first items info via closure
            // will contain a dict and error
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] dict, _ in
                    // NSDictionary works like a Swift dictionary, except you don't need to declare or even know what data types it holds. One of the nasty things about NSDictionary is that you don't need to declare or even know what data types it holds.
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    // Right now, there's nothing in that dictionary other than the data we sent from JavaScript, and that's stored in a special key called NSExtensionJavaScriptPreprocessingResultsKey. So, we pull that value out from the dictionary, and put it into a value called javaScriptValues.
                    // We sent a dictionary of data from JavaScript, so we typecast javaScriptValues as an NSDictionary again so that we can pull out values using keys,
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    print(javaScriptValues)
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""

                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
    }

    @objc func chooseScript() {
        let ac = UIAlertController(title: "Choose Script", message: "", preferredStyle: .alert)
        ac.addAction(generateAlertAction(title: "Display webpage title", text: "alert(document.title);"))
        ac.addAction(generateAlertAction(title: "Display current year", text: "const d = new Date; alert(d.getFullYear());"))
        ac.addAction(generateAlertAction(title: "Display user agent info", text: "alert(navigator.userAgent);"))
        present(ac, animated: true)
    }

    func generateAlertAction(title: String, text: String) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default) { [weak self] _ in
            self?.script.text = text
        }
    }

    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text!]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]

        extensionContext?.completeRequest(returningItems: [item])
    }

    // will receive a parameter that is of type Notification. This will include the name of the notification as well as a Dictionary containing notification-specific information called userInfo.
    @objc func adjustForKeyboard(notification: Notification) {
        // When working with keyboards, the dictionary will contain a key called UIResponder.keyboardFrameEndUserInfoKey telling us the frame of the keyboard after it has finished animating. This will be of type NSValue, which in turn is of type CGRect. The CGRect struct holds both a CGPoint and a CGSize, so it can be used to describe a rectangle.
        // we cast as NSValue because a quirck of Objective-C was that arrays and dictionaries couldn't contain structures like CGRect, so Apple had a special class called NSValue that acted as a wrapper around structures so they could be put into dictionaries and arrays.
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        // pull out the correct frame of the keyboard
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        //  we need to convert the rectangle to our view's co-ordinates. This is because rotation isn't factored into the frame, so if the user is in landscape we'll have the width and height flipped – using the convert() method will fix that.
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        // workaround for hardware keyboards being connected by explicitly setting the insets to be zero.
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            // The next thing we need to do in the adjustForKeyboard() method is to adjust the contentInset and scrollIndicatorInsets of our text view. These two essentially indent the edges of our text view so that it appears to occupy less space even though its constraints are still edge to edge in the view.
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        // Finally, we're going to make the text view scroll so that the text entry cursor is visible. If the text view has shrunk this will now be off screen, so scrolling to find it again keeps the user experience intact.
        script.scrollIndicatorInsets = script.contentInset

        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
}
