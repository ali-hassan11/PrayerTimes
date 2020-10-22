//
//  PrayerTimesWidget.swift
//  PrayerTimesWidget
//
//  Created by user on 21/10/2020.
//

import WidgetKit
import SwiftUI
import Intents
//Will need to call WidgetKit.reloadTimeline whenever user shancges setting, whenever location changes
//Request new timeline after midnight or after next prayer

// MARK: Entry - Holds the date of when the date of when widget should be updated and presenter
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

// MARK: Provider - Tells the app widgets when they need to be updated
struct Provider: TimelineProvider {
    
    let service = Service.shared
    
    func placeholder(in context: Context) -> PrayerTimeEntry {
        return Entry(prayerTimes: [])
    }
    
    //WidgetKit makes the snapshot request when displaying the widget in transient situations, such as when the user is adding a widget.
    func getSnapshot(in context: Context, completion: @escaping (PrayerTimeEntry) -> Void) {
        if context.isPreview {
            completion(PrayerTimeEntry.stub)
        } else {
        
            fetchData() { (result) in
                switch result {
                case .success(let entry):
                    completion(entry)
                    
                case .failure:
                    completion(PrayerTimeEntry.stub)
                }
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<PrayerTimeEntry>) -> Void) {
        fetchData() { (result) in
            switch result {
            case .success(let entry):
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                //After Midnight... (Get current day, add 1 day, change time to 00:0)
                completion(timeline)
                
            case .failure:
                let timeline = Timeline(entries: [PrayerTimeEntry.stub], policy: .after(Date().addingTimeInterval(60 * 2)))
                completion(timeline)
            }
        }

    }
    
    func fetchData(completion: @escaping (Result<PrayerTimeEntry, CustomError>) -> Void) {
    
        let settings = SettingsConfiguration.shared
        let coordinaties = Coordinates(latitude: String(settings.locationInfo.lat),
                                       longitude: String(settings.locationInfo.long))
        let prayerTimesConfiguration = PrayerTimesConfiguration(timestamp: Date().timestampString,
                                                                coordinates: coordinaties,
                                                                method: settings.method,
                                                                school: settings.school,
                                                                latitudeAdjustmentMethod: settings.latitudeAdjustmentMethod)
        
        guard let url = URLBuilder.prayerTimesForDateURL(configuration: prayerTimesConfiguration) else { return }
        
        service.fetchPrayerTimes(url: url) { (result) in
            switch result {
            
            case .success(let response):
                let prayerTimesData = response.prayerTimesData
                let prayerNames: [PrayerName] = [.fajr, .sunrise, .dhuhr, .asr, .maghrib, .isha]
                
                let prayers: [Prayer] = prayerNames.map { prayerName in
                    let prayerTimeString = prayerTimesData.timings[prayerName.capitalized()]
                    let prayerNameString = prayerName.capitalized()
                    
                    return Prayer(name: prayerNameString,
                                  prayerDateString: "",
                                  formattedTime: prayerTimeString ?? "",
                                  isNextPrayer: false,
                                  hasPassed: false,
                                  icon: Icon.forName(prayerName))
                }
                
                let prayerTimesEntry = PrayerTimeEntry(prayerTimes: prayers)
                completion(.success(prayerTimesEntry))
                
            case .failure(let error):
                print(error)
                completion(.failure(.init(title: "Error", message: "Failed to get data for widget")))
            }
        }

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
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        HStack {
            switch family {
            
            case .systemSmall:
                SmallWidget(entry: entry)
                
            case .systemMedium:
                Text("Medium")
                
            case .systemLarge:
                Text("Large")
                
            default:
                Text("Dunno")
            
            }
        }
    }
}

struct SmallWidget: View {
    
    let entry: PrayerTimeEntry
    
    var body: some View {
        Text("SMALLLLL")
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
