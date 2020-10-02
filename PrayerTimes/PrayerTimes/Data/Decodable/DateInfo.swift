//
//  DateData.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

struct DateInfo {
    
    let timestamp: String
    let hijriDate: HijriDate

    enum CodingKeys: String, CodingKey {
        case timestamp
        case hijriDate = "hijri"
    }
}


extension DateInfo: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let timestamp = try container.decode(String.self, forKey: .timestamp)
        let hijriDate = try container.decode(HijriDate.self, forKey: .hijriDate)
        
        self.init(timestamp: timestamp, hijriDate: hijriDate)
    }
}
