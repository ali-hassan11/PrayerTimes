//
//  PrayerTimesWidgetEntry.swift
//  PrayerTimes
//
//  Created by user on 22/10/2020.
//

import WidgetKit
import SwiftUI

//Holds the date of when the date of when widget should be updated and presenter
struct PrayerTimesEntry: TimelineEntry {
    let date = Date()
    let prayerTimes: [Prayer]
}
