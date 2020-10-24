//
//  AllPrayersWidgetViewModel.swift
//  PrayerTimes
//
//  Created by user on 24/10/2020.
//

import Foundation
import SwiftUI

struct AllPrayersWidgetViewModel {
    
    let prayers: [Prayer]
    let hijriDate: String
    let gregorianDate: String
    let colorScheme: Color
    
    init(prayerTimesData: PrayerTimesData) {
        
        prayers = Self.prayers(prayerTimesData: prayerTimesData)
        hijriDate = prayerTimesData.dateInfo.hijriDate.readable()
        gregorianDate = prayerTimesData.dateInfo.gergorianDate.readable()
        colorScheme = Color("BlueBlue")
    }
    
    private static func prayers(prayerTimesData: PrayerTimesData) -> [Prayer] {
        let prayerNames: [PrayerName] = [.fajr, .sunrise, .dhuhr, .asr, .maghrib, .isha]
        
        return prayerNames.map { prayerName in
            let prayerTimeString = prayerTimesData.timings[prayerName.capitalized()]
            let prayerNameString = prayerName.capitalized()
            
            return Prayer(name: prayerNameString,
                          prayerDateString: "",
                          formattedTime: prayerTimeString ?? "",
                          isNextPrayer: false,
                          hasPassed: false,
                          icon: Icon.forName(prayerName))
        }
    }
    
    static var stub: AllPrayersWidgetViewModel {
        return AllPrayersWidgetViewModel(prayerTimesData: PrayerTimesData(timings: ["Fajr" : " ",
                                                                                    "Dhuhr" : " ",
                                                                                    "Asr": " ",
                                                                                    "Maghrib" : " ",
                                                                                    "Isha" : " "],
                                                                          dateInfo: DateInfo(timestamp: " ",
                                                                                             hijriDate: .init(day: "",
                                                                                                              month: .init(name: " "),
                                                                                                              year: " ",
                                                                                                              date: " ",
                                                                                                              format: " "),
                                                                                             gergorianDate: .init(day: " ",
                                                                                                                  month: .init(name: " "),
                                                                                                                  year: " ",
                                                                                                                  date: " ",
                                                                                                                  format: " ")),
                                                                          meta: .init(timezone: " ")))
    }
}
