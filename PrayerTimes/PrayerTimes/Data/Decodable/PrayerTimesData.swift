//
//  PrayerTimesData.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

struct PrayerTimesData {
    
    let timings: [String: String]
    let dateInfo: DateInfo
    
    enum CodingKeys: String, CodingKey {
        case timings
        case dateInfo = "date"
    }
    
    init(timings: [String: String], dateInfo: DateInfo) {
        self.timings = timings
        self.dateInfo = dateInfo
    }
}

extension PrayerTimesData: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let timings = try container.decode([String: String].self, forKey: .timings)
        let dateInfo = try container.decode(DateInfo.self, forKey: .dateInfo)
        
        self.init(timings: timings, dateInfo: dateInfo)
    }
}
