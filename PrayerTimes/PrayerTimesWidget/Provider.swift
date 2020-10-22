////
////  Provider.swift
////  PrayerTimes
////
////  Created by user on 21/10/2020.
////
//
//import WidgetKit
//import SwiftUI
//
////Holds the date of when the date of when widget should be updated and presenter
//struct PrayerTimeEntry: TimelineEntry {
//    let date = Date()
//    let prayerTimes: [Prayer]
//}
//
////Tells the app widgets when they need to be updated
//struct Provider: TimelineProvider {
//    
//    func placeholder(in context: Context) -> PrayerTimeEntry {
//        return Entry(prayerTimes: [])
//    }
//    
//    //Quick rendering of what widget looks like when selecting widgets
//    func getSnapshot(in context: Context, completion: @escaping (PrayerTimeEntry) -> Void) {
//        let entry = PrayerTimeEntry(prayerTimes: [])
//        completion(entry)
//    }
//    
//    //Used to update widget with new data
//    func getTimeline(in context: Context, completion: @escaping (Timeline<PrayerTimeEntry>) -> Void) {
//        //Find out how to do this
//        let entry = PrayerTimeEntry(prayerTimes: [])
//        let timeline = Timeline(entries: [entry], policy: .never)
//        completion(timeline)
//
//    }
//   
//}
//
//struct PlaceHolderView: View {
//    
//    var body: some View {
//        Text("Placeholder!")
//    }
//}
//
//struct WidgetEntryView: View {
//    
//    let entry: Provider.Entry
//    
//    var body: some View {
//        HStack {
//            ForEach(entry.prayerTimes) { prayer in
//                Text(prayer.name)
//                    .foregroundColor(Color(.systemPink))
//            }
//        }
//    }
//}
//
//@main
//struct MyWidget: Widget {
//    private let kind = "My_Widget"
//    
//    var body: some WidgetConfiguration {
//        
//        StaticConfiguration(kind: kind,
//                            provider: Provider()) { entry in
//            WidgetEntryView(entry: entry)
//        }
//    }
//}
