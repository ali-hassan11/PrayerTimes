//
//  PrayerTimesWidget.swift
//  PrayerTimesWidget
//
//  Created by user on 21/10/2020.
//

import WidgetKit
import SwiftUI
import Intents


// MARK: Entry - Holds the date of when the date of when widget should be updated and presenter
struct PrayerTimeEntry: TimelineEntry {
    let date = Date()
    let prayerTimes: [Prayer]
    
    var stub: PrayerTimeEntry {
        let prayers: [Prayer] = [
            Prayer(name: "Fajr", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false),
            Prayer(name: "Sunrise", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false),
            Prayer(name: "Dhuhr", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false),
            Prayer(name: "Asr", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false),
            Prayer(name: "Maghrib", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false),
            Prayer(name: "Isha", prayerDateString: "", formattedTime: "", isNextPrayer: false, hasPassed: false)
        ]
        return PrayerTimeEntry(prayerTimes: prayers)
    }
}

// MARK: Provider - Tells the app widgets when they need to be updated
struct Provider: TimelineProvider {
    
    let service = Service.shared
    
    func placeholder(in context: Context) -> PrayerTimeEntry {
        return Entry(prayerTimes: [])
    }
    
    //WidgetKit makes the snapshot request when displaying the widget in transient situations, such as when the user is adding a widget.
    func getSnapshot(in context: Context, completion: @escaping (PrayerTimeEntry) -> Void) {
        let entry = Entry(prayerTimes: [])
        completion(entry)
    }
    
    //Used to update widget with new data
    func getTimeline(in context: Context, completion: @escaping (Timeline<PrayerTimeEntry>) -> Void) {
        //Find out how to do this
        let entry = Entry(prayerTimes: [])
        let timeline = Timeline(entries: [entry], policy: .atEnd) //Request new timeline after mins to midnight
        completion(timeline)

    }
}

// MARK: PlaceHolder
struct PlaceHolderView: View {
    
    var body: some View {
        Text("Placeholder!")
    }
}

// MARK: WidgetView
struct PrayerTimesWidgetEntryView: View {
    
    let entry: Provider.Entry
    
    var body: some View {
        HStack {
            
            Text("I'm ALIVE")
            
            ForEach(entry.prayerTimes) { prayer in
                Text(prayer.name)
                    .foregroundColor(Color(.systemPink))
            }
        }
    }
}

// MARK: Widget
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
