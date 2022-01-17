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
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //  we only care about first input item created by the extension
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            // gives the us first items info via closure
            // will contain a dict and error
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] _, _ in
                    // do stuff!
                }
            }
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        extensionContext!.completeRequest(returningItems: extensionContext!.inputItems, completionHandler: nil)
    }
}
