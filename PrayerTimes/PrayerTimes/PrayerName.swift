//
//  PrayerName.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

enum PrayerName: String, Decodable {
    case Fajr
    case Sunrise
    case Dhuhr
    case Asr
    case Maghrib
    case Isha
    
    func capitalized() -> String {
        return self.rawValue.capitalized
    }
}
