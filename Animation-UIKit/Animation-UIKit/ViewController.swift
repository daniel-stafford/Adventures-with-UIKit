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

        // start animation, lasts one second, no delay, no special pptions
        // UIView.animate(withDuration: 1, delay: 0, options: [],
        // use spring mode!
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
                       // provide animation as closure, no chance of retention cycle as animation is temporary, no need for weak
                       animations: {
                           switch self.currentAnimation {
                           // make two times the default size
                           // default is ease in, ease out
                           case 0:
                               self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                           // clears out transforms, back to default
                           case 1:
                               self.imageView.transform = .identity
                           // relative move left and up
                           case 2:
                               self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
                           case 3:
                               self.imageView.transform = .identity
                           // rotate in radians (as CG Float), always shortest root (could be clockwise or counterclockwise). Rotating 360 won't be anything, same with 540, just 180 degrees.
                           case 4:
                               self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                           case 5:
                               self.imageView.transform = .identity
                           case 6:
                               // fade out ant and change background
                               self.imageView.alpha = 0.1
                               self.imageView.backgroundColor = UIColor.green
                           case 7:
                               // fade back in and change background back to clear
                               self.imageView.alpha = 1
                               self.imageView.backgroundColor = UIColor.clear
                           default:
                               break
                           }
                           // closure when finished, show button
                       }) { _ in
            sender.isHidden = false
        }

        currentAnimation += 1

        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
}
