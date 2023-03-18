//
//  ViewController.swift
//  The Wonderful Maps App
//
//  Created by Juan Gabriel Medina Marquez on 17/03/23.
//

import Cocoa
import MapKit

class ViewController: NSViewController, CLLocationManagerDelegate {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var mapLabel: NSTextField!
    var locationManager = CLLocationManager()
    var recognizer: NSClickGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = 10
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()

        mapView.showsUserLocation = true
        mapView.userTrackingMode = MKUserTrackingMode.follow

        recognizer = NSClickGestureRecognizer(target: self, action: #selector(locationClicked))
        recognizer?.numberOfClicksRequired = 1
        mapView.addGestureRecognizer(recognizer!)
    }

    @objc func locationClicked() {
        guard let mouseClickLocation = recognizer?.location(in: mapView) else { return }
        let newCoord = mapView.convert(mouseClickLocation, toCoordinateFrom: mapView)
        print(newCoord)
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord = locations.first?.coordinate else { return }
        let region = MKCoordinateRegion(center: coord, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
        print("Location: ", coord.latitude, ", ", coord.longitude)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error:", error.localizedDescription)
    }
}
