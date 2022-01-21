//
//  ViewController.swift
//  Extensions
//
//  Created by Daniel Stafford on 1/21/22.
//

import UIKit

extension UIView {
    func bounceOut(duration: Int) {
        UIView.animate(withDuration: TimeInterval(duration), animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        })
    }
}

class ViewController: UIViewController {
    @IBOutlet var box: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        box.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        print("tap")
        box.bounceOut(duration: 3)
    }
}
