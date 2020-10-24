//
//  PrayerTimesWidget.swift
//  PrayerTimesWidget
//
//  Created by user on 21/10/2020.
//

import WidgetKit
import SwiftUI
import Intents
///Will need to call WidgetKit.reloadTimeline whenever user shancges setting, whenever location changes
///Request new timeline after midnight or after next prayer


@main
struct PrayerTimesWidget: Widget {
    private let kind = "Prayer_Times_Widget"
    
    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind,
                            provider: Provider()) { entry in
            PrayerTimesWidgetEntryView(entry: entry)
        }
    }
}
