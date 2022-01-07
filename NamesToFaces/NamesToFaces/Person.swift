//
//  Person.swift
//  NamesToFaces
//
//  Created by Daniel Stafford on 1/8/22.
//  Copyright © 2022 Shubham shah. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
