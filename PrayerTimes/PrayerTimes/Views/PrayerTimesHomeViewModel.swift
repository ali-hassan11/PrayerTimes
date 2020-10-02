//
//  PrayerTimesHomeViewModel.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation
import SwiftUI

class PrayerTimesHomeViewModel: ObservableObject {
    
    @Published var prayers: [Prayer] = [] {
        didSet {
            prayers.forEach { prayer in
                if prayer.isNextPrayer {
                    nextPrayer = prayer
                }
            }
        }
    }
    @Published var nextPrayer: Prayer?
    @Published var formattedDate: String = ""
    
    private var nextPrayerFound = false
    
    init(settings: SettingsConfiguration) {
        fetchData(settings: settings)
    }
    
    //Pass in configuration
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
                
                self?.handlePrayerTimes(prayerTimesResponse: prayerTimesResponse)
                self?.handleDate(prayerTimesResponse: prayerTimesResponse, dateType: settings.dateMode)
                                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
 
extension PrayerTimesHomeViewModel {
    
    
    private func handlePrayerTimes(prayerTimesResponse: PrayerTimesResponse) {
        let prayerTimesData = prayerTimesResponse.prayerTimesData
        
        var prayerTimes = [Prayer]()
                
        let currentTimestamp = TimeInterval(prayerTimesData.dateInfo.timestamp) ?? Date().timeIntervalSince1970
        let currentDate = Date(timeIntervalSince1970: currentTimestamp)
        
        let prayerNames: [PrayerName] = [.fajr, .sunrise, .dhuhr, .asr, .maghrib, .isha]
            
        prayerNames.forEach { prayerName in
            guard let prayerTime = prayerTimesData.timings[prayerName.capitalized()] else { return }
            
            let formatter = DateFormatter()
            let dateFormat = "dd-MM-yyyy"
            formatter.dateFormat = "\(dateFormat) HH:mm"
            formatter.timeZone = .current
            
            let prayerDateString = prayerTimesData.dateInfo.gergorianDate.date
            
            let prayerTimesDate: Date
            if let date = formatter.date(from: "\(prayerDateString) \(prayerTime)") {
                prayerTimesDate = Date(timeIntervalSince1970: TimeInterval(date.timeIntervalSince1970))
            } else {
                prayerTimesDate = currentDate
            }
            
            let isNextPrayer = self.isNextPrayer(prayerTimesDate: prayerTimesDate, currentDate: currentDate)
            let prayer = Prayer(name: prayerName.capitalized(), time: Date(), formattedTime: prayerTime, isNextPrayer: isNextPrayer)
            
            prayerTimes.append(prayer)
            
            DispatchQueue.main.async {
                self.prayers = prayerTimes
            }
        }
    }
    
    private func handleDate(prayerTimesResponse: PrayerTimesResponse, dateType: DateMode) {
        let hijri = prayerTimesResponse.prayerTimesData.dateInfo.hijriDate.readable()
        let gregorian = prayerTimesResponse.prayerTimesData.dateInfo.gergorianDate.readable()
        let date = dateType == .hijri ? hijri : gregorian
        
        DispatchQueue.main.async {
            self.formattedDate = date
        }
    }
    
    private func isNextPrayer(prayerTimesDate: Date, currentDate: Date) -> Bool {
        if nextPrayerFound {
            return false
        }
        
        if currentDate < prayerTimesDate {
            nextPrayerFound = true
            return true
        } else {
            return false
        }
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
