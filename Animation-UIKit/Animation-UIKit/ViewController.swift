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

    // change Any to UIButton
    @IBAction func buttonTapped(_ sender: UIButton) {
        // hide the button when tapped
        sender.isHidden = true

        //start animation, lasts one second, no delay, no special pptions
        UIView.animate(withDuration: 1, delay: 0, options: [],
        // provide animation as closure
        // no chance of retention cycle as animation is temporary, no need for weak
           animations: {
            switch self.currentAnimation {
            case 0:
                break

            default:
                break
            }
            // closure when finished, show button
        }) { finished in
            sender.isHidden = false
        }

        currentAnimation += 1

        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
}
