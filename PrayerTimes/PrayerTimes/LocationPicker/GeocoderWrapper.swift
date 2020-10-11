//

import CoreLocation

class GeocoderWrapper {
    
    func locationInfo(for location: CLLocation?, completion: @escaping (Result<(LocationInfo, TimeZone), CustomError>) -> Void) {
        guard let location = location else {
            completion(.failure(.init(title: "Unable to Locate",
                                      message: "There was a problem finding your location. Please try again.")))
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placeMarks, error in
            
            if error != nil {
                completion(.failure(.init(title: "Unable to Locate",
                                          message: "There was a problem finding your location. Please try again.")))
            }

            let place = placeMarks?.first
            guard let placeName = place?.locality, let country = place?.country, let timeZone = place?.timeZone else {
                completion(.failure(.init(title: "Unable to Locate",
                                          message: "There was a problem finding your location. Please try again.")))
                return
            }
            let locationInfo = LocationInfo(cityName: "\(placeName), \(country)", lat: location.coordinate.latitude, long: location.coordinate.longitude)

            completion(.success((locationInfo, timeZone)))
        }
    }
}
