//
//  HijriDate.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

struct DateElements: Decodable {
    let day: String
    let month: Month
    let year: String
    
    let date: String
    let format: String
    
    func readable() -> String {
        return "\(day) \(month.name), \(year)"
    }
}
