//
//  LocationManager.swift
//  PrayerTimes
//
//  Created by user on 10/10/2020.
//

import Foundation
import CoreLocation

struct LocationInfo {
    let cityName: String
    let lat: Double
    let long: Double
}

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    
    let locationUpdatedCompletion: (Result<(LocationInfo, TimeZone), CustomError>) -> Void
    
    init(completion: @escaping (Result<(LocationInfo, TimeZone), CustomError>) -> Void) {
        self.locationUpdatedCompletion = completion
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("Did change")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .restricted, .denied:
            print("Restricted/Denied")
            
        case .authorizedAlways, .authorizedWhenInUse: //Happy path
            manager.startUpdatingLocation()

        case .notDetermined:
            print("Always in use")

        default:
            print("default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        
        let geocoder = GeocoderWrapper()

        geocoder.locationInfo(for: locations.first) { result in
            switch result {
            case .success((let locationInfo, let timeZone)):
                self.locationUpdatedCompletion(.success((locationInfo, timeZone)))
            case .failure(let error):
                self.locationUpdatedCompletion(.failure(error))
            }
        }
    }
}
