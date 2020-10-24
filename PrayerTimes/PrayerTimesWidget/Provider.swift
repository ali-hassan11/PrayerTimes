//
//  Provider.swift
//  PrayerTimesWidgetExtension
//
//  Created by user on 22/10/2020.
//

import SwiftUI
import WidgetKit

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
