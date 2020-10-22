//
//  Icons.swift
//  PrayerTimes
//
//  Created by user on 22/10/2020.
//

import Foundation

enum Icon: String {
    case fajr = "FajrIcon"
    case sunrise = "sunrise.fill"
    case dhuhr = "sun.max.fill"
    case asr = "sun.max"
    case maghrib = "sunset.fill"
    case isha = "moon.fill"
    
    static func forName(_ name: PrayerName) -> Icon {
        switch name {
        case .fajr: return .fajr
        case .sunrise: return .sunrise
        case .dhuhr: return .dhuhr
        case .asr: return .asr
        case .maghrib: return .maghrib
        case .isha: return .isha
        }
    }
}
