//
//  Photo.swift
//  CameraAlbum
//
//  Created by Daniel Stafford on 1/9/22.
//

import UIKit

class Photo: NSObject, Codable {
    var fileName: String
    var image: String

    // Classes don't need a custom initializer if their property are given initial values somewhere, for example if we give them default values, in this case we don't provide default values, hence the init
    init(fileName: String, image: String) {
        self.fileName = fileName
        self.image = image
    }
}
