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
        print("Did change?")
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
        
        guard let firstLocation = locations.first else {
            locationUpdatedCompletion(.failure(.init(title: "Unable to Locate",
                                                     message: "There was a problem finding your location. Please try again.")))
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(firstLocation) { (placeMarks, error) in
            
            #if DEBUG
            if let error = error {
                print("⚠️ FAILD TO GEOCODE: \(error.localizedDescription)")
            }
            #endif
            
            let place = placeMarks?.first
            guard let placeName = place?.locality, let country = place?.country, let timeZone = place?.timeZone else {
                self.locationUpdatedCompletion(.failure(.init(title: "Unable to Locate",
                                                         message: "There was a problem finding your location. Please try again.")))
                return
            }
            let locationInfo = LocationInfo(cityName: "\(placeName), \(country)", lat: firstLocation.coordinate.latitude, long: firstLocation.coordinate.longitude)

            self.locationUpdatedCompletion(.success((locationInfo, timeZone)))
        }
    }
}
