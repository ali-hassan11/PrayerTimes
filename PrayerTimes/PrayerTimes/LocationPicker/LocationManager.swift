//
//  LocationManager.swift
//  PrayerTimes
//
//  Created by user on 10/10/2020.
//

import Foundation
import CoreLocation

struct LocationInfo {
    let locationName: String
    let lat: Double
    let long: Double
}

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    
    let locationUpdatedCompletion: (Result<(LocationInfo, TimeZone), CustomError>) -> Void
    
    init(completion: @escaping (Result<(LocationInfo, TimeZone), CustomError>) -> Void) {
        self.locationUpdatedCompletion = completion
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        
        case .authorizedAlways, .authorizedWhenInUse: //Happy path
            manager.startUpdatingLocation()
            
        case .notDetermined:
            manager.requestAlwaysAuthorization()

        case .restricted, .denied:
            print("Location restricted or denied")

        default:
            print("default")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
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
