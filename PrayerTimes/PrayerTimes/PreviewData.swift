//
//  PreviewData.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

struct PreviewData {

    let PREVIEW_PRAYERS = [
        Prayer(name: "Fajr", prayerDateString: "22-10-1389", formattedTime: "05:00", isNextPrayer: false, hasPassed: true),
        Prayer(name: "Sunrise", prayerDateString: "22-10-1389", formattedTime: "07:00", isNextPrayer: false, hasPassed: true),
        Prayer(name: "Dhuhr", prayerDateString: "22-10-1389", formattedTime: "12:00", isNextPrayer: true, hasPassed: false),
        Prayer(name: "Asr", prayerDateString: "22-10-1389", formattedTime: "16:00", isNextPrayer: false, hasPassed: false),
        Prayer(name: "Maghrib", prayerDateString: "22-10-1389", formattedTime: "18:00", isNextPrayer: false, hasPassed: false),
        Prayer(name: "Isha", prayerDateString: "22-10-1389", formattedTime: "20:00", isNextPrayer: false, hasPassed: false)
    ]
    
    let PREVIEW_SETTING_CONFIG = SettingsConfiguration.shared
    
    var prayerTimeListViewModel: PrayerTimeListViewModel {
        return PrayerTimeListViewModel()
    }
}
