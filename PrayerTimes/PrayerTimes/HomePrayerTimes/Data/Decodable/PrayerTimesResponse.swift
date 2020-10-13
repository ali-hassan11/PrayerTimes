//
//  Response.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

class PrayerTimesResponse: Codable {
    
    let status: String
    let prayerTimesData: PrayerTimesData
    
    enum CodingKeys: String, CodingKey {
        case status
        case prayerTimesData = "data"
    }
    
    init(status: String, prayerTimesData: PrayerTimesData) {
        self.status = status
        self.prayerTimesData = prayerTimesData
    }
    
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let status = try container.decode(String.self, forKey: .status)
        let prayerTimesData = try container.decode(PrayerTimesData.self, forKey: .prayerTimesData)
        self.init(status: status,
                  prayerTimesData: prayerTimesData)
    }
}
