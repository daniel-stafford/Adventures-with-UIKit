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

        // five UILabel objects, each with unique text and a unique background color.
        let label1 = UILabel()
        // by default iOS generates Auto Layout constraints for you based on a view's size and position. We'll be doing it by hand, so we need to disable this feature.
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        // are all sized to fit their content
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

        // All five views then get added to the view belonging to our view controller by using view.addSubview().
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)

        // reates a dictionary with strings for its keys and our labels as its values (the values). So, to get access to label1, we can now use viewsDictionary["label1"].
        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]

        for label in viewsDictionary.keys {
            print("label", label)
            // view.addConstraints(): this adds an array of constraints to our view controller's view. This array is used rather than a single constraint because VFL can generate multiple constraints at a time.
            // NSLayoutConstraint.constraints(withVisualFormat:) is the Auto Layout method that converts VFL into an array of constraints.
            // The H: parts means that we're defining a horizontal layout;
            // The pipe symbol, |, means "the edge of the view." We're adding these constraints to the main view inside our view controller, so this effectively means "the edge of the view controller.
            // put label1 here". Imagine the brackets, [ and ], are the edges of the view.
            // So, "H:|[label1]|" means "horizontally, I want my label1 to go edge to edge in my view."
            // viewsDictionary: we used strings for the key and UILabels for the value, then set "label1" to be our label. This dictionary gets passed in along with the VFL, and gets used by iOS to look up the names from the VFL. So when it sees [label1], it looks in our dictionary for the "label1" key and uses its value to generate the Auto Layout constraints.
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
        }

        // V:, meaning that these constraints are vertical.
        // he - symbol, which means "space". It's 10 points by default, but you can customize it.
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
    }
}
