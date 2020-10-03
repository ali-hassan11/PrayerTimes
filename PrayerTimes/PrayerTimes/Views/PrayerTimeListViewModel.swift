//
//  PrayerTimesHomeViewModel.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation
import SwiftUI

//1. Rename to PrayerTimesListViewModel, Create MultiplePrayerTimeListViewModel that contains [PrayerTimesListViewModel]
//2. Create MultiplePrayerListView, which populaters a list of PrayerTimesListView using a MultiplePrayerTimeListViewModel
//2. Create separate viewModel for date - DateViewModel
class PrayerTimeListViewModel: ObservableObject, Identifiable {
    
    @Published var prayers: [Prayer] = [] {
        didSet {
            prayers.forEach { prayer in
                if prayer.isNextPrayer {
                    DispatchQueue.main.async {
                        self.nextPrayer = prayer
                    }
                }
            }
        }
    }
    @Published var nextPrayer: Prayer?
//    @Published var hijriDate: String = ""
//    @Published var gregorianDate: String = ""
    
    private var nextPrayerFound = false
    
    init(settings: SettingsConfiguration) {
        fetchData(settings: settings)
    }
    
    func fetchData(settings: SettingsConfiguration) {
        let prayerTimesConfiguration = PrayerTimesConfiguration(timestamp: Date().timestampString,
                                                               coordinates: .init(latitude: "53.5228", longitude: "1.1285"),
                                                               method: settings.method,
                                                               school: settings.school,
                                                               timeZone: settings.timeZone)
        
        guard let url = URLBuilder.prayerTimesForDateURL(configuration: prayerTimesConfiguration) else { return }
        
        Service.shared.fetchPrayerTimes(url: url) { [weak self] result in
            
            switch result {
            case .success(let prayerTimesResponse):
                
                self?.handlePrayerTimes(prayerTimesResponse: prayerTimesResponse, completion: { prayers in
                    DispatchQueue.main.async {
                        self?.prayers = prayers
                    }
                })
                
//                self?.handleDate(prayerTimesResponse: prayerTimesResponse, dateType: settings.dateMode,completion: { hijri, gregorian in
//                    DispatchQueue.main.async {
//                        self?.hijriDate = hijri
//                        self?.gregorianDate = gregorian
//                    }
//                })
                                
            case .failure(let error):
                print(error)
            }
        }
    
    }
}
 
extension PrayerTimeListViewModel {
    
    func handlePrayerTimes(prayerTimesResponse: PrayerTimesResponse, completion: @escaping (([Prayer]) -> Void)) {
        
        let prayerTimesData = prayerTimesResponse.prayerTimesData
        
        var prayerTimes = [Prayer]()
                
        let currentTimestamp = TimeInterval(prayerTimesData.dateInfo.timestamp) ?? Date().timeIntervalSince1970
        let currentDate = Date(timeIntervalSince1970: currentTimestamp)
        
        let prayerNames: [PrayerName] = [.fajr, .sunrise, .dhuhr, .asr, .maghrib, .isha]
            
        prayerNames.forEach { prayerName in
            guard let prayerTimeString = prayerTimesData.timings[prayerName.capitalized()] else { return }
            let prayerDateString = prayerTimesData.dateInfo.gergorianDate.date
            
            let prayerTimesDate = self.prayerTimesDate(dateString: prayerDateString, timeString: prayerTimeString, currentDate: currentDate)
            let isNextPrayer = self.isNextPrayer(prayerTimesDate: prayerTimesDate, currentDate: currentDate)
            
            let prayer = Prayer(name: prayerName.capitalized(), timestamp: Date(), formattedTime: prayerTimeString, isNextPrayer: isNextPrayer)
            prayerTimes.append(prayer)
        }
        
        completion(prayerTimes)
    }
    
//    func handleDate(prayerTimesResponse: PrayerTimesResponse, dateType: DateMode, completion: @escaping (String, String) -> Void) {
//
//        let hijri = prayerTimesResponse.prayerTimesData.dateInfo.hijriDate.readable()
//        let gregorian = prayerTimesResponse.prayerTimesData.dateInfo.gergorianDate.readable()
//
//        DispatchQueue.main.async {
//            completion(hijri, gregorian)
//        }
//    }
    
    private func prayerTimesDate(dateString: String, timeString: String, currentDate: Date) -> Date {
        
        if let date = formatter.date(from: "\(dateString) \(timeString)") {
            return Date(timeIntervalSince1970: TimeInterval(date.timeIntervalSince1970))
        } else {
            return currentDate
        }
    }
    
    private func isNextPrayer(prayerTimesDate: Date, currentDate: Date) -> Bool {
        
        if nextPrayerFound {
            return false
        }
        formatter.dateStyle = .full
        if currentDate < prayerTimesDate {
            nextPrayerFound = true
            return true
        } else {
            return false
        }
    }
    
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        let dateFormat = formatter.apiDateFormat()
        formatter.dateFormat = "\(dateFormat) HH:mm"
        formatter.timeZone = .current
        return formatter
    }
}

//MOVE SOMEWHERE

extension DateFormatter {
    func apiDateFormat() -> String {
        return "dd-MM-yyyy"
    }
}

extension Date {
    var timestampString: String {
        return String(self.timeIntervalSince1970)
    }
    
    var timestampPlus24HoursString: String {
        return String(self.timeIntervalSince1970 + 86400)
    }
}