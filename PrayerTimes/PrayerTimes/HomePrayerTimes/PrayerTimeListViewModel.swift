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
    
    var timeRemaining: Int? = 0 {
        didSet {
            
            guard let nextPrayer = nextPrayer else { return }
            
            guard let prayerTimeString = prayers.filter({ $0.name == nextPrayer.name }).first else { return }
            
            let currentDate = Date()
            guard let nextPrayerDate = self.prayerTimesDate(dateString: nextPrayer.prayerDateString,
                                                      timeString: prayerTimeString.formattedTime,
                                                      currentDate: currentDate) else { return }
            
            let timeRemainingTimestamp = nextPrayerDate.timeIntervalSince(currentDate)
            
            let (h,m,s) = secondsToHoursMinutesSeconds(seconds: timeRemainingTimestamp)
            
            timeRemainingString = "begins in \(h)h \(m)m \(s)s"
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
            
            let isNextPrayer: Bool
            if let prayerTimesDate = prayerTimesDate {
                isNextPrayer = self.isNextPrayer(prayerTimesDate: prayerTimesDate, currentDate: currentDate)
            } else {
                isNextPrayer = false
            }
            
            let prayer = Prayer(name: prayerName.capitalized(), prayerDateString: prayerDateString, formattedTime: prayerTimeString, isNextPrayer: isNextPrayer)
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
    
    private func prayerTimesDate(dateString: String, timeString: String, currentDate: Date) -> Date? {
        
        if let date = formatter.date(from: "\(dateString) \(timeString)") {
            return Date(timeIntervalSince1970: TimeInterval(date.timeIntervalSince1970))
        } else {
            return nil
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
    
    private func secondsToHoursMinutesSeconds (seconds : Double) -> (Int, Int, Int) {
      let (hr,  minf) = modf (seconds / 3600)
      let (min, secf) = modf (60 * minf)
      return (Int(hr), Int(min), Int(60 * secf))
    }
}
