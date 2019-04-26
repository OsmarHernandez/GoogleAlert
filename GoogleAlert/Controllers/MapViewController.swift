//
//  MapViewController.swift
//  GoogleAlert
//
//  Created by Osmar Hernández on 25/04/19.
//  Copyright © 2019 tallervertical. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    var emergencyColor: UIColor!
    
    private var searchedLocation: CLLocationCoordinate2D?
    
    private let locationManager = CLLocationManager()
    
    private let searchRadius: Double = 1000
    
    @IBOutlet weak var emergencyTypeLabel: UILabel!
    
    var emergencyType: EmergencyType!
    
    @IBOutlet weak var emergencyBar: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if let color = emergencyColor {
            emergencyBar.backgroundColor? = color
        }
        
        if let type = emergencyType {
            emergencyTypeLabel.text = type.rawValue
        }
    }
    
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.map = mapView
    }
    
    @IBAction func drawCircleButton(_ sender: UIButton) {
        guard let location = searchedLocation else {
            return
        }
        
        let circle = GMSCircle(position: location, radius: 100)
        circle.fillColor = emergencyColor.withAlphaComponent(0.45)
        circle.strokeColor = emergencyColor
        circle.map = mapView
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }

        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        locationManager.stopUpdatingLocation()
    }
    
    func search(place: String) {
        PlaecesAPI.searchInGoogleMaps(place: place) {
            (latitud, longitud) in
            
            let position = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
            
            self.showMarker(position: position)
            self.searchedLocation = position
        }
    }
}

extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text, !text.isReallyEmpty {
            search(place: text)
        }
        
        return true
    }
    
    // Test
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "Sin información")
    }
}
