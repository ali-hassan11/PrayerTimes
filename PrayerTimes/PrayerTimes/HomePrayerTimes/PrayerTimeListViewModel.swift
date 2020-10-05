//
//  PrayerTimesHomeViewModel.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation
import SwiftUI

class PrayerTimeListViewModel: ObservableObject, Identifiable {
    
//    @Environment var settingsConfiguration: SettingsConfiguration
            
    var date: Date = Date()
        
    @Published var hijriDate: String = ""
    @Published var gregorianDate: String = ""
    
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
    var timeRemaining: Int? = 100 {
        didSet {
            timeRemainingString = "begins in 1h 2m \(timeRemaining!)s"
        }
    }
    @Published var timeRemainingString: String = ""

    @Published var stateManager: StateManager = StateManager(prayerTimesState: .loading, displayDateState: .loading)
    
    private var nextPrayerFound = false
    
    init() {
        fetchData(date: Date())
    }
    
    //PASS IN SETTINGS HERE AS WE WILL ACCESS TO IT FROM THE VIEW
    func fetchData(date: Date) {
        self.date = date
        self.nextPrayerFound = false
        stateManager.loading()
        
        let settings = SettingsConfiguration.shared
        let prayerTimesConfiguration = PrayerTimesConfiguration(timestamp: date.timestampString,
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
                        self?.stateManager.prayerTimesLoaded()
                    }
                })
                
                self?.handleDate(prayerTimesResponse: prayerTimesResponse, dateType: settings.dateMode,completion: { hijri, gregorian in
                    DispatchQueue.main.async {
                        self?.hijriDate = hijri
                        self?.gregorianDate = gregorian
                        self?.stateManager.datesLoaded()
                    }
                })
                                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self?.prayers = []
                    self?.stateManager.failed()
                }
            }
        }
    }
    
    func isToday(date: Date) -> Bool {
        return Calendar.current.isDate(self.date, inSameDayAs: Date())
    }
}
 
extension PrayerTimeListViewModel {
    
    func handlePrayerTimes(prayerTimesResponse: PrayerTimesResponse, completion: @escaping (([Prayer]) -> Void)) {
        
        let prayerTimesData = prayerTimesResponse.prayerTimesData
        
        var prayerTimes = [Prayer]()
                
        let currentDate = Date()
        
        let prayerNames: [PrayerName] = [.fajr, .sunrise, .dhuhr, .asr, .maghrib, .isha]
            
        prayerNames.forEach { prayerName in
            guard let prayerTimeString = prayerTimesData.timings[prayerName.capitalized()] else { return }
            let prayerDateString = prayerTimesData.dateInfo.gergorianDate.date
            
            let prayerTimesDate = self.prayerTimesDate(dateString: prayerDateString, timeString: prayerTimeString, currentDate: currentDate)
            let isNextPrayer = self.isNextPrayer(prayerTimesDate: prayerTimesDate, currentDate: currentDate)
            
            let prayer = Prayer(name: prayerName.capitalized(), formattedTime: prayerTimeString, isNextPrayer: isNextPrayer)
            prayerTimes.append(prayer)
        }
        
        completion(prayerTimes)
    }
    
    func handleDate(prayerTimesResponse: PrayerTimesResponse, dateType: DateMode, completion: @escaping (String, String) -> Void) {

        let hijri = prayerTimesResponse.prayerTimesData.dateInfo.hijriDate.readable()
        let gregorian = prayerTimesResponse.prayerTimesData.dateInfo.gergorianDate.readable()

        DispatchQueue.main.async {
            completion(hijri, gregorian)
        }
    }
    
    private func prayerTimesDate(dateString: String, timeString: String, currentDate: Date) -> Date {
        
        if let date = formatter.date(from: "\(dateString) \(timeString)") {
            return Date(timeIntervalSince1970: TimeInterval(date.timeIntervalSince1970))
        } else {
            return currentDate
        }
    }
    
    func isNextPrayer(prayerTimesDate: Date, currentDate: Date) -> Bool {
        
        if !isToday(date: prayerTimesDate) {
            return false
        }
        
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
