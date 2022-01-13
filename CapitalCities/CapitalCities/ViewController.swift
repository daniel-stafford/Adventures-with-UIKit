//
//  ViewController.swift
//  CapitalCities
//
//  Created by Daniel Stafford on 1/12/22.
//

import MapKit
import UIKit

// We already used Interface Builder to make our view controller the delegate for the map view, but if you want code completionadd MKMapViewDelegate
class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let ac = UIAlertController(title: "Select Map Type", message: nil, preferredStyle: .alert)

        let addSatelite = UIAlertAction(title: "Satelite", style: .default) { [weak self] _ in
            self?.mapView.mapType = .satellite
        }
        let addStandard = UIAlertAction(title: "Standard", style: .default) { [weak self] _ in
            self?.mapView.mapType = .standard
        }
        let addHybrid = UIAlertAction(title: "Hybrid", style: .default) { [weak self] _ in
            self?.mapView.mapType = .hybrid
        }

        ac.addAction(addSatelite)
        ac.addAction(addStandard)
        ac.addAction(addHybrid)

        present(ac, animated: true)

        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")

        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1 If the annotation isn't from a capital city, it must return nil so iOS uses a default view.
        guard annotation is Capital else { return nil }

        // 2 Define a reuse identifier. This is a string that will be used to ensure we reuse annotation views as much as possible.
        let identifier = "Capital"

        // 3 Try to dequeue an annotation view from the map view's pool of unused views.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        if annotationView == nil {
            // 4 If it isn't able to find a reusable view, create a new one using MKPinAnnotationView and sets its canShowCallout property to true. This triggers the popup with the city name.
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            // 5 Create a new UIButton using the built-in .detailDisclosure type. This is a small blue "i" symbol with a circle around it.
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6 f it can reuse a view, update that view to use a different annotation.
            annotationView?.annotation = annotation
        }

        annotationView?.pinTintColor = .green
        return annotationView
    }

    // you don't need to use addTarget() to add an action to the button, because you'll automatically be told by the map view using a calloutAccessoryControlTapped method.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // The annotation view contains a property called annotation, which will contain our Capital object
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        let formatCapitalTitle = placeName == "Washington DC" ? "Washington,_D.C." : placeName

        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))

        let wiki = UIAlertAction(title: "Wikipedia", style: .default) { [weak self] _ in
            if let browserView = self?.storyboard?.instantiateViewController(withIdentifier: "Browser") as? BrowserVC {
                browserView.selectedWebsite = "en.wikipedia.org/wiki/\(formatCapitalTitle ?? "")"
                
                self?.navigationController?.pushViewController(browserView, animated: true)
            }
        }
        
        ac.addAction(wiki)

        present(ac, animated: true)
    }
}
