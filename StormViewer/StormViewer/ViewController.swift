//
//  ViewController.swift
//  StormViewer
//
//  Created by Daniel Stafford on 12/24/21.
//

// this file will reference the iOS user interface toolkit.”
import UIKit

// “I want to create a new screen of data called ViewController, based on UIViewController.” When you see a data type that starts with “UI”, it means it comes from UIKit. UIViewController is Apple’s default screen type, which is empty and white until we change it.
class ViewController: UIViewController {
    //To create a property, you need to declare it outside of methods.
    //That pictures array will be created when the ViewController screen is created, and exist for as long as the screen exists. It will be empty, because we haven’t actually filled it with anything, but at least it’s there ready for us to fill.
    var pictures = [String]()

    // the override keyword is needed because it means “we want to change Apple’s default behavior from UIViewController.” viewDidLoad() is called by UIKit when the screen has loaded, and is ready for you to customize.
    override func viewDidLoad() {
        // This super call means “tell Apple’s UIViewController to run its own code before I run mine,” and you’ll see this used a lot.
        super.viewDidLoad()
        // This is a data type that lets us work with the filesystem, and in our case we'll be using it to look for files.
        let fm = FileManager.default
        // declares a constant called path that is set to the resource path of our app's bundle. Remember, a bundle is a directory containing our compiled program and all our assets. So, this line says, "tell me where I can find all those images I added to my app."
        let path = Bundle.main.resourcePath!
        // The items constant will be an array of strings containing filenames.
        // In this instance it’s perfectly fine to use Bundle.main.resourcePath! and try!, because if this code fails it means our app can't read its own data so something must be seriously wrong. Some Swift developers attempt to write code to handle these catastrophic errors at runtime, but sadly all too often they just mask the actual problem that occurred.
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
    }
}
