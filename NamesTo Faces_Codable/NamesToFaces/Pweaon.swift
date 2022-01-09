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
// Codable (not compataible with objC but very easy to use, tells Swift we went to read/write
class Person: NSObject, Codable {
    var name: String
    var image: String

    // Classes don't need a custom initializer if their property are given initial values somewhere, for example if we give them default values, in this case we don't provide default values, hence the init
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
