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
    @IBOutlet var buttons: [UIButton]!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
    }
    
    //UIAlertAction! = nil, force unwrap and set to nil, allows askQuestion() to work without writing askQuestion(action:nil)
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
        
        getTitle()
        // https://programmingwithswift.com/how-to-get-index-and-value-from-for-loop-with-swift/
        for (index, button) in buttons.enumerated() {
            button.layer.borderWidth = 1
            button.setImage(UIImage(named: countries[index]), for: .normal)
        }
    }

    func getTitle(){
        title = countries[correctAnswer].capitalized
           if title == "Us" { title = "United States" }
           if title == "Uk" { title = "United Kingdom" }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer + 1 {
            score += 1
            title = "Correct"
        } else {
            score -= 1
            title = "Wrong"
        }
        
        let ac = UIAlertController(title: title, message: "Your score is now \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: ("Continue"), style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}
