//
//  Response.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

struct PrayerTimesResponse {
    
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
}

extension PrayerTimesResponse: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let status = try container.decode(String.self, forKey: .status)
        let prayerTimesData = try container.decode(PrayerTimesData.self, forKey: .prayerTimesData)
        print(prayerTimesData.timings)
        self.init(status: status,
                  prayerTimesData: prayerTimesData)
    }
}
