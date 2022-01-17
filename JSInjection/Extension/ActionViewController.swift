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

    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]

        extensionContext?.completeRequest(returningItems: [item])
    }
}
