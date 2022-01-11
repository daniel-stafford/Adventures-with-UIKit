//
//  ViewController.swift
//  Animation-UIKit
//
//  Created by Daniel Stafford on 1/11/22.
//

import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView!
    var currentAnimation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }

    @IBAction func buttonTapped(_ sender: Any) {
        currentAnimation += 1

        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
}
