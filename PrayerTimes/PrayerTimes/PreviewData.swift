//
//  PreviewData.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

struct PreviewData {

    let PREVIEW_PRAYERS = [
        Prayer(name: "Fajr", formattedTime: "05:00", isNextPrayer: false),
        Prayer(name: "Sunrise", formattedTime: "07:00", isNextPrayer: true),
        Prayer(name: "Dhuhr", formattedTime: "12:00", isNextPrayer: false),
        Prayer(name: "Asr", formattedTime: "16:00", isNextPrayer: false),
        Prayer(name: "Maghrib", formattedTime: "18:00", isNextPrayer: false),
        Prayer(name: "Isha", formattedTime: "20:00", isNextPrayer: false)
    ]
    
    let PREVIEW_SETTING_CONFIG = SettingsConfiguration.shared
    
    var prayerTimeListViewModel: PrayerTimeListViewModel {
        return PrayerTimeListViewModel()
    }
}
