//
//  PrayerTimesEntry.swift
//  PrayerTimesWidgetExtension
//
//  Created by user on 22/10/2020.
//

import SwiftUI
import WidgetKit

struct PrayerTimeEntry: TimelineEntry {
    let date = Date()
    let prayerTimes: [Prayer]
    
    static var stub: PrayerTimeEntry {
        let prayers: [Prayer] = [
            Prayer(name: "Fajr", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false, icon: .fajr),
            Prayer(name: "Sunrise", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false, icon: .sunrise),
            Prayer(name: "Dhuhr", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false, icon: .dhuhr),
            Prayer(name: "Asr", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false, icon: .asr),
            Prayer(name: "Maghrib", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false, icon: .maghrib),
            Prayer(name: "Isha", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false, icon: .isha)
        ]
        return PrayerTimeEntry(prayerTimes: prayers)
    }
}
