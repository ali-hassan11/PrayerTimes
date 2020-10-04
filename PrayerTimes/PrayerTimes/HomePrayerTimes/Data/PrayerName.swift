//
//  PrayerNames.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

enum PrayerName: String {
    case fajr
    case sunrise
    case dhuhr
    case asr
    case maghrib
    case isha
    
    func capitalized() -> String {
        return rawValue.capitalized
    }
}
