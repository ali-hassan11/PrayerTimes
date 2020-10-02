//
//  PreviewData.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

struct PreviewData {

    let PREVIEW_PRAYERS = [
        Prayer(name: "Fajr", timestamp: Date(), formattedTime: "05:00", isNextPrayer: false),
        Prayer(name: "Sunrise", timestamp: Date(), formattedTime: "07:00", isNextPrayer: true),
        Prayer(name: "Dhuhr", timestamp: Date(), formattedTime: "12:00", isNextPrayer: false),
        Prayer(name: "Asr", timestamp: Date(), formattedTime: "16:00", isNextPrayer: false),
        Prayer(name: "Maghrib", timestamp: Date(), formattedTime: "18:00", isNextPrayer: false),
        Prayer(name: "Isha", timestamp: Date(), formattedTime: "20:00", isNextPrayer: false)
    ]
}
