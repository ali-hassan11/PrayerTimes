//
//  PrayerTimesData.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

struct PrayerTimesData {
    
    let timings: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case timings
    }
    
    init(timings: [String: String]) {
        self.timings = timings
    }
}

extension PrayerTimesData: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let timings = try container.decode([String: String].self, forKey: .timings)
        
        self.init(timings: timings)
    }
}
