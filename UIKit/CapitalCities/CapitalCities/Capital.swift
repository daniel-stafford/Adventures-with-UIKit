//
//  Capital.swift
//  CapitalCities
//
//  Created by Daniel Stafford on 1/12/22.
//

import MapKit
import UIKit

//must use classes with map annoations
class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
