//
//  ViewController.swift
//  Debug
//
//  Created by Daniel Stafford on 1/15/22.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(1, 2, 3, 4, 5, separator: "-")
        // asserts are not used in release builds, only written during test builds
        print("Some message", terminator: "")
        assert(1 == 1, "Maths failure!")
//        assert(1 == 2, "Maths failure!")
        assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing!")
    }
    
    func myReallySlowMethod() -> Bool {
        return false
    }
}
