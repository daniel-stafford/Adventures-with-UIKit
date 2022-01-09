//
//  Person.swift
//  NamesToFaces
//
//  Created by Daniel Stafford on 1/8/22.
//  Copyright © 2022 Shubham shah. All rights reserved.
//

import UIKit

// NSCoding allow for saving in user defaults
// We're not using a struct here, becuase we couldn't use it with NSCoding
class Person: NSObject, NSCoding {
    var name: String
    var image: String

    // Classes don't need a custom initializer if their property are given initial values somewhere, for example if we give them default values, in this case we don't provide default values, hence the init
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

    // new class called NSCoder. This is responsible for both encoding (writing) and decoding (reading) your data so that it can be used with UserDefaults.
    // required = if anyone tries to subclass this class, they are required to implement this method." An alternative to using required is to declare that your class can never be subclassed, known as a final class, in which case you don't need required because subclassing isn't possible. We'll be using required here.
    
    // reading form disk
    required init(coder aDecoder: NSCoder) {
        // no such things as decodeString, so use object
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }

    // writing to disk
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
}
