//
//  DateData.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

struct DateInfo {
    
    let timestamp: String
    let hijriDate: DateElements
    let gergorianDate: DateElements
    
    var date: Date? {
        guard let timestampInt = TimeInterval(timestamp) else { return nil }
        return Date(timeIntervalSince1970: timestampInt)
    }

    enum CodingKeys: String, CodingKey {
        case timestamp
        case hijriDate = "hijri"
        case gergorianDate = "gregorian"
    }
}


extension DateInfo: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let timestamp = try container.decode(String.self, forKey: .timestamp)
        let hijriDate = try container.decode(DateElements.self, forKey: .hijriDate)
        let gregorianDate = try container.decode(DateElements.self, forKey: .gergorianDate)
        
        self.init(timestamp: timestamp, hijriDate: hijriDate, gergorianDate: gregorianDate)
    }
}
