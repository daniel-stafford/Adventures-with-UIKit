//
//  ViewController.swift
//  UIKitPreview
//
//  Created by Daniel Stafford on 12/30/21.
//

import SwiftUI
import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    var countries = [String]()
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        func askQuestion() {
            // for: .normal The setImage() method takes a second parameter that describes which state of the button should be changed. We're specifying .normal, which means "the standard state of the button."
            // .normal is a static property of a struct called UIControlState
            button1.setImage(UIImage(named: countries[0]), for: .normal)
            button2.setImage(UIImage(named: countries[1]), for: .normal)
            button3.setImage(UIImage(named: countries[2]), for: .normal)
        }

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        // CALayer has its own way of setting colors called CGColor, which comes from Apple's Core Graphics framework. This, like CALayer, is at a lower level than UIButton, so the two can talk happily – again, as long as you're happy with the extra complexity.
        button1.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        button2.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        button3.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor

        askQuestion()
    }
}

struct VCPreview: PreviewProvider {
    static var previews: some View {
        VCContainerView().edgesIgnoringSafeArea(.all)
    }

    struct VCContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return ViewController()
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }

        typealias UIViewControllerType = UIViewController
    }
}
