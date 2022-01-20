//
//  ViewController.swift
//  Detect-a-Beacon
//
//  Created by Daniel Stafford on 1/20/22.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var distanceReading: UILabel!
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager?.delegate = self
        // ask for always location
        // non-blocking call
        locationManager?.requestAlwaysAuthorization()
        // ask for when in use
        // locationManager?.requestWhenInUseAuthorization()

        view.backgroundColor = .gray
    }

    // did change authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // check support for beacons
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    print("we're good")
                }
            }
        }
    }
}
