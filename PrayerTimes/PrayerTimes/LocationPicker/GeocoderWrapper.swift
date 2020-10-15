//

import CoreLocation

class GeocoderWrapper {
    
    func locationInfo(for location: CLLocation?, completion: @escaping (Result<LocationInfo, CustomError>) -> Void) {
        guard let location = location else {
            completion(.failure(.init(title: "Unable to Locate",
                                      message: "There was a problem finding your location. Please try again 1")))
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placeMarks, error in
            
            if error != nil {

            }

            let place = placeMarks?.first

            var locationNameString = ""
            if let locality = place?.locality, let country = place?.country {
                locationNameString = "\(locality), \(country)"
            } else
            if let administrative = place?.administrativeArea, let country = place?.country {
                locationNameString = "\(administrative), \(country)"
            } else
            if let locality = place?.locality {
                locationNameString = locality
            } else
            if let administrative = place?.administrativeArea {
                locationNameString = administrative
            } else {
                completion(.failure(.init(title: "Unable get location name",
                                          message: "Failed to get any info about place name")))
            }
            
            let locationInfo = LocationInfo(locationName: locationNameString, lat: location.coordinate.latitude, long: location.coordinate.longitude)
            completion(.success(locationInfo))
        }
    }
}
