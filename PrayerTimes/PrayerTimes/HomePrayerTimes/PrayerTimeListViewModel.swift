//
//  PrayerTimesHomeViewModel.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation
import SwiftUI
import CoreLocation

class PrayerTimeListViewModel: ObservableObject, Identifiable {
    
    @Published var date: Date = Date() {
        didSet {
            fetchData(date: date)
        }
    }
    
    private let locationManager : CLLocationManager
    private var nextPrayerFound = false
    @Published var locationName = ""
    @Published var nextPrayer: Prayer?
    @Published var hijriDate: String = ""
    @Published var gregorianDate: String = ""
    @Published var timeRemainingString: String = ""
    @Published var stateManager: StateManager = StateManager(prayerTimesState: .loading, displayDateState: .loading)
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
    
    var timeRemaining: Int? = 0 {
        didSet {
            guard let nextPrayer = nextPrayer else { return }

            if timeRemaining == 0 {
                
                //Set next prayer to the one after
                //Calc & set time remaining
                return
            }
                        
            guard let prayerTimeString = prayers.filter({ $0.name == nextPrayer.name }).first else { return }
            
            let currentDate = Date()
            guard let nextPrayerDate = self.prayerTimesDate(dateString: nextPrayer.prayerDateString,
                                                      timeString: prayerTimeString.formattedTime,
                                                      currentDate: currentDate) else { return }
        
            timeRemainingString = formattedTimeRemaining(seconds: nextPrayerDate.timeIntervalSince(currentDate))
        }
    }
    
    private func formattedTimeRemaining(seconds: TimeInterval) -> String {
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds: seconds)
        
        return "Begins in:\n\(h)h \(m)m \(s)s"
    }
    
    init() {
        self.locationManager = CLLocationManager()
        let locationManagerdelegate = LocationManagerDelegate(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success((let locationInfo, let timeZone)):
                self.updateSettings(with: locationInfo, and: timeZone)
                self.fetchData(date: self.date)
            case .failure(let error):
                print(error)
                self.stateManager.failed()
            }
            
        })
        locationManager.delegate = locationManagerdelegate
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //PASS IN SETTINGS HERE AS WE WILL ACCESS TO IT FROM THE VIEW
    func fetchData(date: Date) {
        self.nextPrayerFound = false
        stateManager.loading()
        
        let settings = SettingsConfiguration.shared
        let coordinaties = Coordinates(latitude: String(settings.locationInfo.lat), longitude: String(settings.locationInfo.long))
        let prayerTimesConfiguration = PrayerTimesConfiguration(timestamp: date.timestampString,
                                                               coordinates: coordinaties,
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
                        self?.locationName = settings.locationInfo.cityName
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
    
    func retryFetchData() {
        fetchData(date: date)
    }
    
    func plusOneDay() {
        date = date.plusOneDay
    }
    
    func minusOneDay() {
        date = date.minusOneDay
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
    
    private func updateSettings(with locationInfo: LocationInfo, and timeZone: TimeZone) {
        SettingsConfiguration.shared.locationInfo = locationInfo
        SettingsConfiguration.shared.timeZone = timeZone
    }
}
