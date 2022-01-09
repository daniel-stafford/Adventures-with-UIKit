//
//  ViewController.swift
//  Instafilter
//
//  Created by Daniel Stafford on 1/9/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBOutlet var intensityChanged: NSLayoutConstraint!
    @IBAction func save(_ sender: Any) {
    }
    @IBAction func changeFilter(_ sender: Any) {
    }
}

