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
    let viewModel: AllPrayersWidgetViewModel
    
    static var stub: PrayerTimeEntry {
        return PrayerTimeEntry(viewModel: AllPrayersWidgetViewModel.stub)
    }
}
