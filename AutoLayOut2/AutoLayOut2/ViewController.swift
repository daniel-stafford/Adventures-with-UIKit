//
//  ViewController.swift
//  AutoLayOut2
//
//  Created by Daniel Stafford on 1/3/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        override func viewDidLoad() {
            super.viewDidLoad()

            let label1 = UILabel()
            label1.translatesAutoresizingMaskIntoConstraints = false
            label1.backgroundColor = UIColor.red
            label1.text = "THESE"
            label1.sizeToFit()

            let label2 = UILabel()
            label2.translatesAutoresizingMaskIntoConstraints = false
            label2.backgroundColor = UIColor.cyan
            label2.text = "ARE"
            label2.sizeToFit()

            let label3 = UILabel()
            label3.translatesAutoresizingMaskIntoConstraints = false
            label3.backgroundColor = UIColor.yellow
            label3.text = "SOME"
            label3.sizeToFit()

            let label4 = UILabel()
            label4.translatesAutoresizingMaskIntoConstraints = false
            label4.backgroundColor = UIColor.green
            label4.text = "AWESOME"
            label4.sizeToFit()

            let label5 = UILabel()
            label5.translatesAutoresizingMaskIntoConstraints = false
            label5.backgroundColor = UIColor.orange
            label5.text = "LABELS"
            label5.sizeToFit()

            view.addSubview(label1)
            view.addSubview(label2)
            view.addSubview(label3)
            view.addSubview(label4)
            view.addSubview(label5)
        }
    }


}

