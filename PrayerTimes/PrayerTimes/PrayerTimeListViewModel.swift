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
    
    var delegate: CLLocationManagerDelegate?
    
    func createDelegate() -> CLLocationManagerDelegate? {
        return LocationManagerDelegate(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let locationInfo):
                
                SettingsConfiguration.shared.saveLocationSetting(locationInfo)
                self.fetchTodayPrayerTimes()
                
            case .failure(let error):
                print(error)
                self.stateManager.failed(with: .geoCodingError)
            }
        })
    }
    
    init() {
        self.locationManager = CLLocationManager()
        self.delegate = createDelegate()
        
        if SettingsConfiguration.getLocationInfoSetting() != nil {
            fetchTodayPrayerTimes()
        } else {
            switch locationManager.authorizationStatus {
            
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.delegate = self.delegate
                locationManager.startUpdatingLocation()
                
            case .notDetermined:
                locationManager.delegate = self.delegate
                locationManager.requestAlwaysAuthorization()

            case .restricted, .denied:
                stateManager.failed(with: .locationDisabled)

            default:
                stateManager.failed(with: .locationDisabled)

            }
            
        }
    }
    

    func fetchData(date: Date) {

        self.nextPrayerFound = false
        stateManager.loading()
        
        let settings = SettingsConfiguration.shared
        let coordinaties = Coordinates(latitude: String(settings.locationInfo.lat), longitude: String(settings.locationInfo.long))
        let prayerTimesConfiguration = PrayerTimesConfiguration(timestamp: date.timestampString,
                                                               coordinates: coordinaties,
                                                               method: settings.method,
                                                               school: settings.school,
                                                               latitudeAdjustmentMethod: settings.latitudeAdjustmentMethod)
        
        guard let url = URLBuilder.prayerTimesForDateURL(configuration: prayerTimesConfiguration) else {
            stateManager.failed(with: .geoCodingError) //Add another failure state for this
            return
        }

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
                    self?.stateManager.failed(with: .noInternet)
                }
            }
        }
    }
    
    func retryFetchData() {
        let date = self.date
        self.date = date
    }
    
    func fetchTodayPrayerTimes() {
        self.date = Date()
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
        
        //If there is still time remaining
        if secondsRemaining > 0 {
            updateTimeRemaining(with: secondsRemaining)
            return
        }
        
        //Else If time's up...
        
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
    
        //Set the current isNextPrayer to false & the current hasPassed to true
        guard let currentNextPrayerPosition = currentNextPrayerIndex else { return }
        prayers[currentNextPrayerPosition].isNextPrayer = false
        prayers[currentNextPrayerPosition].hasPassed = true
                
        //If a next prayer exists
        if prayers.indices.contains(currentNextPrayerPosition + 1) {
            
            //Set the new isNextPrayer to true & update self.nextPrayer
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
            
            let prayerTimeDate = self.prayerTimesDate(dateString: prayerDateString,
                                                      timeString: prayerTimeString)
            
            let isNextPrayer: Bool
            if let prayerTimeDate = prayerTimeDate {
                isNextPrayer = self.isNextPrayer(prayerTimesDate: prayerTimeDate,
                                                 currentDate: currentDate)
            } else {
                isNextPrayer = false
            }
            
            let prayer = Prayer(name: prayerName.capitalized(),
                                prayerDateString: prayerDateString,
                                formattedTime: prayerTimeString,
                                isNextPrayer: isNextPrayer,
                                hasPassed: !self.nextPrayerFound && isToday(date: Date()),
                                icon: Icon.forName(prayerName))//Change to isInPast(date: prayerTimeDate)
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
        
        //Improvment: Show Next days fajr
        
        //If in past return { false }
        
        //if is within 24 hours of future {
        
        //Is not sunrise yet
        //return true
        
        //}
        
        if isToday(date: prayerTimesDate) == false {
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
