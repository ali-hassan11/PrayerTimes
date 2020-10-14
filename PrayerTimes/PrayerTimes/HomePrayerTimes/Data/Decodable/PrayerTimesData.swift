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
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case timings
        case dateInfo = "date"
        case meta
    }
    
    init(timings: [String: String], dateInfo: DateInfo, meta: Meta) {
        self.timings = timings
        self.dateInfo = dateInfo
        self.meta = meta
    }
}

struct Meta: Codable {
    let timezone: String
}

extension PrayerTimesData: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let timings = try container.decode([String: String].self, forKey: .timings)
        let dateInfo = try container.decode(DateInfo.self, forKey: .dateInfo)
        let meta = try container.decode(Meta.self, forKey: .meta)
        
        self.init(timings: timings, dateInfo: dateInfo, meta: meta)
    }
}
