//
//  LocationService.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func locationDidUpdate(lat: Double, lon: Double)
}

class LocationService: NSObject {
    // MARK:- Private properties
    private let locationManager = CLLocationManager()
    
    // MARK:- Properties
    weak var delegate: LocationServiceDelegate?
    
    // MARK:- Inits
    override init() {
        super.init()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = manager.location?.coordinate else { return }
        self.delegate?.locationDidUpdate(lat: coordinate.latitude, lon: coordinate.longitude)
    }
}
