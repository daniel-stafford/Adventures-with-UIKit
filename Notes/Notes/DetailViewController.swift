//
//  DetailViewController.swift
//  Notes
//
//  Created by Daniel Stafford on 1/20/22.
//

import UIKit


class DetailViewController: UIViewController {
    var selectedNote: Note!
    var notes: [Note]!
    
    @IBOutlet var body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        body.text = selectedNote?.body
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let compose = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        toolbarItems = [spacer, compose]
        navigationController?.isToolbarHidden = false
        
        // access notification center
        let notificationCenter = NotificationCenter.default
        // we care about hiding and changing frames of keyboard
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
   

    @objc func done() {
        self.view.endEditing(true)
        for note in notes {
            if (note.id == selectedNote.id) {
                note.body = body.text
            }
        }
        save()
    }
    
    @objc func shareTapped() {
        let noteToShare = body.text
        let shareMessage = noteToShare
        let vc = UIActivityViewController(activityItems: [shareMessage ?? ""], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            print("Failed to save notes.")
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            body.contentInset = .zero
        } else {
            body.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        body.scrollIndicatorInsets = body.contentInset
        let selectedRange = body.selectedRange
        body.scrollRangeToVisible(selectedRange)
    }
}
