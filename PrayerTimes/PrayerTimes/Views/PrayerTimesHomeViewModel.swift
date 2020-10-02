//
//  PrayerTimesHomeViewModel.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation
import SwiftUI

class PrayerTimesHomeViewModel: ObservableObject {
    
    @Published var prayers: [Prayer] = []
    @Published var formattedDate: String = ""
    
    @EnvironmentObject var settingsConfiguration: SettingsConfiguration

    init(settings: SettingsConfiguration) {
        fetchData(settings: settings)
    }
    
    //Pass in configuration
    func fetchData(settings: SettingsConfiguration) {
        let prayerTimesConfiguration = PrayerTimesConfiguration(timestamp: "00000000",
                                                               coordinates: .init(latitude: "53.5228", longitude: "1.1285"),
                                                               method: settings.method,
                                                               school: settings.school)
        
        guard let url = URLBuilder.prayerTimesForDateURL(configuration: prayerTimesConfiguration) else { return }
        
        Service.shared.fetchPrayerTimes(url: url) { [weak self] result in
            
            switch result {
            case .success(let prayerTimesResponse):
                
                self?.handlePrayerTimes(prayerTimesResponse: prayerTimesResponse)
                self?.handleDate(prayerTimesResponse: prayerTimesResponse, dateType: settings.dateType)
                                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func handlePrayerTimes(prayerTimesResponse: PrayerTimesResponse) {
        let prayerTimesData = prayerTimesResponse.prayerTimesData
        
        var prayerTimes = [Prayer]()
        
//        let currentTimestamp = Date().timeIntervalSince1970
        
        ["Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"].forEach { prayerName in
            guard let prayerTime = prayerTimesData.timings[prayerName] else { return }
            
            //Convert prayer time to timestamp, compare that with current
   
            let isNextPrayer: Bool
            
            if 1 > 1 {
                isNextPrayer = true
            } else {
                isNextPrayer = false
            }
            
            let prayer = Prayer(name: prayerName, time: Date(), formattedTime: prayerTime, isNextPrayer: isNextPrayer)
            
            prayerTimes.append(prayer)
            
            DispatchQueue.main.async {
                self.prayers = prayerTimes
            }
        }
    }
    
    private func handleDate(prayerTimesResponse: PrayerTimesResponse, dateType: DateType) {
        let hijri = prayerTimesResponse.prayerTimesData.dateInfo.hijriDate.formatted()
        let gregorian = prayerTimesResponse.prayerTimesData.dateInfo.gergorianDate.formatted()
        let date = dateType == .hijri ? hijri : gregorian
        
        DispatchQueue.main.async {
            self.formattedDate = date
        }
    }
}
