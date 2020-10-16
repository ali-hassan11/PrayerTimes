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
            guard let locationInfo = SettingsConfiguration.getLocationInfoSetting() else { return }
            fetchData(date: date, locationInfo: locationInfo)
        }
    }
    
    let locationManager : CLLocationManager
    @Published var locationName = ""

    
    private var nextPrayerFound = false
    @Published var nextPrayer: Prayer?

    @Published var hijriDate: String = ""
    @Published var gregorianDate: String = ""
    
    @Published var timeRemainingString: String = ""
    private var timeRemaining: Int = 0

    @Published var stateManager: StateManager = StateManager(prayerTimesState: .loading, displayDateState: .loading)
    
    @Published var prayers: [Prayer] = [] {
        didSet {
            prayers.forEach { prayer in
                if prayer.isNextPrayer {
                    DispatchQueue.main.async { [weak self] in
                        self?.nextPrayer = prayer
                        self?.updateTimeRemaining()
                    }
                }
            }
        }
    }
    
    func createDelegate() -> CLLocationManagerDelegate? {
        return LocationManagerDelegate(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let locationInfo):
                
                SettingsConfiguration.shared.saveLocationSetting(locationInfo)
                self.fetchData(date: self.date, locationInfo: locationInfo)
                
            case .failure(let error):
                print(error)
                self.stateManager.failed()
            }
        })
    }
    init() {
        self.locationManager = CLLocationManager()
    
        locationManager.delegate = createDelegate()

        if let locationInfo = SettingsConfiguration.getLocationInfoSetting() {
            fetchData(date: date, locationInfo: locationInfo)
        } else {
            
            switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse: //Happy path
                locationManager.startUpdatingLocation()
                
            case .notDetermined:
                locationManager.delegate = createDelegate() //WHY IS THE DELEGATE NIL??????!!!!!!!
                locationManager.requestAlwaysAuthorization()

            case .restricted, .denied:
                print("Location restricted or denied")

            default:
                print("default")
            }
            
        }
    }
    

    //PASS IN SETTINGS HERE AS WE WILL ACCESS TO IT FROM THE VIEW
    func fetchData(date: Date, locationInfo: LocationInfo) {

        self.nextPrayerFound = false
        stateManager.loading()
        
        let settings = SettingsConfiguration.shared
        let coordinaties = Coordinates(latitude: String(settings.locationInfo.lat), longitude: String(settings.locationInfo.long))
        let prayerTimesConfiguration = PrayerTimesConfiguration(timestamp: date.timestampString,
                                                               coordinates: coordinaties,
                                                               method: settings.method,
                                                               school: settings.school,
                                                               latitudeAdjustmentMethod: settings.latitudeAdjustmentMethod)
        
        guard let url = URLBuilder.prayerTimesForDateURL(configuration: prayerTimesConfiguration) else { return }

        Service.shared.fetchPrayerTimes(url: url) { [weak self] result in
            
            switch result {
            case .success(let prayerTimesResponse):
                
                self?.handlePrayerTimes(prayerTimesResponse: prayerTimesResponse, completion: { prayers in
                    DispatchQueue.main.async {
                        self?.prayers = prayers
                        self?.locationName = settings.locationInfo.locationName
                        self?.stateManager.prayerTimesLoaded()
                    }
                })
                
                self?.handleDate(prayerTimesResponse: prayerTimesResponse, completion: { hijri, gregorian in
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
        guard let locationInfo = SettingsConfiguration.getLocationInfoSetting() else { return }
        fetchData(date: date, locationInfo: locationInfo)
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
    
    func updateTimeRemaining() {
        guard let nextPrayer = nextPrayer else { return }
        guard let prayerTimeString = prayers.filter({ $0.name == nextPrayer.name }).first else { return }
        
        guard let nextPrayerDate = self.prayerTimesDate(dateString: nextPrayer.prayerDateString,
                                                  timeString: prayerTimeString.formattedTime) else { return }
    
        let currentDate = Date()
        let secondsRemaining = nextPrayerDate.timeIntervalSince(currentDate)
        
        //IF TIME IS > 0
        if secondsRemaining > 0 {
            updateTimeRemaining(with: secondsRemaining)
            return
        }
        //ELSE
        
        //If all there is no nextPrayer in self.prayers, do nothing
        if prayers.map({ return $0.isNextPrayer }) == [false, false, false, false, false, false] {
            nextPrayerFound = false
            return
        }
        
        //If there is a next prayer in prayers, get its index
        var currentNextPrayerIndex: Int?
        for (index, prayer) in prayers.enumerated() {
            if prayer == nextPrayer {
                currentNextPrayerIndex = index
                break
            }
        }
        
        //Set the current isNextPrayer to false & set the new isNextPrayer to true
        guard let currentNextPrayerPosition = currentNextPrayerIndex else { return }
        
        prayers[currentNextPrayerPosition].isNextPrayer = false
        
        //If a next prayer exists
        if prayers.indices.contains(currentNextPrayerPosition + 1) {
            
            //Set its isNextPrayer to true & update self.nextPrayer
            prayers[currentNextPrayerPosition + 1].isNextPrayer = true
            self.nextPrayer = prayers[currentNextPrayerPosition + 1]
            self.nextPrayerFound = true
            
            //Get time remaining until new next prayer
            let newNextPrayer = prayers[currentNextPrayerPosition + 1]
            guard let newNextPrayerDate = prayerTimesDate(dateString: newNextPrayer.prayerDateString,
                                                          timeString: newNextPrayer.formattedTime) else { return }
            let newSecondsRemaining = newNextPrayerDate.timeIntervalSince(currentDate)

            //Update time remaining
            updateTimeRemaining(with: newSecondsRemaining)
        
        } else {
            self.nextPrayerFound = false
            return
        }
    }
    
    private func updateTimeRemaining(with remainingTime: TimeInterval) {
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds: remainingTime)
        let formattedTimeString = "\(h)h \(m)m \(s)s"
        
        timeRemaining = Int(remainingTime)
        timeRemainingString = formattedTimeString
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
            
            let prayerTimesDate = self.prayerTimesDate(dateString: prayerDateString, timeString: prayerTimeString)
            
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
    
    func handleDate(prayerTimesResponse: PrayerTimesResponse, completion: @escaping (String, String) -> Void) {

        let hijri = prayerTimesResponse.prayerTimesData.dateInfo.hijriDate.readable()
        let gregorian = prayerTimesResponse.prayerTimesData.dateInfo.gergorianDate.readable()

        DispatchQueue.main.async {
            completion(hijri, gregorian)
        }
    }
    
    private func prayerTimesDate(dateString: String, timeString: String) -> Date? {
        
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
