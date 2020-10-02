//
//  Month.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

struct Month {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "en"
    }
}

extension Month: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        
        self.init(name: name)
    }
}
