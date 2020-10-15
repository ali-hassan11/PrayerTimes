//
//  URLBuilder.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

class URLBuilder {
    
    private static let baseURLTemplate = "https://api.aladhan.com/v1/timings/{timestamp}?latitude={latitude}&longitude={longitude}&method={method}&school={school}&latitudeadjustmentmethod={latitudeAdjustmentMethod}"
    
    static func prayerTimesForDateURL(configuration: PrayerTimesConfiguration) -> URL? {

        let urlString = baseURLTemplate
            .replacingOccurrences(of: "{timestamp}", with: configuration.timestamp)
            .replacingOccurrences(of: "{latitude}", with: configuration.coordinates.latitude)
            .replacingOccurrences(of: "{longitude}", with: configuration.coordinates.longitude)
            .replacingOccurrences(of: "{method}", with: String(configuration.method.index))
            .replacingOccurrences(of: "{school}", with: String(configuration.school.index))
            .replacingOccurrences(of: "{latitudeAdjustmentMethod}", with: String(configuration.latitudeAdjustmentMethod.index))
        guard let url = URL(string: urlString) else { return nil }
        
        return url
    }
}

